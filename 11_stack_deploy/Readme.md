# Swarm Stacks

Similarly as we do with compose, we can create declarative files describing the services we want to be deployed.

## Deploy a replicated service

```
docker service create --name=testweb --publish=8888:80/tcp nginx
```

```
docker stack deploy -c testweb.yml testweb
```

now we can test the internal routing:

```
for i in {1..100};do echo $i && curl -s http://192.168.99.101:8888 2>&1 >/dev/null;done

docker service logs testweb_nginx -f
```

it's the same if we hit everytime a different host

```
for i in {1..100};do for j in 0 1 3 4 5;do echo 192.168.99.10$j&&curl -s http://192.168.99.10$j:8888 2>&1 >/dev/null;done;done | sort |uniq -c

docker service logs testweb_nginx -f
```

change the port the servie is listening on

```sh
docker service update --publish-add "8889:80" --publish-rm "8888:80" testweb_nginx
```

and test it again

```sh
curl 192.168.99.100:8888 #should fail now
curl 192.168.99.100:8889 #should succeed now
```