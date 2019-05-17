# Deploy our first service

The first service we will deploy is going to be a visualization dashboard: [swarm-viz](https://github.com/dockersamples/docker-swarm-visualizer)

```
#ssh to one of the master nodes
docker service create \
    --name=viz \
    --publish=9090:8080/tcp \
    --constraint=node.role==manager \
    --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
    dockersamples/visualizer
```

You can check if the deployment worked by running:
```
docker service ls
```

and you can take alook at the service's tasks
```
docker service ps viz
```

now you can visit the service hitting the ip of one of the nodes in the cluster:

```
#from your local console
docker-machine ip manager1 #e.g.: 192.168.99.100
```

click [here](http://192.168.99.100:9090)

Now Let's try to inspect the service definiton

```
docker service inspect viz
docker service inspect --pretty viz
```