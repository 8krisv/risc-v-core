/*#########################################################################
//# Register file write signal generator test bench
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

module WSIGNAL_tb();

//////////// Input signals declarations ////////////

reg tb_clk_50;
reg tb_en;

wire Wsignal_Write;

/* Device Under Test (DUT) instantiation */
WSIGNAL Wsignal(

///// inputs /////
.WSIGNAL_Clk(tb_clk_50),
.WSIGNAL_En(tb_en),
///// outputs /////
.WSIGNAL_RegFile_Write(Wsignal_Write)

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
	tb_en<=1'b0;
	@(posedge tb_clk_50)
	@(negedge tb_clk_50)
	tb_en<=1'b1;
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	tb_en<=1'b0;
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	
		
	$stop;
	
end


endmodule

