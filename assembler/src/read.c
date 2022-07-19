#include <stdio.h>
#include <stdlib.h>


int main(int argc, char const *argv[])
{

    FILE* fp;

    int buffer[100];


    fp=fopen("test.bin","rb");

    fread(buffer,4,6,fp);

    printf("%x\n",buffer[0]);
    
    return 0;
}
