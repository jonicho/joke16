halt = 1 << 0
set_step = 1 << 1

ra_in = 0 << 6
rb_in = 1 << 6
rc_in = 2 << 6
rd_in = 3 << 6
rx_in = 4 << 6
ry_in = 5 << 6
pc_in = 6 << 6
sp_in = 7 << 6
rw_in = 8 << 6
rz_in = 9 << 6
adlatch_in = 10 << 6
ir_in = 11 << 6
db_in = 12 << 6

ra_out = 1 << 10
rb_out = 2 << 10
rc_out = 3 << 10
rd_out = 4 << 10
rx_out = 5 << 10
ry_out = 6 << 10
pc_out = 7 << 10
sp_out = 8 << 10
alu_out = 9 << 10
flagreg_out = 10 << 10
db_out = 11 << 10

rx_out_address_bus = 1 << 14
ry_out_address_bus = 2 << 14
pc_out_address_bus = 3 << 14
sp_out_address_bus = 4 << 14
adlatch_out_a = 5 << 14

rx_count_up = 1 << 17
rx_count_down = 1 << 18
ry_count_up = 1 << 19
ry_count_down = 1 << 20
pc_count_up = 1 << 21
pc_count_down = 1 << 22
sp_count_up = 1 << 23
sp_count_down = 1 << 24

rz_clear = 1 << 25

alu_adc = 0 << 26 | 0b01 << 29
alu_adc_0 = 0 << 26 | 0b00 << 29
alu_adc_1 = 0 << 26 | 0b10 << 29
alu_add = alu_adc_0
alu_sbc = 1 << 26 | 0b01 << 29
alu_sbc_0 = 1 << 26 | 0b00 << 29
alu_sbc_1 = 1 << 26 | 0b10 << 29
alu_sub = alu_sbc_1
alu_shl = 2 << 26 | 0b00 << 29
alu_rolc = 2 << 26 | 0b10 << 29
alu_rol = 2 << 26 | 0b11 << 29
alu_shrl = 3 << 26 | 0b00 << 29
alu_shra = 3 << 26 | 0b01 << 29
alu_rorc = 3 << 26 | 0b10 << 29
alu_ror = 3 << 26 | 0b11 << 29
alu_and = 4 << 26
alu_or = 5 << 26
alu_xor = 6 << 26
alu_not = 7 << 26

flagreg_in = 1 << 31
flagreg_sel_bus = 1 << 32
flagreg_set = 1 << 33
flagreg_reset = 1 << 34


def step_bits(step):
    if step < 0 or step > 15:
        raise ValueError(step)
    return step << 2


def set_step_counter(step):
    return step_bits(step) | set_step


def set_flag(flag):
    if flag < 0 or flag > 7:
        raise ValueError(flag)
    return flag << 35 | flagreg_set


def clear_flag(flag):
    if flag < 0 or flag > 7:
        raise ValueError(flag)
    return flag << 35 | flagreg_reset


next_ins_value_out = pc_out_address_bus | pc_count_up | db_out

# use alu as temporary register
tmp_in = rw_in | rz_clear
tmp_out = alu_out


# ra = 0b000
# rb = 0b001
# rc = 0b010
# rd = 0b011
# rx = 0b100
# ry = 0b101
# pc = 0b110
# sp = 0b111


def insbit_out(regcode):
    return [ra_out,
            rb_out,
            rc_out,
            rd_out,
            rx_out,
            ry_out,
            pc_out,
            sp_out][regcode]


def insbit_out_address_bus(regcode):
    return [rx_out_address_bus,
            ry_out_address_bus,
            pc_out_address_bus,
            sp_out_address_bus][regcode-4]


def insbit_in(regcode):
    return [ra_in,
            rb_in,
            rc_in,
            rd_in,
            rx_in,
            ry_in,
            pc_in,
            sp_in][regcode]


def from_reg_mem(dest_bits, src_reg):
    if src_reg < 4:
        return [
            insbit_out(src_reg) | adlatch_in,
            adlatch_out_a | db_out | dest_bits
        ]
    else:
        return [
            insbit_out_address_bus(src_reg) | db_out | dest_bits
        ]


def to_reg_mem(dest_reg, src_bits, reg_already_in_adlatch=False):
    if dest_reg < 4:
        if reg_already_in_adlatch:
            return [
                adlatch_out_a | src_bits | db_in
            ]
        else:
            return [
                insbit_out(dest_reg) | adlatch_in,
                adlatch_out_a | src_bits | db_in
            ]
    else:
        return [
            insbit_out_address_bus(dest_reg) | src_bits | db_in
        ]


def controlwords_instruction(instruction):
    if instruction == 0x7fff:  # interrupt
        return [
            rz_clear | sp_count_down | clear_flag(4),
            sp_out_address_bus | pc_out | db_in,
            alu_and | alu_out | rw_in,
            alu_sbc_0 | alu_out | adlatch_in,
            adlatch_out_a | db_out | pc_in
        ]

    opcode = (instruction >> 10) & 0x1f

    if opcode == 0:  # mov/push/pop
        operand_0 = (instruction >> 5) & 0x1f
        operand_1 = instruction & 0x1f

        if operand_0 <= 24 and operand_1 <= 25 and (operand_0 < 16 or operand_0 >= 24 or operand_1 < 8 or operand_1 == 25):
            return mov(dest=operand_0, src=operand_1)
        if operand_0 == 25 and operand_1 <= 25:
            return push(src=operand_1)
        if operand_0 == 26 and operand_1 <= 24:
            return pop(dest=operand_1)
        return []

    elif opcode == 1:  # set/clr
        if instruction & (1 << 9) == 0:
            clear_flag((instruction >> 6) & 0x7)
        else:
            set_flag((instruction >> 6) & 0x7)
    elif opcode == 2:  # call
        call(src=(instruction >> 5) & 0x1f)
    elif opcode == 3:  # copy
        copy(length_src=(instruction >> 4) & 0x1f,
             up=bool((instruction >> 9) & 0x1),
             zero_flag=bool(instruction & 0x1))
    elif opcode >= 8 and opcode < 16:  # jump's
        return jump(condition=(instruction >> 9) & 0xf,
                    src=(instruction >> 4) & 0x1f,
                    flags=instruction & 0xf)
    elif opcode < 24:  # binary alu operations
        return bin_alu_op(operation=(instruction >> 9) & 0xf,
                          operand_0=(instruction >> 5) & 0xf,
                          operand_1=instruction & 0x1f)
    elif opcode < 26:  # shift
        return shift(operation=(instruction >> 8) & 0x7,
                     operand=(instruction >> 4) & 0xf,
                     amount=instruction & 0xf)
    elif opcode == 26:  # unary alu operations
        return un_alu_op(operation=(instruction >> 7) & 0x7,
                         operand=(instruction >> 2) & 0x1f)
    return []


def mov(dest, src):
    if dest < 8:
        if src < 8:
            return [insbit_out(src) | insbit_in(dest)]
        elif src < 16:
            return from_reg_mem(insbit_in(dest), src-8)
        elif src < 24:
            src_reg = src-16
            return [
                insbit_out(src_reg) | rw_in,
                next_ins_value_out | rz_in,
                alu_add | alu_out | adlatch_in,
                adlatch_out_a | db_out | insbit_in(dest)
            ]
        elif src == 24:
            return [
                next_ins_value_out | adlatch_in,
                adlatch_out_a | db_out | insbit_in(dest)
            ]
        elif src == 25:
            return [next_ins_value_out | insbit_in(dest)]
    elif dest < 16:
        dest_reg = dest-8
        if src < 8:
            return to_reg_mem(dest_reg, insbit_out(src))
        elif src < 16:
            src_reg = src-8
            return from_reg_mem(tmp_in, src_reg) + to_reg_mem(dest_reg, tmp_out)
        elif src < 24:
            src_reg = src-16
            return [
                insbit_out(src_reg) | rw_in,
                next_ins_value_out | rz_in,
                alu_add | alu_out | adlatch_in,
                adlatch_out_a | db_out | tmp_in
            ] + to_reg_mem(dest_reg, tmp_out)
        elif src == 24:
            return [
                next_ins_value_out | adlatch_in,
                adlatch_out_a | db_out | tmp_in
            ] + to_reg_mem(dest_reg, tmp_out)
        elif src == 25:
            return [next_ins_value_out | tmp_in] + to_reg_mem(dest_reg, tmp_out)
    elif dest < 24:
        dest_reg = dest-16
        if src < 8:
            return [
                insbit_out(dest_reg) | rw_in,
                next_ins_value_out | rz_in,
                alu_add | alu_out | adlatch_in,
                adlatch_out_a | insbit_out(src) | db_in
            ]
        elif src == 25:
            return [
                insbit_out(dest_reg) | rw_in,
                next_ins_value_out | rz_in,
                alu_add | alu_out | adlatch_in,
                next_ins_value_out | tmp_in,
                adlatch_out_a | tmp_out | db_in
            ]
    elif dest == 24:
        if src < 8:
            return [
                next_ins_value_out | adlatch_in,
                adlatch_out_a | insbit_out(src) | db_in
            ]
        elif src < 16:
            src_reg = src-8
            return from_reg_mem(tmp_in, src_reg) + [
                next_ins_value_out | adlatch_in,
                adlatch_out_a | tmp_out | db_in
            ]
        elif src < 24:
            src_reg = src-16
            return [
                insbit_out(src_reg) | rw_in,
                next_ins_value_out | rz_in,
                alu_add | alu_out | adlatch_in,
                adlatch_out_a | db_out | tmp_in,
                next_ins_value_out | adlatch_in,
                adlatch_out_a | tmp_out | db_in
            ]
        elif src == 24:
            return [
                next_ins_value_out | adlatch_in,
                adlatch_out_a | db_out | tmp_in,
                next_ins_value_out | adlatch_in,
                adlatch_out_a | tmp_out | db_in
            ]
        elif src == 25:
            return [
                next_ins_value_out | adlatch_in,
                next_ins_value_out | tmp_in,
                adlatch_out_a | tmp_out | db_in
            ]
    return []


def push(src):
    if src < 8:
        return [sp_count_down, sp_out_address_bus | insbit_out(src) | db_in]
    elif src < 16:
        a = from_reg_mem(tmp_in, src-8)
        a[0] |= sp_count_down
        return a + [sp_out_address_bus | tmp_out | db_in]
    elif src < 24:
        return [
            sp_count_down | insbit_out(src-16) | rw_in,
            next_ins_value_out | rz_in,
            alu_add | alu_out | adlatch_in,
            adlatch_out_a | db_out | tmp_in,
            sp_out_address_bus | tmp_out | db_in
        ]
    elif src == 24:
        return [
            sp_count_down | next_ins_value_out | adlatch_in,
            adlatch_out_a | db_out | tmp_in,
            sp_out_address_bus | tmp_out | db_in
        ]
    elif src == 25:
        return [
            sp_count_down | next_ins_value_out | tmp_in,
            sp_out_address_bus | tmp_out | db_in
        ]
    elif src == 26:
        return [sp_count_down, sp_out_address_bus | flagreg_out | db_in]
    return []


def pop(dest):
    if dest < 8:
        return [sp_out_address_bus | sp_count_up | db_out | insbit_in(dest)]
    elif dest < 16:
        return [
            sp_out_address_bus | sp_count_up | db_out | tmp_in
        ] + to_reg_mem(dest-8, tmp_out)
    elif dest < 24:
        return [
            insbit_out(dest-16) | rw_in,
            next_ins_value_out | rz_in,
            alu_add | alu_out | adlatch_in,
            sp_out_address_bus | sp_count_up | db_out | tmp_in,
            adlatch_out_a | tmp_out | db_in
        ]
    elif dest == 24:
        return [
            sp_out_address_bus | sp_count_up | db_out | tmp_in,
            next_ins_value_out | adlatch_in,
            adlatch_out_a | tmp_out | db_in
        ]
    elif dest == 25:
        return [sp_out_address_bus | sp_count_up | db_out | flagreg_sel_bus | flagreg_in]
    return []


def call(src):
    push_pc = [
        sp_count_down,
        sp_out_address_bus | pc_out | db_in
    ]
    if src < 8:
        return push_pc + [insbit_out(src) | pc_in]
    elif src < 12:
        return [
            sp_count_down | insbit_out(src-8) | adlatch_in,
            sp_out_address_bus | pc_out | db_in,
            adlatch_out_a | db_out | pc_in
        ]
    elif src < 16:
        return push_pc + [insbit_out_address_bus(src-8) | db_out | pc_in]
    elif src < 24:
        return [
            sp_count_down | next_ins_value_out | rz_in,
            sp_out_address_bus | pc_out | db_in,
            insbit_out(src-16) | rw_in,
            alu_add | alu_out | adlatch_in,
            adlatch_out_a | db_out | pc_in
        ]
    elif src == 24:
        return [
            sp_count_down | next_ins_value_out | adlatch_in,
            sp_out_address_bus | pc_out | db_in,
            adlatch_out_a | db_out | pc_in
        ]
    elif src == 25:
        return [
            sp_count_down | next_ins_value_out | tmp_in,
            adlatch_out_a | db_out | pc_in,
            tmp_out | pc_in
        ]


def copy(length_src, up, zero_flag):
    if length_src < 4:
        return [
            insbit_out(length_src) | flagreg_in,
            set_step_counter(0) if zero_flag else (
                rx_out_address_bus | db_out | tmp_in),
            ry_out_address_bus | tmp_out | db_in,
            insbit_out(length_src) | rw_in | rz_clear |
            ((rx_count_up | ry_count_up) if up else (
                rx_count_down | ry_count_down)),
            alu_sbc_0 | alu_out | insbit_in(length_src) |
            flagreg_in | set_step_counter(2)
        ]
    return []


def jump(condition, src, flags):
    zero_flag = bool((flags >> 0) & 1)
    carry_flag = bool((flags >> 1) & 1)
    negative_flag = bool((flags >> 2) & 1)
    overflow_flag = bool((flags >> 3) & 1)

    condition_list = [
        True,
        zero_flag,
        not zero_flag,
        carry_flag,
        not carry_flag,
        negative_flag,
        not negative_flag,
        overflow_flag,
        not overflow_flag,
        (not carry_flag) or zero_flag,
        carry_flag and not zero_flag,
        overflow_flag != negative_flag,
        zero_flag or (overflow_flag != negative_flag),
        (not zero_flag) and (overflow_flag == negative_flag),
        overflow_flag == negative_flag
    ]

    if condition >= len(condition_list):
        return []

    if not condition_list[condition]:
        return [pc_count_up if src == 24 or src == 25 else 0]

    if src < 8:
        return [insbit_out(src) | pc_in]
    elif src < 16:
        return from_reg_mem(pc_in, src-8)
    elif src < 24:
        return [
            insbit_out(src-16) | rw_in,
            next_ins_value_out | rz_in,
            alu_add | alu_out | adlatch_in,
            adlatch_out_a | db_out | pc_in
        ]
    elif src == 24:
        return [
            next_ins_value_out | adlatch_in,
            adlatch_out_a | db_out | pc_in
        ]
    elif src == 25:
        return [next_ins_value_out | pc_in]
    elif src == 26:
        return [
            pc_out | rw_in,
            next_ins_value_out | rz_in,
            alu_add | alu_out | pc_in
        ]
    return []


def bin_alu_op(operation, operand_0, operand_1):
    result = []
    operand_0_in = rz_in if operation in [4, 5, 13] else rw_in
    operand_1_in = rw_in if operation in [4, 5, 13] else rz_in

    if operand_0 < 8:
        result += [insbit_out(operand_0) | operand_0_in]
    elif operand_0 < 16:
        result += from_reg_mem(operand_0_in, operand_0-8)
    else:
        return []

    if operand_1 < 8:
        result += [insbit_out(operand_1) | operand_1_in]
    elif operand_1 < 16:
        result += from_reg_mem(operand_1_in, operand_1-8)
    elif operand_1 == 16:
        result += [next_ins_value_out | operand_1_in]
    else:
        return []

    last_operation_bits = 0
    if operation < 9:
        last_operation_bits = [
            alu_add,
            alu_adc,
            alu_sub,
            alu_sbc,
            alu_sub,
            alu_sbc,
            alu_and,
            alu_or,
            alu_xor
        ][operation]
    elif operation < 12:
        result += [[alu_and, alu_or, alu_xor]
                   [operation-9] | alu_out | rw_in | rz_clear]
        last_operation_bits = alu_not
    elif operation < 15:
        operation_bits = [
            alu_sub,
            alu_sub,
            alu_and
        ][operation-12]
        return result + [operation_bits | alu_out | flagreg_in]
    else:
        return []

    if operand_0 < 8:
        result += [last_operation_bits | alu_out |
                   insbit_in(operand_0) | flagreg_in]
    elif operand_0 < 16:
        result += to_reg_mem(operand_0-8, last_operation_bits | alu_out | flagreg_in,
                             reg_already_in_adlatch=True)
    else:
        return []
    return result


def shift(operation, operand, amount):
    if amount < 1 or operation > 6:
        return []

    operation_bits = [
        alu_shl,
        alu_rol,
        alu_rolc,
        alu_shrl,
        alu_shra,
        alu_ror,
        alu_rorc
    ][operation]

    if operand < 8:
        if amount > 14:
            return []
        return ([insbit_out(operand) | rw_in | rz_clear] +
                ([operation_bits | alu_out | rw_in] * (amount-1)) +
                [operation_bits | alu_out | insbit_in(operand) | flagreg_in])
    elif operand < 16:
        if ((operand < 12 and amount > 12) or
                (operand >= 12 and amount > 14)):
            return []
        return (from_reg_mem(rw_in | rz_clear, operand-8) +
                ([operation_bits | alu_out | rw_in] * (amount-1)) +
                to_reg_mem(operand-8, operation_bits | alu_out | flagreg_in,
                           reg_already_in_adlatch=True))
    return []


def un_alu_op(operation, operand):
    if operation < 3:
        operation_bits = [
            alu_not,
            alu_adc_1,
            alu_sbc_0
        ][operation]

        if operand < 4:
            return [
                insbit_out(operand) | rw_in | rz_clear,
                operation_bits | alu_out | insbit_in(operand) | flagreg_in
            ]
        elif operand < 8:  # use hardware inc/dec for operands that support it
            if operation == 0:
                return [
                    insbit_out(operand) | rw_in | rz_clear,
                    alu_not | alu_out | insbit_in(operand) | flagreg_in
                ]
            if operation == 1:
                return [
                    [pc_count_up, sp_count_up, rx_count_up,
                        ry_count_up][operand-4] | flagreg_in
                ]
            if operation == 2:
                return [
                    [pc_count_down, sp_count_down, rx_count_down,
                        ry_count_down][operand-4] | flagreg_in
                ]
        elif operand < 16:
            return (from_reg_mem(rw_in | rz_clear, operand-8) +
                    to_reg_mem(operand-8, operation_bits | alu_out | flagreg_in,
                               reg_already_in_adlatch=True))
        elif operand == 16:
            return [
                next_ins_value_out | adlatch_in,
                adlatch_out_a | db_out | rw_in | rz_clear,
                adlatch_out_a | operation_bits | alu_out | db_in | flagreg_in
            ]
    elif operation == 3:
        if operand < 8:
            return [insbit_out(operand) | flagreg_in]
        if operand < 16:
            return from_reg_mem(flagreg_in, operand-8)
        if operand == 16:
            return [
                next_ins_value_out | adlatch_in,
                adlatch_out_a | db_out | flagreg_in
            ]

    return []


def get_controlwords(instruction):
    controlwords = []
    if instruction == 0:  # reset/nop
        # when nop step counter is at 1, load next instruction and keep step counter at 1
        # when reset step counter is at 0, perform reset sequence while skipping step 1 in order to not execute nop
        controlwords = [
            alu_sbc_0 | alu_out | rw_in | set_step_counter(2),
            # nop, load next instrucion and keep step counter at 1
            next_ins_value_out | ir_in | set_step_counter(1),
            alu_sbc_0 | alu_out | adlatch_in,
            adlatch_out_a | db_out | pc_in,
            next_ins_value_out | ir_in | set_step_counter(1)
        ]
    else:
        # load instruction at step 0
        controlwords = [next_ins_value_out | ir_in]
        # execute instruction
        controlwords += controlwords_instruction(instruction)

    # set step counter to 0 at the end of instruction
    controlwords[len(controlwords)-1] |= set_step

    if len(controlwords) > 16:
        raise RuntimeError("control word list too long")

    return controlwords


controlword_list = [get_controlwords(instruction)
                    for instruction in range(2**15)]


def get_controlword(input_bits):
    step = input_bits & 0xf
    instruction = (input_bits >> 4) & 0x7fff

    if len(controlword_list[instruction]) >= step+1:
        return controlword_list[instruction][step]
    else:
        return halt


def main():
    print("generating control words...")
    o_cw = [x for x in controlword_list if len(x) > 1]
    print(f"{len(o_cw)} of {len(controlword_list)} instructions used ({100*len(o_cw)/len(controlword_list)} %)")
    controlwords = [get_controlword(x) for x in range(2**19)]
    for eeprom_number in [0, 1, 2, 3, 4, 5]:
        bs = bytearray([(x >> (eeprom_number * 8)) & 0xff
                        for x in controlwords])
        file = open("microcode-"+str(eeprom_number) + ".bin", "wb")
        file.write(bs)
        file.close()


if __name__ == "__main__":
    main()
