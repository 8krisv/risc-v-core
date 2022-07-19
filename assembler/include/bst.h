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

#ifndef BST
#define BST

#include <stdlib.h>
#include <string.h>
#include <stdio.h>


/*binary tree structure*/
typedef struct bst{
  
    char* key;
    void* data; /*pointer to data structure*/
    struct bst* left;
    struct bst* right;

}bst;

/*function prototypes*/
bst* insert_node(bst* root, char* key, void* data_ptr);
bst* search_node(bst* root, char* key);
bst* delete_node_tree(bst* root, char* key, void (*free_data)(void*));
void delete_tree (bst** bst,void (*free_data)(void*));
bst* balanced_tree(char** key,void** data, int start, int end);
void inorder(bst* root);


#endif