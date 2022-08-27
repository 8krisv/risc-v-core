#########################################################
#### Data memory (.data), 188 clock cycles
#########################################################

addi x3 x0 0x00000320 # set value of global pointer
addi x2 x3 -4 # set value of stack pointer

## size of matrixes
addi x5 x0 0x00000004
sw x5 0(x3)

## operands first matrix [nxn]
addi x5 x0 0x00000002 # opx_11
sw x5 4(x3)
addi x5 x0 0x00000002 # opx_12
sw x5 8(x3)
addi x5 x0 0x00000002 # opx_13
sw x5 12(x3)
addi x5 x0 0x00000002 # opx_14
sw x5 16(x3)
addi x5 x0 0x00000004 # opx_21
sw x5 20(x3)
addi x5 x0 0x00000004 # opx_22
sw x5 24(x3)
addi x5 x0 0x00000004 # opx_23
sw x5 28(x3)
addi x5 x0 0x00000004 # opx_24
sw x5 32(x3)
addi x5 x0 0x00000006 # opx_31
sw x5 36(x3)
addi x5 x0 0x00000006 # opx_32
sw x5 40(x3)
addi x5 x0 0x00000006 # opx_33
sw x5 44(x3)
addi x5 x0 0x00000006 # opx_34
sw x5 48(x3)
addi x5 x0 0x00000008 # opx_41
sw x5 52(x3)
addi x5 x0 0x00000008 # opx_42
sw x5 56(x3)
addi x5 x0 0x00000008 # opx_43
sw x5 60(x3)
addi x5 x0 0x00000008 # opx_44
sw x5 64(x3)
    
## operands second matrix [nx1]
addi x5 x0 0x00000004 # opy_11
sw x5 68(x3)
addi x5 x0 0x00000004 # opy_12
sw x5 72(x3)
addi x5 x0 0x00000004 # opy_13
sw x5 76(x3)
addi x5 x0 0x00000004 # opy_14
sw x5 80(x3)

## the result must be store in these memory addresses
addi x5 x0 0x00000190  # result = 32dec
sw x5 84(x3)
addi x5 x0 0x00000194  # result = 64dec
sw x5 88(x3)
addi x5 x0 0x00000198  # result = 96dec
sw x5 92(x3)
addi x5 x0 0x0000019C  # result = 128dec
sw x5 96(x3)
addi x5 x0 0

#########################################################
#### Instruction memory (.text)
#########################################################

end:
$stop
