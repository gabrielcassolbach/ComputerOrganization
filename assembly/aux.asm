#	Exercício 1: armazena uma sequência crescente de 1000 valores na memória a partir do 
# endereço 0x1001 1234.

		li   s1, 0x10011234 # registrador da primeira posição de memória.
		addi s2, zero, 1 #valor inicial da sequência crescente.
		addi s11, zero, 1000 # valor final.
		addi t0, zero, 1 #incremento.
	
		sw  s2, (s1) # valor 1 é colocado na posição de memória s1.
		bne s2, s11, desvio
desvio:		add s2, s2, t0 # valor++;
		addi s1, s1, 4 
		sw  s2,(s1)  # armazena o valor de s2 no endereço s1.		
		bne s2, s11, desvio # enquanto o valor não chegar a 1000.. repita.
		nop

