                    .begin
                    .macro push num
                    addcc %r14, -4, %r14
                    st num, %r14
                    .endmacro
                    .macro pop reg
                    ld %r14, reg
                    addcc %r14, 4, %r14
                    .endmacro
                    .org 2048
per_20              .equ 0xC6400
per_12              .equ 0xC2c
arrayA:               .dwb 10

main:               sethi per_20, %r1
                    sll %r1, 2, %r1
                    add %r1, per_12, %r1
                    st %r1, %r1
                    add %r0, 40, %r10
                    add %r15, %r0, %r31

loop:               andcc %r10, %r10, %r0
                    be finish
                    call read_num
                    call is_neg
                    ba loop

read_num:           ld %r1, %r2
                    push %r2
                    ba done

is_neg:             pop %r2
                    addcc %r2, %r0, %r0
                    bneg add_num
                    ba done

add_num:            add %r10, -4, %r10
                    st %r2, %r10, arrayA
                    ld arrayA,%r10, %r3
                    ba done

done:               jmpl %r15 + 4, %r0
finish:             jmpl %r31 + 4, %r0

                    .end
                    

