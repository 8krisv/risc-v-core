addi x1 x0 4 # 4
addi x2 x1 4 # 8
addi x3 x3 511
addi x4 x4 -4

sb x3 0(x0)
sh x4 0(x1)
sw x4 0(x2)

lb x5 0(x0)
lh x6 0(x1)
lw x7 0(x2)
lbu x8 0(x0)
lhu x9 0(x1)


EXIT:
jal x0 EXIT
