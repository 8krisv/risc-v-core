#########################################################
#### Data memory (.data),  76 clock cycles
#########################################################

addi x3 x0 0x00000320 # set value of global pointer
addi x2 x3 -4 # set value of stack pointer

## size of matrixes
addi x5 x0 0x00000002
sw x5 0(x3)

## operands first matrix [nxn]
addi x5 x0 0x00000064 # opx_11
sw x5 4(x3)
addi x5 x0 0x000001C2 # opx_12
sw x5 8(x3)
addi x5 x0 0x00000055 # opx_21
sw x5 12(x3)
addi x5 x0 0x000000E6 # opx_22
sw x5 16(x3)

## operands second matrix [nx1]
addi x5 x0 0x0000000A # opy_11
sw x5 20(x3)
addi x5 x0 0x00000014 # opy_12
sw x5 24(x3)

## the result must be store in these memory addresses
addi x5 x0 0x00000190 # result = 10000dec
sw x5 28(x3)
addi x5 x0 0x00000194 # result = 5450dec
sw x5 32(x3)
addi x5 x0 0

#########################################################
#### Instruction memory (.text)
#########################################################

end:
$stop
