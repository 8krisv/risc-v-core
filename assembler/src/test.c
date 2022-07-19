#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>


typedef struct r_struct{
  
    int opcode:7;
    int rd:5;
    int funct3:3;
    int rs1:5;
    int rs2:5;
    int funct7:7;
        
}r_struct;

union data_r{
    r_struct rstruct;
    int instruction;
};




int main(int argc, char const *argv[]){
    
    
    int n=8;



    printf("%ld\n",strlen("hola"));



    return 0;
  

}
