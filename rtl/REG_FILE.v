/*#########################################################################
//# Register file
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

module REG_FILE(

//////////// INPUTS //////////

REG_FILE_Clk,
REG_FILE_Reset_in,
REG_FILE_Write_En,
REG_FILE_Data_InBUS,
REG_FILE_R1_InBUS, // register 1 selecter
REG_FILE_R2_InBUS, // register 2 selecter
REG_FILE_Rd_InBUS,

//////////// Output //////////
REG_FILE_Data1_OutBUS,
REG_FILE_Data2_OutBUS

);

//============================================================
//  PARAMETER DECLARATIONS
//=========================================================

parameter DATAWIDTH=32;
localparam DEMUX_SELECTOR_RD_INPUT = 1'b1;

//============================================================
//  PORT DECLARATIONS
//============================================================

input REG_FILE_Clk;
input REG_FILE_Reset_in;
input REG_FILE_Write_En;
input [DATAWIDTH-1:0] REG_FILE_Data_InBUS;
input [4:0] REG_FILE_R2_InBUS;
input [4:0] REG_FILE_R1_InBUS;
input [4:0] REG_FILE_Rd_InBUS;
output [DATAWIDTH-1:0] REG_FILE_Data1_OutBUS;
output [DATAWIDTH-1:0] REG_FILE_Data2_OutBUS;



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire [DATAWIDTH-1:0] Reg0_Output;
wire [DATAWIDTH-1:0] Reg1_Output;
wire [DATAWIDTH-1:0] Reg2_Output;
wire [DATAWIDTH-1:0] Reg3_Output;
wire [DATAWIDTH-1:0] Reg4_Output;
wire [DATAWIDTH-1:0] Reg5_Output;
wire [DATAWIDTH-1:0] Reg6_Output;
wire [DATAWIDTH-1:0] Reg7_Output;
wire [DATAWIDTH-1:0] Reg8_Output;
wire [DATAWIDTH-1:0] Reg9_Output;
wire [DATAWIDTH-1:0] Reg10_Output;
wire [DATAWIDTH-1:0] Reg11_Output;
wire [DATAWIDTH-1:0] Reg12_Output;
wire [DATAWIDTH-1:0] Reg13_Output;
wire [DATAWIDTH-1:0] Reg14_Output;
wire [DATAWIDTH-1:0] Reg15_Output;
wire [DATAWIDTH-1:0] Reg16_Output;
wire [DATAWIDTH-1:0] Reg17_Output;
wire [DATAWIDTH-1:0] Reg18_Output;
wire [DATAWIDTH-1:0] Reg19_Output;
wire [DATAWIDTH-1:0] Reg20_Output;
wire [DATAWIDTH-1:0] Reg21_Output;
wire [DATAWIDTH-1:0] Reg22_Output;
wire [DATAWIDTH-1:0] Reg23_Output;
wire [DATAWIDTH-1:0] Reg24_Output;
wire [DATAWIDTH-1:0] Reg25_Output;
wire [DATAWIDTH-1:0] Reg26_Output;
wire [DATAWIDTH-1:0] Reg27_Output;
wire [DATAWIDTH-1:0] Reg28_Output;
wire [DATAWIDTH-1:0] Reg29_Output;
wire [DATAWIDTH-1:0] Reg30_Output;
wire [DATAWIDTH-1:0] Reg31_Output;


wire Reg0_Set;
wire Reg1_Set;
wire Reg2_Set;
wire Reg3_Set;
wire Reg4_Set;
wire Reg5_Set;
wire Reg6_Set;
wire Reg7_Set;
wire Reg8_Set;
wire Reg9_Set;
wire Reg10_Set;
wire Reg11_Set;
wire Reg12_Set;
wire Reg13_Set;
wire Reg14_Set;
wire Reg15_Set;
wire Reg16_Set;
wire Reg17_Set;
wire Reg18_Set;
wire Reg19_Set;
wire Reg20_Set;
wire Reg21_Set;
wire Reg22_Set;
wire Reg23_Set;
wire Reg24_Set;
wire Reg25_Set;
wire Reg26_Set;
wire Reg27_Set;
wire Reg28_Set;
wire Reg29_Set;
wire Reg30_Set;
wire Reg31_Set;


//=======================================================
//  Structural coding
//=======================================================

/* Demultiplexer instantiation*/

DEMUX_1_32 #(.INPUT_DATA_WIDTH(1'b1)) Demux_Selector_Rd (

//////////// INPUTS /////////
.DEMUX_Data_InBUS(DEMUX_SELECTOR_RD_INPUT),
.DEMUX_Selector_InBUS(REG_FILE_Rd_InBUS),
.DEMUX_En(REG_FILE_Write_En),

//////////// OUTPUTS //////////
.DEMUX_out0(Reg0_Set),
.DEMUX_out1(Reg1_Set),
.DEMUX_out2(Reg2_Set),
.DEMUX_out3(Reg3_Set),
.DEMUX_out4(Reg4_Set),
.DEMUX_out5(Reg5_Set),
.DEMUX_out6(Reg6_Set),
.DEMUX_out7(Reg7_Set),
.DEMUX_out8(Reg8_Set),
.DEMUX_out9(Reg9_Set),
.DEMUX_out10(Reg10_Set),
.DEMUX_out11(Reg11_Set),
.DEMUX_out12(Reg12_Set),
.DEMUX_out13(Reg13_Set),
.DEMUX_out14(Reg14_Set),
.DEMUX_out15(Reg15_Set),
.DEMUX_out16(Reg16_Set),
.DEMUX_out17(Reg17_Set),
.DEMUX_out18(Reg18_Set),
.DEMUX_out19(Reg19_Set),
.DEMUX_out20(Reg20_Set),
.DEMUX_out21(Reg21_Set),
.DEMUX_out22(Reg22_Set),
.DEMUX_out23(Reg23_Set),
.DEMUX_out24(Reg24_Set),
.DEMUX_out25(Reg25_Set),
.DEMUX_out26(Reg26_Set),
.DEMUX_out27(Reg27_Set),
.DEMUX_out28(Reg28_Set),
.DEMUX_out29(Reg29_Set),
.DEMUX_out30(Reg30_Set),
.DEMUX_out31(Reg31_Set)


);

/* Multiplexer instantiation for R1 output */

MUX_32_1 #(.INPUT_DATA_WIDTH(DATAWIDTH)) Mux_Output_R1 (

//////////// INPUTS //////////
.MUX_Input_0(Reg0_Output),
.MUX_Input_1(Reg1_Output),
.MUX_Input_2(Reg2_Output),
.MUX_Input_3(Reg3_Output),
.MUX_Input_4(Reg4_Output),
.MUX_Input_5(Reg5_Output),
.MUX_Input_6(Reg6_Output),
.MUX_Input_7(Reg7_Output),
.MUX_Input_8(Reg8_Output),
.MUX_Input_9(Reg9_Output),
.MUX_Input_10(Reg10_Output),
.MUX_Input_11(Reg11_Output),
.MUX_Input_12(Reg12_Output),
.MUX_Input_13(Reg13_Output),
.MUX_Input_14(Reg14_Output),
.MUX_Input_15(Reg15_Output),
.MUX_Input_16(Reg16_Output),
.MUX_Input_17(Reg17_Output),
.MUX_Input_18(Reg18_Output),
.MUX_Input_19(Reg19_Output),
.MUX_Input_20(Reg20_Output),
.MUX_Input_21(Reg21_Output),
.MUX_Input_22(Reg22_Output),
.MUX_Input_23(Reg23_Output),
.MUX_Input_24(Reg24_Output),
.MUX_Input_25(Reg25_Output),
.MUX_Input_26(Reg26_Output),
.MUX_Input_27(Reg27_Output),
.MUX_Input_28(Reg28_Output),
.MUX_Input_29(Reg29_Output),
.MUX_Input_30(Reg30_Output),
.MUX_Input_31(Reg31_Output),


.MUX_Sel_InBUS(REG_FILE_R1_InBUS),

//////////// OUTPUT //////////

.MUX_Output_OutBUS(REG_FILE_Data1_OutBUS)

);


/* Multiplexer instantiation for R2 output */

MUX_32_1 #(.INPUT_DATA_WIDTH(DATAWIDTH)) Mux_Output_R2 (

//////////// INPUTS //////////
.MUX_Input_0(Reg0_Output),
.MUX_Input_1(Reg1_Output),
.MUX_Input_2(Reg2_Output),
.MUX_Input_3(Reg3_Output),
.MUX_Input_4(Reg4_Output),
.MUX_Input_5(Reg5_Output),
.MUX_Input_6(Reg6_Output),
.MUX_Input_7(Reg7_Output),
.MUX_Input_8(Reg8_Output),
.MUX_Input_9(Reg9_Output),
.MUX_Input_10(Reg10_Output),
.MUX_Input_11(Reg11_Output),
.MUX_Input_12(Reg12_Output),
.MUX_Input_13(Reg13_Output),
.MUX_Input_14(Reg14_Output),
.MUX_Input_15(Reg15_Output),
.MUX_Input_16(Reg16_Output),
.MUX_Input_17(Reg17_Output),
.MUX_Input_18(Reg18_Output),
.MUX_Input_19(Reg19_Output),
.MUX_Input_20(Reg20_Output),
.MUX_Input_21(Reg21_Output),
.MUX_Input_22(Reg22_Output),
.MUX_Input_23(Reg23_Output),
.MUX_Input_24(Reg24_Output),
.MUX_Input_25(Reg25_Output),
.MUX_Input_26(Reg26_Output),
.MUX_Input_27(Reg27_Output),
.MUX_Input_28(Reg28_Output),
.MUX_Input_29(Reg29_Output),
.MUX_Input_30(Reg30_Output),
.MUX_Input_31(Reg31_Output),


.MUX_Sel_InBUS(REG_FILE_R2_InBUS),

//////////// OUTPUT //////////

.MUX_Output_OutBUS(REG_FILE_Data2_OutBUS)

);



/*Register #1 instantiation, Reg0 is hardwired to
0x00000000 according to RISC-V Calling Convention*/

REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg0(
//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg0_Set),
.REG_Data_InBUS(32'h00000000),
//////////// OUTPUTS ////////////////////// OUTPUT //////////
.REG_Data_OutBUS(Reg0_Output)

);


/*Register #2 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg1(
//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg1_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg1_Output)

);


/*Register #3 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg2(
//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg2_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg2_Output)

);

/*Register #4 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg3(
//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg3_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg3_Output)

);


/*Register #5 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg4(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg4_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg4_Output)

);

/*Register #6 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg5(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg5_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg5_Output)

);


/*Register #7 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg6(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg6_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg6_Output)

);

/*Register #8 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg7(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg7_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg7_Output)

);


/*Register #9 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg8(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg8_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg8_Output)

);


/*Register #10 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg9(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg9_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg9_Output)

);

/*Register #11 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg10(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg10_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg10_Output)

);

/*Register #12 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg11(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg11_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg11_Output)

);

/*Register #13 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg12(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg12_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg12_Output)

);

/*Register #14 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg13(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg13_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg13_Output)

);

/*Register #15 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg14(
//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg14_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg14_Output)

);


/*Register #16 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg15(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg15_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg15_Output)

);


/*Register #17 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg16(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg16_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg16_Output)

);

/*Register #18 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg17(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg17_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg17_Output)

);

/*Register #19 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg18(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg18_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg18_Output)
//////////// OUTPUT //////////
);

/*Register #20 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg19(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg19_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg19_Output)

);

/*Register #21 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg20(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg20_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg20_Output)

);
/*Register #22 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg21(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg21_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg21_Output)

);
/*Register #23 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg22(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg22_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg22_Output)

);
/*Register #24 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg23(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg23_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg23_Output)

);

/*Register #25 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg24(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg24_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg24_Output)

);

/*Register #26 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg25(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg25_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg25_Output)

);

/*Register #27 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg26(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg26_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg26_Output)

);


/*Register #28 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg27(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg27_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg27_Output)

);

/*Register #29 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg28(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg28_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg28_Output)

);

/*Register #30 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg29(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg29_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg29_Output)

);


/*Register #31 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg30(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg30_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg30_Output)

);

/*Register #32 instantiation*/
REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Reg31(

//////////// INPUTS //////////
.REG_Clk(REG_FILE_Clk),
.REG_Reset(REG_FILE_Reset_in),
.REG_Set(Reg31_Set),
.REG_Data_InBUS(REG_FILE_Data_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Reg31_Output)

);


endmodule 

