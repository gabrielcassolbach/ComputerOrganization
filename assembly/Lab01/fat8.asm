#Código em assembly que computa o fatorial de 8.
	# Variáveis: ----------------------------------------------------#
		addi a1, zero, 8 # control loop i.
		addi a0, zero, 1 # end of control loop i.
		addi t0, zero, -1 # decrement of control loop i.
		addi s0, zero, 0 # variável auxiliar.
		addi s1, zero, 8 # guardará o fatorial de 8.
		
	# Lógica: -------------------------------------------------------#
		bne a1, a0, desvio # início do Loop mais externo.
desvio:		add a1, a1, t0 # decremento da variável a1. 
        #-------------  Início do segundo loop: -------------------------#
		add a3, zero, a1 # a3 = 7. # s1 = 8.
		bne a3, zero, desvio2 # durante 7 vezes some 8.
desvio2: 	add s0, s0, s1 
		add a3, a3, t0
		bne a3, zero, desvio2 # durante 7 vezes some 8.
		add s1, zero, s0 
		addi s0, zero, 0
	#----------------------------------------------------------------#		
		bne a1, a0, desvio # término do Loop mais externo.
	# -------------------------------------------------------------- #	  