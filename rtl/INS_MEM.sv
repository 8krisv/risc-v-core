/*#########################################################################
//# Instruction memory for simulation
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


module INS_MEM #(parameter ADDR_WIDTH = 10, BINPATH="")
(
//////////// INPUTS //////////
INS_MEM_Clk,
INS_MEM_Re,
INS_MEM_We,
INS_MEM_Address, 
INS_MEM_Data_In,

//////////// OUTPUT //////////
INS_MEM_Data_Out
);

//============================================================
//  PORT DECLARATIONS
//============================================================

input INS_MEM_Clk;
input INS_MEM_Re;
input INS_MEM_We;
input [ADDR_WIDTH-1:0] INS_MEM_Address;
input [31:0] INS_MEM_Data_In;
output [31:0] INS_MEM_Data_Out;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

reg [31:0] Ram_Array[0:(2**(ADDR_WIDTH-2))-1];
reg [31:0] Q_temp;
wire [ADDR_WIDTH-1:0] Shift_Addr;
reg [31:0] reg32_data;


//============================================================
// LOADING RAM FOR SIMULATION (USING SYSTEM VERILLOG FEATURES)
//============================================================
integer File_ID;

//// function for loading ram 
function void load_ram(integer file);
	
	integer Status;
	
	Status  = $fread(reg32_data,file);
	for(integer i=0; Status ==4; i=i+1)
	begin	
		/*perform endianness correction*/
		Ram_Array[i]=((reg32_data&32'h000000ff) << 24) + ((reg32_data&32'h0000ff00) << 8) + ((reg32_data&32'h00ff0000) >> 8) + ((reg32_data&32'hff000000) >> 24);
		Status  = $fread(reg32_data,File_ID);
	end
	/*Close the file handle*/
	$fclose(file);

endfunction


initial // simulation begin
begin
	$display("Loading Instruction Memory...");
	File_ID = $fopen(BINPATH, "rb");
	load_ram(File_ID);
	$display("Ram successfully loaded.");
end


//============================================================
// SEQUENTIAL LOGIC
//============================================================

always@(posedge INS_MEM_Clk)
begin
	
	if(INS_MEM_We) begin
		Ram_Array[Shift_Addr]<=INS_MEM_Data_In;
	end
	
	Q_temp<=Ram_Array[Shift_Addr];
	
end


assign Shift_Addr=INS_MEM_Address>>2;

//============================================================
// COMBINATIONAL OUTPUT LOGIC
//============================================================

assign INS_MEM_Data_Out = INS_MEM_Re == 1'b1 ? Q_temp : 32'd0;


endmodule
