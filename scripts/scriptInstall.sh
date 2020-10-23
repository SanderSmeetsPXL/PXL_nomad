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
echo start consul systemctl
if [[ "$HOSTNAME" == "server" ]]; then
	cp /vagrant/systemd-units/consul-server.service /etc/systemd/system/consul.service
else
	cp /vagrant/systemd-units/consul-client.service /etc/systemd/system/consul.service
fi
sudo systemctl enable consul.service
sudo systemctl start consul


echo install nomad 
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install nomad

