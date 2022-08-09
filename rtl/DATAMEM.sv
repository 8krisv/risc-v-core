/*#########################################################################
//# Data memory
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



module DATAMEM #( parameter ADDR_BITWIDTH=10 )
(
//////////// INPUTS //////////
DATAMEM_Clk,
DATAMEM_We,
DATAMEM_Re,
DATAMEM_Byteenable,
DATAMEM_Address, 
DATAMEM_Data_In,

//////////// OUTPUT //////////
DATAMEM_Data_Out,
DATAMEM_Read_Valid,
DATAMEM_Write_Ready

);

//============================================================
//  PORT DECLARATIONS
//============================================================

input DATAMEM_Clk;
input DATAMEM_We;
input DATAMEM_Re;
input [ADDR_BITWIDTH-1:0] DATAMEM_Address;
input [31:0] DATAMEM_Data_In;
input [3:0] DATAMEM_Byteenable;
output reg [31:0] DATAMEM_Data_Out;
output DATAMEM_Read_Valid;
output DATAMEM_Write_Ready;

//============================================================
//  PARAMETER DECLARATIONS
//============================================================


localparam ONEBYTE    = 4'b0001,
			  TWOBYTES   = 4'b0011,
			  FOURBYTES  = 4'b1111;
			  
localparam MEMSIZE = 2**(ADDR_BITWIDTH-2);
			

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

wire [31:0] Shift_Addr; 
reg [31:0] Ram_Array[0:MEMSIZE-1];
reg [31:0] Readdata;
reg read_valid = 1'b0;
reg write_ready = 1'b0;


//============================================================
// COMBINATIONAL LOGIC
//============================================================
always@(DATAMEM_Re,DATAMEM_We)
begin
	
	if(DATAMEM_Re)
		read_valid=1'b1;
	else
		read_valid=1'b0;
		
	
	if(DATAMEM_We)
		write_ready=1'b1;
	else
		write_ready=1'b0;

end


always@(DATAMEM_Byteenable,DATAMEM_Address,Ram_Array[Shift_Addr])
begin
	
	case(DATAMEM_Byteenable)
		
		ONEBYTE: // read 1 byte
		
		begin
			case(DATAMEM_Address[1:0])
					
			2'b00: Readdata = {{24{1'b0}},Ram_Array[Shift_Addr][7:0]};
				
			2'b01: Readdata = {{24{1'b0}},Ram_Array[Shift_Addr][15:8]};
				
			2'b10: Readdata = {{24{1'b0}},Ram_Array[Shift_Addr][23:16]};
				
			2'b11: Readdata = {{24{1'b0}},Ram_Array[Shift_Addr][31:24]};
				
			endcase
		
		end
		
		TWOBYTES: // read 2 bytes
		begin
		
			case(DATAMEM_Address[1])
				1'b0: Readdata = {{16{1'b0}},Ram_Array[Shift_Addr][15:0]};	
				1'b1: Readdata = {{16{1'b0}},Ram_Array[Shift_Addr][31:16]};
			endcase
		end
		
		FOURBYTES: Readdata = Ram_Array[Shift_Addr]; // read 4 bytes
		
		default: Readdata = Ram_Array[Shift_Addr];
		
	endcase

end

//============================================================
// SEQUENTIAL LOGIC
//============================================================

always@(posedge DATAMEM_Clk)
begin
	
	if(DATAMEM_We&write_ready) 
	
	begin
	
		case(DATAMEM_Byteenable)
			
			ONEBYTE: // store 1 byte
			begin
				case(DATAMEM_Address[1:0])
					
				2'b00: Ram_Array[Shift_Addr] <= {Ram_Array[Shift_Addr][31:8],DATAMEM_Data_In[7:0]};
					
				2'b01: Ram_Array[Shift_Addr] <= {Ram_Array[Shift_Addr][31:16],DATAMEM_Data_In[7:0],Ram_Array[Shift_Addr][7:0]};
					
				2'b10: Ram_Array[Shift_Addr] <= {Ram_Array[Shift_Addr][31:24],DATAMEM_Data_In[7:0],Ram_Array[Shift_Addr][15:0]};
					
				2'b11:  Ram_Array[Shift_Addr] <= {DATAMEM_Data_In[7:0],Ram_Array[Shift_Addr][23:0]};
					
				endcase
			end
		
		
			TWOBYTES: // store 2 bytes
			begin
				case(DATAMEM_Address[1])
					
					1'b0: Ram_Array[Shift_Addr] <= {Ram_Array[Shift_Addr][31:16],DATAMEM_Data_In[15:0]};
					
					1'b1: Ram_Array[Shift_Addr] <= {DATAMEM_Data_In[15:0],Ram_Array[Shift_Addr][15:0]};
					
				endcase
			end
			
			FOURBYTES:Ram_Array[Shift_Addr] <= DATAMEM_Data_In;  // store 4 bytes
					
			default: Ram_Array[Shift_Addr] <= DATAMEM_Data_In;
			
		endcase
		
	end
	
	if(DATAMEM_Re&read_valid)
		DATAMEM_Data_Out<=Readdata;
		
	else
		DATAMEM_Data_Out<=32'b0;
		

end


//============================================================
// COMBINATIONAL LOGIC
//============================================================

assign Shift_Addr = DATAMEM_Address>>2;
assign DATAMEM_Read_Valid=read_valid;
assign DATAMEM_Write_Ready=write_ready;

//============================================================
// INITIALIZING RAM FOR SIMULATION 
//============================================================

function void init_memory;
	for(integer i=0; i < MEMSIZE; i=i+1)
	begin	
		Ram_Array[i]= 32'h00000000;
	end
endfunction


initial // simulation begin
begin
	$display("Initializig Data Memory...");
	init_memory();
	$display("Data Memory successfully loaded.");
end



endmodule
