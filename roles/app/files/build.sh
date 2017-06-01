#!/bin/bash

# Basic Tools
sudo apt-get update
sudo apt-get install -y ntp
sudo apt-get install -y aptitude
sudo apt-get install -y git
sudo apt-get install -y wget
sudo apt-get install -y tar
sudo apt-get install -y ca-certificates
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential
sudo apt-get install -y python-setuptools
sudo apt-get install -y python-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libssl-dev

#Install Docker
echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-get update
sudo apt-get install -y docker-engine

sudo docker run --name demo -p 80:80 -d f5devcentral/f5-demo-app:latest