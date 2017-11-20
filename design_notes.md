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
[SW4STM32](http://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-ides/sw4stm32.html) is based on GCC + Eclipse
[STM-STUDIO-STM32](http://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-performance-and-debuggers/stm-studio-stm32.html) uses STLINK to monitor RAM variables in real time - might be handy.  Windows only.  Not needed for build, just for testing.


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
* Exterbal +15V is stepped down (buck converter) to +3.3V for processor.
* USB port for ?? (dangerous on un-isolated power)
* JTAG/Debug port (dangerous on un-isolated power)
* High-speed UART link to controller board - isolated.  Maybe differential (RS422)
* HIgh and low side gate drivers
* current feedback with low side shunts (no high-side ground fault protection - calculated risk)
* Low side IOC using internal comparators
* Bus voltage measurement
* Output voltage measurement

Might be able to use a power board in reverse as an AFE.  Would need filter components and line phase sensing.  But increased power factor would be nice, regen would be nice too.
Might be able to use a power board to switch a braking resistor.  Or I could build a braking resistor switch into the board to avoid needing another module just for that.  Or I could incorporate the braking resistor switch with a rectifier module...  need to weigh pros and cons of each approach.

