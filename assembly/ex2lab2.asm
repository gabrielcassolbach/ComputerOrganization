############################
    	li a0, 0x10010100
    	li a2, 1
    	li a3, 41
    	
###### init memory #########
rotina:	sw a2, (a0)
	addi a0, a0, 4
	addi a2, a2, 1
	bne a2, a3, rotina	
	
############################
	li a0, 0x10010100
    	li a1, 0x10011100
	
	li t0, 0
	li t1, 40	
	
###### transfer data #######
loop:	lw s2, (a0)
	sw s2, (a1)
	addi a0, a0, 4
	addi a1, a1, 4	
	addi t0, t0, 1	
	bne t0, t1, loop
    	nop
############################