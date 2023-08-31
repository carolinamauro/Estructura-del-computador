! calculo el cuadrado del numero
! multiplicar x*x => hacer un loop de sumas sumar x veces x	
! ver numeros negativos
	
			.begin
			.org 2048
		
main:			addcc %r0, 2, %r1
			add %r15,%r0, %r30		! backup link	
			call valor_abs		! calculo el valor absoluto
			add %r1,%r0, %r2		! copio el contenido de %r1 en %r2	
			andcc %r3, %r0, %r3		! resultado parcial
			call cuadrado				
			st %r3, [res]			! almaceno en memoria el resultado porque pinto
			jmpl %r30 + 4, %r0
			
cuadrado:		andcc %r2, %r2, %r0		! chequeo iteraciones
			be done
			addcc %r3, %r1, %r3		! sumo
			bvs no_rep
			addcc %r2, -1, %r2		! iteraciones restantes
			ba cuadrado	
valor_abs:		addcc %r1, %r0, %r0
			bneg es_neg			! si mi numero es negativo calculo el complemento a 2
			jmpl %r15 + 4, %r0		! si es positivo calculo el cuadrado sin problema

es_neg:		orncc %r0, %r1, %r1
			addcc %r1, 1, %r1
			jmpl %r15 + 4, %r0 
		
no_rep:		addcc %r0, -1, %r3
			ba done
done:			jmpl %r15 + 4, %r0	
res: 0		
			
			.end




