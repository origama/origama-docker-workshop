#!/usr/bin/env sh
echo Building hellodocker:build

docker build -t hellodocker:build . -f Dockerfile.build

docker container create --name extract hellodocker:build
docker container cp extract:/hello ./hello
docker container rm -f extract

echo Building hellodocker:latest

docker build --no-cache -t hellodocker:latest .
rm ./hello