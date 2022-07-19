/*#########################################################################
//# Program counter set enable signal generation
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

module ENPC_tb();

//////////// Input signals declarations ////////////

reg tb_clk_50;
reg tb_reset;
reg tb_en;

wire Enpc_set_en;

/* Device Under Test (DUT) instantiation */

ENPC Enpc(

//////////// INPUTS //////////
.ENPC_Clk(tb_clk_50),
.ENPC_En(tb_en),
.ENPC_Reset(tb_reset),
//////////// OUTPUTS //////////,
.ENPC_Set_En(Enpc_set_en)

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
	tb_en<=1'b0;
	@(negedge tb_clk_50)
	@(posedge tb_clk_50)
	tb_reset<=1'b1;
	tb_en<=1'b1;
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	
		
	$stop;
	
end

endmodule
