/*#########################################################################
//# General purpose 1:32 demultiplexer
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

module DEMUX_1_32 #(parameter INPUT_DATA_WIDTH =32)(


input [INPUT_DATA_WIDTH-1:0] DEMUX_Data_InBUS,
input [4:0] DEMUX_Selector_InBUS,
input DEMUX_En,

output [INPUT_DATA_WIDTH-1:0] DEMUX_out0,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out1,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out2,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out3,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out4,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out5,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out6,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out7,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out8,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out9,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out10,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out11,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out12,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out13,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out14,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out15,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out16,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out17,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out18,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out19,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out20,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out21,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out22,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out23,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out24,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out25,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out26,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out27,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out28,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out29,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out30,
output [INPUT_DATA_WIDTH-1:0] DEMUX_out31

);

//=======================================================
// PARAMETER DECLARATION
//=======================================================

localparam [INPUT_DATA_WIDTH-1:0] DATA0 = 0;

//============================================================
// COMBINATIONAL LOGIC OUTPUT
//============================================================
assign DEMUX_out0 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd0 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out1 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd1 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out2 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd2 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out3 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd3 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out4 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd4 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out5 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd5 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out6 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd6 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out7 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd7 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out8 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd8 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out9 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd9 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out10 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd10 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out11 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd11 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out12 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd12 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out13 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd13 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out14 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd14 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out15 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd15 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out16 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd16 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out17 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd17 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out18 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd18 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out19 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd19 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out20 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd20 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out21 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd21 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out22 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd22 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out23 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd23 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out24 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd24 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out25 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd25 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out26 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd26 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out27 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd27 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out28 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd28 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out29 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd29 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out30 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd30 ? DEMUX_Data_InBUS : DATA0 : DATA0;
assign DEMUX_out31 = DEMUX_En == 1'b1 ? DEMUX_Selector_InBUS == 5'd31 ? DEMUX_Data_InBUS : DATA0 : DATA0;


endmodule

