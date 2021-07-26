EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 8268 11693 portrait
encoding utf-8
Sheet 2 24
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 5650 4000 550  400 
U 5E834B51
F0 "RegisterA" 50
F1 "Register.sch" 50
F2 "IN" I L 5650 4200 50 
F3 "~OUT" I L 5650 4300 50 
F4 "DATA_BUS" T L 5650 4100 50 
$EndSheet
Text Label 1600 2200 0    50   ~ 0
ADDRESS_BUS
$Sheet
S 5650 4750 550  400 
U 5E834B58
F0 "RegisterB" 50
F1 "Register.sch" 50
F2 "IN" I L 5650 4950 50 
F3 "~OUT" I L 5650 5050 50 
F4 "DATA_BUS" T L 5650 4850 50 
$EndSheet
$Sheet
S 5650 5500 550  400 
U 5E834B5D
F0 "RegisterC" 50
F1 "Register.sch" 50
F2 "IN" I L 5650 5700 50 
F3 "~OUT" I L 5650 5800 50 
F4 "DATA_BUS" T L 5650 5600 50 
$EndSheet
$Sheet
S 5650 6250 550  400 
U 5E834B62
F0 "RegisterD" 50
F1 "Register.sch" 50
F2 "IN" I L 5650 6450 50 
F3 "~OUT" I L 5650 6550 50 
F4 "DATA_BUS" T L 5650 6350 50 
$EndSheet
Wire Bus Line
	5650 6350 4700 6350
Wire Bus Line
	5650 5600 4700 5600
Wire Bus Line
	5650 4850 4700 4850
Wire Bus Line
	5650 4100 4700 4100
Connection ~ 4700 2350
Wire Bus Line
	4100 2350 4700 2350
Text Label 4700 2350 2    50   ~ 0
DATA_BUS
$Sheet
S 5050 6950 1150 500 
U 5E834B7B
F0 "ControlLogic" 50
F1 "ControlLogic.sch" 50
F2 "INSTRUCTION" I R 6200 7050 50 
F3 "ZERO_FLAG" I L 5050 7050 50 
F4 "CARRY_FLAG" I L 5050 7150 50 
F5 "NEGATIVE_FLAG" I L 5050 7250 50 
F6 "OVERFLOW_FLAG" I L 5050 7350 50 
$EndSheet
Wire Bus Line
	4100 6600 4700 6600
$Sheet
S 3200 7800 900  1350
U 5E834B88
F0 "ALU" 50
F1 "ALU.sch" 50
F2 "DATA_BUS" T R 4100 7900 50 
F3 "F0" I L 3200 8250 50 
F4 "F1" I L 3200 8350 50 
F5 "F2" I L 3200 8450 50 
F6 "F3" I L 3200 8550 50 
F7 "W_BUS" I L 3200 7900 50 
F8 "Z_BUS" I L 3200 8000 50 
F9 "F4" I L 3200 8650 50 
F10 "CARRY_IN" I L 3200 8800 50 
F11 "CARRY_OUT" O R 4100 8150 50 
F12 "OVERFLOW_OUT" O R 4100 8250 50 
F13 "OVERFLOW_IN" I L 3200 8900 50 
F14 "~OUT" I L 3200 9050 50 
$EndSheet
Wire Bus Line
	4100 7200 4700 7200
Wire Bus Line
	4100 7900 4700 7900
Wire Bus Line
	3200 6600 3050 6600
Wire Bus Line
	3050 6600 3050 7900
Wire Bus Line
	3050 7900 3200 7900
Wire Bus Line
	3200 7200 3000 7200
Wire Bus Line
	3000 7200 3000 8000
Wire Bus Line
	3000 8000 3200 8000
$Sheet
S 3200 6500 900  350 
U 5E834B95
F0 "RegisterW" 50
F1 "RegisterW.sch" 50
F2 "IN" I L 3200 6750 50 
F3 "DATA_BUS" I R 4100 6600 50 
F4 "W_BUS" O L 3200 6600 50 
$EndSheet
$Sheet
S 3200 7100 900  450 
U 5E834B9B
F0 "RegisterZ" 50
F1 "RegisterZ.sch" 50
F2 "IN" I L 3200 7350 50 
F3 "DATA_BUS" I R 4100 7200 50 
F4 "Z_BUS" O L 3200 7200 50 
F5 "CLEAR" I L 3200 7450 50 
$EndSheet
Wire Bus Line
	4100 3400 4700 3400
$Sheet
S 3000 3300 1100 750 
U 5E834BB1
F0 "StackPointer" 50
F1 "AddressRegister.sch" 50
F2 "DATA_BUS" T R 4100 3400 50 
F3 "ADDRESS_BUS" T L 3000 3400 50 
F4 "~IN" I L 3000 3750 50 
F5 "~OUT_DATA" I L 3000 3850 50 
F6 "~OUT_ADDRESS" I L 3000 3950 50 
F7 "~COUNT_DOWN" I L 3000 3650 50 
F8 "~COUNT_UP" I L 3000 3550 50 
$EndSheet
Wire Bus Line
	4100 4450 4700 4450
$Sheet
S 3000 4350 1100 750 
U 5E834BBB
F0 "RegisterX" 50
F1 "AddressRegister.sch" 50
F2 "DATA_BUS" T R 4100 4450 50 
F3 "ADDRESS_BUS" T L 3000 4450 50 
F4 "~IN" I L 3000 4800 50 
F5 "~OUT_DATA" I L 3000 4900 50 
F6 "~OUT_ADDRESS" I L 3000 5000 50 
F7 "~COUNT_DOWN" I L 3000 4700 50 
F8 "~COUNT_UP" I L 3000 4600 50 
$EndSheet
Wire Bus Line
	4100 5550 4700 5550
$Sheet
S 3000 5450 1100 750 
U 5E834BC5
F0 "RegisterY" 50
F1 "AddressRegister.sch" 50
F2 "DATA_BUS" T R 4100 5550 50 
F3 "ADDRESS_BUS" T L 3000 5550 50 
F4 "~IN" I L 3000 5900 50 
F5 "~OUT_DATA" I L 3000 6000 50 
F6 "~OUT_ADDRESS" I L 3000 6100 50 
F7 "~COUNT_DOWN" I L 3000 5800 50 
F8 "~COUNT_UP" I L 3000 5700 50 
$EndSheet
Connection ~ 4700 6600
Wire Bus Line
	4700 6600 4700 7200
Connection ~ 4700 7200
Wire Bus Line
	4700 7200 4700 7900
Connection ~ 4700 7900
Wire Bus Line
	4700 7900 4700 8250
Text GLabel 5650 4200 0    50   Input ~ 0
RegisterA_IN
Text GLabel 5650 4300 0    50   Input ~ 0
~RegisterA_OUT
Text GLabel 5650 4950 0    50   Input ~ 0
RegisterB_IN
Text GLabel 5650 5050 0    50   Input ~ 0
~RegisterB_OUT
Text GLabel 5650 5700 0    50   Input ~ 0
RegisterC_IN
Text GLabel 5650 5800 0    50   Input ~ 0
~RegisterC_OUT
Text GLabel 5650 6450 0    50   Input ~ 0
RegisterD_IN
Text GLabel 5650 6550 0    50   Input ~ 0
~RegisterD_OUT
Text GLabel 3000 2500 0    50   Input ~ 0
~ProgramCounter_COUNT_UP
Text GLabel 3000 2600 0    50   Input ~ 0
~ProgramCounter_COUNT_DOWN
Text GLabel 3000 2700 0    50   Input ~ 0
~ProgramCounter_IN
Text GLabel 3000 2800 0    50   Input ~ 0
~ProgramCounter_OUT_DATA
Text GLabel 3000 2900 0    50   Input ~ 0
~ProgramCounter_OUT_ADDRESS
Text GLabel 3000 3550 0    50   Input ~ 0
~StackPointer_COUNT_UP
Text GLabel 3000 3650 0    50   Input ~ 0
~StackPointer_COUNT_DOWN
Text GLabel 3000 3750 0    50   Input ~ 0
~StackPointer_IN
Text GLabel 3000 3850 0    50   Input ~ 0
~StackPointer_OUT_DATA
Text GLabel 3000 3950 0    50   Input ~ 0
~StackPointer_OUT_ADDRESS
Text GLabel 3000 4600 0    50   Input ~ 0
~RegisterX_COUNT_UP
Text GLabel 3000 4700 0    50   Input ~ 0
~RegisterX_COUNT_DOWN
Text GLabel 3000 4800 0    50   Input ~ 0
~RegisterX_IN
Text GLabel 3000 4900 0    50   Input ~ 0
~RegisterX_OUT_DATA
Text GLabel 3000 5000 0    50   Input ~ 0
~RegisterX_OUT_ADDRESS
Text GLabel 3000 5700 0    50   Input ~ 0
~RegisterY_COUNT_UP
Text GLabel 3000 5800 0    50   Input ~ 0
~RegisterY_COUNT_DOWN
Text GLabel 3000 5900 0    50   Input ~ 0
~RegisterY_IN
Text GLabel 3000 6000 0    50   Input ~ 0
~RegisterY_OUT_DATA
Text GLabel 3000 6100 0    50   Input ~ 0
~RegisterY_OUT_ADDRESS
Wire Bus Line
	3000 2350 1600 2350
Connection ~ 1600 2350
Wire Bus Line
	3000 3400 1600 3400
Connection ~ 1600 3400
Wire Bus Line
	3000 4450 1600 4450
Connection ~ 1600 4450
Wire Bus Line
	1600 4450 1600 5550
Wire Bus Line
	3000 5550 1600 5550
Text GLabel 2850 6750 0    50   Input ~ 0
RegisterW_IN
Text GLabel 2850 7350 0    50   Input ~ 0
RegisterZ_IN
Text GLabel 2850 7450 0    50   Input ~ 0
RegisterZ_CLEAR
Wire Wire Line
	2850 6750 3200 6750
Wire Wire Line
	2850 7350 3200 7350
Wire Wire Line
	3200 7450 2850 7450
Text GLabel 3200 8250 0    50   Input ~ 0
ALU_F0
Text GLabel 3200 8350 0    50   Input ~ 0
ALU_F1
Text GLabel 3200 8450 0    50   Input ~ 0
ALU_F2
Text GLabel 3200 8550 0    50   Input ~ 0
ALU_F3
Text GLabel 3200 8650 0    50   Input ~ 0
ALU_F4
Text GLabel 3200 9050 0    50   Input ~ 0
~ALU_OUT
Text GLabel 5700 3250 0    50   Input ~ 0
InstructionRegister_IN
Text GLabel 5650 8600 0    50   Input ~ 0
~FlagsRegister_OUT
Text GLabel 5650 8500 0    50   Input ~ 0
FlagRegister_SELECT_BUS_~FLAGS
Text GLabel 5650 8400 0    50   Input ~ 0
FlagRegister_IN
$Sheet
S 5650 8150 1600 1400
U 5EB17E5A
F0 "FlagRegister" 50
F1 "FlagRegister.sch" 50
F2 "IN" I L 5650 8400 50 
F3 "~OUT" I L 5650 8600 50 
F4 "DATA_BUS" T L 5650 8250 50 
F5 "CARRY_IN" I L 5650 8750 50 
F6 "OVERFLOW_IN" I L 5650 8850 50 
F7 "ZERO_OUT" O R 7250 8250 50 
F8 "CARRY_OUT" O R 7250 8350 50 
F9 "NEGATIVE_OUT" O R 7250 8450 50 
F10 "OVERFLOW_OUT" O R 7250 8550 50 
F11 "INTERRUPT_ENABLE_OUT" O R 7250 8650 50 
F12 "SET" I L 5650 9000 50 
F13 "RESET" I L 5650 9100 50 
F14 "A0" I L 5650 9250 50 
F15 "A1" I L 5650 9350 50 
F16 "A2" I L 5650 9450 50 
F17 "SELECT_BUS_~FLAGS" I L 5650 8500 50 
$EndSheet
Text HLabel 700  2400 0    50   Output ~ 0
A0
Text HLabel 700  2500 0    50   Output ~ 0
A1
Text HLabel 700  2600 0    50   Output ~ 0
A2
Text HLabel 700  2700 0    50   Output ~ 0
A3
Text HLabel 700  2800 0    50   Output ~ 0
A4
Text HLabel 700  2900 0    50   Output ~ 0
A5
Text HLabel 700  3000 0    50   Output ~ 0
A6
Text HLabel 700  3100 0    50   Output ~ 0
A7
Text HLabel 700  3200 0    50   Output ~ 0
A8
Text HLabel 700  3300 0    50   Output ~ 0
A9
Text HLabel 700  3400 0    50   Output ~ 0
A10
Text HLabel 700  3500 0    50   Output ~ 0
A11
Text HLabel 700  3600 0    50   Output ~ 0
A12
Text HLabel 700  3700 0    50   Output ~ 0
A13
Text HLabel 700  3800 0    50   Output ~ 0
A14
Text HLabel 700  3900 0    50   Output ~ 0
A15
Entry Wire Line
	1500 2400 1600 2300
Entry Wire Line
	1500 2500 1600 2400
Entry Wire Line
	1500 2600 1600 2500
Entry Wire Line
	1500 2700 1600 2600
Entry Wire Line
	1500 2800 1600 2700
Entry Wire Line
	1500 2900 1600 2800
Entry Wire Line
	1500 3000 1600 2900
Entry Wire Line
	1500 3100 1600 3000
Entry Wire Line
	1500 3200 1600 3100
Entry Wire Line
	1500 3300 1600 3200
Entry Wire Line
	1500 3400 1600 3300
Entry Wire Line
	1500 3500 1600 3400
Entry Wire Line
	1500 3600 1600 3500
Entry Wire Line
	1500 3700 1600 3600
Entry Wire Line
	1500 3800 1600 3700
Entry Wire Line
	1500 3900 1600 3800
Text Label 750  2400 0    50   ~ 0
ADDRESS_BUS_0
Text Label 750  2500 0    50   ~ 0
ADDRESS_BUS_1
Text Label 750  2600 0    50   ~ 0
ADDRESS_BUS_2
Text Label 750  2700 0    50   ~ 0
ADDRESS_BUS_3
Text Label 750  2800 0    50   ~ 0
ADDRESS_BUS_4
Text Label 750  2900 0    50   ~ 0
ADDRESS_BUS_5
Text Label 750  3000 0    50   ~ 0
ADDRESS_BUS_6
Text Label 750  3100 0    50   ~ 0
ADDRESS_BUS_7
Text Label 750  3200 0    50   ~ 0
ADDRESS_BUS_8
Text Label 750  3300 0    50   ~ 0
ADDRESS_BUS_9
Text Label 750  3400 0    50   ~ 0
ADDRESS_BUS_10
Text Label 750  3500 0    50   ~ 0
ADDRESS_BUS_11
Text Label 750  3600 0    50   ~ 0
ADDRESS_BUS_12
Text Label 750  3700 0    50   ~ 0
ADDRESS_BUS_13
Text Label 750  3800 0    50   ~ 0
ADDRESS_BUS_14
Text Label 750  3900 0    50   ~ 0
ADDRESS_BUS_15
Wire Wire Line
	1500 2400 700  2400
Wire Wire Line
	1500 2500 700  2500
Wire Wire Line
	1500 2600 700  2600
Wire Wire Line
	1500 2700 700  2700
Wire Wire Line
	1500 2800 700  2800
Wire Wire Line
	1500 2900 700  2900
Wire Wire Line
	1500 3000 700  3000
Wire Wire Line
	1500 3100 700  3100
Wire Wire Line
	1500 3200 700  3200
Wire Wire Line
	1500 3300 700  3300
Wire Wire Line
	1500 3400 700  3400
Wire Wire Line
	1500 3500 700  3500
Wire Wire Line
	1500 3600 700  3600
Wire Wire Line
	1500 3700 700  3700
Wire Wire Line
	1500 3800 700  3800
Wire Wire Line
	1500 3900 700  3900
Connection ~ 4700 3400
Connection ~ 4700 4450
Connection ~ 4700 5550
$Sheet
S 6500 1200 700  1700
U 5EA86881
F0 "DataBuffer" 50
F1 "DataBuffer.sch" 50
F2 "DATA_BUS" T L 6500 1300 50 
F3 "D0" T R 7200 1300 50 
F4 "D1" T R 7200 1400 50 
F5 "D2" T R 7200 1500 50 
F6 "D3" T R 7200 1600 50 
F7 "D4" T R 7200 1700 50 
F8 "D5" T R 7200 1800 50 
F9 "D6" T R 7200 1900 50 
F10 "D7" T R 7200 2000 50 
F11 "D8" T R 7200 2100 50 
F12 "D9" T R 7200 2200 50 
F13 "D10" T R 7200 2300 50 
F14 "D11" T R 7200 2400 50 
F15 "D12" T R 7200 2500 50 
F16 "D13" T R 7200 2600 50 
F17 "D14" T R 7200 2700 50 
F18 "D15" T R 7200 2800 50 
F19 "~ENABLE" I L 6500 1400 50 
F20 "DIR" I L 6500 1500 50 
$EndSheet
Wire Bus Line
	4700 8250 5650 8250
Wire Wire Line
	4100 8250 4150 8250
Wire Wire Line
	4150 8250 4150 8850
Wire Wire Line
	4150 8850 5650 8850
Wire Wire Line
	4100 8150 4200 8150
Wire Wire Line
	4200 8150 4200 8750
Wire Wire Line
	4200 8750 5650 8750
Wire Wire Line
	3200 8900 2750 8900
Wire Wire Line
	7300 8550 7250 8550
Wire Wire Line
	3200 8800 2700 8800
Wire Wire Line
	7350 8350 7250 8350
Text HLabel 7200 1300 2    50   3State ~ 0
D0
Text HLabel 7200 1400 2    50   3State ~ 0
D1
Text HLabel 7200 1500 2    50   3State ~ 0
D2
Text HLabel 7200 1600 2    50   3State ~ 0
D3
Text HLabel 7200 1700 2    50   3State ~ 0
D4
Text HLabel 7200 1800 2    50   3State ~ 0
D5
Text HLabel 7200 1900 2    50   3State ~ 0
D6
Text HLabel 7200 2000 2    50   3State ~ 0
D7
Text HLabel 7200 2100 2    50   3State ~ 0
D8
Text HLabel 7200 2200 2    50   3State ~ 0
D9
Text HLabel 7200 2300 2    50   3State ~ 0
D10
Text HLabel 7200 2400 2    50   3State ~ 0
D11
Text HLabel 7200 2500 2    50   3State ~ 0
D12
Text HLabel 7200 2600 2    50   3State ~ 0
D13
Text HLabel 7200 2700 2    50   3State ~ 0
D14
Text HLabel 7200 2800 2    50   3State ~ 0
D15
Wire Bus Line
	4700 1300 6500 1300
$Sheet
S 2900 1450 1200 600 
U 5EB93191
F0 "AddressLatch" 50
F1 "AddressLatch.sch" 50
F2 "DATA_BUS" I R 4100 1550 50 
F3 "IN" I L 2900 1800 50 
F4 "ADDRESS_BUS" T L 2900 1550 50 
F5 "~OUT_ADDRESS" I L 2900 1700 50 
$EndSheet
Text GLabel 2900 1700 0    50   Input ~ 0
~AddressLatch_OUT_ADDRESS
Text GLabel 2900 1800 0    50   Input ~ 0
AddressLatch_IN
Wire Bus Line
	2900 1550 1600 1550
Wire Bus Line
	4100 1550 4700 1550
Text HLabel 7400 850  2    50   Output ~ 0
~W
Text HLabel 6250 2500 2    50   Output ~ 0
~R
Wire Wire Line
	5050 7350 5000 7350
Wire Wire Line
	5000 7350 5000 7600
Wire Wire Line
	5000 7600 7600 7600
Wire Wire Line
	7600 7600 7600 8550
Wire Wire Line
	7600 8550 7300 8550
Connection ~ 7300 8550
Wire Wire Line
	5050 7250 4950 7250
Wire Wire Line
	4950 7250 4950 7650
Wire Wire Line
	4950 7650 7550 7650
Wire Wire Line
	7550 7650 7550 8450
Wire Wire Line
	7550 8450 7250 8450
Wire Wire Line
	5050 7150 4900 7150
Wire Wire Line
	4900 7150 4900 7700
Wire Wire Line
	4900 7700 7500 7700
Wire Wire Line
	7500 7700 7500 8350
Wire Wire Line
	7500 8350 7350 8350
Connection ~ 7350 8350
Wire Wire Line
	5050 7050 4850 7050
Wire Wire Line
	4850 7050 4850 7750
Wire Wire Line
	4850 7750 7450 7750
Wire Wire Line
	7450 7750 7450 8250
Wire Wire Line
	7450 8250 7250 8250
Text HLabel 1500 10800 0    50   Input ~ 0
~RST
Text GLabel 1550 11050 2    50   Output ~ 0
~RST
$Comp
L 74xx:74LS04 U?
U 1 1 5F1CEB9C
P 1800 10800
F 0 "U?" H 1800 11117 50  0000 C CNN
F 1 "74LS04" H 1800 11026 50  0000 C CNN
F 2 "" H 1800 10800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 1800 10800 50  0001 C CNN
	1    1800 10800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U?
U 1 1 5F1D28C6
P 2400 10700
F 0 "U?" H 2400 11025 50  0000 C CNN
F 1 "74LS32" H 2400 10934 50  0000 C CNN
F 2 "" H 2400 10700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 2400 10700 50  0001 C CNN
	1    2400 10700
	1    0    0    -1  
$EndComp
Text HLabel 1500 10300 0    50   Input ~ 0
CLK
$Comp
L 74xx:74LS04 U?
U 2 1 5F1EACAD
P 3000 10700
F 0 "U?" H 3000 11017 50  0000 C CNN
F 1 "74LS04" H 3000 10926 50  0000 C CNN
F 2 "" H 3000 10700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3000 10700 50  0001 C CNN
	2    3000 10700
	1    0    0    -1  
$EndComp
Text GLabel 3300 10700 2    50   Output ~ 0
~CLK
Text GLabel 2750 10950 2    50   Output ~ 0
CLK
$Comp
L 74xx:74LS04 U?
U 3 1 5F2108AC
P 6500 950
F 0 "U?" H 6500 1267 50  0000 C CNN
F 1 "74LS04" H 6500 1176 50  0000 C CNN
F 2 "" H 6500 950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 6500 950 50  0001 C CNN
	3    6500 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 9750 7300 9750
Wire Wire Line
	2750 8900 2750 9750
Wire Wire Line
	7300 8550 7300 9750
Wire Wire Line
	7350 9800 2700 9800
Wire Wire Line
	2700 8800 2700 9800
Wire Wire Line
	7350 8350 7350 9800
Text GLabel 5650 9000 0    50   Input ~ 0
FlagRegister_SET
Text GLabel 5650 9100 0    50   Input ~ 0
FlagRegister_RESET
Text GLabel 5650 9250 0    50   Input ~ 0
FlagRegister_A0
Text GLabel 5650 9350 0    50   Input ~ 0
FlagRegister_A1
Text GLabel 5650 9450 0    50   Input ~ 0
FlagRegister_A2
Text HLabel 5550 3450 0    50   Input ~ 0
IRQ
Wire Wire Line
	7250 8650 7650 8650
Wire Wire Line
	7650 8650 7650 7550
$Sheet
S 6500 3150 950  1700
U 5E834B67
F0 "InstructionRegister" 50
F1 "InstructionRegister.sch" 50
F2 "IN" I L 6500 3250 50 
F3 "INSTRUCTION" O L 6500 3450 50 
F4 "SELECT_INT_INST" I L 6500 3350 50 
F5 "D0" I R 7450 3250 50 
F6 "D1" I R 7450 3350 50 
F7 "D2" I R 7450 3450 50 
F8 "D3" I R 7450 3550 50 
F9 "D4" I R 7450 3650 50 
F10 "D5" I R 7450 3750 50 
F11 "D6" I R 7450 3850 50 
F12 "D7" I R 7450 3950 50 
F13 "D8" I R 7450 4050 50 
F14 "D9" I R 7450 4150 50 
F15 "D10" I R 7450 4250 50 
F16 "D11" I R 7450 4350 50 
F17 "D12" I R 7450 4450 50 
F18 "D13" I R 7450 4550 50 
F19 "D14" I R 7450 4650 50 
F20 "D15" I R 7450 4750 50 
$EndSheet
$Sheet
S 4000 1000 550  200 
U 60996BF7
F0 "DATA_BUS_LEDS_PULLDOWNS" 50
F1 "DATA_BUS_LEDS_PULLDOWNS.sch" 50
F2 "DATA_BUS" T R 4550 1100 50 
$EndSheet
$Sheet
S 1900 1000 650  200 
U 60A197D9
F0 "ADDRESS_BUS_LEDS_PULLDOWNS" 50
F1 "ADDRESS_BUS_LEDS_PULLDOWNS.sch" 50
F2 "ADDRESS_BUS" T L 1900 1100 50 
$EndSheet
Wire Bus Line
	1600 1550 1600 1100
Connection ~ 1600 1550
Wire Bus Line
	1600 1100 1900 1100
Wire Bus Line
	4700 1100 4700 1300
Connection ~ 4700 1550
$Sheet
S 3000 2250 1100 750 
U 5E834BA4
F0 "ProgramCounter" 50
F1 "AddressRegister.sch" 50
F2 "DATA_BUS" T R 4100 2350 50 
F3 "ADDRESS_BUS" T L 3000 2350 50 
F4 "~IN" I L 3000 2700 50 
F5 "~OUT_DATA" I L 3000 2800 50 
F6 "~OUT_ADDRESS" I L 3000 2900 50 
F7 "~COUNT_DOWN" I L 3000 2600 50 
F8 "~COUNT_UP" I L 3000 2500 50 
$EndSheet
Text GLabel 2150 10950 2    50   Output ~ 0
RST
Wire Bus Line
	4700 5550 4700 5600
Text HLabel 7450 3250 2    50   3State ~ 0
D0
Text HLabel 7450 3350 2    50   3State ~ 0
D1
Text HLabel 7450 3450 2    50   3State ~ 0
D2
Text HLabel 7450 3550 2    50   3State ~ 0
D3
Text HLabel 7450 3650 2    50   3State ~ 0
D4
Text HLabel 7450 3750 2    50   3State ~ 0
D5
Text HLabel 7450 3850 2    50   3State ~ 0
D6
Text HLabel 7450 3950 2    50   3State ~ 0
D7
Text HLabel 7450 4050 2    50   3State ~ 0
D8
Text HLabel 7450 4150 2    50   3State ~ 0
D9
Text HLabel 7450 4250 2    50   3State ~ 0
D10
Text HLabel 7450 4350 2    50   3State ~ 0
D11
Text HLabel 7450 4450 2    50   3State ~ 0
D12
Text HLabel 7450 4550 2    50   3State ~ 0
D13
Text HLabel 7450 4650 2    50   3State ~ 0
D14
Text HLabel 7450 4750 2    50   3State ~ 0
D15
Wire Bus Line
	4550 1100 4700 1100
Connection ~ 4700 4100
Wire Bus Line
	4700 4100 4700 4450
Connection ~ 4700 4850
Wire Bus Line
	4700 4850 4700 5550
Connection ~ 4700 5600
Wire Bus Line
	4700 5600 4700 6350
Connection ~ 4700 6350
Wire Bus Line
	4700 6350 4700 6600
Wire Bus Line
	4700 2350 4700 3400
Wire Bus Line
	4700 4450 4700 4850
Wire Bus Line
	4700 3400 4700 4100
Connection ~ 4700 1300
Wire Bus Line
	4700 1300 4700 1550
Wire Bus Line
	4700 1550 4700 2350
$Comp
L 74xx:74LS04 U?
U 1 1 612083D0
P 6050 3000
F 0 "U?" V 6096 2820 50  0000 R CNN
F 1 "74LS04" V 6005 2820 50  0000 R CNN
F 2 "" H 6050 3000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 6050 3000 50  0001 C CNN
	1    6050 3000
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74LS08 U?
U 1 1 6121832D
P 5950 2500
F 0 "U?" H 5950 2825 50  0000 C CNN
F 1 "74LS08" H 5950 2734 50  0000 C CNN
F 2 "" H 5950 2500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 5950 2500 50  0001 C CNN
	1    5950 2500
	1    0    0    -1  
$EndComp
Text HLabel 6250 2750 2    50   Output ~ 0
~I
Wire Wire Line
	6250 2750 5650 2750
$Comp
L 74xx:74LS08 U?
U 1 1 6123483C
P 5850 3550
F 0 "U?" H 5850 3875 50  0000 C CNN
F 1 "74LS08" H 5850 3784 50  0000 C CNN
F 2 "" H 5850 3550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 5850 3550 50  0001 C CNN
	1    5850 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 3550 6200 3550
Wire Wire Line
	6200 3550 6200 3350
Wire Wire Line
	6200 3350 6500 3350
Wire Wire Line
	5550 3650 5450 3650
Wire Wire Line
	5450 3650 5450 3750
Wire Wire Line
	5450 3750 6400 3750
Wire Wire Line
	6400 3750 6400 7550
Wire Wire Line
	6400 7550 7650 7550
Wire Bus Line
	6500 3450 6350 3450
Wire Bus Line
	6350 3450 6350 7050
Wire Bus Line
	6200 7050 6350 7050
$Comp
L 74xx:74LS08 U?
U 1 1 6093B661
P 1800 10400
F 0 "U?" H 1800 10725 50  0000 C CNN
F 1 "74LS08" H 1800 10634 50  0000 C CNN
F 2 "" H 1800 10400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 1800 10400 50  0001 C CNN
	1    1800 10400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U?
U 1 1 6094548C
P 1200 10500
F 0 "U?" H 1200 10817 50  0000 C CNN
F 1 "74LS04" H 1200 10726 50  0000 C CNN
F 2 "" H 1200 10500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 1200 10500 50  0001 C CNN
	1    1200 10500
	1    0    0    -1  
$EndComp
Text GLabel 900  10500 0    50   Input ~ 0
Halt
Wire Wire Line
	2700 10700 2700 10950
Connection ~ 2700 10700
Wire Wire Line
	2700 10950 2750 10950
Wire Wire Line
	2100 10800 2100 10950
Wire Wire Line
	2100 10950 2150 10950
Connection ~ 2100 10800
Wire Wire Line
	1500 10800 1500 11050
Wire Wire Line
	1500 11050 1550 11050
Wire Wire Line
	2100 10400 2100 10600
$Comp
L 74xx:74LS32 U?
U 1 1 607CCE4C
P 7100 850
F 0 "U?" H 7100 1175 50  0000 C CNN
F 1 "74LS32" H 7100 1084 50  0000 C CNN
F 2 "" H 7100 850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 7100 850 50  0001 C CNN
	1    7100 850 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U?
U 2 1 607FCF88
P 5950 2000
F 0 "U?" H 5950 2325 50  0000 C CNN
F 1 "74LS32" H 5950 2234 50  0000 C CNN
F 2 "" H 5950 2000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 5950 2000 50  0001 C CNN
	2    5950 2000
	1    0    0    -1  
$EndComp
Text GLabel 5550 1400 0    50   Input ~ 0
~DataBuffer_ENABLE
Text GLabel 5550 1500 0    50   Input ~ 0
DataBuffer_DIR
Wire Wire Line
	5700 3250 6400 3250
Wire Wire Line
	6350 3000 6400 3000
Wire Wire Line
	6400 3000 6400 3250
Connection ~ 6400 3250
Wire Wire Line
	6400 3250 6500 3250
Wire Wire Line
	5750 3000 5650 3000
Wire Wire Line
	5650 3000 5650 2750
Wire Wire Line
	5650 2600 5650 2750
Connection ~ 5650 2750
Wire Wire Line
	6250 2000 6300 2000
Wire Wire Line
	6300 2000 6300 2250
Wire Wire Line
	6300 2250 5600 2250
Wire Wire Line
	5600 2250 5600 2400
Wire Wire Line
	5600 2400 5650 2400
Wire Wire Line
	5550 1400 5650 1400
Wire Wire Line
	5550 1500 5600 1500
Wire Wire Line
	5600 2100 5650 2100
Connection ~ 5650 1400
Wire Wire Line
	5650 1400 5650 750 
Wire Wire Line
	5650 750  6800 750 
Wire Wire Line
	5650 1400 6500 1400
Wire Wire Line
	5650 1400 5650 1900
Wire Wire Line
	5600 1500 5600 2100
Wire Wire Line
	5600 1500 5600 950 
Wire Wire Line
	5600 950  6200 950 
Connection ~ 5600 1500
Wire Wire Line
	5600 1500 6500 1500
Wire Bus Line
	1600 1550 1600 2350
Wire Bus Line
	1600 3400 1600 4450
Wire Bus Line
	1600 2350 1600 3400
$EndSCHEMATC
