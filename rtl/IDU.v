/*#########################################################################
//# Instruction decode unit
//#########################################################################
//#
//# Copyright (C) 2021 Jose Maria Jaramillo Hoyos
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, either version 3 of the License, or
//# (at your option) any later version.
//#
//# This program is distributed in the hope that it wIDU_Opcode_InBUSill be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <https://www.gnu.org/licenses/>.
//#
//########################################################################*/

module IDU(

//// inputs ////
IDU_Opcode_InBUS,
IDU_Mcu_State,

//// outputs ////

IDU_Not_Branch_Jump_Op,
IDU_RegFile_Mux_OutBUS,
IDU_RegFile_Write,
IDU_AluOp_OutBUS,
IDU_Bru_En,
IDU_Alu_Select_Immediate_Mux,
IDU_Lsu_En

);

//============================================================
//  PORT DECLARATIONS
//============================================================

input [6:0] IDU_Opcode_InBUS;
input [2:0] IDU_Mcu_State;
output reg IDU_Not_Branch_Jump_Op;
output reg[1:0] IDU_RegFile_Mux_OutBUS;
output reg IDU_RegFile_Write;
output reg[1:0] IDU_AluOp_OutBUS;
output reg IDU_Bru_En;
output reg IDU_Alu_Select_Immediate_Mux;
output reg IDU_Lsu_En;

//==============================================
// OPCODES DEFINITION
// ==============================================
// 8'b0110111: LUI
// 8'b0010111: AUIPC
// 8'b1101111: JAL
// 8'b1100111: JALR
// 8'b1100011: TYPE-B
// 8'b0000011: LB,LH,LW,LBU,LHU
// 8'b0100011: SB,SH,SW
// 8'b0010011: ADDI,SLTI,SLTIU,XORI,ORI,ANDI,SLLI,SRLI,SRAI
// 8'b0110011: TYPE-R
// ==============================================

//============================================================
//  PARAMETER DECLARATIONS
//============================================================

localparam LUI_AUIPC = 7'b0?10111; 
localparam JAL_JALR  = 7'b110?111;
localparam TYPE_B    = 7'b1100011;
localparam LS 			= 7'b0?00011;
localparam RI        = 7'b0?10011;

localparam [2:0] State_Exec	               = 3'b011;
localparam [2:0] State_Wait_Valid_Ready   	= 3'b10?;


//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

wire Lui_Store_TypeR_Op ;

//============================================================
// COMBINATIONAL LOGIC
//============================================================

always@(IDU_Opcode_InBUS,IDU_Mcu_State,Lui_Store_TypeR_Op)
begin

	casex(IDU_Mcu_State)
	
		State_Exec:
		begin
		
			casex(IDU_Opcode_InBUS)
			
				LUI_AUIPC:
				begin
					IDU_Not_Branch_Jump_Op = 1'b0;
					IDU_RegFile_Mux_OutBUS = {~Lui_Store_TypeR_Op,1'b0}; 
					IDU_RegFile_Write = 1'b1;
					IDU_AluOp_OutBUS = 2'b11;
					IDU_Bru_En = 1'b0;
					IDU_Alu_Select_Immediate_Mux = 1'b1;
					IDU_Lsu_En = 1'b0;	
				end
		
				JAL_JALR:
				begin
		 
					IDU_Not_Branch_Jump_Op = 1'b1;
					IDU_RegFile_Mux_OutBUS = 2'b11;
					IDU_RegFile_Write = 1'b1;
					IDU_AluOp_OutBUS = 2'b10;
					IDU_Bru_En = 1'b0;
					IDU_Alu_Select_Immediate_Mux = 1'b1;
					IDU_Lsu_En = 1'b0;	
				end
		
				TYPE_B:
				begin
		 
					IDU_Not_Branch_Jump_Op = 1'b0;
					IDU_RegFile_Mux_OutBUS = 2'b00;
					IDU_RegFile_Write = 1'b0;
					IDU_AluOp_OutBUS = 2'b00;
					IDU_Bru_En = 1'b1;
					IDU_Alu_Select_Immediate_Mux = 1'b0;
					IDU_Lsu_En = 1'b0;	
				end
		
				LS:	
				begin
					IDU_Not_Branch_Jump_Op = 1'b0;
					IDU_RegFile_Mux_OutBUS = 2'b01;
					IDU_RegFile_Write = ~Lui_Store_TypeR_Op;
					IDU_AluOp_OutBUS = 2'b01;
					IDU_Bru_En = 1'b0;
					IDU_Alu_Select_Immediate_Mux = 1'b1;
					IDU_Lsu_En = 1'b1;	
				end
	
				RI:
				begin
					IDU_Not_Branch_Jump_Op = 1'b0;
					IDU_RegFile_Mux_OutBUS = 2'b00;
					IDU_RegFile_Write = 1'b1;
					IDU_AluOp_OutBUS = 2'b00;
					IDU_Bru_En = 1'b0;
					IDU_Alu_Select_Immediate_Mux = ~Lui_Store_TypeR_Op;
					IDU_Lsu_En = 1'b0;	
				end
		
				default:
				begin
					IDU_Not_Branch_Jump_Op = 1'b0;
					IDU_RegFile_Mux_OutBUS = 2'b00;
					IDU_RegFile_Write = 1'b0;
					IDU_AluOp_OutBUS = 2'b00;
					IDU_Bru_En = 1'b0;
					IDU_Alu_Select_Immediate_Mux = 1'b0;
					IDU_Lsu_En = 1'b0;	
				end
			endcase
		end
		
		
		State_Wait_Valid_Ready:
		begin
			IDU_Not_Branch_Jump_Op = 1'b0;
			IDU_RegFile_Mux_OutBUS = 2'b01;
			IDU_RegFile_Write = 1'b0;
			IDU_AluOp_OutBUS = 2'b01;
			IDU_Bru_En = 1'b0;
			IDU_Alu_Select_Immediate_Mux = 1'b1;
			IDU_Lsu_En = 1'b1;	
		end
		
		default:
		begin
			IDU_Not_Branch_Jump_Op = 1'b0;
			IDU_RegFile_Mux_OutBUS = 2'b00;
			IDU_RegFile_Write = 1'b0;
			IDU_AluOp_OutBUS = 2'b00;
			IDU_Bru_En = 1'b0;
			IDU_Alu_Select_Immediate_Mux = 1'b0;
			IDU_Lsu_En = 1'b0;	
		end
	
	endcase
	
	
end


assign Lui_Store_TypeR_Op   = IDU_Opcode_InBUS[5];



endmodule


