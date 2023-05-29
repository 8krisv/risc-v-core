#########################################################################
# Collatz sequence
#########################################################################
#
# Copyright (C) 2023 José Maria Jaramillo Hoyos
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

#### Guide to the correct use of processor registers:
## x0 = hardwired to zero
## x1 = return address by caller
## x2 = stack pointer by caller and callee
## x3 = global data pointer
## x4 = thread pointer
## x5,x6,x7,x28,x29,x30,x31 = used by caller
## x8,x9,x18-x27 = used by callee
## x10 - x17 = return/arguments spaces by caller and callee


main: ## caller main function

	addi x3 x0 0x000003FC # set value of global pointer
	addi x2 x3 -4 # set value of stack pointer
	
	addi x5 x0 1016 # <- initial value for the collatz sequence
	
 	sw x5 0(x3) # store the initial number for the collatz sequence
	beq  x0 x0 collatz 


collatz: ## callee function (Collatz sequence) 

	addi x7 x0 1
	addi x29 x0 2
	blt x5 x29 end
	
begin:
	xori x6 x5 0x00000001
	andi x6 x6 0x00000001
	beq x6 x0 odd 

even:	
	srli x5 x5 1
	beq  x0 x0 compare 
	
odd:
	add x11 x0 x5
	addi x12 x0 3
	jal x1 mult # call mult function
	addi x5 x10 1
	
compare:
	sw x5 0(x2) # save operation result in the stack pointer
	addi x2 x2 -4 # update stack pointer 
	beq x5 x7 end # if x5 is equal to 1
	beq  x0 x0 begin
	
mult: # callee function return on x10 the result of x11 (multiplier) * x12 (multiplicand) (multiply algorithm) 
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
$stop # expand to addi x31 x0 -1 to stop modelsim simulation 
