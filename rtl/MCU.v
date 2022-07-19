/*#########################################################################
//# Main Control Unit 
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

module MCU(

//// inputs ////
MCU_Opcode_InBUS,

//// outputs ////

MCU_Not_Branch_Jump_Op,
MCU_DataMem_Read,
MCU_DataMem_Write,
MCU_RegFile_Mux_OutBUS,
MCU_RegFile_Write,
MCU_AluOp_OutBUS,
MCU_Bru_En,
MCU_Alu_Select_Immediate_Mux,
MCU_Lsu_En

);

//============================================================
//  PORT DECLARATIONS
//============================================================

input [6:0] MCU_Opcode_InBUS;
output reg MCU_Not_Branch_Jump_Op;
output reg MCU_DataMem_Read;
output reg MCU_DataMem_Write;
output reg[1:0] MCU_RegFile_Mux_OutBUS;
output reg MCU_RegFile_Write;
output reg[1:0] MCU_AluOp_OutBUS;
output reg MCU_Bru_En;
output reg MCU_Alu_Select_Immediate_Mux;
output reg MCU_Lsu_En;

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

localparam LUI_AUIPC = 8'b0?10111; 
localparam JAL_JALR  = 8'b110?111;
localparam TYPE_B    = 8'b1100011;
localparam LS 			= 8'b0?00011;
localparam RI        = 8'b0?10011;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

wire Lui_Store_TypeR_Op ;

//============================================================
// COMBINATIONAL LOGIC
//============================================================

always@(MCU_Opcode_InBUS,Lui_Store_TypeR_Op)
begin
	
	casex(MCU_Opcode_InBUS)
	
		LUI_AUIPC:
		begin
		 
			MCU_Not_Branch_Jump_Op = 1'b0;
			MCU_DataMem_Read 	  = 1'b0;
			MCU_DataMem_Write = 1'b0;
			MCU_RegFile_Mux_OutBUS = {~Lui_Store_TypeR_Op,1'b0}; 
			MCU_RegFile_Write = 1'b1;
			MCU_AluOp_OutBUS = 2'b11;
			MCU_Bru_En = 1'b0;
			MCU_Alu_Select_Immediate_Mux = 1'b1;
			MCU_Lsu_En = 1'b0;	
		end
		
		JAL_JALR:
		begin
		 
			MCU_Not_Branch_Jump_Op = 1'b1;
			MCU_DataMem_Read 	  = 1'b0;
			MCU_DataMem_Write = 1'b0;
			MCU_RegFile_Mux_OutBUS = 2'b11;
			MCU_RegFile_Write = 1'b1;
			MCU_AluOp_OutBUS = 2'b10;
			MCU_Bru_En = 1'b0;
			MCU_Alu_Select_Immediate_Mux = 1'b1;
			MCU_Lsu_En = 1'b0;	
		end
		
		TYPE_B:
		begin
		 
			MCU_Not_Branch_Jump_Op = 1'b0;
			MCU_DataMem_Read 	  = 1'b0;
			MCU_DataMem_Write = 1'b0;
			MCU_RegFile_Mux_OutBUS = 2'b00;
			MCU_RegFile_Write = 1'b0;
			MCU_AluOp_OutBUS = 2'b00;
			MCU_Bru_En = 1'b1;
			MCU_Alu_Select_Immediate_Mux = 1'b0;
			MCU_Lsu_En = 1'b0;	
		end
		
		LS:
		begin
		
			MCU_Not_Branch_Jump_Op = 1'b0;
			MCU_DataMem_Read 	 = ~Lui_Store_TypeR_Op;
			MCU_DataMem_Write = Lui_Store_TypeR_Op;
			MCU_RegFile_Mux_OutBUS = 2'b01;
			MCU_RegFile_Write = ~Lui_Store_TypeR_Op;
			MCU_AluOp_OutBUS = 2'b01;
			MCU_Bru_En = 1'b0;
			MCU_Alu_Select_Immediate_Mux = 1'b1;
			MCU_Lsu_En = 1'b1;	
		end
		
		
		RI:
		begin
		
			MCU_Not_Branch_Jump_Op = 1'b0;
			MCU_DataMem_Read 	  = 1'b0;
			MCU_DataMem_Write = 1'b0;
			MCU_RegFile_Mux_OutBUS = 2'b00;
			MCU_RegFile_Write = 1'b1;
			MCU_AluOp_OutBUS = 2'b00;
			MCU_Bru_En = 1'b0;
			MCU_Alu_Select_Immediate_Mux = ~Lui_Store_TypeR_Op;
			MCU_Lsu_En = 1'b0;	
		end
		

		default:
			begin
				MCU_Not_Branch_Jump_Op = 1'b0;
				MCU_DataMem_Read 	  = 1'b0;
				MCU_DataMem_Write = 1'b0;
				MCU_RegFile_Mux_OutBUS = 2'b00;
				MCU_RegFile_Write = 1'b0;
				MCU_AluOp_OutBUS = 2'b00;
				MCU_Bru_En = 1'b0;
				MCU_Alu_Select_Immediate_Mux = 1'b0;
				MCU_Lsu_En = 1'b0;	
			end
		
	endcase
	
end


assign Lui_Store_TypeR_Op   = MCU_Opcode_InBUS[5];



endmodule


