# dado um conjunto de constantes em determinados registradores, some-as 
# e guarde esses resultados no registrador a0.

	li s0, -7
	li s1, 15 
	li s2, -123
	li s3, +123
	li s4, -500
	li s5, -23
	
	add a0, s0, a0
	add a0, s1, a0
	add a0, s2, a0
	add a0, s3, a0
	add a0, s4, a0
	add a0, s5, a0
		
	li a7, 1
	ecall
			
	