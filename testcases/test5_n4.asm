#########################################################
#### Data memory (.data), 344 clock cycles
#########################################################

addi x3 x0 0x00000320 # set value of global pointer
addi x2 x3 -4 # set value of stack pointer

## size of matrixes
addi x5 x0 0x00000004
sw x5 0(x3)

## operands first matrix [nxn]
addi x5 x0 0x000051F6 # opx_11 
addi x6 x0 0x00000fff
srli x6 x6 20
and x5 x5 x6
lui x7 0x000051F6
add x5 x5 x7
sw x5 4(x3)
addi x5 x0 0x000114EB # opx_12
and x5 x5 x6
lui x7 0x000114EB
add x5 x5 x7
sw x5 8(x3)
addi x5 x0 0x000088D0 # opx_13
and x5 x5 x6
lui x7 0x000088D0
add x5 x5 x7
sw x5 12(x3)
addi x5 x0 0x0000E312 # opx_14
and x5 x5 x6
lui x7 0x0000E312
add x5 x5 x7
sw x5 16(x3)
addi x5 x0 0x000114EB # opx_21
and x5 x5 x6
lui x7 0x000114EB
add x5 x5 x7
sw x5 20(x3)
addi x5 x0 0x000051F6 # opx_22
and x5 x5 x6
lui x7 0x000051F6
add x5 x5 x7
sw x5 24(x3)
addi x5 x0 0x000114EB # opx_23
and x5 x5 x6
lui x7 0x000114EB
add x5 x5 x7
sw x5 28(x3)
addi x5 x0 0x000088D0 # opx_24
and x5 x5 x6
lui x7 0x000088D0
add x5 x5 x7
sw x5 32(x3)
addi x5 x0 0x000088D0 # opx_31
and x5 x5 x6
lui x7 0x000088D0
add x5 x5 x7
sw x5 36(x3)
addi x5 x0 0x000114EB # opx_32
and x5 x5 x6
lui x7 0x000114EB
add x5 x5 x7
sw x5 40(x3)
addi x5 x0 0x000051F6 # opx_33
and x5 x5 x6
lui x7 0x000051F6
add x5 x5 x7
sw x5 44(x3)
addi x5 x0 0x000114EB # opx_34
and x5 x5 x6
lui x7 0x000114EB
add x5 x5 x7
sw x5 48(x3)
addi x5 x0 0x0000E312 # opx_41
and x5 x5 x6
lui x7 0x0000E312
add x5 x5 x7
sw x5 52(x3)
addi x5 x0 0x000088D0 # opx_42
and x5 x5 x6
lui x7 0x000088D0
add x5 x5 x7
sw x5 56(x3)
addi x5 x0 0x000114EB # opx_43
and x5 x5 x6
lui x7 0x000114EB
add x5 x5 x7
sw x5 60(x3)
addi x5 x0 0x000051F6 # opx_44
and x5 x5 x6
lui x7 0x000051F6
add x5 x5 x7
sw x5 64(x3)

## operands second matrix [nx1]
addi x5 x0 0x0000000A # opy_11
sw x5 68(x3)
addi x5 x0 0x0000001E # opy_12
sw x5 72(x3)
addi x5 x0 0x00000046 # opy_13
sw x5 76(x3)
addi x5 x0 0x0000005A # opy_14
sw x5 80(x3)

## the result must be store in these memory addresses
addi x5 x0 0x00000190  # result = 10019930dec
sw x5 84(x3)
addi x5 x0 0x00000194  # result = 9452900dec
sw x5 88(x3)
addi x5 x0 0x00000198  # result = 10325900dec
sw x5 92(x3)
addi x5 x0 0x0000019C  # result = 8482770dec
sw x5 96(x3)
addi x5 x0 0
addi x6 x0 0
addi x7 x0 0

#########################################################
#### Instruction memory (.text)
#########################################################

end:
$stop
