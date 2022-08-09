/*#########################################################################
//# Axi ram
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


module AXI_RAM #(parameter ADDR_WIDTH = 10)
(
//////////// INPUTS //////////
AXI_RAM_Clk,
AXI_RAM_Read_Ready,
AXI_RAM_Write_Valid,
AXI_RAM_Address, 
AXI_RAM_Data_In,
//////////// OUTPUT //////////
AXI_RAM_Read_Valid,
AXI_RAM_Write_Ready,
AXI_RAM_Data_Out
);

//============================================================
//  PORT DECLARATIONS
//============================================================
input AXI_RAM_Clk;
input AXI_RAM_Read_Ready;
input AXI_RAM_Write_Valid;
input [ADDR_WIDTH-1:0] AXI_RAM_Address;
input [31:0] AXI_RAM_Data_In;

//////////// OUTPUT //////////
output AXI_RAM_Read_Valid;
output AXI_RAM_Write_Ready;
output reg [31:0] AXI_RAM_Data_Out;


reg [31:0] Ram_Array[0:(2**(ADDR_WIDTH-1))];


reg read_valid = 1'b0;
reg write_ready = 1'b0;


always@(AXI_RAM_Read_Ready,AXI_RAM_Write_Valid)
begin
	
	if(AXI_RAM_Read_Ready)
		read_valid=1'b1;
	else
		read_valid=1'b0;
		
	
	if(AXI_RAM_Write_Valid)
		write_ready=1'b1;
	else
		write_ready=1'b0;


end


always@(posedge AXI_RAM_Clk)
begin


	if(AXI_RAM_Write_Valid&write_ready)begin
		Ram_Array[AXI_RAM_Address]<=AXI_RAM_Data_In;
	end
	
	
	if(AXI_RAM_Read_Ready&read_valid) begin
			AXI_RAM_Data_Out<=Ram_Array[AXI_RAM_Address];
	end
	
	else 
		AXI_RAM_Data_Out<=32'b0;

	
	
end



assign AXI_RAM_Read_Valid=read_valid;
assign AXI_RAM_Write_Ready=write_ready;

endmodule
