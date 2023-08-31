! devolver el numero mayor y el menor de un arreglo
! %r1 esta la longuitud del arreglo
! %r2 puntero al arrelo 
! %r3 maximo
! %r4 minimo

			.begin
			.org 2048
			! .extern minimo
			
main:			add %r15, %r0, %r31		! backup link
			ld [length], %r1		! cargo desde memoria la longitud del arreglo
			addcc %r1, -4, %r9
			ld %r9,[array], %r3		! cargo el primer elemento
			ld %r9,[array], %r4			

for:			andcc %r1, %r1, %r0		! chequear elementos restantes
			be done
			addcc %r1, -4, %r1
			ld %r1,[array], %r5		! elemento actual del array a comparar
			call maximo
			call minimo
			ba for
			
maximo:		xorcc %r5, %r3, %r0
			bneg uno_y_uno
			subcc %r5, %r3, %r0		! ambos negativos o negativos
			bneg done_max			! resultado es negativo => %r5 < %r3 (10 - 11 = -1, 11 > 10)
			ba mayor_nuevo		! 			    => %r5 < %r3 (-10-(-2) = -8, -2 > -10)

uno_y_uno:		orncc %r0, %r5, %r0
			bneg mayor_nuevo
			ba done_max

mayor_nuevo:		or %r5, %r0, %r3
			ba done_max

done_max:		jmpl %r15 + 4, %r0

done:			jmpl %r31 + 4, %r0

			! .global 
			! .begin
			! .org 2048 ?
minimo:		xorcc %r5, %r4, %r0	
			bneg neg_y_pos		! uno negativo y uno positivo
			subcc %r5, %r4, %r0		! ambos positivos o ambos negavitvos
			bneg menor_nuevo
			ba done_min

neg_y_pos:		orcc %r0, %r5, %r0		! chequeo si el actual es negativo
			bneg menor_nuevo		! de ser negativo significa que %r5 < %r4	
			ba done_min			

menor_nuevo:		or %r5, %r0, %r4
			ba done_min

done_min:		jmpl %r15 + 4, %r0
							
			! .end

length:		24
array:			-2
			-4
			2
			1
			-128
			30
		
			.end


