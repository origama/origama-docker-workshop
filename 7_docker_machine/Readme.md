# Demo VII : Create infrastructure

In this example we will create the VMs that will run our clusters and services.
We will use docker-machine for this purpouse since it's already included in the docker installation most of the times.

## Prerequisites

You need to have Virtualbox and docker-machine.
You will need approx. 1GB of RAM per VM

RAM note: you could try to set a custom memory amount but you may find hangs and issues:

```sh
docker-machine create -d virtualbox --virtualbox-memory 500 test
```

## Create the machines by using the scripts

You can choose to create the machines manually or by using the script.
If you want to use the script you can use `swarm-cluster-vbox-create.sh` to create the VMs and `swarm-cluster-vbox-teardown.sh` to destroy them all.

We will create two masters and two workers, if you want to change the number of masters or workers you can set the variables at the top of the script, then run:

```sh
./swarm-cluster-vbox-create.sh
```

## Create the machines manually

You can run manually, one by one, the same steps contained in the script:

```sh
docker-machine create -d virtualbox manager1;
docker-machine create -d virtualbox manager2;
docker-machine create -d virtualbox worker1;
docker-machine create -d virtualbox worker2;
```

You can also check that the VMs have been created in Virtualbox.

## Test some commands

List all machines

```sh
docker-machine ls
```

SSH into a machine
```sh
docker-machine ssh master1
```

See what is the currently active machine
```sh
docker-machine active
```

Set an active machine
```sh
eval $(docker-machine env manager1)
```

Set no machine as active
```sh
eval $(docker-machine env -u)
```