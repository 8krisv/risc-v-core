/*#########################################################################
//# Main control unit
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

module MCU(

///// inputs /////
MCU_Clk,
MCU_Reset,
MCU_Insmem_Valid,
MCU_Datamem_Valid_In,
MCU_Datamem_Ready_In,
MCU_Opcode_InBUS,

///// outputs /////
MCU_Internal_State,
MCU_Pc_Reset, 
MCU_Enpc_Set, 
MCU_Enpc_Reset, 
MCU_Ir_Reset,
MCU_Ir_Set,
MCU_RegFIle_Reset,
MCU_Insmem_Ready,
MCU_Datamem_Ready_Out,
MCU_Datamem_Valid_Out

);

//=======================================================
//  State declarations
//=======================================================

localparam [2:0] State_reset			   = 3'b000;
localparam [2:0] State_Wait			   = 3'b001;
localparam [2:0] State_Fetch           = 3'b010;
localparam [2:0] State_Exec	         = 3'b011;
localparam [2:0] State_Wait_Valid   	= 3'b100;
localparam [2:0] State_Wait_Ready  		= 3'b101;

/// load/store instruction ///
localparam LOAD 			= 7'b0000011;
localparam STORE 			= 7'b0100011;

//=======================================================
//  PORT declarations
//=======================================================

input MCU_Clk;
input MCU_Reset;
input MCU_Insmem_Valid; 
input MCU_Datamem_Valid_In;
input MCU_Datamem_Ready_In;
input [6:0] MCU_Opcode_InBUS;
output [2:0] MCU_Internal_State;
output reg MCU_Pc_Reset;
output reg MCU_Enpc_Set;
output reg MCU_Enpc_Reset;
output reg MCU_Ir_Reset;
output reg MCU_Ir_Set;
output reg MCU_RegFIle_Reset;
output reg MCU_Insmem_Ready;
output reg MCU_Datamem_Ready_Out;
output reg MCU_Datamem_Valid_Out;

//=======================================================
//  REG/WIRE DECLARATIONS
//=======================================================
reg [2:0] State_Register;
reg [2:0] State_Signal;

// Next state combinational logic
always @(*)
begin
	
	case(State_Register)
	
	State_reset: if(!MCU_Pc_Reset)
						State_Signal=State_reset;
					 else
						State_Signal=State_Wait;
						
						
	State_Wait:  if(MCU_Insmem_Valid)
						State_Signal=State_Fetch;
					 else
						State_Signal=State_Wait;
							
	State_Fetch: 
	begin
			
			case(MCU_Opcode_InBUS)
				
				LOAD:
				begin
					State_Signal=State_Wait_Valid;
				end
				
				STORE:
				begin
					State_Signal=State_Wait_Ready;
				end
			
				default:
					State_Signal=State_Exec;
							
			endcase
			
	end
	
	
	State_Wait_Valid: if(MCU_Datamem_Valid_In)
								State_Signal=State_Exec;
							else
								State_Signal=State_Wait_Valid;
	
	
	State_Wait_Ready: if(MCU_Datamem_Ready_In)
								State_Signal=State_Exec;
							else
								State_Signal=State_Wait_Ready;
	
	
	State_Exec:State_Signal=State_Wait;

	
	default: State_Signal =State_reset;
	
	endcase

	
end


// Sequential Logic // asynchronous active low reset
always @ (posedge MCU_Clk, negedge MCU_Reset)
begin
		if(!MCU_Reset)
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
			MCU_Pc_Reset=1'b1; 
			MCU_Enpc_Set=1'b0;
			MCU_Enpc_Reset=1'b0;
			MCU_Ir_Reset=1'b1;
			MCU_Ir_Set=1'b0;
			MCU_RegFIle_Reset=1'b1;
			MCU_Insmem_Ready=1'b0;
			MCU_Datamem_Ready_Out=1'b0;
			MCU_Datamem_Valid_Out=1'b0;
		end
		
		
		State_Wait:
		begin
			MCU_Pc_Reset=1'b0; 
			MCU_Enpc_Set=1'b0;
			MCU_Enpc_Reset=1'b1;
			MCU_Ir_Reset=1'b0;
			MCU_Ir_Set=1'b0;
			MCU_RegFIle_Reset=1'b0;
			MCU_Insmem_Ready=1'b1;
			MCU_Datamem_Ready_Out=1'b0;
			MCU_Datamem_Valid_Out=1'b0;
		end
		
		State_Fetch:
		begin
			MCU_Pc_Reset=1'b0; 
			MCU_Enpc_Set=1'b0;
			MCU_Enpc_Reset=1'b1;
			MCU_Ir_Reset=1'b0;
			MCU_Ir_Set=1'b1;
			MCU_RegFIle_Reset=1'b0;
			MCU_Insmem_Ready=1'b0;
			MCU_Datamem_Ready_Out=1'b0;
			MCU_Datamem_Valid_Out=1'b0;
		end
		
		
		State_Exec:
		begin
			MCU_Pc_Reset=1'b0; 
			MCU_Enpc_Set=1'b1;
			MCU_Enpc_Reset=1'b1;
			MCU_Ir_Reset=1'b0;
			MCU_Ir_Set=1'b0;
			MCU_RegFIle_Reset=1'b0;
			MCU_Insmem_Ready=1'b0;
			MCU_Datamem_Ready_Out=1'b0;
			MCU_Datamem_Valid_Out=1'b0;
		end
		
		
		State_Wait_Ready:
		begin
			MCU_Pc_Reset=1'b0; 
			MCU_Enpc_Set=1'b0;
			MCU_Enpc_Reset=1'b0;
			MCU_Ir_Reset=1'b0;
			MCU_Ir_Set=1'b0;
			MCU_RegFIle_Reset=1'b0;
			MCU_Insmem_Ready=1'b0;
			MCU_Datamem_Ready_Out=1'b0;
			MCU_Datamem_Valid_Out=1'b1;
		end
		
		
		
		State_Wait_Valid:
		begin
			MCU_Pc_Reset=1'b0; 
			MCU_Enpc_Set=1'b0;
			MCU_Enpc_Reset=1'b0;
			MCU_Ir_Reset=1'b0;
			MCU_Ir_Set=1'b0;
			MCU_RegFIle_Reset=1'b0;
			MCU_Insmem_Ready=1'b0;
			MCU_Datamem_Ready_Out=1'b1;
			MCU_Datamem_Valid_Out=1'b0;
		end
		
		default:
		begin
			MCU_Pc_Reset=1'b1; 
			MCU_Enpc_Set=1'b0;
			MCU_Enpc_Reset=1'b0;
			MCU_Ir_Reset=1'b1;
			MCU_Ir_Set=1'b0;
			MCU_RegFIle_Reset=1'b1;
			MCU_Insmem_Ready=1'b0;	
			MCU_Datamem_Ready_Out=1'b0;
			MCU_Datamem_Valid_Out=1'b0;
		end
		
	endcase
end


assign MCU_Internal_State = State_Register;


endmodule
