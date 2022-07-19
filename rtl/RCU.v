/*#########################################################################
//# Reset control unit
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

module RCU(

///// inputs /////
RCU_Clk,
RCU_Reset,
///// outputs /////

RCU_Pc_Reset, 
RCU_Enpc_Set, 
RCU_Enpc_Reset, 
RCU_Ir_Reset,
RCU_Ir_Set,
RCU_RegFIle_Reset,
RCU_Insmem_Read

);

//=======================================================
//  State declarations
//=======================================================

localparam State_reset				= 2'b00;
localparam State_Feeding_0			= 2'b01;
localparam State_Feeding_1			= 2'b10;

//=======================================================
//  PORT declarations
//=======================================================

input RCU_Clk;
input RCU_Reset;
output reg RCU_Pc_Reset;
output reg RCU_Enpc_Set;
output reg RCU_Enpc_Reset;
output reg RCU_Ir_Reset;
output reg RCU_Ir_Set;
output reg RCU_RegFIle_Reset;
output reg RCU_Insmem_Read;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================
reg [1:0] State_Register;
reg [1:0] State_Signal;

// Next state combinational logic
always @(*)
begin
	
	case(State_Register)
	
	State_reset: if(!RCU_Pc_Reset)
						State_Signal=State_reset;
					 else
						State_Signal=State_Feeding_0;
						
	State_Feeding_0: State_Signal=State_Feeding_1;
	State_Feeding_1: State_Signal=State_Feeding_1;
					
	default: State_Signal =State_reset;
	
	endcase

	
end


// Sequential Logic // asynchronous active low reset
always @ (posedge RCU_Clk, negedge RCU_Reset)
begin
		if(!RCU_Reset)
			State_Register <= State_reset;
		else
			State_Register <= State_Signal;
end



// COMBINATIONAL OUTPUT LOGIC
always @ (*)
begin
	
	case(State_Register)
	
		State_reset:
		begin
			RCU_Pc_Reset=1'b1; 
			RCU_Enpc_Set=1'b0;
			RCU_Enpc_Reset=1'b0;
			RCU_Ir_Reset=1'b0;
			RCU_Ir_Set=1'b0;
			RCU_RegFIle_Reset=1'b0;
			RCU_Insmem_Read=1'b0;
		end
		
		State_Feeding_0:
		begin
			RCU_Pc_Reset=1'b0; 
			RCU_Enpc_Set=1'b1;
			RCU_Enpc_Reset=1'b1;
			RCU_Ir_Reset=1'b1;
			RCU_Ir_Set=1'b1;
			RCU_RegFIle_Reset=1'b1;
			RCU_Insmem_Read=1'b1;
		end
		
		State_Feeding_1:
		begin
			RCU_Pc_Reset=1'b0; 
			RCU_Enpc_Set=1'b1;
			RCU_Enpc_Reset=1'b1;
			RCU_Ir_Reset=1'b1;
			RCU_Ir_Set=1'b1;
			RCU_RegFIle_Reset=1'b1;
			RCU_Insmem_Read=1'b1;
		end
		
		default:
		begin
			RCU_Pc_Reset=1'b1; 
			RCU_Enpc_Set=1'b0;
			RCU_Enpc_Reset=1'b0;
			RCU_Ir_Reset=1'b0;
			RCU_Ir_Set=1'b0;
			RCU_RegFIle_Reset=1'b0;
			RCU_Insmem_Read=1'b0;	
		end
		
	endcase
end


endmodule
