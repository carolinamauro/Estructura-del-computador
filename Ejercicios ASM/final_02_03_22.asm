! ldsh lduh

                    .begin
                    .org 2048
per_20              .equ 0xA7220
per_12              .equ 0x350
arrayA              .dwb 48
length:             .equ 194 

main:               sethi per_20, %r1
                    sll %r1, 2, %r1
                    add %r1, per_12, %r1            ! %r1 <- periferico
                    add %r0, length, %r10
                    add %r0, %r15, %r31
loop:               andcc %r10, %r10, %r0
                    be done
                    ld %r1, %r2
                    push %r2
                    call sub_rut
                    add %r10, -4, %r10
                    pop %r4
                    st [arrayA], %r10, %r4
                    add %r10, -4, %r10
                    pop %r4
                    st [arrayA], %r10, %r4
                    ba loop
                    
sub_rut:            pop %r2                         ! aca separo los numeros y los devuelvo
                    ldsh %r2, %r3                   ! los primeros 16 bits
                    push %r3
                    srl %r2, 16, %r2
                    push %r2
                    jmpl %r15 + 4, %r0

done:               jmpl %r31 + 4, %r0

                    .end
