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
DATAMEM_Data_Out
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
output [31:0] DATAMEM_Data_Out;

//============================================================
//  PARAMETER DECLARATIONS
//============================================================


localparam ONEBYTE    = 4'b0001,
			  TWOBYTES   = 4'b0011,
			  FOURBYTES  = 4'b1111;
			

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================

wire [31:0] Shift_Addr; 

reg [31:0] Ram_Array[0:(2**(ADDR_BITWIDTH-2))-1];
reg [31:0] Q_temp;

reg [31:0] Readdata;


//============================================================
// COMBINATIONAL LOGIC
//============================================================

always@(DATAMEM_Byteenable,DATAMEM_Address,Q_temp)
begin
	
	case(DATAMEM_Byteenable)
		
		ONEBYTE: 
		
		begin
			case(DATAMEM_Address[1:0])
					
			2'b00: Readdata = {{24{1'b0}},Q_temp[7:0]};
				
			2'b01: Readdata = {{24{1'b0}},Q_temp[15:8]};
				
			2'b10: Readdata = {{24{1'b0}},Q_temp[23:16]};
				
			2'b11: Readdata = {{24{1'b0}},Q_temp[31:24]};
				
			endcase
		
		end
		
		TWOBYTES:
		begin
		
			case(DATAMEM_Address[1])
				1'b0: Readdata = {{16{1'b0}},Q_temp[15:0]};	
				1'b1: Readdata = {{16{1'b0}},Q_temp[31:16]};
			endcase
		end
		
		FOURBYTES: Readdata = Q_temp;
		
		default: Readdata = Q_temp;
		
	endcase

end

//============================================================
// SEQUENTIAL LOGIC
//============================================================

always@(posedge DATAMEM_Clk)
begin
	
	if(DATAMEM_We) 
	
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
			
			FOURBYTES:Ram_Array[Shift_Addr] <= DATAMEM_Data_In;
					
			default: Ram_Array[Shift_Addr] <= DATAMEM_Data_In;
			
		endcase
		
	end
	
	Q_temp<=Ram_Array[Shift_Addr];

end


//============================================================
// COMBINATIONAL OUTPUT LOGIC
//============================================================

assign DATAMEM_Data_Out = DATAMEM_Re == 1'b1 ? Readdata : 32'd0;
assign Shift_Addr = DATAMEM_Address>>2;



endmodule
