/*#########################################################################
//# General purpose 32:1 multiplexer
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

module MUX_32_1 #(parameter INPUT_DATA_WIDTH =32)(

//////////// INPUTS //////////
input [INPUT_DATA_WIDTH-1:0] MUX_Input_0,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_1,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_2,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_3,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_4,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_5,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_6,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_7,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_8,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_9,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_10,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_11,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_12,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_13,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_14,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_15,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_16,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_17,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_18,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_19,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_20,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_21,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_22,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_23,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_24,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_25,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_26,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_27,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_28,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_29,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_30,
input [INPUT_DATA_WIDTH-1:0] MUX_Input_31,


input [4:0] MUX_Sel_InBUS,

//////////// OUTPUT //////////

output[INPUT_DATA_WIDTH-1:0]  MUX_Output_OutBUS

);


reg [INPUT_DATA_WIDTH-1:0] Data;


//============================================================
// COMBINATIONAL LOGIC
//============================================================

always@(*)
begin
	case(MUX_Sel_InBUS)
		5'd0: Data=MUX_Input_0;
		5'd1: Data=MUX_Input_1;
		5'd2: Data=MUX_Input_2;
		5'd3: Data=MUX_Input_3;
		5'd4: Data=MUX_Input_4;
		5'd5: Data=MUX_Input_5;
		5'd6: Data=MUX_Input_6;
		5'd7: Data=MUX_Input_7;
		5'd8: Data=MUX_Input_8;
		5'd9: Data=MUX_Input_9;
		5'd10: Data=MUX_Input_10;
		5'd11: Data=MUX_Input_11;
		5'd12: Data=MUX_Input_12;
		5'd13: Data=MUX_Input_13;
		5'd14: Data=MUX_Input_14;
		5'd15: Data=MUX_Input_15;
		5'd16: Data=MUX_Input_16;
		5'd17: Data=MUX_Input_17;
		5'd18: Data=MUX_Input_18;
		5'd19: Data=MUX_Input_19;
		5'd20: Data=MUX_Input_20;
		5'd21: Data=MUX_Input_21;
		5'd22: Data=MUX_Input_22;
		5'd23: Data=MUX_Input_23;
		5'd24: Data=MUX_Input_24;
		5'd25: Data=MUX_Input_25;
		5'd26: Data=MUX_Input_26;
		5'd27: Data=MUX_Input_27;
		5'd28: Data=MUX_Input_28;
		5'd29: Data=MUX_Input_29;
		5'd30: Data=MUX_Input_30;
		5'd31: Data=MUX_Input_31;
	endcase
end


assign MUX_Output_OutBUS=Data;

endmodule
