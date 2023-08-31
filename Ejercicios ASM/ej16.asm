                    .begin
                    .org 2048
D1_22      		.equ    0x90001
D1_10      		.equ    0xD00
D2_22    	  	.equ    0x90001
D2_10		       .equ    0xD04
off_22    	  	.equ    0xbffff
off_10		       .equ    0xfff
on_22    	  	.equ    0x40000
on_10		       .equ    0x000

main:               sethi	D1_22, %r1              ! asumo que es representable en 13 bits
                    sll	    %r1, 2, %r1
                    add	    %r1, D1_10, %r1		
                    ld	    %r1, %r1                ! tengo mi valor de temperatura
                    sll     %r1, 5, %r1             ! byte menos significativo => temperatura
                    sethi	D2_22, %r2
                    sll %r2, 2, %r2
                    add %r2, D2_10, %r2		
                    ld	  %r2, %r2                ! D2 valor
                    subcc   %r1, 80, %r0
                    bneg    turn_off
                    ba turn_on

turn_off:           sethi off_22, %r3
                    sll %r3, 2, %r3
                    add %r3, off_10, %r3		
                    ld %r3, %r3	
			andcc %r2, [off], %r2
                    ba end
turn_on:            orcc %r2, [on], %r2
                    ba end

end:                halt

                    .end


