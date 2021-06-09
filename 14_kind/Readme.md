# Testing kubernetes

### Create kind cluster
```kind create cluster --config=./kind.yaml```

```
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
- role: worker
- role: worker
EOF
```

### List nodes
```kubectl get nodes```

### List namespaces
```kubectl get ns```

### List pods
```kubectl get pods -o wide```
```kubectl get pods --all-namespaces -o wide```

### List Services
```kubectl get services --all-namespaces -o wide```

### create ingress
```kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml```

### wait for the ingress to be up
```
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```

### deploy applications
```
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
```

### access applications thourgh ingress
```
# should output "foo"
curl localhost/foo
# should output "bar"
curl localhost/bar
```
