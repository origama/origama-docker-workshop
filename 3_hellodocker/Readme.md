Run the following and observe the output:

```
docker run --rm hello-world
```

* how to list running containers

```
docker ps
```

* how to list exited and stopped containers
```
docker ps -a
```

* how to list local images
```
docker images
```

* how to delete containers and images

```
docker rm <containerid>
docker rmi <imageid>
```

* how to execute a command in a docker container

```
docker run --rm -it busybox uname -a
```

* how environment variables are used inside the container

```
docker run --rm -it hello-world
```

* how to run in readonly mode

```
docker run --rm -it hello-world
```