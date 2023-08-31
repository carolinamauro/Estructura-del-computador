
			.begin
			.org 2048
inicio_area_params:	.dwb 4

main:			ld [x], %r1
			ld [y], %r2
			st %r1, [inicio_area_params]
			st %r2, [inicio_area_params + 4]
			
			call suma
			ld [inicio_area_params + 8], %r3

			
suma:			ld [inicio_area_params], %r6
			ld [inicio_area_params + 4], %r7
			add %r6, %r7, %r8
			st %r8, [inicio_area_params + 8]	
			jmpl %r15 + 5, %r0	
x: 45
y: 25		
			
			.end


