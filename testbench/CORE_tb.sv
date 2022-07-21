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
parameter PROGRAMPATH = "../testcases/test.bin";


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
wire [DATAWIDTH-1:0] data_mem_data_outbus;
wire data_mem_request_ready;


/* Device Under Test (DUT) instantiation */

CORE #(.DATAWIDTH(DATAWIDTH)) RiscCore(

///// inputs /////

.CORE_Clk_in(tb_clk_50),
.CORE_Reset_in(tb_reset),
.CORE_Insmem_Readdata_InBUS(ins_mem_data_outbus),
.CORE_Datamem_Readdata_InBUS(data_mem_data_outbus),

//// outputs ////

.CORE_Insmem_Read(core_isnsmem_read),
.Core_Insmem_Addr_OutBUS(core_isnsmem_addr_outbus),
.CORE_Datamem_Read(core_datamem_read),
.CORE_Datamem_Write(core_datamem_write),
.CORE_Datamem_Byteenable_OutBUS(core_byteenable_outbus),
.CORE_Datamem_Writedata_outBUS(core_writedata_outbus),
.CORE_Datamem_Addr_OutBUS(core_datamem_addr_outbus)
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
.INS_MEM_Data_Out(ins_mem_data_outbus)
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
.DATAMEM_Data_Out(data_mem_data_outbus)
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
