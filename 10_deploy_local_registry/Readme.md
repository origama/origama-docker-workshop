# Deploy a registry loca to the cluster

Everytime we will deploy a service on n nodes all the nodes will need to get the image in order to run it.
If we use github as our registry thes means we will get the same image nn times from github, which may be overkill.

Let's try and use a local registry then. We will run it as a swarm service

## Generate certificates

on manager1 run the following

```sh
openssl req -newkey rsa:4096 -nodes -sha256 -keyout registry.key -x509 -days 365 -out registry.crt
```
You shoud get an output like the following
```
Generating a 4096 bit RSA private key
........................++
.....................................................................................................................................................................++
writing new private key to 'registry.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) []:IT
State or Province Name (full name) []:Italy
Locality Name (eg, city) []:Catania
Organization Name (eg, company) []:Origama Inc.
Organizational Unit Name (eg, section) []:DevOps
Common Name (eg, fully qualified host name) []:myregistry.com
Email Address []:origama0@gmail.com
```

and two files are generated `registry.cert` and `registry.key`.

## Create Certs Secrets

We can provide the registry with certs through secrets:

```
docker secret create registry.crt registry.crt
docker secret create registry.key registry.key
docker secret ls
```

## Add myregistry.com to all the nodes' hosts file

```
for h in $(docker-machine ls -q);do docker-machine ssh $h 'echo "127.0.0.1 myregistry.com" | sudo tee -a /etc/hosts';done
```

## Label nodes that will run the registry

In our example we want to run the registry only on one node, so

```
docker node update --label-add registry=true manager2
```

## Registry Service

```sh
$ docker service create \
  --name registry \
  --secret registry.crt \
  --secret registry.key \
  --constraint 'node.labels.registry==true' \
  --mount type=bind,src=/mnt/registry,dst=/var/lib/registry \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/run/secrets/registry.crt \
  -e REGISTRY_HTTP_TLS_KEY=/run/secrets/registry.key \
  --publish published=443,target=443 \
  --replicas 1 \
  registry:2
```

oneline version of the same command
```sh
docker service create --name registry --secret domain.crt --secret domain.key --constraint 'node.labels.registry==true' --mount type=bind,src=/mnt/registry,dst=/var/lib/registry -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=/run/secrets/domain.crt -e REGISTRY_HTTP_TLS_KEY=/run/secrets/domain.key --publish published=443,target=443 --replicas 1 registry:2
```

Make sure the registry is correctly running

```
docker service ls
docker service ps registry
```

you can access the registry at any of the node's ip at port 443

```
nc -vz 127.0.0.1 443
```

push our first image to our registry

```
docker pull nginx

docker tag nginx myregistry.com/nginx
docker push myregistry.com/nginx
```