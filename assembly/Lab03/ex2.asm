

	li s0, -7
	li s1, +15
	li s2, -123
	li s3, +123
	li s4, -500
	li s5, -23
	
	##################
	addi a0, a0, s0
	addi a0, a0, s1
	addi a0, a0, s2
	addi a0, a0, s3 
	addi a0, a0, s4
	addi a0, a0, s5
	
	li a7, 1
	ecall 
	