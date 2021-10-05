package main

import (
	"bytes"
	"errors"
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
)

const (
	HALT uint64 = 1 << iota
	SET_STEP
	_ // STEP_COUNTER_0
	_ // STEP_COUNTER_1
	_ // STEP_COUNTER_2
	IR_IN
	_ // IN_0
	_ // IN_1
	_ // IN_2
	_ // IN_3
	_ // OUT_0
	_ // OUT_1
	_ // OUT_2
	_ // OUT_3
	_ // OUT_ADD_0
	_ // OUT_ADD_1
	_ // OUT_ADD_2
	RX_COUNT_UP
	RX_COUNT_DOWN
	RY_COUNT_UP
	RY_COUNT_DOWN
	PC_COUNT_UP
	PC_COUNT_DOWN
	SP_COUNT_UP
	SP_COUNT_DOWN
	RZ_CLEAR
	_ // ALU_F_0
	_ // ALU_F_1
	_ // ALU_F_2
	_ // ALU_F_3
	_ // ALU_F_4
	FR_IN
	FR_SELECT_BUS
	FR_SET
	FR_RESET
	_ // FR_A_0
	_ // FR_A_1
	_ // FR_A_2
)

const (
	RA_IN uint64 = (iota + 1) << 6
	RB_IN
	RC_IN
	RD_IN
	RX_IN
	RY_IN
	PC_IN
	SP_IN
	RW_IN
	RZ_IN
	AL_IN
	DB_IN
	BP_IN
)

const (
	RA_OUT uint64 = (iota + 1) << 10
	RB_OUT
	RC_OUT
	RD_OUT
	RX_OUT
	RY_OUT
	PC_OUT
	SP_OUT
	ALU_OUT
	FR_OUT
	DB_OUT
	BP_OUT
)

const (
	RX_OUT_ADD uint64 = (iota + 1) << 14
	RY_OUT_ADD
	PC_OUT_ADD
	SP_OUT_ADD
	AL_OUT_ADD
	BP_OUT_ADD
)

const (
	ALU_ADD uint64 = iota << 26
	ALU_SUB
	ALU_SHL
	ALU_SHR
	ALU_AND
	ALU_OR
	ALU_XOR
	ALU_NOT
)

const (
	ALU_ADD_CARRY_0 uint64 = ALU_ADD | (iota << 29)
	ALU_ADD_CARRY
	ALU_ADD_CARRY_1
	_
)

const (
	ALU_SUB_CARRY_0 = ALU_SUB | (iota << 29)
	ALU_SUB_CARRY
	ALU_SUB_CARRY_1
	_
)

const (
	ALU_SHL_0 = ALU_SHL | (iota << 29)
	ALU_SHL_1
	ALU_ROL_CARRY
	ALU_ROL
)

const (
	ALU_SHR_0 = ALU_SHR | (iota << 29)
	ALU_SHR_SIGN
	ALU_ROR_CARRY
	ALU_ROR
)

const NEXT_INST = PC_OUT_ADD | PC_COUNT_UP | IR_IN | SET_STEP
const NEXT_IMM_OUT = PC_OUT_ADD | PC_COUNT_UP | DB_OUT

const (
	TMP_IN  = RW_IN | RZ_CLEAR
	TMP_OUT = ALU_OUT
)

const MICROSTEPS = 8

func setStepCounter(stepCounter uint64) uint64 {
	return SET_STEP | ((stepCounter & 0b111) << 2)
}

func regIn(reg uint8) uint64 {
	if reg >= 8 {
		panic("invalid register in: " + strconv.Itoa(int(reg)))
	}
	return []uint64{
		RA_IN,
		RB_IN,
		RC_IN,
		RD_IN,
		RX_IN,
		RY_IN,
		BP_IN,
		SP_IN,
	}[reg]
}

func regOut(reg uint8) uint64 {
	if reg >= 8 {
		panic("invalid register out: " + strconv.Itoa(int(reg)))
	}
	return []uint64{
		RA_OUT,
		RB_OUT,
		RC_OUT,
		RD_OUT,
		RX_OUT,
		RY_OUT,
		BP_OUT,
		SP_OUT,
	}[reg]
}

func regOutAdd(reg uint8) uint64 {
	if reg >= 8 || reg < 4 {
		panic("invalid register out add: " + strconv.Itoa(int(reg)))
	}
	return []uint64{
		RX_OUT_ADD,
		RY_OUT_ADD,
		BP_OUT_ADD,
		SP_OUT_ADD,
	}[reg-4]
}

func setFlag(flag uint8) uint64 {
	return FR_SET | (uint64(flag&0b111) << 35)
}

func clearFlag(flag uint8) uint64 {
	return FR_RESET | (uint64(flag&0b111) << 35)
}

func main() {
	fmt.Println("generating microcode...")
	var instructions [1 << 16][]uint64
	for i := 0; i < 1<<16; i++ {
		instruction := getInstruction(uint16(i))
		if len(instruction) > MICROSTEPS {
			panic("too many microsteps (" + strconv.Itoa(len(instruction)) + ") for instruction " + strconv.FormatInt(int64(i), 16))
		}
		instructions[i] = instruction
	}
	numberOfUsedInstructions := 0
	for i, instruction := range instructions {
		if len(instruction) > 0 {
			numberOfUsedInstructions++
		}
		for _, microstep := range instruction {
			if microstep&DB_OUT != 0 {
				if ((microstep>>14)&0b111 == RX_OUT_ADD>>14 && (microstep>>6)&0b1111 == RX_IN>>6) ||
					((microstep>>14)&0b111 == RY_OUT_ADD>>14 && (microstep>>6)&0b1111 == RY_IN>>6) ||
					((microstep>>14)&0b111 == PC_OUT_ADD>>14 && (microstep>>6)&0b1111 == PC_IN>>6) ||
					((microstep>>14)&0b111 == SP_OUT_ADD>>14 && (microstep>>6)&0b1111 == SP_IN>>6) {
					panic("instruction " + strconv.FormatInt(int64(i), 16) + " may trigger the address register hardware bug")
				}
			}
		}
	}
	fmt.Println("used", numberOfUsedInstructions, "of", len(instructions), "instructions (", float64(numberOfUsedInstructions)/float64(len(instructions))*100, "% )")
	var microcode [1 << 19]uint64
	for i := 0; i < 1<<19; i++ {
		instructionBits := i >> 3
		step := i & 0b111
		instruction := instructions[instructionBits]
		if len(instruction) > step {
			microcode[i] = instruction[step]
		} else {
			microcode[i] = HALT
		}
	}
	var newMicrocodeBytes [6][1 << 19]uint8
	for i := 0; i < 1<<19; i++ {
		for j := 0; j < 6; j++ {
			newMicrocodeBytes[j][i] = uint8((microcode[i] >> (8 * j)) & 0xff)
		}
	}
	changedMicrocodeFiles := []int{}
	for i := 0; i < 6; i++ {
		oldMicrocodeBytes, err := ioutil.ReadFile("microcode" + strconv.Itoa(i) + ".bin")
		if err != nil {
			if errors.Is(err, os.ErrNotExist) {
				changedMicrocodeFiles = append(changedMicrocodeFiles, i)
				continue
			}
			panic(err)
		}
		if !bytes.Equal(oldMicrocodeBytes, newMicrocodeBytes[i][:]) {
			changedMicrocodeFiles = append(changedMicrocodeFiles, i)
			break
		}
	}
	if len(changedMicrocodeFiles) == 0 {
		fmt.Println("no microcode files changed")
		return
	}
	fmt.Println("changed microcode files:", changedMicrocodeFiles)
	fmt.Print("do you want to write those files? (y/N) ")
	var answer string
	fmt.Scanln(&answer)
	if answer != "y" {
		fmt.Println("exiting...")
		return
	}

	for _, i := range changedMicrocodeFiles {
		fmt.Println("writing microcode file", i, "...")
		err := ioutil.WriteFile("microcode"+strconv.Itoa(i)+".bin", newMicrocodeBytes[i][:], 0644)
		if err != nil {
			panic(err)
		}
	}
	fmt.Println("done")
}

type addressingModeType int

const (
	ADDR_MODE_REG addressingModeType = iota
	ADDR_MODE_REG_IND
	ADDR_MODE_REG_IND_OFF
	ADDR_MODE_IMM_IND
	ADDR_MODE_IMM
	ADDR_MODE_PUSH
	ADDR_MODE_POP
	ADDR_MODE_FR
	ADDR_MODE_PC
	ADDR_MODE_PC_OFF
	ADDR_MODE_CALL
)

func (mode addressingModeType) hasImmediate() bool {
	switch mode {
	case ADDR_MODE_REG_IND_OFF,
		ADDR_MODE_IMM_IND,
		ADDR_MODE_IMM,
		ADDR_MODE_PC_OFF:
		return true
	default:
		return false
	}
}

func (mode addressingModeType) isSrc() bool {
	switch mode {
	case ADDR_MODE_REG,
		ADDR_MODE_REG_IND,
		ADDR_MODE_REG_IND_OFF,
		ADDR_MODE_IMM_IND,
		ADDR_MODE_IMM,
		ADDR_MODE_POP,
		ADDR_MODE_FR,
		ADDR_MODE_PC,
		ADDR_MODE_PC_OFF:
		return true
	default:
		return false
	}
}

func (mode addressingModeType) isDest() bool {
	switch mode {
	case ADDR_MODE_REG,
		ADDR_MODE_REG_IND,
		ADDR_MODE_REG_IND_OFF,
		ADDR_MODE_IMM_IND,
		ADDR_MODE_PUSH,
		ADDR_MODE_FR,
		ADDR_MODE_PC,
		ADDR_MODE_CALL:
		return true
	default:
		return false
	}
}

func (mode addressingModeType) requiresALU() bool {
	switch mode {
	case ADDR_MODE_REG_IND_OFF,
		ADDR_MODE_PC_OFF:
		return true
	default:
		return false
	}
}

func (mode addressingModeType) isInMemory() bool {
	switch mode {
	case ADDR_MODE_REG_IND,
		ADDR_MODE_REG_IND_OFF,
		ADDR_MODE_IMM_IND,
		ADDR_MODE_IMM,
		ADDR_MODE_PUSH,
		ADDR_MODE_POP,
		ADDR_MODE_PC_OFF,
		ADDR_MODE_CALL:
		return true
	default:
		return false
	}
}

type addressingMode struct {
	mode addressingModeType
	reg  uint8
}

func (mode addressingMode) getPrepSteps() []uint64 {
	switch mode.mode {
	case ADDR_MODE_REG:
		return []uint64{}
	case ADDR_MODE_REG_IND:
		if mode.reg < 4 {
			return []uint64{
				regOut(mode.reg) | AL_IN,
			}
		} else {
			return []uint64{}
		}
	case ADDR_MODE_REG_IND_OFF:
		return []uint64{
			regOut(mode.reg) | RW_IN,
			NEXT_IMM_OUT | RZ_IN,
			ALU_ADD | ALU_OUT | AL_IN,
		}
	case ADDR_MODE_IMM_IND:
		return []uint64{
			NEXT_IMM_OUT | AL_IN,
		}
	case ADDR_MODE_IMM:
		return []uint64{}
	case ADDR_MODE_PUSH:
		return []uint64{}
	case ADDR_MODE_POP:
		return []uint64{
			SP_COUNT_UP,
		}
	case ADDR_MODE_FR:
		return []uint64{}
	case ADDR_MODE_PC:
		return []uint64{}
	case ADDR_MODE_PC_OFF:
		return []uint64{
			PC_OUT | RW_IN,
			NEXT_IMM_OUT | RZ_IN,
		}
	case ADDR_MODE_CALL:
		return []uint64{
			PC_OUT | SP_OUT_ADD | DB_IN | SP_COUNT_DOWN,
		}
	default:
		panic("unreachable")
	}
}

func (mode addressingMode) getIn() uint64 {
	switch mode.mode {
	case ADDR_MODE_REG:
		return regIn(mode.reg)
	case ADDR_MODE_REG_IND:
		if mode.reg < 4 {
			return AL_OUT_ADD | DB_IN
		} else {
			return regOutAdd(mode.reg) | DB_IN
		}
	case ADDR_MODE_REG_IND_OFF:
		return AL_OUT_ADD | DB_IN
	case ADDR_MODE_IMM_IND:
		return AL_OUT_ADD | DB_IN
	case ADDR_MODE_IMM:
		panic("ADDR_MODE_IMM is not dest")
	case ADDR_MODE_PUSH:
		return SP_OUT_ADD | DB_IN | SP_COUNT_DOWN
	case ADDR_MODE_POP:
		panic("ADDR_MODE_POP is not dest")
	case ADDR_MODE_FR:
		return FR_IN | FR_SELECT_BUS
	case ADDR_MODE_PC:
		return PC_IN
	case ADDR_MODE_PC_OFF:
		panic("ADDR_MODE_PC_OFF is not dest")
	case ADDR_MODE_CALL:
		return PC_IN
	default:
		panic("unreachable")
	}
}

func (mode addressingMode) getOut() uint64 {
	switch mode.mode {
	case ADDR_MODE_REG:
		return regOut(mode.reg)
	case ADDR_MODE_REG_IND:
		if mode.reg < 4 {
			return AL_OUT_ADD | DB_OUT
		} else {
			return regOutAdd(mode.reg) | DB_OUT
		}
	case ADDR_MODE_REG_IND_OFF:
		return AL_OUT_ADD | DB_OUT
	case ADDR_MODE_IMM_IND:
		return AL_OUT_ADD | DB_OUT
	case ADDR_MODE_IMM:
		return NEXT_IMM_OUT
	case ADDR_MODE_PUSH:
		panic("ADDR_MODE_PUSH is not src")
	case ADDR_MODE_POP:
		return SP_OUT_ADD | DB_OUT
	case ADDR_MODE_FR:
		return FR_OUT
	case ADDR_MODE_PC:
		return PC_OUT
	case ADDR_MODE_PC_OFF:
		return ALU_ADD | ALU_OUT
	case ADDR_MODE_CALL:
		panic("ADDR_MODE_CALL is not src")
	default:
		panic("unreachable")
	}
}

func getAddressingMode(bits uint8) addressingMode {
	if bits&0b11000 == 0b00000 {
		return addressingMode{
			mode: ADDR_MODE_REG,
			reg:  bits & 0b111,
		}
	} else if bits&0b11000 == 0b01000 {
		return addressingMode{
			mode: ADDR_MODE_REG_IND,
			reg:  bits & 0b111,
		}
	} else if bits&0b11000 == 0b10000 {
		return addressingMode{
			mode: ADDR_MODE_REG_IND_OFF,
			reg:  bits & 0b111,
		}
	} else if bits == 0b11000 {
		return addressingMode{
			mode: ADDR_MODE_IMM_IND,
		}
	} else if bits == 0b11001 {
		return addressingMode{
			mode: ADDR_MODE_IMM,
		}
	} else if bits == 0b11010 {
		return addressingMode{
			mode: ADDR_MODE_PUSH,
		}
	} else if bits == 0b11011 {
		return addressingMode{
			mode: ADDR_MODE_POP,
		}
	} else if bits == 0b11100 {
		return addressingMode{
			mode: ADDR_MODE_FR,
		}
	} else if bits == 0b11101 {
		return addressingMode{
			mode: ADDR_MODE_PC,
		}
	} else if bits == 0b11110 {
		return addressingMode{
			mode: ADDR_MODE_PC_OFF,
		}
	} else if bits == 0b11111 {
		return addressingMode{
			mode: ADDR_MODE_CALL,
		}
	} else {
		panic("invalid addressing mode: " + strconv.FormatInt(int64(bits), 2))
	}
}

func getInstruction(instructionBits uint16) []uint64 {
	if instructionBits == 1 { // reset
		// calculate address 0xfffe and put value at that address into pc
		return []uint64{
			RZ_CLEAR,
			// put 0 into rw
			ALU_AND | ALU_OUT | RW_IN,
			// rw and rz are 0 because of reset
			ALU_SUB_CARRY_0 | ALU_OUT | RW_IN,
			// now rw contains 0xffff
			ALU_SUB_CARRY_0 | ALU_OUT | AL_IN,
			// now al contains 0xfffe, put value at that address into pc
			AL_OUT_ADD | DB_OUT | PC_IN,
			// get first instruction
			NEXT_INST,
		}
	}
	if instructionBits == 0 { // nop
		return []uint64{NEXT_INST}
	}
	if instructionBits>>14 == 0 { // mov
		return mov(getAddressingMode(uint8((instructionBits>>9)&0x1f)),
			getAddressingMode(uint8((instructionBits>>4)&0x1f)),
			instructionBits&1 == 1)
	} else if instructionBits>>14 == 1 {
		if (instructionBits>>5)&0x1ff == 0 { // set/clear flag
			flag := uint8((instructionBits >> 1) & 0b111)
			if (instructionBits>>4)&1 == 1 { // set
				return []uint64{
					setFlag(flag) | NEXT_INST,
				}
			} else { // clear
				return []uint64{
					clearFlag(flag) | NEXT_INST,
				}
			}
		} else if (instructionBits>>6)&0xff == 0x80 { // test
			return test(getAddressingMode(uint8((instructionBits >> 1) & 0x1f)))
		}
	} else if instructionBits>>15 == 1 { // alu
		if (instructionBits>>11)&0xf != 0xf { // binary alu
			return binaryAlu(uint8((instructionBits>>11)&0xf),
				getAddressingMode(uint8((instructionBits>>6)&0x1f)),
				getAddressingMode(uint8((instructionBits>>1)&0x1f)))
		} else { // unary alu
			if (instructionBits>>8)&0b111 != 0b111 { // shift
				return shift(uint8((instructionBits>>8)&0b111),
					uint8((instructionBits>>6)&0b11),
					getAddressingMode(uint8((instructionBits>>1)&0x1f)))
			} else { // other unary alu
				return unaryAlu(uint8((instructionBits>>6)&0b11),
					getAddressingMode(uint8((instructionBits>>1)&0x1f)))
			}
		}
	}
	return []uint64{}
}

func mov(dest addressingMode, src addressingMode, condition bool) []uint64 {
	if !dest.mode.isDest() || !src.mode.isSrc() {
		return []uint64{}
	}

	if !condition {
		instruction := []uint64{NEXT_INST}
		if src.mode.hasImmediate() {
			instruction = append([]uint64{PC_COUNT_UP}, instruction...)
		}
		if dest.mode.hasImmediate() {
			instruction = append([]uint64{PC_COUNT_UP}, instruction...)
		}
		return instruction
	}

	tempRequired := dest.mode.isInMemory() && src.mode.isInMemory()

	// fix hardware bug for rx, ry, sp and pc
	tempRequired = tempRequired || (dest.mode == ADDR_MODE_REG && src.mode == ADDR_MODE_REG_IND &&
		(dest.reg == 4 || dest.reg == 5 || dest.reg == 7) && dest.reg == src.reg) ||
		(dest.mode == ADDR_MODE_PC && src.mode == ADDR_MODE_IMM) ||
		(dest.mode == ADDR_MODE_REG && dest.reg == 7 && src.mode == ADDR_MODE_POP)

	if tempRequired && dest.mode.requiresALU() {
		return []uint64{}
	}

	srcPrepSteps := src.getPrepSteps()
	if !src.mode.isInMemory() && len(srcPrepSteps) != 0 {
		panic("src should have no preparation steps if it is not in memory")
	}
	destPrepSteps := dest.getPrepSteps()
	if !dest.mode.isInMemory() && len(destPrepSteps) != 0 {
		panic("dest should have no preparation steps if it is not in memory")
	}

	instruction := []uint64{}
	if tempRequired {
		instruction = append(instruction, srcPrepSteps...)
		instruction = append(instruction, src.getOut()|TMP_IN)
		instruction = append(instruction, destPrepSteps...)
		instruction = append(instruction, dest.getIn()|TMP_OUT)
	} else {
		instruction = append(instruction, srcPrepSteps...)
		instruction = append(instruction, destPrepSteps...)
		instruction = append(instruction, src.getOut()|dest.getIn())
	}
	return append(instruction, NEXT_INST)
}

func binaryAlu(aluOperation uint8, operand0 addressingMode, operand1 addressingMode) []uint64 {
	if !operand0.mode.isDest() || !operand0.mode.isSrc() || !operand1.mode.isSrc() {
		return []uint64{}
	}
	if operand0.mode.requiresALU() {
		return []uint64{}
	}

	operand0ALU_IN := RW_IN
	operand1ALU_IN := RZ_IN
	if aluOperation == 3 || aluOperation == 5 || aluOperation == 13 { // reverse operand order
		operand0ALU_IN, operand1ALU_IN = operand1ALU_IN, operand0ALU_IN
	}
	instruction := []uint64{}
	instruction = append(instruction, operand1.getPrepSteps()...)
	instruction = append(instruction, operand1.getOut()|operand1ALU_IN)
	instruction = append(instruction, operand0.getPrepSteps()...)
	instruction = append(instruction, operand0.getOut()|operand0ALU_IN)
	switch aluOperation {
	case 0: // add
		instruction = append(instruction, ALU_ADD|ALU_OUT|FR_IN|operand0.getIn())
	case 1: // addc
		instruction = append(instruction, ALU_ADD_CARRY|ALU_OUT|FR_IN|operand0.getIn())
	case 2, 3: // sub
		instruction = append(instruction, ALU_SUB_CARRY_1|ALU_OUT|FR_IN|operand0.getIn())
	case 4, 5: // subc
		instruction = append(instruction, ALU_SUB_CARRY|ALU_OUT|FR_IN|operand0.getIn())
	case 6: // and
		instruction = append(instruction, ALU_AND|ALU_OUT|FR_IN|operand0.getIn())
	case 7: // or
		instruction = append(instruction, ALU_OR|ALU_OUT|FR_IN|operand0.getIn())
	case 8: // xor
		instruction = append(instruction, ALU_XOR|ALU_OUT|FR_IN|operand0.getIn())
	case 9: // nand
		instruction = append(instruction, ALU_AND|ALU_OUT|RW_IN)
		instruction = append(instruction, ALU_NOT|ALU_OUT|FR_IN|operand0.getIn())
	case 10: // nor
		instruction = append(instruction, ALU_OR|ALU_OUT|RW_IN)
		instruction = append(instruction, ALU_NOT|ALU_OUT|FR_IN|operand0.getIn())
	case 11: // nxor
		instruction = append(instruction, ALU_XOR|ALU_OUT|RW_IN)
		instruction = append(instruction, ALU_NOT|ALU_OUT|FR_IN|operand0.getIn())
	case 12, 13: // cmp
		instruction = append(instruction, ALU_SUB_CARRY_1|ALU_OUT|FR_IN)
	case 14: // bits
		instruction = append(instruction, ALU_AND|ALU_OUT|FR_IN)
	default:
		panic("invalid alu operation")
	}
	if len(instruction) >= 8 {
		// TODO: handle this properly
		return []uint64{}
	}
	return append(instruction, NEXT_INST)
}

func unaryAlu(aluOperation uint8, operand addressingMode) []uint64 {
	if !operand.mode.isDest() || !operand.mode.isSrc() {
		return []uint64{}
	}
	instruction := []uint64{}
	instruction = append(instruction, operand.getPrepSteps()...)
	instruction = append(instruction, operand.getOut()|RW_IN|RZ_CLEAR)
	switch aluOperation {
	case 0: // not
		instruction = append(instruction, ALU_NOT|ALU_OUT|FR_IN|operand.getIn())
	case 1: // neg
		instruction = append(instruction, ALU_NOT|ALU_OUT|RW_IN)
		instruction = append(instruction, ALU_ADD_CARRY_1|ALU_OUT|FR_IN|operand.getIn())
	case 2: // inc
		instruction = append(instruction, ALU_ADD_CARRY_1|ALU_OUT|FR_IN|operand.getIn())
	case 3: // dec
		instruction = append(instruction, ALU_SUB_CARRY_0|ALU_OUT|FR_IN|operand.getIn())
	default:
		panic("invalid alu operation")
	}
	return append(instruction, NEXT_INST)
}

func shift(shiftOperation uint8, shiftAmount uint8, operand addressingMode) []uint64 {
	if !operand.mode.isDest() || !operand.mode.isSrc() {
		return []uint64{}
	}
	instruction := []uint64{}
	instruction = append(instruction, operand.getPrepSteps()...)
	instruction = append(instruction, operand.getOut()|RW_IN)
	shiftOperationBits := uint64(0)
	switch shiftOperation {
	case 0: // shl
		shiftOperationBits = ALU_SHL
	case 1: // rol
		shiftOperationBits = ALU_ROL
	case 2: // rolc
		shiftOperationBits = ALU_ROL_CARRY
	case 3: // shrl
		shiftOperationBits = ALU_SHR_0
	case 4: // shra
		shiftOperationBits = ALU_SHR_SIGN
	case 5: // ror
		shiftOperationBits = ALU_ROR
	case 6: // rorc
		shiftOperationBits = ALU_ROR_CARRY
	default:
		panic("invalid shift operation")
	}
	for i := 0; i < int(shiftAmount); i++ {
		instruction = append(instruction, shiftOperationBits|ALU_OUT|RW_IN)
	}
	instruction = append(instruction, shiftOperationBits|ALU_OUT|FR_IN|operand.getIn())
	if len(instruction) >= 8 {
		// TODO: handle this properly
		return []uint64{}
	}
	return append(instruction, NEXT_INST)
}

func test(src addressingMode) []uint64 {
	if !src.mode.isSrc() {
		return []uint64{}
	}
	instruction := []uint64{}
	instruction = append(instruction, src.getPrepSteps()...)
	instruction = append(instruction, src.getOut()|FR_IN)
	return append(instruction, NEXT_INST)
}
