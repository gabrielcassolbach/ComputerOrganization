#  Faça um programa que imprime na tela todos os caracteres correspondentes aos códigos
# ASCII entre 32 e 126(inclusive).

	li a0, 32
	li t1, 127
	
	li a7, 11
	
loop:   ecall
	addi a0, a0, 1
	bne a0, t1, loop
	
	