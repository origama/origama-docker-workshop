# Create a Swarm cluster

In this demo we will initiate a swarm cluster on the nodes we just created

# Initiate the cluster by script

Again you can use a script or you can run steps manually.

The script can be found as `swarm-node-vbox-setup.sh`

```sh
./swarm-node-vbox-setup.sh
```

# Initiate the cluster manually


Initialize the first swarm manager

```sh
docker-machine ip manager1 #<ip1_here>

docker-machine ssh manager1 "docker swarm init --listen-addr <ip1_here> --advertise-addr <ip1_here>"
```

getting manager and worker tokens

```sh
docker-machine ssh manager1 "docker swarm join-token manager -q" #<manager_token_here>
docker-machine ssh manager1 "docker swarm join-token worker -q" #<worker_token_here>
```

joining the second master

```sh
docker-machine ip manager2 #<ip2_here>
docker-machine ssh manager2 \
		"docker swarm join \
		--token <manager_token_here> \
		--listen-addr <ip2_here> \
		--advertise-addr <ip2_here> \
		<ip1_here>"
```

joining workers, repeat the following for each worker

```sh
docker-machine ip worker1 #<ipw1_here>
docker-machine ssh worker1 \
		"docker swarm join \
		--token <worker_token_here> \
		--listen-addr <ipw1_here> \
		--advertise-addr <ipw1_here> \
		<ip1_here>"
```


## Check the cluster

```sh
docker node ls
```