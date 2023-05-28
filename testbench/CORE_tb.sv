/*#########################################################################
//# Testbench for RISC-V Core
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

`timescale 1 ns/10 ps

module CORE_tb();


//////////// Parameter declarations ////////////

parameter DATAWIDTH=32;
parameter INS_MEM_ADDR_WIDTH=10;
parameter DATA_MEM_ADDR_WIDTH=10;
parameter PROGRAMPATH = "../testcases/collatz.bin";


//////////// counter declaration ////////////
reg unsigned [31:0] Clock_Cycle_Counter= 32'h00000000;
localparam [31:0] Clock_Cycle_Limit = 32'h00001388; // 5000

//////////// Input signals declarations ////////////

reg tb_clk_50;
reg tb_reset;

//////////// Output signals declarations ////////////

wire core_isnsmem_read;
wire [DATAWIDTH-1:0] core_isnsmem_addr_outbus;
wire core_datamem_read;
wire core_datamem_write;
wire [3:0] core_byteenable_outbus;
wire [DATAWIDTH-1:0] core_writedata_outbus;
wire [DATAWIDTH-1:0] core_datamem_addr_outbus;
wire [DATAWIDTH-1:0] ins_mem_data_outbus;
wire ins_mem_read_valid;
wire ins_mem_write_ready;
wire [DATAWIDTH-1:0] data_mem_data_outbus;
wire data_mem_read_valid;
wire data_mem_write_ready;


/* Device Under Test (DUT) instantiation */

CORE #(.RESET_ADDR(32'h0000_0000)) RiscCore(


///// Clk/Reset ////
.CORE_Clk_In(tb_clk_50),
.CORE_Reset_In(tb_reset),


///// Instruction memory interface ////
.CORE_Insmem_Ready_Out(core_isnsmem_read),
.CORE_Insmem_Valid_In(ins_mem_read_valid),
.Core_Insmem_Addr_OutBUS(core_isnsmem_addr_outbus),
.CORE_Insmem_Readdata_InBUS(ins_mem_data_outbus),



///// Data memory interface ////
.CORE_Datamem_Ready_Out(core_datamem_read),
.CORE_Datamem_Valid_In(data_mem_read_valid),
.CORE_Datamem_Readdata_InBUS(data_mem_data_outbus),
.CORE_Datamem_Valid_Out(core_datamem_write),
.CORE_Datamem_Ready_In(data_mem_write_ready),
.CORE_Datamem_Writedata_outBUS(core_writedata_outbus),
.CORE_Datamem_Addr_OutBUS(core_datamem_addr_outbus),
.CORE_Datamem_Byteenable_OutBUS(core_byteenable_outbus)

);



/*Instuction memory instantiation*/

INS_MEM #(.ADDR_WIDTH(INS_MEM_ADDR_WIDTH), .BINPATH(PROGRAMPATH)) ins_mem
(
//////////// INPUTS //////////
.INS_MEM_Clk(tb_clk_50),
.INS_MEM_Re(core_isnsmem_read),
.INS_MEM_We(1'b0),
.INS_MEM_Address(core_isnsmem_addr_outbus[INS_MEM_ADDR_WIDTH-1:0]), 
.INS_MEM_Data_In(32'h00000000),

//////////// OUTPUT //////////
.INS_MEM_Data_Out(ins_mem_data_outbus),
.INS_MEM_Read_Valid(ins_mem_read_valid),
.INS_MEM_Write_Ready(ins_mem_write_ready)


);



/*Data memory instantiation*/

DATAMEM #(.ADDR_BITWIDTH(DATA_MEM_ADDR_WIDTH)) data_mem
(
//////////// INPUTS //////////
.DATAMEM_Clk(tb_clk_50),
.DATAMEM_We(core_datamem_write),
.DATAMEM_Re(core_datamem_read),
.DATAMEM_Byteenable(core_byteenable_outbus),
.DATAMEM_Address(core_datamem_addr_outbus[DATA_MEM_ADDR_WIDTH-1:0]), 
.DATAMEM_Data_In(core_writedata_outbus),

//////////// OUTPUT //////////
.DATAMEM_Data_Out(data_mem_data_outbus),
.DATAMEM_Read_Valid(data_mem_read_valid),
.DATAMEM_Write_Ready(data_mem_write_ready)
);




//////////// create a 50Mhz clock //////////
always
begin
		tb_clk_50=1'b1;
		#10;
		tb_clk_50=1'b0;
		#10;
end



initial
begin

	tb_reset<=1'b0;
	@(negedge tb_clk_50)
	@(posedge tb_clk_50)
	tb_reset<=1'b1;

	for(integer i =0; CORE_tb.RiscCore.Register_File.Reg31_Output != 32'hffffffff ;i=i+1)
	begin
		@(posedge tb_clk_50)
		Clock_Cycle_Counter<=Clock_Cycle_Counter + 32'h00000001;
		if(Clock_Cycle_Counter ==Clock_Cycle_Limit )begin
			$display("Warning clock cycles limit has been reached");
			break;
		end
		
	end

	$display("Total clock cycles: %d",Clock_Cycle_Counter);
	
	$stop;
	
end

endmodule
