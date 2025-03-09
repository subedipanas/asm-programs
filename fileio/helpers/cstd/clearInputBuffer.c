#include <stdio.h>

void clearInputBuffer() {
    int c;
    
    //  -1 for EOF
    while((c = getchar()) != '\n' && c != -1) {}
}