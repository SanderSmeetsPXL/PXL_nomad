#!/bin/bash
echo Installing docker...
sudo yum install -y yum-utils
yum-config-manager \
   --add-repo \
   http://download.docker.com/linux/centos/docker-ce.repo
   
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker.service
sudo systemctl start docker.service


echo Installing consul...
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install consul
echo Consul installed
echo Starting Consul...
sudo systemctl start consul.service


echo install nomad 
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install nomad
sudo systemctl start nomad.service

echo create webserver job...
nomad job plan /vagrant/webserver-job/webserver.nomad
nomad job run /vagrant/webserver-job/webserver.nomad

