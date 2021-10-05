#bits 16

#subruledef reg {
    ra => 0`3
    rb => 1`3
    rc => 2`3
    rd => 3`3
    rx => 4`3
    ry => 5`3
    bp => 6`3
    sp => 7`3
}

#subruledef addr_mode {
    {reg: reg} => 0b00 @ reg
    [{reg: reg}] => 0b01 @ reg
    [{reg: reg}+{offset: i16}] => {
        assert(offset==0)
        0b01 @ reg
    }
    [{reg: reg}-{offset: i16}] => {
        assert(offset==0)
        0b01 @ reg
    }
    [{reg: reg}+{offset: i16}] => {
        assert(offset!=0)
        offset @ 0b10 @ reg
    }
    [{reg: reg}-{offset: i16}] => {
        assert(offset!=0)
        (-offset)`16 @ 0b10 @ reg
    }
    [{addr: u16}] => addr @ 0b11000
    {val: i16} => val @ 0b11001
}

#subruledef addr_mode_dest {
    {dest: addr_mode} => {
        assert(dest`5 != 0b11001)
        dest
    }
}

#subruledef condition {
    {} => 0b000 @ 0b0 ; always
    z => 0b001 @ 0b0 ; zero
    c => 0b010 @ 0b0 ; carry
    n => 0b011 @ 0b0 ; negative
    o => 0b100 @ 0b0 ; overflow
    be => 0b101 @ 0b0 ; below or equal (not carry or zero)
    l => 0b110 @ 0b0 ; less than (overflow != negative)
    le => 0b111 @ 0b0 ; less than or equal ((overflow != negative) or zero)

    nz => 0b001 @ 0b1 ; not zero
    nc => 0b010 @ 0b1 ; not carry
    nn => 0b011 @ 0b1 ; not negative
    no => 0b100 @ 0b1 ; not overflow
    a => 0b101 @ 0b1 ; above (not zero and carry)
    ge => 0b110 @ 0b1 ; greater than or equal (overflow == negative)
    g => 0b111 @ 0b1 ; greater than ((overflow == negative) and not zero)

    e => 0b001 @ 0b0 ; equal (zero)
    ne => 0b001 @ 0b1 ; not equal (not zero)
    ae => 0b010 @ 0b0 ; above or equal (carry)
    b => 0b010 @ 0b1 ; below (not carry)
}

#ruledef {
    reset => 0`16 ; resets the cpu
    nop => 1`16 ; no operation
}

#ruledef mov {
    ; moves the value at src to dest if condition is true

    mov{cond: condition} {dest: addr_mode_dest}, {src: addr_mode} => {
        assert(dest != src)
        assert(dest`5 < 0b10000 && src`5 < 0b10000)
        0b00 @ dest`5 @ src`5 @ cond`4
    }

    mov{cond: condition} {dest: addr_mode_dest}, {src: addr_mode} => {
        assert(dest != src)
        assert(dest`5 < 0b10000 && src`5 >= 0b10000)
        0b00 @ dest`5 @ src`5 @ cond`4 @ src[20:5]
    }

    mov{cond: condition} {dest: addr_mode_dest}, {src: addr_mode} => {
        assert(dest != src)
        assert(dest`5 >= 0b10000 && src`5 < 0b10000)
        0b00 @ dest`5 @ src`5 @ cond`4 @ dest[20:5]
    }

    mov{cond: condition} {dest: addr_mode_dest}, {src: addr_mode} => {
        assert(dest != src)
        assert(dest`5 >= 0b10000 && src`5 >= 0b10000)
        0b00 @ dest`5 @ src`5 @ cond`4 @ src[20:5] @ dest[20:5]
    }
}

#ruledef push {
    ; pushes the value at src onto the stack if condition is true

    push{cond: condition} {src: addr_mode} => {
        assert(src`5 < 0b10000)
        0b00 @ 0b11010 @ src`5 @ cond`4
    }

    push{cond: condition} {src: addr_mode} => {
        assert(src`5 >= 0b10000)
        0b00 @ 0b11010 @ src`5 @ cond`4 @ src[20:5]
    }

    push{cond: condition} fr => {
        0b00 @ 0b11010 @ 0b11100 @ cond`4
    }
}

#ruledef pop {
    ; pops a value off the stack into dest

    pop{cond: condition} {dest: addr_mode_dest} => {
        assert(dest`5 < 0b10000)
        0b00 @ dest`5 @ 0b11011 @ cond`4
    }

    pop{cond: condition} {dest: addr_mode_dest} => {
        assert(dest`5 >= 0b10000)
        0b00 @ dest`5 @ 0b11011 @ cond`4 @ dest[20:5]
    }

    pop{cond: condition} fr => {
        0b00 @ 0b11100 @ 0b11011 @ cond`4
    }
}

#ruledef jmp {
    ; jumps to addr if condition is true

    jmp{cond: condition} {addr: addr_mode} => {
        assert(addr`5 < 0b10000)
        0b00 @ 0b11101 @ addr`5 @ cond`4
    }

    jmp{cond: condition} {addr: addr_mode} => {
        assert(addr`5 >= 0b10000)
        0b00 @ 0b11101 @ addr`5 @ cond`4 @ addr[20:5]
    }

    jmp{cond: condition} pc+{offset: i16} => {
        0b00 @ 0b11101 @ 0b11110 @ cond`4 @ offset
    }
}

#ruledef call {
    ; calls the subroutine at addr if condition is true

    call{cond: condition} {addr: addr_mode} => {
        assert(addr`5 < 0b10000)
        0b00 @ 0b11111 @ addr`5 @ cond`4
    }

    call{cond: condition} {addr: addr_mode} => {
        assert(addr`5 >= 0b10000)
        0b00 @ 0b11111 @ addr`5 @ cond`4 @ addr[20:5]
    }

    call{cond: condition} pc+{offset: i16} => {
        0b00 @ 0b11111 @ 0b11110 @ cond`4 @ offset
    }
}

#ruledef ret {
    ; returns from subroutine if condition is true

    ret{cond: condition} => {
        0b00 @ 0b11101 @ 0b11011 @ cond`4
    }
}

#subruledef flag {
    z => 0 ; zero flag
    c => 1 ; carry flag
    n => 2 ; negative flag
    o => 3 ; overflow flag
    i => 4 ; interrupt enable flag
}

#ruledef {
    set{flag: flag} => ; sets the flag
        0b01 @ 0`9 @ 0b1 @ flag`3 @ 0b0

    clear{flag: flag} => ; clears the flag
        0b01 @ 0`9 @ 0b0 @ flag`3 @ 0b0
}

#ruledef test {
    ; sets zero and negative flags based on the value in src

    test {src: addr_mode} => {
        assert(src`5 < 0b10000)
        0b011 @ 0`7 @ src`5 @ 0b0
    }

    test {src: addr_mode} => {
        assert(src`5 >= 0b10000)
        0b011 @ 0`7 @ src`5 @ 0b0 @ src[20:5]
    }
}

; binary alu instructions:
; performs a binary alu operation on op0 and op1 and saves the result in op0
; operations with the postfix "_r" have a reversed operand order while the result is still saved in op1

#subruledef alu_op_binary {
    add => 0 ; op0 <- op0 + op1
    addc => 1 ; op0 <- op0 + op1 + c
    sub => 2 ; op0 <- op0 - op1
    sub_r => 3 ; op0 <- op1 - op0
    subc => 4 ; op0 <- op0 - op1 - c
    subc_r => 5 ; op0 <- op1 - op0 - c
    and => 6 ; op0 <- op0 & op1
    or => 7 ; op0 <- op0 | op1
    xor => 8 ; op0 <- op0 ^ op1
    nand => 9 ; op0 <- ~(op0 & op1)
    nor => 10 ; op0 <- ~(op0 | op1)
    nxor => 11 ; op0 <- ~(op0 ^ op1)
    cmp => 12 ; op0 - op1 (no result is saved, only affects flags)
    cmp_r => 13 ; op1 - op0 (no result is saved, only affects flags)
    bits => 14 ; op0 & op1 (no result is saved, only affects flags)
}

#ruledef {
    {alu_op: alu_op_binary} {op0: addr_mode_dest}, {op1: addr_mode} => {
        assert(op0`5 < 0b10000 && op1`5 < 0b10000)
        0b1 @ alu_op`4 @ op0`5 @ op1`5 @ 0b0
    }

    {alu_op: alu_op_binary} {op0: addr_mode_dest}, {op1: addr_mode} => {
        assert(op0`5 < 0b10000 && op1`5 >= 0b10000)
        0b1 @ alu_op`4 @ op0`5 @ op1`5 @ 0b0 @ op1[20:5]
    }

    {alu_op: alu_op_binary} {op0: addr_mode_dest}, {op1: addr_mode} => {
        assert(op0`5 == 0b11000 && op1`5 < 0b10000)
        0b1 @ alu_op`4 @ op0`5 @ op1`5 @ 0b0 @ op0[20:5]
    }

    {alu_op: alu_op_binary} {op0: addr_mode_dest}, {op1: addr_mode} => {
        assert(op0`5 == 0b11000 && op1`5 >= 0b10000)
        0b1 @ alu_op`4 @ op0`5 @ op1`5 @ 0b0 @ op1[20:5] @ op0[20:5]
    }
}

; shift instructions:
; shifts the value in op by the specified amount and saves the result back in op

#subruledef alu_op_shift {
    shl => 0 ; shift left
    rol => 1 ; rotate left
    rolc => 2 ; rotate left through carry
    shrl => 3 ; shift right logical
    shra => 4 ; shift right arithmetic
    ror => 5 ; rotate right
    rorc => 6 ; rotate right through carry
}

#ruledef {
    {alu_op: alu_op_shift} {op: addr_mode_dest} => {
        assert(op`5 < 0b10000)
        0b1 @ 0b1111 @ alu_op`3 @ 0b00 @ op`5 @ 0b0
    }

    {alu_op: alu_op_shift} {op: addr_mode_dest} => {
        assert(op`5 >= 0b10000)
        0b1 @ 0b1111 @ alu_op`3 @ 0b00 @ op`5 @ 0b0 @ op[20:5]
    }

    {alu_op: alu_op_shift} {op: addr_mode_dest}, {amount: u4} => {
        assert(amount >= 1 && amount <= 4)
        assert(op`5 < 0b10000)
        0b1 @ 0b1111 @ alu_op`3 @ (amount-1)`2 @ op`5 @ 0b0
    }

    {alu_op: alu_op_shift} {op: addr_mode_dest}, {amount: u4} => {
        assert(amount >= 1 && amount <= 4)
        assert(op`5 >= 0b10000)
        0b1 @ 0b1111 @ alu_op`3 @ (amount-1)`2 @ op`5 @ 0b0 @ op[20:5]
    }
}

; unary alu instructions:
; performs a unary alu operation on op and saves the result in op

#subruledef alu_op_unary {
    not => 0 ; op <- ~op
    neg => 1 ; op <- -op
    inc => 2 ; op <- op + 1
    dec => 3 ; op <- op - 1
}

#ruledef {
    {alu_op: alu_op_unary} {op: addr_mode_dest} => {
        assert(op`5 < 0b10000)
        0b1 @ 0b1111 @ 0b111 @ alu_op`2 @ op`5 @ 0b0
    }

    {alu_op: alu_op_unary} {op: addr_mode_dest} => {
        assert(op`5 >= 0b10000)
        0b1 @ 0b1111 @ 0b111 @ alu_op`2 @ op`5 @ 0b0 @ op[20:5]
    }
}
