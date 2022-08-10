/*#########################################################################
//# General purpose register triggered on the positive edge of the clock
//# and asynchronous active low reset 
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

module REG_POS #(parameter REG_DATA_WIDTH=32, parameter [REG_DATA_WIDTH-1:0] RESET_VALUE= 32'h00000000)(

//////////// INPUTS //////////
REG_Clk,
REG_Reset,
REG_Set,
REG_Data_InBUS,
//////////// OUTPUTS //////////
REG_Data_OutBUS
);

//============================================================
//  PORT DECLARATIONS
//============================================================
input REG_Clk;
input REG_Reset;
input REG_Set;
input signed [REG_DATA_WIDTH-1:0] REG_Data_InBUS;
output signed [REG_DATA_WIDTH-1:0] REG_Data_OutBUS;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

reg signed [REG_DATA_WIDTH-1:0] Internal_Signal_Reg;
reg signed[REG_DATA_WIDTH-1:0] Internal_Data_Reg;

//============================================================
// COMBINATIONAL LOGIC
//============================================================
always@(*)
begin
	if(REG_Set)
		Internal_Signal_Reg=REG_Data_InBUS;
	else
		Internal_Signal_Reg=Internal_Data_Reg;
end

//============================================================
// SEQUENTIAL LOGIC
//============================================================

always@(posedge REG_Clk or negedge REG_Reset)
begin
	if(!REG_Reset)
		Internal_Data_Reg<=RESET_VALUE;
	else
		Internal_Data_Reg<=Internal_Signal_Reg;
end

//============================================================
// COMBINATIONAL OUTPUT LOGIC
//============================================================
assign REG_Data_OutBUS=Internal_Data_Reg;

endmodule
