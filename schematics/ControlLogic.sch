EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 7 24
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 7650 1450 2    50   Output ~ 0
T0
Wire Wire Line
	5400 1750 5400 3000
Connection ~ 5400 1750
Wire Wire Line
	5850 1750 5400 1750
Wire Wire Line
	5450 1550 5450 1350
Connection ~ 5450 1550
Wire Wire Line
	5450 1550 5850 1550
Wire Wire Line
	5500 1350 5500 2800
Connection ~ 5500 1350
Wire Wire Line
	5850 1350 5500 1350
Connection ~ 5550 1150
Wire Wire Line
	5550 1150 5850 1150
Wire Wire Line
	6450 1550 6450 1650
Wire Wire Line
	6450 1250 6450 1350
$Comp
L 74xx:74LS32 U?
U 3 1 60142DEC
P 6750 1450
F 0 "U?" H 6750 1775 50  0000 C CNN
F 1 "74LS32" H 6750 1684 50  0000 C CNN
F 2 "" H 6750 1450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 6750 1450 50  0001 C CNN
	3    6750 1450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U?
U 2 1 60141D0B
P 6150 1650
F 0 "U?" H 6150 1975 50  0000 C CNN
F 1 "74LS32" H 6150 1884 50  0000 C CNN
F 2 "" H 6150 1650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 6150 1650 50  0001 C CNN
	2    6150 1650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U?
U 1 1 6013FAB9
P 6150 1250
F 0 "U?" H 6150 1575 50  0000 C CNN
F 1 "74LS32" H 6150 1484 50  0000 C CNN
F 2 "" H 6150 1250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 6150 1250 50  0001 C CNN
	1    6150 1250
	1    0    0    -1  
$EndComp
Text GLabel 6850 6100 2    50   Output ~ 0
FlagRegister_A2
Text GLabel 6850 6000 2    50   Output ~ 0
FlagRegister_A1
Text GLabel 6850 5900 2    50   Output ~ 0
FlagRegister_A0
Text GLabel 6850 5800 2    50   Output ~ 0
FlagRegister_RESET
Text GLabel 6850 5700 2    50   Output ~ 0
FlagRegister_SET
$Comp
L power:+5V #PWR?
U 1 1 5F2B1DC9
P 12700 6600
F 0 "#PWR?" H 12700 6450 50  0001 C CNN
F 1 "+5V" H 12715 6773 50  0000 C CNN
F 2 "" H 12700 6600 50  0001 C CNN
F 3 "" H 12700 6600 50  0001 C CNN
	1    12700 6600
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F2A3B98
P 4100 850
F 0 "#PWR?" H 4100 700 50  0001 C CNN
F 1 "+5V" H 4115 1023 50  0000 C CNN
F 2 "" H 4100 850 50  0001 C CNN
F 3 "" H 4100 850 50  0001 C CNN
	1    4100 850 
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F298BDF
P 4100 2750
F 0 "#PWR?" H 4100 2600 50  0001 C CNN
F 1 "+5V" H 4115 2923 50  0000 C CNN
F 2 "" H 4100 2750 50  0001 C CNN
F 3 "" H 4100 2750 50  0001 C CNN
	1    4100 2750
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F289E54
P 12700 4950
F 0 "#PWR?" H 12700 4800 50  0001 C CNN
F 1 "+5V" H 12715 5123 50  0000 C CNN
F 2 "" H 12700 4950 50  0001 C CNN
F 3 "" H 12700 4950 50  0001 C CNN
	1    12700 4950
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F2881A3
P 12700 3300
F 0 "#PWR?" H 12700 3150 50  0001 C CNN
F 1 "+5V" H 12715 3473 50  0000 C CNN
F 2 "" H 12700 3300 50  0001 C CNN
F 3 "" H 12700 3300 50  0001 C CNN
	1    12700 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 7800 1600 7800
Wire Wire Line
	7100 6400 7100 7800
Wire Wire Line
	6850 6400 7100 6400
Wire Wire Line
	1650 7750 1650 1250
Wire Wire Line
	7050 6500 6850 6500
Wire Wire Line
	7050 7750 7050 6500
Wire Wire Line
	1650 7750 7050 7750
Wire Wire Line
	1700 7700 1700 1350
Wire Wire Line
	7000 7700 1700 7700
Wire Wire Line
	7000 6600 7000 7700
Wire Wire Line
	6850 6600 7000 6600
Wire Wire Line
	1750 7650 1750 1450
Wire Wire Line
	6850 6700 6950 6700
Wire Wire Line
	6950 7650 1750 7650
Wire Wire Line
	6950 6700 6950 7650
Wire Wire Line
	10450 6800 6850 6800
Wire Wire Line
	6850 6900 10500 6900
Wire Wire Line
	10550 7000 6850 7000
Wire Wire Line
	6850 7100 10600 7100
Wire Wire Line
	6850 7200 10650 7200
Wire Wire Line
	6850 7300 10700 7300
Wire Wire Line
	6850 7400 10750 7400
$Comp
L power:GND #PWR?
U 1 1 5EF058CF
P 12700 7900
F 0 "#PWR?" H 12700 7650 50  0001 C CNN
F 1 "GND" H 12705 7727 50  0000 C CNN
F 2 "" H 12700 7900 50  0001 C CNN
F 3 "" H 12700 7900 50  0001 C CNN
	1    12700 7900
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EEF8F26
P 12700 6250
F 0 "#PWR?" H 12700 6000 50  0001 C CNN
F 1 "GND" H 12705 6077 50  0000 C CNN
F 2 "" H 12700 6250 50  0001 C CNN
F 3 "" H 12700 6250 50  0001 C CNN
	1    12700 6250
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EEED9B3
P 12700 4600
F 0 "#PWR?" H 12700 4350 50  0001 C CNN
F 1 "GND" H 12705 4427 50  0000 C CNN
F 2 "" H 12700 4600 50  0001 C CNN
F 3 "" H 12700 4600 50  0001 C CNN
	1    12700 4600
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EED3020
P 4100 2450
F 0 "#PWR?" H 4100 2200 50  0001 C CNN
F 1 "GND" H 4105 2277 50  0000 C CNN
F 2 "" H 4100 2450 50  0001 C CNN
F 3 "" H 4100 2450 50  0001 C CNN
	1    4100 2450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EEC60F8
P 4100 4650
F 0 "#PWR?" H 4100 4400 50  0001 C CNN
F 1 "GND" H 4105 4477 50  0000 C CNN
F 2 "" H 4100 4650 50  0001 C CNN
F 3 "" H 4100 4650 50  0001 C CNN
	1    4100 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EEC5B8C
P 3600 4350
F 0 "#PWR?" H 3600 4100 50  0001 C CNN
F 1 "GND" V 3605 4222 50  0000 R CNN
F 2 "" H 3600 4350 50  0001 C CNN
F 3 "" H 3600 4350 50  0001 C CNN
	1    3600 4350
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 1150 1600 7800
Wire Wire Line
	3600 1150 1600 1150
Wire Wire Line
	1650 1250 3600 1250
Wire Wire Line
	1700 1350 3600 1350
Wire Wire Line
	1750 1450 3600 1450
$Comp
L 74xx:74LS04 U?
U 3 1 5EAC4943
P 9150 5100
AR Path="/5E82FA95/5E834B88/5F222472/5EAC4943" Ref="U?"  Part="3" 
AR Path="/5E82FA95/5E834B7B/5EAC4943" Ref="U?"  Part="3" 
F 0 "U?" H 9150 5417 50  0000 C CNN
F 1 "74LS04" H 9150 5326 50  0000 C CNN
F 2 "" H 9150 5100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 5100 50  0001 C CNN
	3    9150 5100
	1    0    0    -1  
$EndComp
Wire Bus Line
	5200 2550 2500 2550
Wire Wire Line
	5550 2700 6300 2700
Wire Wire Line
	5550 1150 5550 2700
Wire Wire Line
	4600 1150 5550 1150
Wire Wire Line
	5500 2800 6300 2800
Wire Wire Line
	5500 1250 5500 1350
Wire Wire Line
	4600 1250 5500 1250
Wire Wire Line
	5450 1350 4600 1350
Wire Wire Line
	5450 2900 5450 1550
Wire Wire Line
	6300 2900 5450 2900
Wire Wire Line
	5400 3000 6300 3000
Wire Wire Line
	5400 1450 5400 1750
Wire Wire Line
	4600 1450 5400 1450
Wire Wire Line
	5050 3100 6300 3100
Wire Wire Line
	5050 3050 5050 3100
Wire Wire Line
	4600 3050 5050 3050
Wire Wire Line
	5050 3200 6300 3200
Wire Wire Line
	5050 3350 5050 3200
Wire Wire Line
	4600 3350 5050 3350
Wire Wire Line
	5450 3300 6300 3300
Wire Wire Line
	5450 3250 5450 3300
Wire Wire Line
	5100 3250 5450 3250
Wire Wire Line
	5100 3650 5100 3250
Wire Wire Line
	4600 3650 5100 3650
Wire Wire Line
	5400 3400 6300 3400
Wire Wire Line
	5400 3300 5400 3400
Wire Wire Line
	5150 3300 5400 3300
Wire Wire Line
	5150 3950 5150 3300
Wire Wire Line
	4600 3950 5150 3950
Text HLabel 3600 3950 0    50   Input ~ 0
OVERFLOW_FLAG
Text HLabel 3600 3650 0    50   Input ~ 0
NEGATIVE_FLAG
Text HLabel 3600 3350 0    50   Input ~ 0
CARRY_FLAG
Text HLabel 3600 3050 0    50   Input ~ 0
ZERO_FLAG
$Comp
L 74xx:74LS157 U?
U 1 1 5EC7C4DB
P 4100 3650
F 0 "U?" H 4100 4731 50  0000 C CNN
F 1 "74LS157" H 4100 4640 50  0000 C CNN
F 2 "" H 4100 3650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 4100 3650 50  0001 C CNN
	1    4100 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 1800 3600 1850
Connection ~ 3600 1800
Wire Wire Line
	3600 1750 3600 1800
$Comp
L power:+5V #PWR?
U 1 1 5EBEDF57
P 3600 1800
F 0 "#PWR?" H 3600 1650 50  0001 C CNN
F 1 "+5V" V 3615 1928 50  0000 L CNN
F 2 "" H 3600 1800 50  0001 C CNN
F 3 "" H 3600 1800 50  0001 C CNN
	1    3600 1800
	0    -1   -1   0   
$EndComp
Text GLabel 3600 1650 0    50   Input ~ 0
~SetStepCounter
Text GLabel 3600 2150 0    50   Input ~ 0
~RST
Text GLabel 3600 1950 0    50   Input ~ 0
CLK
$Comp
L 74xx:74LS04 U?
U 1 1 5EAC494F
P 9150 4500
AR Path="/5E82FA95/5E834B88/5F222472/5EAC494F" Ref="U?"  Part="1" 
AR Path="/5E82FA95/5E834B7B/5EAC494F" Ref="U?"  Part="1" 
F 0 "U?" H 9150 4817 50  0000 C CNN
F 1 "74LS04" H 9150 4726 50  0000 C CNN
F 2 "" H 9150 4500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 4500 50  0001 C CNN
	1    9150 4500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 2 1 5EAC4949
P 9150 4800
AR Path="/5E82FA95/5E834B88/5F222472/5EAC4949" Ref="U?"  Part="2" 
AR Path="/5E82FA95/5E834B7B/5EAC4949" Ref="U?"  Part="2" 
F 0 "U?" H 9150 5117 50  0000 C CNN
F 1 "74LS04" H 9150 5026 50  0000 C CNN
F 2 "" H 9150 4800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 4800 50  0001 C CNN
	2    9150 4800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 4 1 5EAC493D
P 9150 5400
AR Path="/5E82FA95/5E834B88/5F222472/5EAC493D" Ref="U?"  Part="4" 
AR Path="/5E82FA95/5E834B7B/5EAC493D" Ref="U?"  Part="4" 
F 0 "U?" H 9150 5717 50  0000 C CNN
F 1 "74LS04" H 9150 5626 50  0000 C CNN
F 2 "" H 9150 5400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 5400 50  0001 C CNN
	4    9150 5400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 1 1 5EA70BD4
P 9150 2700
AR Path="/5E82FA95/5E834B88/5F222472/5EA70BD4" Ref="U?"  Part="1" 
AR Path="/5E82FA95/5E834B7B/5EA70BD4" Ref="U?"  Part="1" 
F 0 "U?" H 9150 3017 50  0000 C CNN
F 1 "74LS04" H 9150 2926 50  0000 C CNN
F 2 "" H 9150 2700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 2700 50  0001 C CNN
	1    9150 2700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 2 1 5EA70BCE
P 9150 3000
AR Path="/5E82FA95/5E834B88/5F222472/5EA70BCE" Ref="U?"  Part="2" 
AR Path="/5E82FA95/5E834B7B/5EA70BCE" Ref="U?"  Part="2" 
F 0 "U?" H 9150 3317 50  0000 C CNN
F 1 "74LS04" H 9150 3226 50  0000 C CNN
F 2 "" H 9150 3000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 3000 50  0001 C CNN
	2    9150 3000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 3 1 5EA70BC8
P 9150 3300
AR Path="/5E82FA95/5E834B88/5F222472/5EA70BC8" Ref="U?"  Part="3" 
AR Path="/5E82FA95/5E834B7B/5EA70BC8" Ref="U?"  Part="3" 
F 0 "U?" H 9150 3617 50  0000 C CNN
F 1 "74LS04" H 9150 3526 50  0000 C CNN
F 2 "" H 9150 3300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 3300 50  0001 C CNN
	3    9150 3300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 4 1 5EA70BC2
P 9150 3600
AR Path="/5E82FA95/5E834B88/5F222472/5EA70BC2" Ref="U?"  Part="4" 
AR Path="/5E82FA95/5E834B7B/5EA70BC2" Ref="U?"  Part="4" 
F 0 "U?" H 9150 3917 50  0000 C CNN
F 1 "74LS04" H 9150 3826 50  0000 C CNN
F 2 "" H 9150 3600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 3600 50  0001 C CNN
	4    9150 3600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 5 1 5EA70BBC
P 9150 3900
AR Path="/5E82FA95/5E834B88/5F222472/5EA70BBC" Ref="U?"  Part="5" 
AR Path="/5E82FA95/5E834B7B/5EA70BBC" Ref="U?"  Part="5" 
F 0 "U?" H 9150 4217 50  0000 C CNN
F 1 "74LS04" H 9150 4126 50  0000 C CNN
F 2 "" H 9150 3900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 3900 50  0001 C CNN
	5    9150 3900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 6 1 5EA70BB6
P 9150 4200
AR Path="/5E82FA95/5E834B88/5F222472/5EA70BB6" Ref="U?"  Part="6" 
AR Path="/5E82FA95/5E834B7B/5EA70BB6" Ref="U?"  Part="6" 
F 0 "U?" H 9150 4517 50  0000 C CNN
F 1 "74LS04" H 9150 4426 50  0000 C CNN
F 2 "" H 9150 4200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 4200 50  0001 C CNN
	6    9150 4200
	1    0    0    -1  
$EndComp
Entry Wire Line
	5200 4400 5300 4500
Entry Wire Line
	5200 4300 5300 4400
Entry Wire Line
	5200 4200 5300 4300
Entry Wire Line
	5200 4100 5300 4200
Entry Wire Line
	5200 4000 5300 4100
Entry Wire Line
	5200 3900 5300 4000
Entry Wire Line
	5200 3800 5300 3900
Entry Wire Line
	5200 3700 5300 3800
Entry Wire Line
	5200 3600 5300 3700
Entry Wire Line
	5200 3500 5300 3600
Entry Wire Line
	5200 3400 5300 3500
Entry Wire Line
	2500 3950 2600 4050
Entry Wire Line
	2500 3650 2600 3750
Entry Wire Line
	2500 3350 2600 3450
Entry Wire Line
	2500 3050 2600 3150
Wire Wire Line
	5300 4500 6300 4500
Wire Wire Line
	5300 4400 6300 4400
Wire Wire Line
	5300 4300 6300 4300
Wire Wire Line
	5300 4200 6300 4200
Wire Wire Line
	5300 4100 6300 4100
Wire Wire Line
	5300 4000 6300 4000
Wire Wire Line
	5300 3900 6300 3900
Wire Wire Line
	5300 3800 6300 3800
Wire Wire Line
	5300 3700 6300 3700
Wire Wire Line
	5300 3600 6300 3600
Wire Wire Line
	5300 3500 6300 3500
Wire Wire Line
	2600 4050 3600 4050
Wire Wire Line
	2600 3750 3600 3750
Wire Wire Line
	2600 3450 3600 3450
Wire Wire Line
	2600 3150 3600 3150
Text Label 5500 4500 0    50   ~ 0
INSTRUCTION_14
Text Label 5500 4400 0    50   ~ 0
INSTRUCTION_13
Text Label 5500 4300 0    50   ~ 0
INSTRUCTION_12
Text Label 5500 4200 0    50   ~ 0
INSTRUCTION_11
Text Label 5500 4100 0    50   ~ 0
INSTRUCTION_10
Text Label 5500 4000 0    50   ~ 0
INSTRUCTION_9
Text Label 5500 3900 0    50   ~ 0
INSTRUCTION_8
Text Label 5500 3800 0    50   ~ 0
INSTRUCTION_7
Text Label 5500 3700 0    50   ~ 0
INSTRUCTION_6
Text Label 5500 3600 0    50   ~ 0
INSTRUCTION_5
Text Label 5500 3500 0    50   ~ 0
INSTRUCTION_4
Text Label 2800 4050 0    50   ~ 0
INSTRUCTION_3
Text Label 2800 3750 0    50   ~ 0
INSTRUCTION_2
Text Label 2800 3450 0    50   ~ 0
INSTRUCTION_1
Text Label 2800 3150 0    50   ~ 0
INSTRUCTION_0
Wire Wire Line
	10750 7100 10750 7400
Wire Wire Line
	10700 7000 10700 7300
Wire Wire Line
	10650 6900 10650 7200
Wire Wire Line
	10600 5850 10600 7100
Wire Wire Line
	10550 5450 10550 7000
Wire Wire Line
	10500 5350 10500 6900
Wire Wire Line
	10450 5250 10450 6800
Text GLabel 6850 2800 2    50   Output ~ 0
Halt
Text GLabel 9450 2700 2    50   Output ~ 0
~SetStepCounter
Connection ~ 11850 5250
Wire Wire Line
	10450 5250 11850 5250
Connection ~ 11800 5350
Wire Wire Line
	10500 5350 11800 5350
Connection ~ 11750 5450
Wire Wire Line
	10550 5450 11750 5450
Connection ~ 11700 5850
Wire Wire Line
	10600 5850 11700 5850
Wire Wire Line
	11700 5850 12200 5850
Wire Wire Line
	11700 4300 11700 5850
Wire Wire Line
	12200 4300 11700 4300
Wire Wire Line
	10650 6900 12200 6900
Wire Wire Line
	10700 7000 12200 7000
Wire Wire Line
	10750 7100 12200 7100
$Sheet
S 6300 2600 550  4900
U 5EDC8B23
F0 "Flashs" 50
F1 "Flashs.sch" 50
F2 "A0" I L 6300 2700 50 
F3 "A1" I L 6300 2800 50 
F4 "A2" I L 6300 2900 50 
F5 "A3" I L 6300 3000 50 
F6 "A4" I L 6300 3100 50 
F7 "A5" I L 6300 3200 50 
F8 "A6" I L 6300 3300 50 
F9 "A7" I L 6300 3400 50 
F10 "A8" I L 6300 3500 50 
F11 "A9" I L 6300 3600 50 
F12 "A10" I L 6300 3700 50 
F13 "A11" I L 6300 3800 50 
F14 "A12" I L 6300 3900 50 
F15 "A13" I L 6300 4000 50 
F16 "A14" I L 6300 4100 50 
F17 "A15" I L 6300 4200 50 
F18 "A16" I L 6300 4300 50 
F19 "A17" I L 6300 4400 50 
F20 "A18" I L 6300 4500 50 
F21 "D0" O R 6850 2700 50 
F22 "D1" O R 6850 2800 50 
F23 "D2" O R 6850 2900 50 
F24 "D3" O R 6850 3000 50 
F25 "D4" O R 6850 3100 50 
F26 "D5" O R 6850 3200 50 
F27 "D6" O R 6850 3300 50 
F28 "D7" O R 6850 3400 50 
F29 "D8" O R 6850 3500 50 
F30 "D9" O R 6850 3600 50 
F31 "D10" O R 6850 3700 50 
F32 "D11" O R 6850 3800 50 
F33 "D12" O R 6850 3900 50 
F34 "D13" O R 6850 4000 50 
F35 "D14" O R 6850 4100 50 
F36 "D15" O R 6850 4200 50 
F37 "D16" O R 6850 4300 50 
F38 "D17" O R 6850 4400 50 
F39 "D18" O R 6850 4500 50 
F40 "D19" O R 6850 4600 50 
F41 "D20" O R 6850 4700 50 
F42 "D21" O R 6850 4800 50 
F43 "D22" O R 6850 4900 50 
F44 "D23" O R 6850 5000 50 
F45 "D24" O R 6850 5100 50 
F46 "D25" O R 6850 5200 50 
F47 "D26" O R 6850 5300 50 
F48 "D27" O R 6850 5400 50 
F49 "D28" O R 6850 5500 50 
F50 "D29" O R 6850 5600 50 
F51 "D30" O R 6850 5700 50 
F52 "D31" O R 6850 5800 50 
F53 "D32" O R 6850 5900 50 
F54 "D33" O R 6850 6000 50 
F55 "D34" O R 6850 6100 50 
F56 "D35" O R 6850 6200 50 
F57 "D36" O R 6850 6300 50 
F58 "D37" O R 6850 6400 50 
F59 "D38" O R 6850 6500 50 
F60 "D39" O R 6850 6600 50 
F61 "D40" O R 6850 6700 50 
F62 "D41" O R 6850 6800 50 
F63 "D42" O R 6850 6900 50 
F64 "D43" O R 6850 7000 50 
F65 "D44" O R 6850 7100 50 
F66 "D45" O R 6850 7200 50 
F67 "D46" O R 6850 7300 50 
F68 "D47" O R 6850 7400 50 
$EndSheet
Text GLabel 6850 3600 2    50   Output ~ 0
ALU_F0
Text GLabel 6850 3700 2    50   Output ~ 0
ALU_F1
Text GLabel 6850 3800 2    50   Output ~ 0
ALU_F2
Text GLabel 6850 3900 2    50   Output ~ 0
ALU_F3
Text GLabel 6850 4000 2    50   Output ~ 0
ALU_F4
Text GLabel 6850 5500 2    50   Output ~ 0
FlagRegister_IN
Text GLabel 6850 5400 2    50   Output ~ 0
InstructionRegister_IN
Text GLabel 6850 2900 2    50   Output ~ 0
RegisterA_IN
Text GLabel 6850 3000 2    50   Output ~ 0
RegisterB_IN
Text GLabel 6850 3100 2    50   Output ~ 0
RegisterC_IN
Text GLabel 6850 3200 2    50   Output ~ 0
RegisterD_IN
Text GLabel 6850 3300 2    50   Output ~ 0
RegisterW_IN
Text GLabel 6850 3500 2    50   Output ~ 0
RegisterZ_CLEAR
Text GLabel 6850 3400 2    50   Output ~ 0
RegisterZ_IN
Text GLabel 9450 3900 2    50   Output ~ 0
~ProgramCounter_IN
Text GLabel 9450 4800 2    50   Output ~ 0
~RegisterX_IN
Text GLabel 9450 5700 2    50   Output ~ 0
~RegisterY_IN
Text GLabel 9450 3000 2    50   Output ~ 0
~StackPointer_IN
Text GLabel 6850 5300 2    50   Output ~ 0
AddressLatch_IN
Wire Wire Line
	13200 4800 13800 4800
Wire Wire Line
	13200 4300 13200 4800
$Comp
L power:GND #PWR?
U 1 1 5ED822D5
P 12200 7500
F 0 "#PWR?" H 12200 7250 50  0001 C CNN
F 1 "GND" V 12205 7372 50  0000 R CNN
F 2 "" H 12200 7500 50  0001 C CNN
F 3 "" H 12200 7500 50  0001 C CNN
	1    12200 7500
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5ED80C18
P 12200 7600
F 0 "#PWR?" H 12200 7450 50  0001 C CNN
F 1 "+5V" V 12215 7728 50  0000 L CNN
F 2 "" H 12200 7600 50  0001 C CNN
F 3 "" H 12200 7600 50  0001 C CNN
	1    12200 7600
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ED80C12
P 12200 7400
F 0 "#PWR?" H 12200 7150 50  0001 C CNN
F 1 "GND" V 12205 7272 50  0000 R CNN
F 2 "" H 12200 7400 50  0001 C CNN
F 3 "" H 12200 7400 50  0001 C CNN
	1    12200 7400
	0    1    1    0   
$EndComp
Wire Wire Line
	13300 4500 13800 4500
Wire Wire Line
	13300 4100 13300 4500
Wire Wire Line
	13200 4100 13300 4100
Wire Wire Line
	13250 4650 13800 4650
Wire Wire Line
	13250 4200 13250 4650
Wire Wire Line
	13200 4200 13250 4200
Wire Wire Line
	13550 4950 13800 4950
Wire Wire Line
	13550 5250 13550 4950
Wire Wire Line
	13200 5250 13550 5250
Wire Wire Line
	13600 5100 13800 5100
Wire Wire Line
	13600 5350 13600 5100
Wire Wire Line
	13200 5350 13600 5350
Wire Wire Line
	13650 5250 13800 5250
Wire Wire Line
	13650 5450 13650 5250
Wire Wire Line
	13200 5450 13650 5450
Wire Wire Line
	13700 5400 13800 5400
Wire Wire Line
	13700 5550 13700 5400
Wire Wire Line
	13200 5550 13700 5550
Wire Wire Line
	13750 5550 13800 5550
Wire Wire Line
	13750 5650 13750 5550
Wire Wire Line
	13200 5650 13750 5650
Wire Wire Line
	13750 5700 13800 5700
Wire Wire Line
	13750 5750 13750 5700
Wire Wire Line
	13200 5750 13750 5750
Wire Wire Line
	13200 5850 13800 5850
Wire Wire Line
	11750 5450 12200 5450
Wire Wire Line
	11750 3800 11750 5450
Wire Wire Line
	12200 3800 11750 3800
Wire Wire Line
	11800 3700 12200 3700
Wire Wire Line
	11800 5350 11800 3700
Wire Wire Line
	12200 5350 11800 5350
Wire Wire Line
	11850 5250 12200 5250
Wire Wire Line
	11850 3600 12200 3600
Wire Wire Line
	11850 5250 11850 3600
$Comp
L power:+5V #PWR?
U 1 1 5ED69521
P 12200 5950
F 0 "#PWR?" H 12200 5800 50  0001 C CNN
F 1 "+5V" V 12215 6078 50  0000 L CNN
F 2 "" H 12200 5950 50  0001 C CNN
F 3 "" H 12200 5950 50  0001 C CNN
	1    12200 5950
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ED681B9
P 12200 4200
F 0 "#PWR?" H 12200 3950 50  0001 C CNN
F 1 "GND" V 12205 4072 50  0000 R CNN
F 2 "" H 12200 4200 50  0001 C CNN
F 3 "" H 12200 4200 50  0001 C CNN
	1    12200 4200
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ED67EF1
P 12200 5750
F 0 "#PWR?" H 12200 5500 50  0001 C CNN
F 1 "GND" V 12205 5622 50  0000 R CNN
F 2 "" H 12200 5750 50  0001 C CNN
F 3 "" H 12200 5750 50  0001 C CNN
	1    12200 5750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ED67416
P 12200 4100
F 0 "#PWR?" H 12200 3850 50  0001 C CNN
F 1 "GND" V 12205 3972 50  0000 R CNN
F 2 "" H 12200 4100 50  0001 C CNN
F 3 "" H 12200 4100 50  0001 C CNN
	1    12200 4100
	0    1    1    0   
$EndComp
$Comp
L 74xx:74LS137 U?
U 1 1 5ED66111
P 12700 3900
F 0 "U?" H 12700 4681 50  0000 C CNN
F 1 "74LS137" H 12700 4590 50  0000 C CNN
F 2 "" H 12700 3900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS137" H 12700 3900 50  0001 C CNN
	1    12700 3900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS137 U?
U 1 1 5ED6596B
P 12700 5550
F 0 "U?" H 12700 6331 50  0000 C CNN
F 1 "74LS137" H 12700 6240 50  0000 C CNN
F 2 "" H 12700 5550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS137" H 12700 5550 50  0001 C CNN
	1    12700 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	13450 6900 13650 6900
Wire Wire Line
	13450 7100 13450 6900
Wire Wire Line
	13200 7100 13450 7100
Wire Wire Line
	13500 7050 13650 7050
Wire Wire Line
	13500 7200 13500 7050
Wire Wire Line
	13200 7200 13500 7200
Wire Wire Line
	13550 7200 13650 7200
Wire Wire Line
	13550 7300 13550 7200
Wire Wire Line
	13200 7300 13550 7300
Wire Wire Line
	13550 7350 13650 7350
Wire Wire Line
	13550 7400 13550 7350
Wire Wire Line
	13200 7400 13550 7400
Wire Wire Line
	13200 7500 13650 7500
$Comp
L 74xx:74LS137 U?
U 1 1 5ED60C13
P 12700 7200
F 0 "U?" H 12700 7981 50  0000 C CNN
F 1 "74LS137" H 12700 7890 50  0000 C CNN
F 2 "" H 12700 7200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS137" H 12700 7200 50  0001 C CNN
	1    12700 7200
	1    0    0    -1  
$EndComp
Text GLabel 6850 6200 2    50   Output ~ 0
DataBuffer_IN
Text GLabel 13650 6900 2    50   Output ~ 0
~AddressLatch_OUT_ADDRESS
Text GLabel 13800 4800 2    50   Output ~ 0
~StackPointer_OUT_DATA
Text GLabel 13650 7350 2    50   Output ~ 0
~StackPointer_OUT_ADDRESS
Text GLabel 13800 5100 2    50   Output ~ 0
~RegisterY_OUT_DATA
Text GLabel 13650 7050 2    50   Output ~ 0
~RegisterY_OUT_ADDRESS
Text GLabel 13800 5250 2    50   Output ~ 0
~RegisterX_OUT_DATA
Text GLabel 13650 7200 2    50   Output ~ 0
~RegisterX_OUT_ADDRESS
Text GLabel 13800 5400 2    50   Output ~ 0
~RegisterD_OUT
Text GLabel 13800 5550 2    50   Output ~ 0
~RegisterC_OUT
Text GLabel 13800 5700 2    50   Output ~ 0
~RegisterB_OUT
Text GLabel 13800 5850 2    50   Output ~ 0
~RegisterA_OUT
Text GLabel 13800 4950 2    50   Output ~ 0
~ProgramCounter_OUT_DATA
Text GLabel 13650 7500 2    50   Output ~ 0
~ProgramCounter_OUT_ADDRESS
Text GLabel 13800 4500 2    50   Output ~ 0
~FlagsRegister_OUT
Text GLabel 13800 4650 2    50   Output ~ 0
~ALU_OUT
Text HLabel 2500 2550 0    50   Input ~ 0
INSTRUCTION
$Comp
L 74xx:74LS161 U?
U 1 1 5E8D293A
P 4100 1650
F 0 "U?" H 4100 2631 50  0000 C CNN
F 1 "74LS161" H 4100 2540 50  0000 C CNN
F 2 "" H 4100 1650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 4100 1650 50  0001 C CNN
	1    4100 1650
	1    0    0    -1  
$EndComp
Text GLabel 13800 4350 2    50   Output ~ 0
~DataBuffer_OUT
Wire Wire Line
	13200 4000 13350 4000
Wire Wire Line
	13350 4000 13350 4350
Wire Wire Line
	13350 4350 13800 4350
Text GLabel 9450 4200 2    50   Output ~ 0
~ProgramCounter_COUNT_UP
Text GLabel 9450 4500 2    50   Output ~ 0
~ProgramCounter_COUNT_DOWN
Text GLabel 9450 3600 2    50   Output ~ 0
~StackPointer_COUNT_DOWN
Text GLabel 9450 5400 2    50   Output ~ 0
~RegisterX_COUNT_DOWN
Text GLabel 9450 6300 2    50   Output ~ 0
~RegisterY_COUNT_DOWN
Text GLabel 9450 6000 2    50   Output ~ 0
~RegisterY_COUNT_UP
Text GLabel 9450 5100 2    50   Output ~ 0
~RegisterX_COUNT_UP
Text GLabel 9450 3300 2    50   Output ~ 0
~StackPointer_COUNT_UP
$Comp
L 74xx:74LS04 U?
U 5 1 61CE0B43
P 9150 5700
F 0 "U?" H 9150 6017 50  0000 C CNN
F 1 "74LS04" H 9150 5926 50  0000 C CNN
F 2 "" H 9150 5700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 5700 50  0001 C CNN
	5    9150 5700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 6 1 61CE1EC3
P 9150 6000
F 0 "U?" H 9150 6317 50  0000 C CNN
F 1 "74LS04" H 9150 6226 50  0000 C CNN
F 2 "" H 9150 6000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 6000 50  0001 C CNN
	6    9150 6000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 1 1 61CE3310
P 9150 6300
F 0 "U?" H 9150 6617 50  0000 C CNN
F 1 "74LS04" H 9150 6526 50  0000 C CNN
F 2 "" H 9150 6300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 6300 50  0001 C CNN
	1    9150 6300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 2 1 61CE65A6
P 7350 1450
F 0 "U?" H 7350 1767 50  0000 C CNN
F 1 "74LS04" H 7350 1676 50  0000 C CNN
F 2 "" H 7350 1450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 7350 1450 50  0001 C CNN
	2    7350 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 2700 6850 2700
Wire Wire Line
	6850 4100 7600 4100
Wire Wire Line
	7600 4100 7600 3000
Wire Wire Line
	7600 3000 8850 3000
Wire Wire Line
	6850 4200 7650 4200
Wire Wire Line
	7650 4200 7650 3300
Wire Wire Line
	7650 3300 8850 3300
Wire Wire Line
	6850 4300 7700 4300
Wire Wire Line
	7700 4300 7700 3600
Wire Wire Line
	7700 3600 8850 3600
Wire Wire Line
	6850 4400 7750 4400
Wire Wire Line
	7750 4400 7750 3900
Wire Wire Line
	7750 3900 8850 3900
Wire Wire Line
	6850 4500 7800 4500
Wire Wire Line
	7800 4500 7800 4200
Wire Wire Line
	7800 4200 8850 4200
Wire Wire Line
	6850 4600 7850 4600
Wire Wire Line
	7850 4600 7850 4500
Wire Wire Line
	7850 4500 8850 4500
Wire Wire Line
	6850 5200 8200 5200
Wire Wire Line
	8200 5200 8200 6300
Wire Wire Line
	8200 6300 8850 6300
Wire Wire Line
	6850 5100 8250 5100
Wire Wire Line
	8250 5100 8250 6000
Wire Wire Line
	8250 6000 8850 6000
Wire Wire Line
	6850 5000 8300 5000
Wire Wire Line
	8300 5000 8300 5700
Wire Wire Line
	8300 5700 8850 5700
Wire Wire Line
	6850 4900 8350 4900
Wire Wire Line
	8350 4900 8350 5400
Wire Wire Line
	8350 5400 8850 5400
Wire Wire Line
	6850 4800 8400 4800
Wire Wire Line
	8400 4800 8400 5100
Wire Wire Line
	8400 5100 8850 5100
Wire Wire Line
	6850 4700 8450 4700
Wire Wire Line
	8450 4700 8450 4800
Wire Wire Line
	8450 4800 8850 4800
Entry Wire Line
	2500 4150 2600 4250
Wire Wire Line
	2600 4250 3600 4250
Text Label 2800 4250 0    50   ~ 0
INSTRUCTION_15
Text GLabel 6850 5600 2    50   Output ~ 0
FlagRegister_SELECT_BUS_~FLAGS
Wire Bus Line
	2500 2550 2500 4150
Wire Bus Line
	5200 2550 5200 4400
$EndSCHEMATC