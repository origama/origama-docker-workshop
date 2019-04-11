Single process

Let's imagine we have a complicated program to be run in the container like the following:

```c
#include<stdio.h>

int main(void) {
    printf("Hello World\n");
    return 0;
}
```

Let's compile it and try it out:

```bash
gcc helloworld.c -o hello
chmod +x hello
./hello
```

Cool, it works, now let's build an image 

```
docker build . -f $(pwd)/Dockerfile_ubuntu
```

and now let's run it

```
docker --rm run 
```