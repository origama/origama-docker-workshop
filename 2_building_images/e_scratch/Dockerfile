FROM ubuntu as buildstage
copy helloworld.c /
RUN apt update && apt install gcc -y && gcc /helloworld.c -o /hello

FROM scratch
COPY --from=buildstage /hello /hello
CMD [ "/hello" ]