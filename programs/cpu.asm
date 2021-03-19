#bits 16

#subruledef reg {
    ra => 0`3
    rb => 1`3
    rc => 2`3
    rd => 3`3
    rx => 4`3
    ry => 5`3
    pc => 6`3
    sp => 7`3
}

#subruledef operand_reg {
    {reg: reg} => 0b00 @ reg
}

#subruledef operand_ind_reg {
    [{reg: reg}] => 0b01 @ reg[2:0]
    [{reg: reg},0] => 0b01 @ reg
}

#subruledef operand_ind_off {
    [{reg: reg},{offset: i16}] => 0b10 @ reg @ offset[15:0]
}

#subruledef operand_ind_imm {
    [{value: u16}] => 0b11000 @ value
}

#subruledef operand_imm {
    {value: i16} => 0b11001 @ value
}

#subruledef operand_dest_noimmval {
    {op: operand_reg} => op
    {op: operand_ind_reg} => op
}

#subruledef operand_dest_immval {
    {op: operand_ind_off} => op
    {op: operand_ind_imm} => op
}

#subruledef operand_noimmval {
    {op: operand_reg} => op
    {op: operand_ind_reg} => op
}

#subruledef operand_immval {
    {op: operand_ind_off} => op
    {op: operand_ind_imm} => op
    {op: operand_imm} => op
}

#subruledef operand {
    {op: operand_immval} => op
    {op: operand_noimmval} => op
}

#subruledef operand_dest {
    {op: operand_dest_immval} => op
    {op: operand_dest_noimmval} => op
}

#ruledef {
    nop => (1<<15)[15:0]

    mov {dest: operand_dest_noimmval}, {src: operand_noimmval} =>
        0b1 @ 0b00000 @ dest @ src

    mov {dest: operand_dest_noimmval}, {src: operand_immval} =>
        0b1 @ 0b00000 @ dest @ src

    mov {dest: operand_dest_immval}, {src: operand_noimmval} =>
        0b1 @ 0b00000 @ dest[20:16] @ src @ dest[15:0]

    mov {dest: operand_dest_immval}, {src: operand_imm} =>
        0b1 @ 0b00000 @ dest[20:16] @ src[20:16] @ dest[15:0] @ src[15:0]

    mov {dest: operand_ind_imm}, {src: operand_dest_immval} =>
        0b1 @ 0b00000 @ dest[20:16] @ src[20:16] @ src[15:0] @ dest[15:0]
}

#ruledef {
    push {src: operand} =>
        0b1 @ 0b00000 @ 0b11001 @ src

    push flags =>
        0b1 @ 0b00000 @ 0b11001 @ 0b11010

    pop =>
        0b1 @ 0b11010 @ 0b001 @ 0b0111 @ 0b000 ; inc sp

    pop {dest: operand_dest} =>
        0b1 @ 0b00000 @ 0b11010 @ dest

    pop flags =>
        0b1 @ 0b00000 @ 0b11010 @ 0b11001
}

#subruledef jmp_ins {
    jmp => 0 ; always
    jz => 1 ; zero
    jnz => 2 ; not zero
    jc => 3 ; carry
    jnc => 4 ; not carry
    jn => 5 ; negative
    jnn => 6 ; not negative
    jo => 7 ; overflow
    jno => 8 ; not overflow
    je => 1 ; equal (zero)
    jne => 2 ; not equal (not zero)
    jb => 4 ; below (not carry)
    jbe => 9 ; below or equal (not carry or zero)
    ja => 10 ; above (carry and not zero)
    jae => 3 ; above or equal (carry)
    jl => 11 ; less than (overflow != negative)
    jle => 12 ; less than or equal (zero or (overflow != negative))
    jg => 13 ; greater than (not zero and (overflow == negative))
    jge => 14 ; greater than or equal (overflow == negative)
}

#ruledef {
    {cond: jmp_ins} {src: operand_noimmval} =>
        0b0 @ 0b01 @ cond[3:0] @ src @ 0b0000

    {cond: jmp_ins} {src: operand_immval} =>
        0b0 @ 0b01 @ cond[3:0] @ src[20:16] @ 0b0000 @ src[15:0]

    {cond: jmp_ins} pc,{relative: i16} =>
        0b0 @ 0b01 @ cond[3:0] @ 0b11010 @ 0b0000 @ relative
}


; binary alu operations:
; performs an binary alu operation on op0 and op1 and saves the result in op0

; operations with the postfix "_r" have a reversed operand order (result is still saved in op1)
#subruledef alu_op_binary {
    add => 0 ; add operands
    addc => 1 ; add operands and carry
    sub => 2 ; subtract second operand from first operand
    subc => 3 ; subtract second operand and carry from first operand
    sub_r => 4
    subc_r => 5
    and => 6
    or => 7
    xor => 8
    nand => 9
    nor => 10
    nxor => 11
    cmp => 12 ; sub without saving result
    cmp_r => 13 ; sub_r without saving result
    bits => 14 ; and without saving result
}

#ruledef {
    {operation: alu_op_binary} {op0: operand_noimmval}, {op1: operand_noimmval} =>
        0b1 @ 0b10 @ operation[3:0] @ op0[3:0] @ op1[4:0]

    {operation: alu_op_binary} {op0: operand_noimmval}, {op1: i16} =>
        0b1 @ 0b10 @ operation[3:0] @ op0[3:0] @ 0b10000 @ op1
}


; shift alu operations:
; shifts the operand by 1 or the speecified amount,
; amount is limited to 14 (12 when operand is in memory
; addressed by ra, rb, rc or rd) shifts because there are only 16
; microsteps per instruction

#subruledef alu_op_shift {
    shl => 0 ; shift left, 0 gets shiftet in
    rol => 1 ; rotate left
    rolc => 2 ; rotate left through carry
    shrl => 3 ; shift right logical, 0 gets shiftet in
    shra => 4 ; shift right arithmetical, bit 15 (sign bit) gets shiftet in
    ror => 5 ; rotate right
    rorc => 6 ; rotate right through carry
}

#ruledef {
    {operation: alu_op_shift} {op: operand_noimmval} =>
        0b1 @ 0b1100 @ operation[2:0] @ op[3:0] @ 0b0001

    {operation: alu_op_shift} {op: operand_reg}, {amount: u4} => {
        assert(amount != 0)
        assert(amount <= 14)
        0b1 @ 0b1100 @ operation[2:0] @ op[3:0] @ amount
    }

    {operation: alu_op_shift} {op: operand_ind_reg}, {amount: u4} => {
        assert(amount != 0)
        assert(op >= 4 || amount <= 12)
        assert(op < 4 || amount <= 14)
        0b1 @ 0b1100 @ operation[2:0] @ (op+8)[3:0] @ amount
    }
}


#subruledef alu_op_unary {
    not => 0
    inc => 1
    dec => 2
    test => 3 ; sets flags as if op were an alu result
}

#ruledef {
    {operation: alu_op_unary} {op: operand_noimmval} =>
        0b1 @ 0b11010 @ operation[2:0] @ op[4:0] @ 0b00

    {operation: alu_op_unary} [{op: u16}] =>
        0b1 @ 0b11010 @ operation[2:0] @ 0b10000 @ 0b00 @ op
}


#tokendef flag {
    z => 0 ; zero
    c => 1 ; carry
    n => 2 ; negative
    o => 3 ; overflow
    i => 4 ; interrupt enable
}

#ruledef {
    set{flag: flag} =>
        0b1 @ 0b00001 @ 0b1 @ flag[2:0] @ 0b000000

    clr{flag: flag} =>
        0b1 @ 0b00001 @ 0b0 @ flag[2:0] @ 0b000000
}

#ruledef {
    call {src: operand_noimmval} =>
        0b1 @ 0b00010 @ src @ 0b00000

    call {src: operand_immval} =>
        0b1 @ 0b00010 @ src[20:16] @ 0b00000 @ src[15:0]

    ret =>
        0b1 @ 0b00000 @ 0b11010 @ 0b00110 ; pop pc
}
