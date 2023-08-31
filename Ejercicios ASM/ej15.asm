		.begin
		.org 2048
		ld [num], %r10

prog1:		ld [a], %r1
		andcc %r1, %r10, %r2	! valor absoluto de %r10 en punto flotante
		jmpl %r15 + 4, %r0

a:		0x7fffffff			! máscara para el signo, busco que el primer bit sea 0
num:		0xf1ce8000			! número en punto flotante

		.end
