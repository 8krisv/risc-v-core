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


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "../include/bst.h"
#include "../include/utils.h"
#include "../include/list.h"
#include "../include/struct.h"


#define DEFSIZESYMTABLE 256
#define NUMERRORMSG 32
#define MAXSIZEERROR 128

static int _eror_buff_size=NUMERRORMSG;
static char _bufferror[MAXSIZEERROR]; /*buffer for error message*/


enum LEXEME_TYPE {LX_OP,LX_REG,LX_IMMEDIATE,LX_OFFSET,LX_LABEL_ASS,LX_LABEL_USE,LX_LABEL_UKNOWN};
enum OP_TYPE {R_TYPE, I_TYPE, S_TYPE, B_TYPE, U_TYPE, J_TYPE, STOP};


char get_funct7_r_type(char* opname){

    if (!strcmp(opname,"sub") | !strcmp(opname,"sra"))
    {
        return 0x20;
    }
    return 0x0;
};

char get_type_instruction(char opcode){

    if (opcode==0x33){
        return R_TYPE;
    }

    else if (opcode==0x13 |opcode==0x03 |opcode==0x67){
        return I_TYPE;
    }

    else if (opcode==0x23 ){
        return S_TYPE;
    }
    
    else if (opcode == 0x63){
        return B_TYPE;
    }
    else if (opcode==0x6f)
    {
        return J_TYPE;
    }
    else if(opcode==0x0f){
        return STOP;
    }
    else{
        return U_TYPE;
    }
}



static bst* load_ops_bst(void){

    op_data_struct** ops_data = malloc(sizeof(op_data_struct*)*NUM_OPS);
    bst* ops_bst;

    for (int i = 0; i < NUM_OPS; i++){
        /* code */
        ops_data[i]=malloc(sizeof(op_data_struct));
        ops_data[i]->index=i;

    }

    /*make balanced binary search tree of operations lexemes*/
    ops_bst= balanced_tree(OP_LEXEMES,(void**)ops_data,0,NUM_OPS-1);
   
    free(ops_data);
    return ops_bst;
}

static bst* load_regs_bst(){

    bst* regs_bst;
    
    regs_bst=balanced_tree(REGISTER_NAMES,NULL,0,31);

    return regs_bst;
}

int get_immediate(char* str, char* enptr, int base, int* number){

    *number = strtol(str, &enptr, base);

    if(*enptr=='\0'){
        return 1;  
    }
    return 0;
}

int get_offreg_format(char* token,int* number, char** str){

    int j=0;

    int start = 0;
    int end=strlen(token)-1;
    char* enptr;

    if (token[end]!=')'){
        return 0;
    }
    
    while (token[j]!='\0'){    
    
        if (token[j]=='('){
            start=j;
            break;
        }
        j++;
    }

    if (start == 0 ){
        return 0;
    }

    *number = strtol(token, &enptr, 10);
    
    if(*enptr!=token[start]){
        return 0;
    }

    token[end]='\0';
    *str = strdup(&token[start+1]);
    token[end]=')';

    return 1;

};



static list* get_row_sym_table( bst* ops_bst, bst* regs_bst,bst** label_bst, char *line, int* compile_line ,int* text_line, char** stderr_buff, int* nerror ){

    int i;
    list* row = NULL;
    char* token = NULL;
    bst* node =NULL;
    char* save_pointer;
    const char delimiter[]=" \t\n";

    char* linecopy=strdup(line);
    char* label=NULL;
    int immediate;
    char* enptr;
    char* reg;
         
    token = strtok_r(linecopy,delimiter,&save_pointer);


    i=0;
    while (token!=NULL) {
            
        /*start a comment*/
        if (token[0]=='#'){    
            break;
        }

       
        /*first token of the new line*/
        if (i==0){


            node = search_node(ops_bst,token);
                        
            /*token is a function*/
            if (node!=NULL){
                append(&row,token,LX_OP,((op_data_struct*)node->data)->index,*text_line);
            }

             /*token is a label asignation*/

            else if(token[strlen(token)-1]==':'){

                label=strdup(token);
                label[strlen(token)-1]='\0';
                
                if ((node=search_node(*label_bst,label)) != NULL){
                    /*multiple label assignation*/

                    if (*nerror <_eror_buff_size){
                        sprintf(_bufferror,"Error: multiple assignations of label %s at line %d and line %d\n",label,
                        ((list*)node->data)->line,*text_line);
                        stderr_buff[*nerror]=strdup(_bufferror);
                        *nerror=*nerror+1;
                    }    
                }
                else {
                    list* new_label = append(&row,label,LX_LABEL_ASS,*compile_line,*text_line);
                    *label_bst=insert_node(*label_bst,new_label->lexeme,(void*)new_label);
                    *compile_line= *compile_line-1;
                }
                free(label);
            }

            else{
               if (*nerror <_eror_buff_size){
                sprintf(_bufferror,"Error: uknown operation %s at line %d\n",token,*text_line);
                stderr_buff[*nerror]=strdup(_bufferror);
                stderr_buff[*nerror]=strdup(_bufferror);
                *nerror=*nerror+1;
               }
            }
        }

        else{
            
            node =search_node(regs_bst,token);

            /*token is a register*/
            if (node!=NULL){
                sscanf(token,"%*c%d",&immediate);
                append(&row,token,LX_REG,immediate,*text_line);
            }

            /*immediate base 10*/
            else if(get_immediate(token,enptr,10,&immediate)){  
                append(&row,token,LX_IMMEDIATE,immediate,*text_line);
            }

            /*immediate base 16*/
            else if (get_immediate(token,enptr,16,&immediate)){  
          
                append(&row,token,LX_IMMEDIATE,immediate,*text_line);
             
            }

            /*empieza el problema*/
            else if(get_offreg_format(token,&immediate,&reg)){
                

                node = search_node(regs_bst,reg);

                if (node!=NULL){
                    append(&row,"OFFSET",LX_OFFSET,immediate,*text_line);
                    sscanf(reg,"%*c%d",&immediate);
                    append(&row,reg,LX_REG,immediate,*text_line);
                }

                else{
                    append(&row,token,LX_LABEL_UKNOWN,0,*text_line);
                }

                free(reg);
            }

            else{
                append(&row,token,LX_LABEL_UKNOWN,0,*text_line);
            }
                
        }

        token = strtok_r(NULL,delimiter,&save_pointer);
        i++;
    }

    free(linecopy);
    *compile_line= *compile_line+1;
    return row;   
}


int is_space(char c){
    if(c==' ' | c=='\t'){
        return 1;
    }
    return 0;
}



static list** lexical_analysis(FILE* fp, bst* ops_bst, bst* regs_bst, bst** label_bst, char** stderr_buff){

   
    char *line = NULL;  /*char pointer to the read line*/
    size_t len = 0; /*len of the read line*/

    list** symbol_table = malloc(sizeof(list*)*DEFSIZESYMTABLE);


    int compile_line=0;
    int text_line=0;
    int nerror=0;
    int i=0;
    int j=0;
    
    while (getline(&line,&len,fp)!=-1){
        
        text_line++;
        j=0;
        
        /*remove leading whitespace*/
        while (is_space(line[j])){
            j++;
        }

        /*blank line or comment */
        if (line[j]=='\n' | line[j]=='#'){
            continue;
        }
       
        symbol_table[i]=get_row_sym_table(ops_bst,regs_bst,label_bst,&line[j],&compile_line,&text_line,stderr_buff,&nerror);

        i++;
    }

    free(line);

    symbol_table[i]=NULL;
    
    return symbol_table;
}


void print_list(list* head){

    if (head==NULL){
        return;
    }

    printf("Lexeme:%s\n",head->lexeme);

    switch (head->type)
    {
        case 0:
        printf("Type:%s\n","LX_OP");
        break;

        case 1:
        printf("Type:%s\n","LX_REG");
        break;
    
        case 2:
        printf("Type:%s\n","LX_IMMEDIATE");
        break;
    
        case 3:
        printf("Type:%s\n","LX_OFFSET");
        break;
    
        case 4:
        printf("Type:%s\n","LX_LABEL_ASS");
        break;

        case 5:
        printf("Type:%s\n","LX_LABEL_USS");
        break;

        default:
        printf("Type:%s\n","LX_LABEL_UKNOWN");
        break;
    }

    printf("Value:%d\n",head->value);
    printf("Line:%d\n\n",head->line);


    print_list(head->next);
}


void print_sym_table(list** sym_table){
  
  for (int i = 0; sym_table[i]!=NULL; i++){

        printf("---------------- TABLE ROW %d ----------------\n",i);
        print_list(sym_table[i]);
    }
}



void error(char** stderr_buff){
    if (stderr_buff[0]!=NULL){
        for (int i = 0;stderr_buff[i]!=NULL ; i++){
            fprintf(stderr,"%s",stderr_buff[i]);
        }
        exit(EXIT_FAILURE);
    }
}



void get_op_format(int opcode,char* format){

    switch (opcode)
    {
    case 0x13: //0010011
        format[0]=LX_REG;
        format[1]=LX_REG;
        format[2]=LX_IMMEDIATE;
        format[3]='\0';
        break;

    
    case 0x33: //0110011
        format[0]=LX_REG;
        format[1]=LX_REG;
        format[2]=LX_REG;
        format[3]='\0';
        break;

    case 0x03: //0000011
        format[0]=LX_REG;
        format[1]=LX_OFFSET;
        format[2]=LX_REG;
        format[3]='\0';
        break;

    
    case 0x23: //0100011
        format[0]=LX_REG;
        format[1]=LX_OFFSET;
        format[2]=LX_REG;
        format[3]='\0';
        break;

    case 0x63: //1100011
        format[0]=LX_REG;
        format[1]=LX_REG;
        format[2]=LX_LABEL_USE;
        format[3]='\0';
        break;

    case 0x67: //1100111 jalr
        format[0]=LX_REG;
        format[1]=LX_OFFSET;
        format[2]=LX_REG;
        format[3]='\0';
        break;

    case 0x6f: //1101111 jal
        format[0]=LX_REG;
        format[1]=LX_LABEL_USE;
        format[2]='\0';
        format[3]='\0';
        break;

    case 0x17: //0010111 auipc
        format[0]=LX_REG;
        format[1]=LX_IMMEDIATE;
        format[2]='\0';
        format[3]='\0';
        break;

    case 0x37: //0110111 lui
        format[0]=LX_REG;
        format[1]=LX_IMMEDIATE;
        format[2]='\0';
        format[3]='\0';
        break;

    case 0x0f: //  $stop
        format[0]='\0';
        format[1]='\0';
        format[2]='\0';
        format[3]='\0';
        break;

    default:
        break;
    }

}


list** syntax_analysis(list** sym_table,bst* label_bst,char** stderr_buff,int* compile_line){

    char format[4];
    bst* node;
    list* next;
    int j;
    int nerror=0;
    
    for (int i = 0; sym_table[i]!=NULL; i++){
     
        if (sym_table[i]->type == LX_OP)
        {
           // printf("OP:%s\n",sym_table[i]->lexeme);

            j=0;
            get_op_format(OP_OPCODES[sym_table[i]->value],format);

            //printf("FORMAT:%d,%d,%d,%d\n",format[0],format[1],format[2],format[3]);

            next=sym_table[i]->next;

            while (format[j]!='\0' && next!=NULL){

                //printf("j=%d,format=%d,type=%d\n",j,format[j],next->type);

                if (format[j]==LX_LABEL_USE && next->type==LX_LABEL_UKNOWN){
                    
                    node= search_node(label_bst,next->lexeme);
                    
                    if (node!=NULL){
                        next->type=LX_LABEL_USE;
                        next->value=((list*)(node->data))->value - *compile_line;
                    }

                    else{
                       sprintf(_bufferror,"Error at line %d uknown label %s\n",sym_table[i]->line,next->lexeme);
                        
                        if (nerror<_eror_buff_size){
                            stderr_buff[nerror]=strdup(_bufferror);
                            nerror++;
                        }
                    }

                }

                else if(format[j]!=next->type){
                    break;
                }
                
                j++;
                next=next->next;
            }

            if (format[j]=='\0' && next==NULL){
                *compile_line= *compile_line+1;
                continue;
            }/* condition */
            else{
                sprintf(_bufferror,"Error at line %d invalid syntax of the instruction %s\n",sym_table[i]->line,sym_table[i]->lexeme);
                if (nerror<_eror_buff_size){
                    stderr_buff[nerror]=strdup(_bufferror);
                    nerror++;
                }

            }
            
        }
        else{
            continue;
        }
        
    }
    /* condition */
    return sym_table;
}



int get_compiled_instruction(list* head){

    int comp;

    int type = get_type_instruction(OP_OPCODES[head->value]);


    if (type==R_TYPE){
   
        union r_type instruction_r;

        instruction_r.rstruct.opcode=OP_OPCODES[head->value];
        instruction_r.rstruct.rd=head->next->value;
        instruction_r.rstruct.funct3=OP_FUNCT3[head->value];
        instruction_r.rstruct.rs1=head->next->next->value;
        instruction_r.rstruct.rs2=head->next->next->next->value;
        instruction_r.rstruct.funct7=get_funct7_r_type(head->lexeme);

        return instruction_r.instruction;
    }

    else if (type==I_TYPE){

        union i_type instruction_i;

        /*load instructions*/

        instruction_i.istruct.opcode =OP_OPCODES[head->value];
        instruction_i.istruct.rd =  head->next->value;
        instruction_i.istruct.funct3 =OP_FUNCT3[head->value];


        /*load instructions or jalr instruction*/
        if (head->lexeme[0]=='l' | head->lexeme[0]=='j'){
            /* code */
            instruction_i.istruct.rs1=head->next->next->next->value;
            instruction_i.istruct.immediate_11_0=head->next->next->value&0x00000fff;
        }

        //slli, srli ,srai
        
        else if (head->lexeme[0]=='s'){

         
            instruction_i.istruct.rs1=head->next->next->value;

            //srai
            if (head->lexeme[2]=='a'){
                instruction_i.istruct.immediate_11_0=(head->next->next->next->value&0x0000001f)+ 0x00000400;
            }
            else{
                instruction_i.istruct.immediate_11_0=head->next->next->next->value&0x0000001f;
            }
        }

        else{

            instruction_i.istruct.rs1=head->next->next->value;    
            instruction_i.istruct.immediate_11_0=head->next->next->next->value&0x00000fff;
        }
        return instruction_i.instruction;
    }

    else if (type==S_TYPE){
     
        union s_type instruction_s;

        instruction_s.struct_s.opcode=OP_OPCODES[head->value];
        instruction_s.struct_s.immediate_4_0=  head->next->next->value&0x0000001f;
        instruction_s.struct_s.funct3=OP_FUNCT3[head->value];
        instruction_s.struct_s.rs1=head->next->next->next->value;
        instruction_s.struct_s.rs2=head->next->value;
        instruction_s.struct_s.immediate_11_5=((head->next->next->value&0x00000fe0)>>5);

        return instruction_s.instruction;

    }

    else if (type==B_TYPE) {

        union b_type instruction_b;

        instruction_b.bstruct.opcode=OP_OPCODES[head->value];
        instruction_b.bstruct.immediate_11=(((head->next->next->next->value*4)&0x00000800)>>11);
        instruction_b.bstruct.immediate_4_1=(((head->next->next->next->value*4)&0x0000001e)>>1);
        instruction_b.bstruct.funct3=OP_FUNCT3[head->value];
        instruction_b.bstruct.rs1=head->next->value;
        instruction_b.bstruct.rs2=head->next->next->value;
        instruction_b.bstruct.immediate_10_5=(((head->next->next->next->value*4)&0x000007e0)>>5);
        instruction_b.bstruct.immediate_12=(((head->next->next->next->value*4)&0x00001000)>>12);

        return instruction_b.instruction;
    }

    else if(type==U_TYPE){

        union u_type instruction_u;

        instruction_u.ustruct.opcode=OP_OPCODES[head->value];
        instruction_u.ustruct.rd=head->next->value;
        instruction_u.ustruct.immediate_31_12=((head->next->next->value&0xfffff000)>>12);

        return instruction_u.instruction;
    }
   
    else if (type==J_TYPE){
        union j_type instruction_j;
     
        instruction_j.jstruct.opcode=OP_OPCODES[head->value];
        instruction_j.jstruct.rd=head->next->value;
        instruction_j.jstruct.immediate_19_12=(((head->next->next->value*4)&0x000ff000)>>12);
        instruction_j.jstruct.immediate_11=(((head->next->next->value*4)&0x00000800)>>11);
        instruction_j.jstruct.immediate_10_1=(((head->next->next->value*4)&0x000007fe)>>1);
        instruction_j.jstruct.immediate_20=(((head->next->next->value*4)&0x00100000)>>20);
        
        return instruction_j.instruction;

    }

    //STOP
    else{
        
        union i_type instruction_i;

        instruction_i.istruct.opcode = 0x13;
        instruction_i.istruct.rd =  31;
        instruction_i.istruct.funct3 = 0x00;
        instruction_i.istruct.rs1=0;    
        instruction_i.istruct.immediate_11_0=-1;

        return instruction_i.instruction;
    }
}

void compile(list** sym_table, int size){

    int* compile_instructions = malloc(sizeof(int)*size);

    for (int i = 0, j=0; sym_table[i]!=NULL; i++){
               
        if (sym_table[i]->type==LX_LABEL_ASS){
            continue;
        }
        
        compile_instructions[j]=get_compiled_instruction(sym_table[i]);

        j++;
    }

    FILE *bin;
    bin = fopen("test.bin","wb");
    fwrite(compile_instructions,sizeof(int),size,bin);
    fclose(bin);
}


int main(int argc, char const *argv[]){

    bst* ops_bst = NULL;
    bst* regs_bst  = NULL;
    bst* label_bst  = NULL;
    char** stderr_buff =malloc(sizeof(char*)*_eror_buff_size); // error buffer
    int ninstr=0;

    FILE* fp;

    if (argc < 2){
        fprintf(stderr,"Please provide a source code!\n");
        exit(EXIT_FAILURE);
    }

    fp=fopen(argv[1],"r");

    /*if fopen return a null pointer there was a problem reading the file*/
    if (fp==NULL){
        /* code */
        perror("Error");
        exit(EXIT_FAILURE);
    }

    /*loading op lexemes and regs name in a binary search tree for time complexity  O(logn) in searches*/
    ops_bst=load_ops_bst();
    regs_bst=load_regs_bst();

    /*lexical analysis stage*/
    list** sym_table=lexical_analysis(fp,ops_bst,regs_bst,&label_bst,stderr_buff);
    /*there was one or more errors in the lexical analysis stage*/
    error(stderr_buff);


    /*syntax and semantic analysis stage*/
    sym_table=syntax_analysis(sym_table,label_bst,stderr_buff,&ninstr);
    /*there was one or more errors in the sintax analysis stage*/
    error(stderr_buff);

    

    /*compilation stage*/
    compile(sym_table,ninstr);

    printf("Successful compilation!\n");

    
    fclose(fp);
    free(stderr_buff);
    
    exit(EXIT_SUCCESS);
  
  
}
