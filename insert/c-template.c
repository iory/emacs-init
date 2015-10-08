#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

void* ecMalloc(unsigned int size){
    void* ptr = malloc(size);
    if(ptr==NULL){
        printf("Memory Error\n");
        exit(-1);
    }
    return ptr;
}

int main(int argc, char *argv[]){

    return 0;
}
