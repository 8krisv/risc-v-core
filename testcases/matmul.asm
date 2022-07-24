## DESIGN-PROBLEM M02 SOLUTION: multiply two matrixes nxn * nx1 = nx1

#########################################################
#### Data memory
#########################################################

addi x3 x0 0x00000320 # set value of global pointer
addi x2 x3 -4 # set value of stack pointer

## size of matrixes
addi x5 x0 0x00000002
sw x5 0(x3)

## operands first matrix [nxn]
addi x5 x0 0x00000004 # opx_11
sw x5 4(x3)
addi x5 x0 0x00000008 # opx_12
sw x5 8(x3)
addi x5 x0 0x00000002 # opx_21
sw x5 12(x3)
addi x5 x0 0x00000006 # opx_22  
sw x5 16(x3)
  
## operands second matrix [nx1]
addi x5 x0 0x00000002 # opy_11
sw x5 20(x3)
addi x5 x0 0x00000003 # opy_21
sw x5 24(x3)

## the result must be store in these memory addresses
addi x5 x0 0x00000190 # result = 32dec
sw x5 28(x3)
addi x5 x0 0x00000194  # result = 22dec
sw x5 32(x3)
addi x5 x0 0

#########################################################
#### Instruction memory
#########################################################


#### Guide to the correct use of processor registers:
## x0 = hardwired to zero
## x1 = return address by caller
## x2 = stack pointer by caller and callee
## x3 = global data pointer
## x4 = thread pointer
## x5,x6,x7,x28,x29,x30,x31 = used by caller
## x8,x9,x18-x27 = used by calle
## x10 - x17 = return/arguments spaces by caller and callee


main: # caller, load information and coordinate operations
	
    add x4 x2 x0 # copy stack pointer on thread pointer
  
    lw x5 0(x3) # load n size of matrixes on x5 register

    addi x6 x3 4 # load the global pointer to memory directions of nxn matrix
    
begin:    
    addi x7 x0 2 # set value for comparison
    beq  x5 x7 set2
    addi x7 x0 3 # set value for comparison
    beq  x5 x7 set3
    addi x7 x0 4 # set value for comparison
    beq  x5 x7 set4
    
set2:
    addi x7 x3 20 # initial direction of vector nx1
    addi x28 x7 8 # final direction of vector nx1 
    addi x29 x7 0 # iterator pointer for vector nx1
    beq  x0 x0 loop

set3:
    addi x7 x3 40 # initial direction of vector nx1
    addi x28 x7 12 # final direction of vector nx1 
    addi x29 x7 0 # iterator pointer for vector nx1
    beq  x0 x0 loop
    
set4:
    addi x7 x3 68 # initial direction of vector nx1
    addi x28 x7 16 # final direction of vector nx1        
    addi x29 x7 0 # iterator pointer for vector nx1   
    beq  x0 x0 loop	

loop: ## is basically a double FOR to operate all elements in both matrixes (nxn and nx1)
    lw x11 0(x6) # firts param for multiply function
    addi x6 x6 4 # update the matrix nxn pointer
    
    lw x12 0(x29) # first input of matriz nx1
    addi x29 x29 4 # updates the matrix nx1 pointer
    
    jal x1 mult # call mult function
 
    sw x10 0(x2) # save operation result
      
    addi x2 x2 -4 # update stack pointer  
    
    beq x6 x7 end_loop # if all elements of nxn matrix were visited
    bne x29 x28 loop # if not all elements of nx1 matrix were visited in this iteration
    beq x0 x0 begin # if all elements of nx1 matrix were visited, reset its pointer for next row

end_loop: # final part of sum operations to return nx1 vector solution
    lw x28 0(x28) # load address to return the result vector
    add x29 x0 x0 # clear register to save parcial sums
    
loop2: # it is similar to a while loop to operate (sums) all multiplications saved on memory
    beq x4 x2 end # if all partial multiplications were operated (¿stack pointer == thread pointer?), finish
    addi x6 x0 0 # counter for load operands from data memory
    
    lw x11 0(x4) # first operand of sum
    addi x4 x4 -4 # update thread pointer 
    addi x6 x6 1 # update counter
    
    lw x12 0(x4) # second operand of sum
    addi x4 x4 -4
    addi x6 x6 1 # update counter

    add x29 x11 x12 # first sum of operands
    
    beq x6 x5 mid2  # if only need 2 operands 
    
    lw x11 0(x4) # first operand of sum
    addi x4 x4 -4 # update thread pointer 
    addi x6 x6 1 # update counter
    
    add x29 x29 x11 # second sum of operands
    
    beq x6 x5 mid2  # if only need 3 operands 
    
    lw x11 0(x4) # first operand of sum
    addi x4 x4 -4 # update thread pointer 
    addi x6 x6 1 # update counter
    
    add x29 x29 x11 # third sum of operands
    
    beq x6 x5 mid2  # if only need 4 operands 

mid2:
    sw x29 0(x28) # save result of partial sums in result vector 
    addi x28 x28 4 # update address to save values of result vector
    add x29 x0 x0 # clear partial sums for new entry in result vector
    beq x0 x0 loop2

    
mult: # calle function return on x10 the result of x11 (multiplier) * x12 (multiplicand) (multiply algorithm) 
    addi x9 x0 1 # get one to compare LSB of multiplier
    addi x10 x0 0 # clear x10 to return result of multiplication
mult1: 
    and x8 x11 x9 # get AND operation for LSB of multiplier on x8
    beq x8 x0 mult2 # if LSB of multiplier is equal to zero
    add x10 x10 x12 # else increments accumluator (x10) with multiplicand
mult2:
    sll x12 x12 x9 # shift left 1 position (x5 indicator) multiplicand
    srl x11 x11 x9 # shift rigth 1 position multiplier
    beq x11 x0 jump # if multiplier is zero then finish
    beq x0 x0 mult1 # else repeat on mult1
jump:
    jalr x8 0(x1)  # return to the last caller instruction (saved on x1) and saves its address just to jump

end:
$stop

