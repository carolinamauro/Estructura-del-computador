

                    .begin
                    .org 2048

D1_22       .equ    0x90001
D1_12       .equ    0xD00
D2_22       .equ    0x90001
D2_12       .equ    0xD04
off_22      .equ    0xbffff
off_12      .equ    0xfff
on_22       .equ    0x40000
on_12       .equ    0x000

var_prueba_22 .equ  0xfff09

main:               sethi var_prueba_22, %r30
			addcc   %r0, %r15, %r31         ! guardo pos link
                    sethi	D1_22, %r1              ! asumo que es representable en 13 bits
                    sll	    %r1, 2, %r1
                    add	    %r1, D1_12, %r1		    ! direccion D1 en %r1
			st %r30, %r1
                    ld	    %r1, %r2                ! valor de D1 %r2
                    sll     %r2, 24, %r3            ! byte menos significativo => temperatura en %r3
                    srl     %r3, 24, %r3
                    sethi	D2_22, %r4              
                    sll	    %r4, 2, %r4
                    add	    %r4, D2_12, %r4         ! direc D2 en %r4	
			             st %r30, %r4	
                    ld	    %r4, %r5                ! D2 valor
                    call    setear_mantisas
                    subcc   %r3, 80, %r0
                    bneg    turn_off
                    ba turn_on

setear_mantisas:    sethi off_22, %r6
                    sll %r6, 2, %r6
                    add %r6, off_12, %r6            ! mantisa off
                    sethi on_22, %r7
                    sll %r7, 2, %r7
                    add %r7, on_12, %r7             ! mantisa on
                    jmpl %r15 + 4, %r0

turn_off:           andcc %r5, %r6, %r5
                    st %r5, %r4              
                    ba end
turn_on:            orcc %r5, %r7, %r5
                    st %r5, %r4
                    ba end


end:                halt

                    .end
                
                
