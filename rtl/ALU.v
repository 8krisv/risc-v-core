/*#########################################################################
//# Arithmetic Logic Unit 
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

module ALU (

/// inputs ///
Operand_1,
Operand_2,
Opcode,

// outputs //
Out

);


//==============================================
// MICRO-OPCODES DEFINITION
// ==============================================
// 4'b0000: ADD 
// 4'b0001: SUB
// 4'b0010: SLL 
// 4'b0011: SLT
// 4'b0100: SLTU  
// 4'b0101: XOR 
// 4'b0110: SRL 
// 4'b0111: SRA 
// 4'b1000: OR
// 4'b1001: AND 
// 4'b1010: BUFFB
// 4'b1011: BUFFA
// ==============================================

//============================================================
//  PARAMETER DECLARATIONS
//============================================================

// Datawidth
parameter DATAWIDTH=32;

// Alu Opcodes
parameter  ADD   = 4'b0000,
			  SUB   = 4'b0001,
			  SLL   = 4'b0010,
			  SLT   = 4'b0011,
			  SLTU  = 4'b0100, /*set less than*/
			  XOR   = 4'b0101,
			  SRL   = 4'b0110,
			  SRA   = 4'b0111,
			  OR    = 4'b1000,
			  AND   = 4'b1001,
			  BUFFB = 4'b1010,
			  BUFFA = 4'b1011;
			  
/******** Student code here ********/

/* You must complete with the Alu Opcode
for the new multiplication instruction*/





			  
/******** End of student code ********/

//============================================================
//  PORT DECLARATIONS
//============================================================

input [DATAWIDTH-1:0] Operand_1;
input [DATAWIDTH-1:0] Operand_2;
input [3:0] Opcode;
output[DATAWIDTH-1:0] Out;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

reg [DATAWIDTH-1:0] tmp;
reg [63:0] tmp_mult_op;

//============================================================
// COMBINATIONAL LOGIC
//============================================================

// combinational logic for the new multiplication instructions
always @(Operand_1,Operand_2,Opcode) 
begin

	/******** Student code here ********/
	
	/*Combinational logic for the multiplication
	instruction, you must save the multiplication
   result in the 64 bit register tmp_mult_op */
	
	/*
	HINT:
	
		case(...)
			
			value0: tmp_mult_op = ...;
			...
			default: tmp_mult_op = ...;
		
		endcase
		
	*/
	
	
  /******** End of student code ********/
  
end


always @(tmp_mult_op,Operand_1,Operand_2,Opcode)
begin

	case(Opcode)
		ADD: tmp = Operand_1+Operand_2;
		SUB: tmp = Operand_1-Operand_2;
		SLL: tmp = Operand_1 << Operand_2[4:0];
		SLT: tmp = ($signed(Operand_1) < $signed(Operand_2)) ? 32'd1 : 32'd0;
	   SLTU: tmp = (Operand_1 < Operand_2) ? 32'd1 : 32'd0;
		XOR: tmp = Operand_1^Operand_2;
		SRL: tmp = Operand_1 >> Operand_2[4:0];
		SRA: tmp = $signed(Operand_1) >> Operand_2[4:0];
		OR:  tmp = Operand_1|Operand_2;
		AND: tmp = Operand_1&Operand_2;	
		BUFFB: tmp= Operand_2;
		BUFFA: tmp= Operand_1;
		
		/******** Student code here ********/
		
		/* you must set the value of the tmp 
		register according to the value of the 
		tmp_mult_op register and the Alu Opcode
		for the multiplication instruction*/
		
		/*
		HINT:
	
			value0: tmp = tmp_mult_op[..];
			...
		
		*/
		
	   /******** End of student code ********/
		
		default tmp= 32'd0;
		
	endcase

end



assign Out=tmp;

endmodule


