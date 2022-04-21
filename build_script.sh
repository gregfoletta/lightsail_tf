#!/usr/bin/env sh

apt-get -y update 
apt-get -y install docker.io
usermod -aG docker ubuntu
