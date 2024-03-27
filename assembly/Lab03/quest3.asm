#   Faça um programa que lê 10 números inteiros do teclado e imprime na tela a soma de todos eles.
	
	
		li a7, 5
		li s0, 0
		
		li t0, 0
		li t1, 10
		
loop:		ecall
		add s0, s0, a0		
		addi t0, t0, 1
		bne t0, t1, loop
		
		li a7, 1
		mv a0, s0 
		ecall
