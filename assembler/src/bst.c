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
binary search tree data structure implementation and core functions
*/

#include "../include/bst.h"

/*static function prototypes*/
static bst* _new_node(char* key, void* data_ptr);


static bst* _new_node(char* key, void* data_ptr){

    bst* node = malloc(sizeof(bst));
    node->key=key;
    node->data=data_ptr;
    node->left=node->right=NULL;
}


bst* insert_node(bst* root, char* key, void* data_ptr){

    int comp;

    if (root==NULL){
        return _new_node(key,data_ptr);
    }

    comp=strcmp(root->key,key);

    /*root->key < key*/
    if (comp<0){
      root->right=insert_node(root->right,key,data_ptr);  
    }

    /*root->key > key*/
    else if (comp>0){
        root->left=insert_node(root->left,key,data_ptr);  
    }

    return root;
}


bst* search_node(bst* root, char* key){

    int comp;

    if (root!=NULL)  {
       comp=strcmp(root->key,key);
    }
    
    /*root->key = key*/
    if (comp==0 | root == NULL){

        return root;
    }

    /*root->key > key*/
    else if (comp > 0){
        return search_node(root->left,key);
    }

    /*root->key < key*/
    else{
        return search_node(root->right,key);
    }
}



bst* delete_node_tree(bst* root, char* key, void (*free_data)(void*)){
    
    int comp;

    if (root== NULL){
        return root;
    }
    
    comp=strcmp(root->key,key);

    /*root->key < key*/
    if (comp<0) {
        root->right=delete_node_tree(root->right,key,free_data);
        return root; 
    }
    
    /*root->key > key*/
    else if (comp>0){
        root->left=delete_node_tree(root->left,key,free_data);
        return root;
    }

    // key value = root->key, so we have positionated in the node 
    // thet we want to delete

    else{

        /*if the node has only one child or no child */
        if (root->left==NULL){
            bst* tmp=root->right;
            
            if (free_data!=NULL){
                free_data(root->data); /*free data field*/
            }     
            free(root);  
            return tmp;
        }
        
        else if(root->right==NULL){
            bst* tmp=root->left;
            if (free_data!=NULL){
                free_data(root->data); /*free data field*/
            }   
            free(root);     
            return tmp;
        }

        /*the node has two children*/

        else{

            bst* succParent = root;
            bst* succ = root->right;

            /*finding the inorder sucesor*/

            while (succ->left != NULL){
                /* code */
                succParent=succ;
                succ=succ->left;
            }
            
            if (succParent!=root){
                succParent->left=succ->right;
            }
            else{
                // is succParent = root, root has only two children
                succParent->right = succ->right;
            }
            
            root->key=succ->key; /*change data*/
            root->data=succ->data;

            if (free_data!=NULL){
                free_data(root->data); /*free data field*/
            }   
            free(succ);

            return root;
        }
    }
}


static void _delete_tree(bst* node,void (*free_data)(void*)){

    if (node==NULL){
        return;
    }

    /*traverse the tree in postorder*/
    _delete_tree(node->left,free_data);
    _delete_tree(node->right,free_data);
    
    if (free_data!=NULL){
            free_data(node->data); /*free data field*/
    }   
    free(node);
}



/*function that construct a balanced binary search tree
from sorted array*/

bst* balanced_tree(char** key,void** data, int start, int end){

    
    if (start>end){
        return NULL;
    }
    
    int mid = (start+end)/2;
    bst* root=NULL;

    /*get the middle element and make it root*/

    if (data!=NULL){
       root = _new_node(key[mid],data[mid]);
    }

    else{
        root = _new_node(key[mid],NULL);
    }
    
    root->left=balanced_tree(key,data,start,mid-1);
    root->right=balanced_tree(key,data,mid+1,end);
   
    return root;

}


void delete_tree (bst** bst,void (*free_data)(void*) ){

    _delete_tree(*bst, free_data);
    *bst=NULL; /*change the bst pointer to null*/
}


void inorder(bst* root){
    
    if (root!=NULL){
        inorder(root->left);
        printf("%s\n",root->key);
        inorder(root->right);
    }
}




