#   Faça um programa que lê um número inteiro pelo teclado e imprime o triplo dele no 
# painel inferior de execução do RARS. Use a syscall de impressão de inteiros.

	li a7, 5
	ecall
	mv t0, a0
	
	li t0, 1
	li t1, 3
	
	mv a1, a0
	
loop:	add a0, a0, a1
	addi t0, t0, 1
	bne t0, t1, loop
		
	li a7, 1
	ecall
	