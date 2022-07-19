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

#ifndef STRUCT
#define STRUCT

/*struct declarations for all instruction's type*/

typedef struct r_struct{
  
    int opcode:7;
    int rd:5;
    int funct3:3;
    int rs1:5;
    int rs2:5;
    int funct7:7;
        
}r_struct;

typedef struct i_struct{
  
    int opcode:7;
    int rd:5;
    int funct3:3;
    int rs1:5;
    int immediate_11_0:12;
}i_struct;

typedef struct s_struct{
  
    int opcode:7;
    int immediate_4_0:5;
    int funct3:3;
    int rs1:5;
    int rs2:5;
    int immediate_11_5:7;

}s_struct;

typedef struct b_struct{
  
    int opcode:7;
    int immediate_11:1;
    int immediate_4_1:4;
    int funct3:3;
    int rs1:5;
    int rs2:5;
    int immediate_10_5:6;
    int immediate_12:1;
    
}b_struct;

typedef struct u_struct{
  
    int opcode:7;
    int rd:5;
    int immediate_31_12:20;
    
}u_struct;

typedef struct j_struct{
  
    int opcode:7;
    int rd:5;
    int immediate_19_12:8;
    int immediate_11:1;
    int immediate_10_1:10;
    int immediate_20:1;
    
}j_struct;

/*union data structure*/

union r_type{
    r_struct rstruct;
    int instruction;
};

union i_type{
    i_struct istruct;
    int instruction;
};

union s_type{
    s_struct struct_s;
    int instruction;
};

union b_type{
    b_struct bstruct;
    int instruction;
};

union u_type{
    u_struct ustruct;
    int instruction;
};

union j_type{
    j_struct jstruct;
    int instruction;
};

#endif
