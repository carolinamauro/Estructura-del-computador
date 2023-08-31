! %r4 resultado
! %r3 suma 	
! %r6 bit menos significativo		
			.begin
			.org 2048
length			.equ 20

main:			add %r0, length, %r1		! almaceno la longitud
			ld [array], %r2			! puntero a mi array
			add %r15, %r0, %r31
			and %r3, %r0, %r3			! acumulador en 0
			call paridad


paridad:		addcc %r0, %r15, %r30		! almaceno pos
			call suma
			srl %r3, 1, %r6
			
			jmpl %r31 + 4, %r0
			


suma:			andcc %r1, %r1, %r0			! chequeo elementos restantes
			be done_suma
			addcc %r1, -4, %r1			! recorro 1 elemento
			ld %r1, [array], %r5		! elemento actual
			addcc %r5, %r3, %r3			! sumo
			bvs overflow
			ba suma

overflow:		add %r0, -1, %r4
			jmpl %r15 + 4, %r0
			
			

done_suma:		jmpl %r15 + 4, %r0
			
			

			


array:		2
		10
		3
		5
		11
			.end


