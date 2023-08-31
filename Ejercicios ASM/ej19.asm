!lee del stack => antes lo cargo
			.begin
			.org 2048
	
			
main:			ld [length], %r2			! long
			addcc %r15, %r0, %r29		! almacenamos posicion link
for:			andcc %r2, %r2, %r0			! chequeo elementos restantes
			be done
			addcc %r2, -4, %r2			! actualizamos indice
			ld %r2, [array], %r5		! direc array + lenght restante => guardo en %r5 el contenido
			call suma_parcial
			addcc %r3, %r4, %r4
			and %r0, %r3, %r3
			ba for

suma_parcial:		andcc %r5, %r5, %r0			! chequeo si queda 1's por contar
			be done_sum
			addcc %r5, %r0, %r0
			bneg sumo1				! bit mas significativo == 1, sumo				
			sll %r5, 1, %r5			! desplazo a izquierda
			ba suma_parcial

sumo1:			addcc %r3,1,%r3
			sll %r5, 1, %r5
			ba suma_parcial

done_sum:		jmpl %r15 + 4, %r0	

done:			push %r4
			jmpl %r29 + 4, %r0
	
length:		16
array:			10
			15
			15
			7					
			
			.end


