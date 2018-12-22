#!/bin/bash
yum install -y yum-utils device-mapper-persistent-data lvm2 epel-release wget
yum groupinstall -y "Development Tools"
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker
/etc/init.d/docker start
chkconfig docker on
docker pull hashicorp/http-echo
docker run -d -p 80:80 hashicorp/http-echo -listen=:80 -text="hello world"
