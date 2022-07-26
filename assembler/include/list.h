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


#ifndef LIST
#define LIST


typedef struct list{
    char* lexeme;
    char type;
    int line;
    int value;
    struct list* next;
}list;

void push(list** head, char* lexeme, char type, int value, int line);
list* append(list** head,  char* lexeme, char type, int value, int line);
void delete_node_list(list** head, char* key);
void delete_list(list** head);

#endif