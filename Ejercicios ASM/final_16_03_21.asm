                   
                    .begin  
                    .org 2048
per_20                .equ 0xBAD00
per_12                .equ 0x132

main:               pop %r1                 ! %r1 <- dirección inicio
                    pop %r2                 ! %r2 <- largo del arreglo. Asumo que el largo esta dado como cant_numeros * 4
                    andcc %r0, %r7, %r7     ! inicializar %r7 en 0
                    add %r15, %r0, %r31
loop:               andcc %r2, %r2, %r0
                    be done
                    add %r2, -4, %r2
                    ld %r1, %r2, %r3        ! %r3 <- elemento leído
                    push %r3
                    call sub_rut
                    pop %r6
                    addcc %r0, %r6, %r0
                    be loop
                    addcc %r3, %r7, %r7     ! %r7 <- suma parcial
                    ba loop
sub_rut:            pop %r4
                    srl %r4, 4, %r4
                    orcc %r4, %r0, %r0
                    be add_num
                    push %r0
                    jmpl %r15 + 4, %r0
add_num:            add %r0, 1, %r5
                    push %r5
                    jmpl %r15 + 4, %r0
done:               sethi per_20, %r10
                    sll %r10, 2, %r10
                    add %r10, per_12, %r10
                    st %r7, %r10
                    jmpl %r31 + 4, %r0

                    .end
