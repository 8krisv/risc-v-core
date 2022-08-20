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

/* 
Linked list implementation and core functions
*/


#include <stdlib.h>
#include <string.h>
#include "../include/list.h"


/*push a new value at the front of the linked list*/
void push(list** head, char* lexeme, char type, int value, int line){

    list* new= (list*) malloc(sizeof(list*));
    
    new->lexeme=strdup(lexeme);
    new->type=type;
    new->value=value;
    new->line=line;

    new->next=*head;

    *head=new;

}


/*append a new value at the end of the list*/
list* append(list** head,  char* lexeme, char type, int value, int line){

    list* new= (list*) malloc(sizeof(list*));

    new->lexeme=strdup(lexeme);
    new->type=type;
    new->value=value;
    new->line=line;

    new->next=NULL;

    list* l= *head;

    if (l==NULL){
        *head=new;
        return new;
    }
    
    while (l->next!=NULL){
        l=l->next;
    }
    
    l->next=new;

    return new;

}

/*given a reference (pointer to pointer ) to a linked list, 
delete the first occurrence of key in the linked list*/

void delete_node_list(list** head, char* key){

    list* node = (*head);
    list* tmp = NULL;

    /*delete from the beginning*/

    int comp= strcmp(node->lexeme,key);


    /*node->lexeme=key*/
    if (comp == 0)   {
        (*head)=node->next;
        free(node->lexeme);
        free(node);
        return;
    }
    
    while (node->next != NULL && (comp=strcmp(node->next->lexeme,key)) != 0 ){
        /* code */
        node=node->next;
    }

    /*key was not present in linked list*/
    if (node->next==NULL){
        return;
    }
    
    tmp=node->next;
    node->next= node->next->next;
    free(tmp->lexeme);
    free(tmp);

}


void delete_list(list** head){

    list* current = (*head);
    list* tmp = NULL;

    while (current!=NULL){

        tmp = current->next; /* save the next node*/
        free(current->lexeme);
        free(current); /*free current node*/
        current=tmp; /*current is now the next node*/
    }
    *head=NULL; /* dereference true pointer*/

}

