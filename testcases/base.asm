## DESIGN-PROBLEM M02: multiply two matrixes nxn * nx1 = nx1

#########################################################
#### Data memory (.data),  76 clock cycles
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
#### Instruction memory (.text)
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


main: ## caller main function
    # your code here!!

    
mult: ## calle function (multiply algorithm) 
     # your code here!!

end:
$stop

