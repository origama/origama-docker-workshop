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

* what is visible inside a container? We start from scratch (empty) adding only what we need, or we can add a full distro filesystem or we can mount specific parts of the filesystem in the overlay

* difference between a short-running process and a long running process
Short running:
```
docker run --rm busybox uname -a
```
Long running
* how to get logs from a running container

* twelve factors overview

```
docker 
```