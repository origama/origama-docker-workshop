#Build an image

## The program
Let's imagine we have a "complex" program to be run in the container like the following:

```c
#include<stdio.h>

int main(void) {
    printf("Hello World\n");
    return 0;
}
```