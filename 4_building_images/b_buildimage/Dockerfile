FROM ubuntu
copy helloworld.c /
RUN apt update && apt install gcc -y && gcc /helloworld.c -o /hello
CMD [ "/hello" ]