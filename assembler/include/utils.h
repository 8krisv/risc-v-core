//#########################################################################
//#
//# Copyright (C) 2021 Jose Maria Jaramillo Hoyos
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, either version 3 of the License, or
//# (at your option) any later version.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <https://www.gnu.org/licenses/>.
//#
//########################################################################*/


#ifndef UTILS
#define UTILS


/*soported operations*/

#define NUM_OPS 38

typedef struct op_data_struct{
 
    char index;

} op_data_struct;


/*sorted aray of register names*/
char* REGISTER_NAMES[32]={
"x0","x1","x10","x11",
"x12","x13","x14","x15",
"x16","x17","x18","x19",
"x2","x20","x21","x22",
"x23","x24","x25","x26",
"x27","x28","x29","x3",
"x30","x31","x4","x5",
"x6","x7","x8","x9"
};


/*sorted arrat of operation lexemes*/
char* OP_LEXEMES[NUM_OPS]={
"$stop","add","addi","and",
"andi","auipc","beq","bge",
"bgeu","blt","bltu","bne",
"jal","jalr","lb","lbu",
"lh","lhu","lui","lw",
"or","ori","sb","sh",
"sll","slli","slt","slti",
"sltiu","sltu","sra","srai",
"srl","srli","sub","sw",
"xor","xori"};


const char OP_OPCODES[NUM_OPS]={
0x0f,0x33,0x13,0x33,
0x13,0x17,0x63,0x63,
0x63,0x63,0x63,0x63,
0x6f,0x67,0x03,0x03,
0x03,0x03,0x37,0x03,
0x33,0x13,0x23,0x23,
0x33,0x13,0x33,0x13,
0x13,0x33,0x33,0x13,
0x33,0x13,0x33,0x23,
0x33,0x13};


const char OP_FUNCT3[]={
0xff,0x00,0x00,0x07,
0x07,0xff,0x00,0x05,
0x07,0x04,0x06,0x01,
0xff,0x00,0x00,0x04,
0x01,0x05,0xff,0x02,
0x06,0x06,0x00,0x01,
0x01,0x01,0x02,0x02,
0x03,0x03,0x05,0x05,
0x05,0x05,0x00,0x02,
0x04,0x04};

#endif