#include <stdio.h>

int foo() {
    int a = 0;
    for(int i = 0; i < 100000; i++) {
        a += 1;
    }
    return a;
}

int main() {
    foo();
    return 0;
}