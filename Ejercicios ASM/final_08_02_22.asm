                    .begin  
                    .org 2048

                    .macro push elemento
                    st elemento, %r14
                    add %r14, -4, %r14
                    .endmacro

                    .macro pop destino
                    add %r14, 4, %r14
                    ld %r14, destino
                    .endmacro

length              .equ 64
per_20              .equ 0xA3C20
per_12              .equ 0x140
arreglo:            .dwb 16
main:               add length, %r0, %r1        ! %r1 <- largo del arreglo
                    sethi arreglo, %r5          ! %r5 <- dirección del arreglo
                    srl %r5, 10, %r5            ! direccion representable en 22 bits
                    push %r15                   ! %r31 <- link  

loop:               andcc %r1, %r1, %r0         ! chequeo elementos restantes
                    be done
                    call lectura 
                    pop %r2                     ! elemento leido
                    addcc %r2, %r0, %r0
                    bneg loop                   ! si es negativo volvemos a leer otro num
                    add %r1, -4, %r1
                    st %r2, %r5, %r1            ! agrero el num a mi arreglo
                    ba loop

lectura:            sethi per_20, %r3
                    sll %r3, 2, %r3
                    add %r3, per_12, %r3        ! direccion de mi periferico
                    ld %r3, %r4                 ! leo un numeros
                    push %r4                    ! guardo el elemento leido en la pila
                    jmpl %r15 + 4, %r0          
                  
done:               pop %r15
                    jmpl %r15 + 4, %r0
                    .end
