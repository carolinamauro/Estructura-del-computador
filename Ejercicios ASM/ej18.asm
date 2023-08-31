!lee del stack => antes lo cargo
			.begin
			.org 2048
			
			.macro push origen
			addcc %r14, -4, %r14
			st origen, %r14
			.endmacro
			
			.macro pop destino
			ld %r14, destino
			addcc %r14, 4, %r14
			.endmacro
			
main:			addcc %r0, 10, %r31		! como no tengo nada en el stack antes cargo algo
			push %r31			! meramente a modo de ejemplo es esto
			pop %r1
			addcc %r1, %r0, %r2		! auxiliar

for:			andcc %r2, %r2, %r0
			be done
			addcc %r2, %r0, %r0
			bneg sumo1			
			sll %r2, 1, %r2
			ba for

sumo1:			addcc %r3,1,%r3
			sll %r2, 1, %r2
			ba for

done:			jmpl %r15 + 4, %r0		
						
			
			.end


