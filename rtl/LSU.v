/*#########################################################################
//# Load\Store Unit
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

module LSU #(parameter DATAWIDTH=32) (

//// inputs ////

LSU_MemData_InBUS,
LSU_Funct3_InBUS,
LSU_Store, /*bit 5 of the opcode field*/
LSU_En,

//// output ////
LSU_Byteenable_OutBUS,
LSU_Data_OutBUS

);

//============================================================
//  PORT DECLARATIONS
//============================================================

input [DATAWIDTH-1:0] LSU_MemData_InBUS;
input [2:0] LSU_Funct3_InBUS;
input LSU_Store;
input LSU_En;

output [3:0]  LSU_Byteenable_OutBUS;
output [DATAWIDTH-1:0] LSU_Data_OutBUS;

//============================================================
//  PARAMETER DECLARATIONS
//============================================================

/*Byteenable values according to avalon interface specifications*/
localparam ONE_BYTE   = 4'b0001,
			  TWO_BYTES  = 4'b0011,
           FOUR_BYTES = 4'b1111;

localparam LSB = 3'b000, /*load/store 1 byte */
			  LSH = 3'b001, /*load/store half word(two byes) */
			  LSW = 3'b010, /*load/store 1 word(4 byes) */
			  LBU = 3'b100, /*load 1 byte unsigned */
			  LHU = 3'b101; /*load 2 bytes unsigned */
			  

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

reg [DATAWIDTH-1:0] Temp_Data;
reg [3:0] Byteenable;

//============================================================
// COMBINATIONAL LOGIC
//============================================================

always@(*)
begin	
	casez(LSU_Funct3_InBUS)
		3'b?00: Byteenable = ONE_BYTE;   /* load/store 1 byte  or load 1 byte unsigned */
		3'b?01: Byteenable = TWO_BYTES;  /* load/store 2 bytes  or load 1 bytes unsigned */
		3'b010: Byteenable = FOUR_BYTES; /*load/store 1 word(4 byes) */
		default: Byteenable = FOUR_BYTES; 	
	endcase
end

always@(*)
begin

	case(LSU_Funct3_InBUS)
		
		LSB: Temp_Data = {{25{LSU_MemData_InBUS[7]}},  //25
							   LSU_MemData_InBUS[6:0]};     // 7
		
		LSH: Temp_Data = {{17{LSU_MemData_InBUS[15]}},  //17
							   LSU_MemData_InBUS[14:0]};     // 15
		
		LSW: Temp_Data = LSU_MemData_InBUS;
		
		LBU: Temp_Data= {{24{1'b0}},                   //24
							   LSU_MemData_InBUS[7:0]};     // 8
								
		LHU: Temp_Data = {{16{1'b0}},                   //16
							   LSU_MemData_InBUS[15:0]};     //16
								
		default Temp_Data= LSU_MemData_InBUS;
	
	endcase 

end


assign LSU_Data_OutBUS = (LSU_En&(~LSU_Store)) == 1'b1 ? Temp_Data : LSU_MemData_InBUS;
assign LSU_Byteenable_OutBUS =  LSU_En == 1'b1 ? Byteenable : 4'b0000;

endmodule

