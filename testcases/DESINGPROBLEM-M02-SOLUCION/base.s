## DESIGN PROBLEM M02: Multiply two matrixes [nxn] * [nx1] = [nx1]

############################################
#### Data memory
############################################
.data 

## size of matrixes
n_size: .word 0x00000002

## operands first matrix [nxn]
opx_11: .word 0x00000004
opx_12: .word 0x00000008
opx_21: .word 0x00000002
opx_22: .word 0x00000006    

## operands second matrix [nx1]
opy_11: .word 0x00000002 
opy_12: .word 0x00000003

## the result must be store in these memory addresses
an_11: .word 0x10000100 # result = 32dec
an_12: .word 0x10000104 # result = 22dec


############################################
#### Instruction memory
############################################
.text

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


end:nop