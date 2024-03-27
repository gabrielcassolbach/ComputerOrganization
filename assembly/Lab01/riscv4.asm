		
		addi a0, zero, 0 # initial i value.
		addi t0, zero, 1 # increment.
		addi t1, zero, 0 # inital j value.
		addi t2, zero, -1
		addi a1, zero, 20 # end i value.
		addi s1, zero, 0 # soma final.
		addi s2, zero, 0 # soma parcial.
		
		
		bne a0, a1, desvio # first loop, a0 is the loop variable.
desvio:		add a0, a0, t0
		## início do segundo loop.
		addi t1, zero, 0 # set j value
		add t1, t1, a0
		addi s2, zero, 0 # reseto a soma parcial.
		bne t1, zero, desvio2
desvio2: 	add s2, s2, a0	
		add t1, t1, t2
		bne t1, zero, desvio2
		add s1, s1, s2
		bne a0, a1, desvio # end of the first loop.