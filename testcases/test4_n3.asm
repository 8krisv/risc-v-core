#########################################################
#### Data memory (.data), 125 clock cycles
#########################################################

addi x3 x0 0x00000320 # set value of global pointer
addi x2 x3 -4 # set value of stack pointer

## size of matrixes
addi x5 x0 0x00000003
sw x5 0(x3)

## operands first matrix [nxn]
addi x5 x0 0x000003E8 # opx_11
sw x5 4(x3)
addi x5 x0 0x0000017C # opx_12
sw x5 8(x3)
addi x5 x0 0x000003DE # opx_13
sw x5 12(x3)
addi x5 x0 0x000000DC # opx_21
sw x5 16(x3)
addi x5 x0 0x000004E2 # opx_22
sw x5 20(x3)
addi x5 x0 0x00000078 # opx_23
sw x5 24(x3)
addi x5 x0 0x00000230 # opx_31
sw x5 28(x3)
addi x5 x0 0x0000037A # opx_32
sw x5 32(x3)
addi x5 x0 0x000000B4 # opx_33
sw x5 36(x3)

## operands second matrix [nx1]
addi x5 x0 0x0000005F # opy_11
sw x5 40(x3)
addi x5 x0 0x00000069 # opy_12
sw x5 44(x3)
addi x5 x0 0x00000023 # opy_13
sw x5 48(x3)

## the result must be store in these memory addresses
addi x5 x0 0x00000190 # result = 169550dec
sw x5 52(x3) 
addi x5 x0 0x00000194 # result = 156350dec
sw x5 56(x3)
addi x5 x0 0x00000198 # result = 152950dec
sw x5 60(x3)
addi x5 x0 0

#########################################################
#### Instruction memory (.text)
#########################################################


end:
$stop
