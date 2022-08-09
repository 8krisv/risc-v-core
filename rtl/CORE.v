/*#########################################################################
//# RISC-V MULTY CYCLE CORE (RV32I BASE INSTRUCTION SET)
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

module CORE #(parameter DATAWIDTH=32)(

///// inputs /////
CORE_Clk_In,
CORE_Reset_In,
CORE_Insmem_Readdata_InBUS,
CORE_Insmem_Valid_In,
CORE_Datamem_Readdata_InBUS,
CORE_Datamem_Valid_In,
CORE_Datamem_Ready_In,

//// outputs ////
CORE_Insmem_Ready_Out,
Core_Insmem_Addr_OutBUS,
CORE_Datamem_Ready_Out,
CORE_Datamem_Valid_Out,
CORE_Datamem_Byteenable_OutBUS,
CORE_Datamem_Writedata_outBUS,
CORE_Datamem_Addr_OutBUS


);


//============================================================
//  PORT DECLARATIONS
//============================================================

input CORE_Clk_In;
input CORE_Reset_In;
input [DATAWIDTH-1:0]CORE_Insmem_Readdata_InBUS;
input CORE_Insmem_Valid_In;
input [DATAWIDTH-1:0]CORE_Datamem_Readdata_InBUS;
input  CORE_Datamem_Valid_In;
input  CORE_Datamem_Ready_In;
output CORE_Insmem_Ready_Out;
output [DATAWIDTH-1:0] Core_Insmem_Addr_OutBUS;
output CORE_Datamem_Ready_Out;
output CORE_Datamem_Valid_Out;
output [3:0] CORE_Datamem_Byteenable_OutBUS;
output [DATAWIDTH-1:0] CORE_Datamem_Writedata_outBUS;
output [DATAWIDTH-1:0] CORE_Datamem_Addr_OutBUS;


//============================================================
//  PARAMETER DECLARATIONS
//============================================================

localparam INSMEMSTEP = 32'd4;

//=======================================================
//  REG/WIRE declarations
//=======================================================


wire [DATAWIDTH-1:0] Pc_Addr_OutBUS_Wire;
wire [DATAWIDTH-1:0] Add1_Rest_OutBUS_Wire;
wire [DATAWIDTH-1:0] Imm_Generation_OutBUS_Wire;
wire [DATAWIDTH-1:0] Iregister_OutBUS_Wire;
wire [DATAWIDTH-1:0] MuxB_Data_OutBUS_Wire;
wire [DATAWIDTH-1:0] MuxA_Data_OutBUS_Wire;

wire [4:0] Rs1_InBUS_Wire;
wire [4:0] Rs2_InBUS_Wire;
wire [4:0] Rd_InBUS_Wire;
wire [6:0] Opcode_InBUS_Wire;
wire [6:0] Funct7_InBUS_Wire;
wire [2:0] Funct3_InBUS_Wire;



wire Idu_Not_Branch_Jump_Op_Wire;
wire [1:0] Idu_RegFile_Mux_OutBUS_Wire;
wire Idu_RegFile_Write_Wire;
wire [1:0] Idu_AluOp_OutBUS_Wire;
wire Idu_Bru_En_Wire;
wire Idu_Alu_Select_Immediate_Mux_Wire;
wire Idu_Lsu_En_Wire;


wire [DATAWIDTH-1:0] Register_File_Data1_OutBUS_Wire;
wire [DATAWIDTH-1:0] Register_File_Data2_OutBUS_Wire;


wire [3:0] Acu_AluControl_OutBUS_Wire;
wire [DATAWIDTH-1:0] Alu_Data_OutBUS_Wire;


wire Jcu_Mux_b_sel_wire;
wire Jcu_Mux_c_sel_wire;

wire Bru_Muxc_En_Wire;

wire MuxC_sel_wire;
wire [DATAWIDTH-1:0] MuxC_Data_OutBUS_Wire;

wire [DATAWIDTH-1:0] Lsu_Data_OutBUS_Wire;


wire [DATAWIDTH-1:0] MuxD_Data_OutBUS_Wire;


wire [DATAWIDTH-1:0] Add0_Rest_OutBUS_Wire;

wire [2:0] Mcu_State_Wire;
wire Mcu_Pc_Reset_Wire;
wire Mcu_Enpc_set_Wire;
wire Mcu_Enpc_reset_Wire;
wire Mcu_Ir_Reset_Wire;
wire Mcu_Ir_Set_Wire;
wire Mcu_RegFile_Reset_Wire;

wire Enpc_Set_En;

wire Wsignal_RegFile_Write;

//=======================================================
//  Structural coding
//=======================================================


/*Instruction register instantiation*/

REG_NEG #(.REG_DATA_WIDTH(DATAWIDTH)) Iregister (

//////////// INPUTS //////////
.REG_Clk(CORE_Clk_In),
.REG_Reset(Mcu_Ir_Reset_Wire),
.REG_Set(Mcu_Ir_Set_Wire),
.REG_Data_InBUS(CORE_Insmem_Readdata_InBUS),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Iregister_OutBUS_Wire)

);


/*Program counter instantiation*/

REG_POS #(.REG_DATA_WIDTH(DATAWIDTH)) Pc (

//////////// INPUTS //////////
.REG_Clk(CORE_Clk_In),
.REG_Reset(~Mcu_Pc_Reset_Wire),
.REG_Set(Mcu_Enpc_set_Wire),
.REG_Data_InBUS(MuxC_Data_OutBUS_Wire),
//////////// OUTPUTS //////////
.REG_Data_OutBUS(Pc_Addr_OutBUS_Wire)

);



/* Program counter set enable signal generation*/
ENPC Enpc(

//////////// INPUTS //////////
.ENPC_Clk(CORE_Clk_In),
.ENPC_En(Mcu_Enpc_set_Wire),
.ENPC_Reset(Mcu_Enpc_reset_Wire),
//////////// OUTPUTS //////////,
.ENPC_Set_En(Enpc_Set_En)

);



ADDER #(.DATAWIDTH(DATAWIDTH)) Add0 (

//// inputs ////
.ADDER_A_inBUS(INSMEMSTEP),
.ADDER_B_inBUS(Pc_Addr_OutBUS_Wire),

//// output ////

.ADDER_Result_OutBUS(Add0_Rest_OutBUS_Wire)

);


ADDER #(.DATAWIDTH(DATAWIDTH)) Add1 (

//// inputs ////
.ADDER_A_inBUS(MuxB_Data_OutBUS_Wire),
.ADDER_B_inBUS(Imm_Generation_OutBUS_Wire),

//// output ////

.ADDER_Result_OutBUS(Add1_Rest_OutBUS_Wire)

);



MUX_2_1 #(.INPUT_DATA_WIDTH()) MuxB (

//////////// INPUTS //////////
.MUX_Input_0(Pc_Addr_OutBUS_Wire),
.MUX_Input_1(Alu_Data_OutBUS_Wire),
.MUX_Sel(Jcu_Mux_b_sel_wire),

//////////// OUTPUT //////////
.MUX_Output_OutBUS(MuxB_Data_OutBUS_Wire)

);



/*immediate generation unit*/

IMM_GEN   Imm_Generation(

.IMM_GEN_ins_InBUS(Iregister_OutBUS_Wire),
.IMM_GEN_Inmediate_OutBUS(Imm_Generation_OutBUS_Wire)

);


REG_FILE Register_File(

 /////// inputs ///////
.REG_FILE_Clk(CORE_Clk_In),
.REG_FILE_Reset_in(~Mcu_RegFile_Reset_Wire),
.REG_FILE_Write_En(Idu_RegFile_Write_Wire),
.REG_FILE_Data_InBUS(MuxD_Data_OutBUS_Wire),
.REG_FILE_R1_InBUS(Rs1_InBUS_Wire), 
.REG_FILE_R2_InBUS(Rs2_InBUS_Wire),
.REG_FILE_Rd_InBUS(Rd_InBUS_Wire),

 /////// Output ///////
.REG_FILE_Data1_OutBUS(Register_File_Data1_OutBUS_Wire),
.REG_FILE_Data2_OutBUS(Register_File_Data2_OutBUS_Wire)

);



WSIGNAL Wsignal(

///// inputs /////
.WSIGNAL_Clk(CORE_Clk_In),
.WSIGNAL_En(Idu_RegFile_Write_Wire),
///// outputs /////
.WSIGNAL_RegFile_Write(Wsignal_RegFile_Write)

);


/* Muxa instantiation*/

MUX_2_1 #(.INPUT_DATA_WIDTH()) MuxA (

//////////// INPUTS //////////
.MUX_Input_0(Register_File_Data2_OutBUS_Wire),
.MUX_Input_1(Imm_Generation_OutBUS_Wire),
.MUX_Sel(Idu_Alu_Select_Immediate_Mux_Wire),

//////////// OUTPUT //////////
.MUX_Output_OutBUS(MuxA_Data_OutBUS_Wire)

);

/*Alu Control Unit instatiation*/

ACU Acu(

//// inputs ////

.ACU_AluOP_InBUS(Idu_AluOp_OutBUS_Wire),
.ACU_Funt3_InBUS(Funct3_InBUS_Wire),
.ACU_Funt7_b5(Funct7_InBUS_Wire[5]), /*bit 5 of the funct7 field*/
.ACU_Opcode_b5(Opcode_InBUS_Wire[5]), /*bit 5 of the opcode field*/

//// outputs ///
.ACU_AluControl_OutBUS(Acu_AluControl_OutBUS_Wire)

);


/* Alu instantiation*/
ALU Alu(

/// inputs ///
.Operand_1(Register_File_Data1_OutBUS_Wire),
.Operand_2(MuxA_Data_OutBUS_Wire),
.Opcode(Acu_AluControl_OutBUS_Wire),

// outputs //
.Out(Alu_Data_OutBUS_Wire)

);



/*Jump control unit instatation*/
JCU Jcu(

//// inputs ////
.JCU_En(Idu_Not_Branch_Jump_Op_Wire),
.JCU_Opcode_b3(Opcode_InBUS_Wire[3]),

//// outputs ////
.JCU_Mux_b_sel(Jcu_Mux_b_sel_wire),
.JCU_Mux_c_sel(Jcu_Mux_c_sel_wire)

);


/*branch unit instatiation*/

BRU Bru(

///// inputs /////
.BRU_rs1_data_InBUS(Register_File_Data1_OutBUS_Wire),
.BRU_rs2_data_InBUS(Register_File_Data2_OutBUS_Wire),
.BRU_funct3_InBUS(Funct3_InBUS_Wire),
.BRU_bren(Idu_Bru_En_Wire),

///// outputs /////
.BRU_en(Bru_Muxc_En_Wire)

);

/*Mux c instantiation*/

MUX_2_1 #(.INPUT_DATA_WIDTH()) MuxC (

//////////// INPUTS //////////
.MUX_Input_0(Add0_Rest_OutBUS_Wire),
.MUX_Input_1(Add1_Rest_OutBUS_Wire),
.MUX_Sel(MuxC_sel_wire),

//////////// OUTPUT //////////
.MUX_Output_OutBUS(MuxC_Data_OutBUS_Wire)

);


/*Load/Store unit*/

LSU #(.DATAWIDTH(DATAWIDTH)) Lsu (

//// inputs ////

.LSU_MemData_InBUS(CORE_Datamem_Readdata_InBUS),
.LSU_Funct3_InBUS(Funct3_InBUS_Wire),
.LSU_Store(Opcode_InBUS_Wire[5]),
.LSU_En(Idu_Lsu_En_Wire),

//// output ////
.LSU_Byteenable_OutBUS(CORE_Datamem_Byteenable_OutBUS),
.LSU_Data_OutBUS(Lsu_Data_OutBUS_Wire)

);


MUX_4_1 #(.INPUT_DATA_WIDTH(DATAWIDTH)) Muxd(

//////////// INPUTS //////////
.MUX_Input_0(Alu_Data_OutBUS_Wire),
.MUX_Input_1(Lsu_Data_OutBUS_Wire),
.MUX_Input_2(Add1_Rest_OutBUS_Wire),
.MUX_Input_3(Add0_Rest_OutBUS_Wire),

.MUX_Sel_InBUS(Idu_RegFile_Mux_OutBUS_Wire),

//////////// OUTPUT //////////
.MUX_Output_OutBUS(MuxD_Data_OutBUS_Wire)


);


/*Main control unit*/
MCU Mcu(

///// inputs /////
.MCU_Clk(CORE_Clk_In),
.MCU_Reset(CORE_Reset_In),
.MCU_Insmem_Valid(CORE_Insmem_Valid_In),
.MCU_Datamem_Valid_In(CORE_Datamem_Valid_In),
.MCU_Datamem_Ready_In(CORE_Datamem_Ready_In),
.MCU_Opcode_InBUS(Opcode_InBUS_Wire),
///// outputs /////
.MCU_Internal_State(Mcu_State_Wire),
.MCU_Pc_Reset(Mcu_Pc_Reset_Wire), 
.MCU_Enpc_Set(Mcu_Enpc_set_Wire),
.MCU_Enpc_Reset(Mcu_Enpc_reset_Wire),
.MCU_Ir_Reset(Mcu_Ir_Reset_Wire),
.MCU_Ir_Set(Mcu_Ir_Set_Wire),
.MCU_RegFIle_Reset(Mcu_RegFile_Reset_Wire),
.MCU_Insmem_Ready(CORE_Insmem_Ready_Out),
.MCU_Datamem_Ready_Out(CORE_Datamem_Ready_Out),
.MCU_Datamem_Valid_Out(CORE_Datamem_Valid_Out)

);


/*Instruction decode unit instantiation*/

IDU IDU(

//// inputs ////
.IDU_Opcode_InBUS(Opcode_InBUS_Wire),
.IDU_Mcu_State(Mcu_State_Wire),

//// outputs ////

.IDU_Not_Branch_Jump_Op(Idu_Not_Branch_Jump_Op_Wire),
.IDU_RegFile_Mux_OutBUS(Idu_RegFile_Mux_OutBUS_Wire),
.IDU_RegFile_Write(Idu_RegFile_Write_Wire),
.IDU_AluOp_OutBUS(Idu_AluOp_OutBUS_Wire),
.IDU_Bru_En(Idu_Bru_En_Wire),
.IDU_Alu_Select_Immediate_Mux(Idu_Alu_Select_Immediate_Mux_Wire),
.IDU_Lsu_En(Idu_Lsu_En_Wire)

);


assign Core_Insmem_Addr_OutBUS = Pc_Addr_OutBUS_Wire;
assign CORE_Datamem_Addr_OutBUS = Alu_Data_OutBUS_Wire;
assign CORE_Datamem_Writedata_outBUS = Register_File_Data2_OutBUS_Wire;
assign MuxC_sel_wire = Jcu_Mux_c_sel_wire|Bru_Muxc_En_Wire;

assign Rs2_InBUS_Wire = Iregister_OutBUS_Wire[24:20];
assign Rs1_InBUS_Wire = Iregister_OutBUS_Wire[19:15];
assign Rd_InBUS_Wire = Iregister_OutBUS_Wire[11:7];
assign Opcode_InBUS_Wire = Iregister_OutBUS_Wire[6:0];
assign Funct7_InBUS_Wire = Iregister_OutBUS_Wire[31:25];
assign Funct3_InBUS_Wire = Iregister_OutBUS_Wire[14:12];







endmodule

