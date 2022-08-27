#########################################################################
#
# Copyright (C) 2021 Jose Maria Jaramillo Hoyos
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#########################################################################

# Compiler test for RV32I Base Instruction Set


#-- type r --#

RTYPE:
add x1 x2 x3
sub x1 x2 x3
sll x1 x2 x3
slt x1 x2 x3
sltu x1 x2 x3
xor x1 x2 x3
srl x1 x2 x3
sra x1 x2 x3
or x1 x2 x3
and x1 x2 x3

#-- type i --#

ITYPE:
addi x1 x1 7
slti x1 x1 1
sltiu x1 x1 2
xori x1 x1 3
ori x1 x1 4
andi x1 x1 5
slli x1 x1 6
srli x1 x1 7
srai x1 x1 8

#-- load/store --#

LS:
sw x1 0(x2)
sh x1 8(x2)
sb x1 16(x2)
lb x1 24(x2)
lh x1 32(x2)
lw x1 40(x2)
lbu x1 48(x2)
lhu x1 54(x2)

#-- branch operations --#

BRANCH:
beq x1 x2 RTYPE
bne x1 x2 ITYPE
blt x1 x2 LS
bge x1 x2 RTYPE
bltu x1 x2 ITYPE
bgeu x1 x2 LS

#-- jal/jalr --#

jal x1 RTYPE
jalr x1 4(x2)

#-- lui/auipc --#

lui x0 0x00007000
auipc x0 0x00007000


#-- Multiplication instruction --#
mul x1 x2 x3


#-- stop --#
$stop


