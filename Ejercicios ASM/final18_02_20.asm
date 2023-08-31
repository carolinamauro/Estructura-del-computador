                    .begin
                    .org 2048

                    .macro push r
                    add %r14, -4, %r14
                    st r, %r14
                    .endmacro

                    .macro pop r
                    ld %r14, r
                    add %r14, 4, %r14
                    .endmacro

array:              .dwb 32                 ! array de 32 palabras
per_20              .equ 0xC3101
per_12              .equ 0x200
length              .equ 128

main:               sethi per_20, %r1
                    sll %r1, 2, %r1
                    add %r1, per_12, %r1    ! %r1 <- periferico
                    add %r15%r0, %r31               ! guardo en el stack la dirección de la rutina invocante
                    add %r0, length, %r2    ! %r2 <- length
                    push %r2                ! pusheo el largo
                    sethi array, %r3
                    srl %r3, 10, %r3        ! %r3 <- dirección del arreglo (válido si es representable en 22 bits)
                    push %r3                ! pusheo dirección arreglo
                   
loop:               andcc %r2, %r2, %r0     ! chequeo condicion
                    be done
                    add %r2, -4, %r2
                    ld %r1, %r10            ! leo un numero
                    st %r10, %r2, %r3       ! guardo el numero en el array
                    ba loop

done:               call calculate_average 
                    jmpl %r31 + 4, %r0

calculate_average:  pop %r3                 ! %r3 <- dirección del arreglo
                    pop %r2                 ! %r2 <- length
loop_average:       andcc %r2, %r2, %r0     ! chequeo condicion
                    be end_average
                    add %r2, -4, %r2
                    ld %r2, %r3, %r4
                    addcc %r4, %r5, %r5     
                    bvs out_of_rang
                    ba loop_average

out_of_rang:        push %r0
                    ba done
end_average:        push %r5
                    ba done

