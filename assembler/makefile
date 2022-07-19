
INCLUDE= include
BIN= bin
SRC = src
OBJ= obj

output: $(OBJ)/main.o $(OBJ)/list.o $(OBJ)/bst.o
	gcc $(OBJ)/main.o $(OBJ)/list.o $(OBJ)/bst.o -o $(BIN)/asm

$(OBJ)/main.o: $(SRC)/main.c $(INCLUDE)/struct.h $(INCLUDE)/utils.h
	gcc -c $(SRC)/main.c -o $(OBJ)/main.o

$(OBJ)/list.o: $(SRC)/list.c $(INCLUDE)/list.h
	gcc -c $(SRC)/list.c -o $(OBJ)/list.o

$(OBJ)/bst.o: $(SRC)/bst.c $(INCLUDE)/bst.h
	gcc -c $(SRC)/bst.c -o $(OBJ)/bst.o

clean:
	rm $(OBJ)/*.o 