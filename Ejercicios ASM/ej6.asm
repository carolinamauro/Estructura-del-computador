		.begin
		.org 2048
prog1:		ld [X], %r1
		ld [Y], %r2
		addcc %r14, -4, %r14
		st %r15, %r14			! guardo la posicion de donde vine para luego volver
		addcc %r14, -4, %r14
		st %r1, %r14
		addcc %r14, -4, %r14
		st %r2, %r14
		call sbr_add
		st %r14, [Z]			! cargo el resultado
		addcc %r14, 4, %r14		! libero 
		jmpl %r14 + 4, %r0		! el programa que me invoco debe ser el responsable de liberar el stack

sbr_add:	ld %r14, %r3			! cargo Y
		addcc %r14, 4, %r14		! libreo 
		ld %r14, %r4			! cargo X
		addcc %r3, %r4, %r10	! efectuo la suma
		st %r10, %r14			! guardo en stack el contenido de %r10 (suma)
		jmpl %r15 + 4, %r0
X:		10
Y:		9
Z:		0
		.end

