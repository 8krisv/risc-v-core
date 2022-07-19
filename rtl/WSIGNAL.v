/*#########################################################################
//# Register file write signal generator
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

module WSIGNAL(

///// inputs /////
WSIGNAL_Clk,
WSIGNAL_En,
///// outputs /////
WSIGNAL_RegFile_Write

);


//=======================================================
//  PORT declarations
//=======================================================

input WSIGNAL_Clk;
input WSIGNAL_En;
output WSIGNAL_RegFile_Write;
wire nClk;

//=======================================================
// REG/WIRE Declarations
//=======================================================

reg Counter=1'b0;

//=======================================================
// sequential logic
//=======================================================

always@(posedge nClk)
begin

	if(WSIGNAL_En)
		Counter <= Counter + 1'b1;
	else
		Counter <=1'b0;
end

assign nClk= ~WSIGNAL_Clk;
assign WSIGNAL_RegFile_Write = (~Counter)&WSIGNAL_En;


endmodule
