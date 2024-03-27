		addi s0, zero, 1
		addi s5, zero, 1
		addi t1, zero, 2
		addi a1, zero, 79
		
		bne s0, a1 , desvio
	desvio: add s0, t1, s0 
		add s5, s5, s0 
		bne s0, a1, desvio
		