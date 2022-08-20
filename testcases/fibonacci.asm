####################################
# fibonacci sequence
####################################

addi x2 x0 0		#fib(n-2)
addi x3 x0 1 		#fib(n-1)
addi x4 x0 2		# i
addi x7 x0 0x00000000	# temp variable
addi x6 x0 10		# value of n
addi x30 x0 0	        # memory adress

sw x2 0(x30)
addi x30 x30 4
sw x3 0(x30)
addi x30 x30 4


jal x0 LOOP

LOOP: 
    beq x4 x6 EXIT
    add x7 x2 x3 # n
    addi x2 x3 0
    addi x3 x7 0
    addi x4 x4 1
    sw x7 0(x30)
    addi x30 x30 4
    jal x0 LOOP
    	
EXIT: 
$stop	# stop modelsim simulation (expand to addi x31 x0 -1)



