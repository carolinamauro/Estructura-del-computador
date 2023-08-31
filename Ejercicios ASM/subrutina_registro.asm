! programa que suma dos numeros
		.begin
		.org 2048

prog1:		ld [x], %r1		
		ld [y], %r2
		addcc %r14, -4, %r14
		st %r15, %r14			! guardo en la pila la pos de quien me invoco
		addcc %r14, -4, %r14	! pila crece hacia las direcciones de memoria menores
		st %r1, %r14			! copiar el contenido de %r1 en la posicion de memoria almacenada en %r14
		addcc %r14, -4, %r14
		st %r2, %r14			
		call sbr_add
		ld %r14, %r3			! recupero el resultado (23)
		addcc %r14, 4, %r14
		st %r13, [z]
		jmpl %r14 + 4, %r0

sbr_add:	ld %r14, %r8			! copiar el contenido de la dirección %r14 de memoria en el registro %r8 (seria y) 
		addcc %r14, 4, %r14		! libero memoria
		ld %r14, %r9			! copio x en %r9
		addcc %r8, %r9, %r10	! sumo y guardo en %r10
		st %r10, %r14			! subo 15+9=23 (contenido de %r10) a posicion de memoria de la pila
		jmpl %r15 + 4, %r0
x:		15
y:		9
z:		0
		.end


