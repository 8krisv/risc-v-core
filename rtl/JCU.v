/*#########################################################################
//# Jump control unit 
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

module JCU(

//// inputs ////
JCU_En,
JCU_Opcode_b3,

//// outputs ////
JCU_Mux_b_sel,
JCU_Mux_c_sel

);

//============================================================
//  PORT DECLARATIONS
//============================================================
input  JCU_En;
input  JCU_Opcode_b3;
output JCU_Mux_b_sel;
output JCU_Mux_c_sel;

//============================================================
// COMBINATIONAL LOGIC
//============================================================

assign JCU_Mux_b_sel = JCU_En&(~JCU_Opcode_b3);
assign JCU_Mux_c_sel = JCU_En;

endmodule
