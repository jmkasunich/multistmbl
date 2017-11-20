# MultiSTMBL

MultiSTMBL is a modular version of the STMBL servo drive.
The goal is to minimize cost per axis.  The target motors are
Yaskawa servos with serial absolute encoders, although other
motors may be supported as well.  The main cost reduction will be
as a result of assuming multiple axes, and sharing as many common
resources as possible between axes.

The STMBL project uses an STM32F3 microcontroller on the power
side of the isolation barrier to drive the power bridge and close
the current loops.  An STM32F4 microcontroller on the low voltage
side of the isolation barrier senses feedback from the encoder
and accepts commands from a higher-level control such as LinuxCNC
and closes the speed and position loops, sending phase angle and
current magnitude commands to the F3 controller over a fast serial
link.

Most of the hardware cost in a STMBL drive is the F4 controller and
its rather extensive and very flexible mix of I/O.  The MultiSTMBL
project hopes to amortize that cost over multiple axes.  The project
will have two boards - a power board with an F3 controller that is very
similar to the STMBL power section, and a control board with an F4
controller that is capable of running *multiple* power boards.  The 
exact number of power boards per control board will depend on chip 
resources, but will be a minimum of three.

An additional goal of MultiSTMBL is to cover a range of power modules.
The STMBL power stage is designed around the IRAM256 intelligent power
module.  That module has been discontinued.  As of November 2017, it
is still available from some dealers, but stocks are diminshing.
MultiSTMBL will have power board(s) that can work with several types of
IGBT modules.


