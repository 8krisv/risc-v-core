/*#########################################################################
//# Branch Unit 
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

module BRU(

///// inputs /////
BRU_rs1_data_InBUS,
BRU_rs2_data_InBUS,
BRU_funct3_InBUS,
BRU_bren,

///// outputs /////
BRU_en

);


//============================================================
//  PORT DECLARATIONS
//============================================================

input [31:0] BRU_rs1_data_InBUS;
input [31:0] BRU_rs2_data_InBUS;
input [2:0] BRU_funct3_InBUS;
input BRU_bren;
output BRU_en;

//============================================================
//  PARAMETER DECLARATIONS
//============================================================

localparam BEQ  = 3'b000,
			  BNE  = 3'b001,
			  BLT  = 3'b100,
			  BGE  = 3'b101,
			  BLTU = 3'b110,
			  BGEU = 3'b111;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

reg Temp_Reg;

//============================================================
// COMBINATIONAL LOGIC
//============================================================

always@(*)
begin

	case(BRU_funct3_InBUS)
		
		BEQ: Temp_Reg =  (BRU_rs1_data_InBUS == BRU_rs2_data_InBUS) ? 1'b1:1'b0; 
		BNE: Temp_Reg =  (BRU_rs1_data_InBUS != BRU_rs2_data_InBUS) ? 1'b1:1'b0; 
		BLT: Temp_Reg =  ($signed(BRU_rs1_data_InBUS) <  $signed(BRU_rs2_data_InBUS)) ? 1'b1:1'b0;
		BGE: Temp_Reg =  ($signed(BRU_rs1_data_InBUS) >= $signed(BRU_rs2_data_InBUS)) ? 1'b1:1'b0;
		BLTU: Temp_Reg =  (BRU_rs1_data_InBUS <  BRU_rs2_data_InBUS) ? 1'b1:1'b0; // default comparation is unsigned
		BGEU: Temp_Reg =  (BRU_rs1_data_InBUS >= BRU_rs2_data_InBUS) ? 1'b1:1'b0;
		
		default: Temp_Reg = 0;
	
	endcase

end


assign BRU_en= BRU_bren == 1'b1 ? Temp_Reg : 1'b0;


endmodule

