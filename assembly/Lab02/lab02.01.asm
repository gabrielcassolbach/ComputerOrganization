#	 Usando apenas instruções nativas do assembly RISC-V, faça um programa que identifica  
# uma de seis diferentes possibilidades de acordo com os valores atuais de s1 e s2. O caso 
# identificado é indicado ao final por por s3, de acordo a tabela no pdf do laboratório.

		addi s1, zero, 1 #definir valores para teste.
		addi s2, zero, 33 #definir valores para teste.
		addi s3, zero, 0 #saída (valor default).
		addi t0, zero, 1 #counter.
		addi t1, zero, 3 #counter2.
		addi a1, zero, 32 #valor para comparação.
		
		# primeiro passo: determinar se s1 >= 0 ou não.
		add s3, s3, t0 # valor inicial de s3 = 1.
		bge s1, zero, s1maior  
		add s3, s3, t1 # s3 = 4.	
		bgt s2, a1, s2maior		
		beq s2, a1, equal
s1maior:	bgt s2, a1, s2maior
		beq s2, a1, equal
		add s3, s3, t0
equal:		add s3, s3, t0
s2maior:	# não some.