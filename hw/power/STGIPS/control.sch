EESchema Schematic File Version 2
LIBS:multistmbl
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:stmbl
LIBS:STGIPS-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
Title "MultiSTMBL Power Board - Control Section"
Date "2017-11-21"
Rev ""
Comp "Open Source Hardware"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L COM #COM?
U 1 1 5A13F7B1
P 5700 5400
F 0 "#COM?" H 5700 5450 60  0001 C CNN
F 1 "COM" H 5700 5250 60  0000 C CNN
F 2 "" H 5700 5400 60  0001 C CNN
F 3 "" H 5700 5400 60  0001 C CNN
	1    5700 5400
	1    0    0    -1  
$EndComp
$Comp
L STM32F303CBTx U?
U 1 1 5A13F7EC
P 5800 3700
F 0 "U?" H 5300 5350 50  0000 L BNN
F 1 "STM32F303CBTx" H 6200 4400 50  0000 R BNN
F 2 "LQFP48" H 6000 4350 50  0000 R TNN
F 3 "" H 6250 3800 50  0000 C CNN
	1    5800 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 5200 5700 5400
Wire Wire Line
	5800 5200 5800 5300
Wire Wire Line
	5700 5300 6000 5300
Connection ~ 5700 5300
Wire Wire Line
	5900 5300 5900 5200
Connection ~ 5800 5300
Wire Wire Line
	6000 5300 6000 5200
Connection ~ 5900 5300
$EndSCHEMATC
