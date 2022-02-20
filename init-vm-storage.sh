#!/bin/bash

#update before install
apt-get update

#add docker repository
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -arch
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update

#docker install
apt-get install docker-ce docker-ce-cli containerd.io
systemctl enable docker
service docker start

#portainer run with auto image pull
mkdir -p /data/portainer
docker run --name portainer -p 8093:9000 -d --restart always -v /data/portainer:/data -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer

#check docker status
service docker status
