/*#########################################################################
//# Immediate generation unit 
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

module IMM_GEN(

input [31:0] IMM_GEN_ins_InBUS,
output [31:0] IMM_GEN_Inmediate_OutBUS

);


//============================================================
// PARAMETER DECLARATIONS
//============================================================

parameter I_TYPE_0 = 7'b00?0011; /*This case does not cover the 
											operations fence,fence.i,ecall,
											ebreak and the csr instructions*/
			 
parameter S_TYPE   = 7'b0100011;
parameter B_TYPE   = 7'b1100011;
parameter U_TYPE   = 7'b0?10111;
parameter J_TYPE   = 7'b1101111;

localparam SLTIU = 3'b011; /*SLTIU operaion*/
			 
//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

wire [6:0] Opcode; 
wire [2:0] Funct3; 
reg  [31:0] Tmp_Imm;

//============================================================
// COMBINATIONAL LOGIC
//============================================================

always@(*)
begin 
	
	casex(Opcode)
	
		I_TYPE_0: if(Funct3 != SLTIU) begin
						Tmp_Imm = {{21{IMM_GEN_ins_InBUS[31]}}, // 21
									 IMM_GEN_ins_InBUS[30:20]};   // 11
						end
					 else begin
						Tmp_Imm= {{20{1'b0}},                // 20
					   IMM_GEN_ins_InBUS[31:20]};            // 12
					 end	 
									
		S_TYPE:	 Tmp_Imm = {{21{IMM_GEN_ins_InBUS[31]}}, // 21
									IMM_GEN_ins_InBUS[30:25], 	  // 6
									IMM_GEN_ins_InBUS[11:7]};    // 5
	
		B_TYPE: Tmp_Imm = {{20{IMM_GEN_ins_InBUS[31]}},   // 20 
								 IMM_GEN_ins_InBUS[7],          // 1
		                   IMM_GEN_ins_InBUS[30:25],      // 6
								 IMM_GEN_ins_InBUS[11:8],       // 4 
		                   1'b0};  //shift left by 1               
		
		U_TYPE: Tmp_Imm = {IMM_GEN_ins_InBUS[31:12],      // 20 
								{12{1'b0}}};                    // 12
								
		J_TYPE: Tmp_Imm = { {12{IMM_GEN_ins_InBUS[31]}},  // 12 
		                    IMM_GEN_ins_InBUS[19:12],     // 8
								  IMM_GEN_ins_InBUS[20],        // 1
								  IMM_GEN_ins_InBUS[30:21],     // 10
								  1'b0};   //shift left by 1  
		
		default: Tmp_Imm= 32'h00000000;
	
	endcase


end 


assign Opcode = IMM_GEN_ins_InBUS[6:0];
assign Funct3 =  IMM_GEN_ins_InBUS[14:12];
assign IMM_GEN_Inmediate_OutBUS= Tmp_Imm; 


endmodule


