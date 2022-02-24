#!/bin/bash

#update before install
apt-get update

#install docker
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -arch
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get install docker-ce docker-ce-cli containerd.io
systemctl enable docker

#install docker-compose
curl -L https://github.com/docker/compose/releases/download/3.8/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#docker start
service docker start

#portainer run
mkdir -p /data/portainer
docker run -d --name portainer -p 8092:9000 --restart always -v /boot/data/portainer:/data -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer

#jenkins run
docker run -d --name jenkins -p 8080:8080 --restart always -v /boot/data/jenkins_home:var/jenkins_home -u root jenkins/jenkins:lts

#check docker status
service docker status
