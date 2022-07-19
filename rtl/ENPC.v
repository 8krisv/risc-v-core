/*#########################################################################
//# Program counter set enable signal generation
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

module ENPC(

//////////// INPUTS //////////
ENPC_Clk,
ENPC_En,
ENPC_Reset,
//////////// OUTPUTS //////////,
ENPC_Set_En

);

//============================================================
//  PORT DECLARATIONS
//============================================================

input ENPC_Clk;
input ENPC_En;
input ENPC_Reset;
output ENPC_Set_En;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================
wire nClk;
wire Clk2;
reg [1:0] Counter = 2'b00;

//============================================================
// SEQUENTIAL LOGIC
//============================================================

always@(posedge ENPC_Clk)
begin
	
	if(!ENPC_Reset)
		Counter<=2'b00;
	else
		Counter<=Counter+2'b01;
end


assign nClk=~ENPC_Clk;
assign Clk2=Counter[0]&nClk;
assign ENPC_Set_En = Clk2&ENPC_En;


endmodule

