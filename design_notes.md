# Design Notes

## Tools

### Hardware Tools

Schematics and PC board layouts will use Kicad.  Benefits of Kicad include
* Free (as in beer - for poor hobbyists)
* Free (as in speech - no corporation can hold data hostage)
* Open (text formatted files)

MultiSTMBL will use the stable release of Kicad, for maximum compatibility.
Stable and nightly versions of Kicad cannot coexist on the same computer,
and for "real work", I don't trust a nightly build.  This project is about
the boards, not the tool.

As of November 2017, the current stable version of Kicad is 4.0.7.  I am using
a default install.

### Software Tools

Still deciding on tool-chain.  Need something that works on windows and Linux.
Need to ask Rene what he is using, would need a good reason to use something differnet.

Could simply use gcc-arm and make from the command line.  Need to investigate the best way to get those tools on windows.

[Detailed writeup](http://thehackerworkshop.com/?p=391) A little old but worth reading. Also [this post](http://thehackerworkshop.com/?p=1056).  [And this](http://thehackerworkshop.com/?p=1216)

[SW4STM32](http://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-ides/sw4stm32.html) is based on GCC + Eclipse, cross-platform.

[STM-STUDIO-STM32](http://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-performance-and-debuggers/stm-studio-stm32.html) uses STLINK to monitor RAM variables in real time - might be handy.  Windows only.  Not needed for build, just for testing.

ST-LINK/V2 connects PC to UUT, allows FLASH programming and debugging, costs about $22 from Mouser.

ST-LINK/V2-ISOL does the same with 1000V isolation, costs $78.  Might be nice for debugging the power board, although I could use an isolation transformer and ground the negative bus.


## Hardware

All parts will include a source - preferrably Digikey, if not available from Digikey some
other major distributor will be listed.

All schematic symbols and PCB footprints will be stored in a dedicated library for the project.
They may start out in the Kicad libraries, but will be copied to the dedicated library so that
the project will not be affected by any upstream library changes.  The project library will be
stored as part of the project git repository.

No "invisible" pins will be used in any symbol.  All power pins will be visible, since this
project may have multiple independent and floating supplies, and any given chip could be 
connected to any supply.

Preferred format for multi-section components (logic gates, op-amps, etc) will be to have
sections for the gates and a separate section for the power terminals.  This allows bypass
caps to be located out of the way of the main circuitry, and avoids re-drawing things if the
assignment if circuits to individual gates changes.

### Power Board

The power board is very similar to the STMBL power board, with the following exceptions:
* +15V supply (relative to negative bus) is external instead of derived from positive bus.  Allows a single +15V supply for all axes, and allows control power up without bus power.
* Might change the serial isolator from single-ended digital isolator to optocouplers for better common mode rejection and longer cable length.

Functions on the board include:
* External +15V is used for gate drive and high-side bootstrap drive.
* External +15V is stepped down (buck converter) to +3.3V for processor.
* USB port for ?? (dangerous on un-isolated power), probably won't populate but leave on artwork.
* JTAG/Debug port (dangerous on un-isolated power), plan on using isolated ST-LINK.
* High-speed UART link to controller board - isolated.  Maybe differential (RS422)
* HIgh and low side gate drivers
* Current feedback with low side shunts (no high-side ground fault protection - calculated risk)
* Low side IOC using internal comparators
* Bus voltage measurement
* Output voltage measurement

The original STMBL power board used the IRAM256 Intelligent Power Module.  I probably want to duplicate that capability, but I also want to be able to use newer (and still in production) power modules.
One candidate family is from ST.  There are 10A, 15A, 20A, and 30A parts in the same 25-pin, 0.993" wide package.  Prices range from $11 to $28.  Part numbers are STGIPSxxC60T-H, where xx is the current rating.  Note that the T-H defines the behavior of two aux pins, they are a 4.7K NTC to ground and a shutdown pin.  Other suffixes use these pins in different (and incompatible) ways.  There are other families of parts (Powerex, Rohm, Infineon and ST) in other packages, but the series listed above seems to give a wide range of ratings at very competitive prices.

A separate version of the power board might be designed with gate driver ICs to support discrete TO-247 IGBTs.  This would probably be a larger board and would definitely cost a bit more, but could use IGBTs rated at 50A or more.  Actual operating current would certainly be less than 50A, but in any case there would be significantly more power available compared to an IPM.  At these current levels, resistive current sensing might involve excessive power dissipation - detailed design of a higher current module is a task for later.


Might be able to use a power board in reverse as an AFE.  Would need filter components and line phase sensing.  But increased power factor would be nice, regen would be nice too.

Might be able to use a power board to switch a braking resistor.  Or I could build a braking resistor switch into the board to avoid needing another module just for that.  Or I could incorporate the braking resistor switch with a rectifier module...  need to weigh pros and cons of each approach.

#### Voltage Clearances
Design to 68100-5 standard.
I am going to assume polution degree 2, overvoltage catagory III.  System voltage is 300V (240V AC is in the 300V catagory).

Table 7 in section 4.3.6.1.5 of the spec says impulse voltage is 4000V anmd temporary overvoltage is 2120 peak, 1500 RMS.

Table 9 in section 4.3.6.4.1 has clearance distances.  For insulation between circuit and surroundings, temporary overvoltage and impulse voltage both require 3.0mm.  For functional insulation within the power circuit, repetitive peak is the limiting factor.  we could in principle use 0.5mm, but I am going to use a minimum of 0.8mm, with 1.5mm preferred.  For reinforced insulation between power and user accessible low voltage both impulse (one step up) and temporary overvoltage (1.6x) require 5.5mm.

Table 10 in section 4.3.6.5.2 as creepage distances.  Creepage considers only RMS working voltage, so I believe the limiting factor is the DC bus - RMS value of a DC voltage is that voltage.  Assuming rectified 240V line gives 340V DC.  Table 10 allows interpolation, so for pollution degree 2 on a board the creepage is 1.7mm.  Creepages are doubled for reinforced insulation, giving 3.4mm.

Choosing the larger of creepage and clearance for each use case results in these final design rules:  1.7mm between power traces, 3.0mm trace to ground, and 5.5mm trace to user-accessible low voltage.  In inches, those values are 67 mils, 118 mils, and 217 mils.
