addi x3 x3 511
addi x4 x4 -8

sb x3 0(x0)
sh x4 4(x0)
sw x4 8(x0)

lb x5 0(x0)
lh x6 4(x0)
lw x7 8(x0)
lbu x8 0(x0)
lhu x9 4(x0)

$stop
