! Calculamos el factorial de x almacenado en %r1.
! Almaceno el resultado en %r3
! El resultado final esta en %r1
! El numero tiene que estar entre 1 y 10

			.begin
			.org 2048

main:			ld [y], %r1			! cargo el 7 en %r1
			st %r15, %r31			! guardo a donde debo volver
			ld [max], %r30		! numero maximo posible
			addcc %r1, %r0, %r0		! chequeo 0 y numeros menores a 1
			be no_rep
			bneg no_rep
			
			orncc %r0, %r1, %r6		! realizo %r0 <- [max]-%r6
			addcc %r29, 1, %r6
			addcc %r6, %r30, %r0
			bneg no_rep			! si la resta me da un numero negativo es porque %r1 > [max]						
			
			addcc %r1, -1, %r2		! factorial actual (6)
			addcc %r1, -1, %r4		! facotial que se va a ir modificando en cada mult (6)
			andcc %r0, %r3, %r3		! acumulador 
		
factorial:		andcc %r2, %r2, %r0		! chqueo iteraciones restantes
			be done
			call multiplicar
			addcc %r2,-1, %r2		! restamos 1 a %r2 y almacenamos en %r2 y %r4
			addcc %r2, %r0, %r4	
			andcc %r1, %r0, %r1		! pongo en 0 a %r1
			addcc %r1, %r3, %r1		! pongo el resultado parcial de %r3 como mi nuevo numero a multiplicar
			andcc %r3, %r0, %r3		! reinicio mi acumulador
			ba factorial

multiplicar:		andcc %r4, %r4, %r0		! chqueo iteraciones restantes
			be volver_fact
			addcc %r1, %r3, %r3		! sumo x a %r3
			bcs no_rep			! chequeo carry
			addcc %r4, -1, %r4
			ba multiplicar
volver_fact:		jmpl %r15 + 4, %r0
		
no_rep:		and %r0, %r3, %r3
			addcc %r3, -1, %r3		! pongo -1 el resultado
			be done

done:			addcc %r3, %r1, %r3		! guardamos resultado en %r3
			jmpl %r31 + 4, %r0

x:			7
y:			0
max:			10

			.end
