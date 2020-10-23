#!/bin/bash

echo Installing docker...
yum install -y yum-utils
yum-config-manager \
   --add-repo \
   http://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker.service
systemctl start docker.service
echo Docker installed.


echo Installing consul...
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install consul 
if [[ "$HOSTNAME" == "server" ]]; then
	cp /vagrant/consul-configs/server.hcl /etc/consul.d/consul.hcl
else
	cp /vagrant/consul-configs/client.hcl /etc/consul.d/consul.hcl
fi
cp /vagrant/systemd-units/consul.service /etc/systemd/system/consul.service
systemctl enable consul.service
systemctl start consul
echo Consul installed.


echo Installing Nomad...
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install nomad
if [[ "$HOSTNAME" == "server" ]]; then
	cp /vagrant/nomad-configs/server.hcl /etc/nomad.d/nomad.hcl
else
	cp /vagrant/nomad-configs/client.hcl /etc/nomad.d/nomad.hcl
fi
cp /vagrant/systemd-units/nomad.service /etc/systemd/system/nomad.service
systemctl enable nomad.service
systemctl start nomad.service
echo Nomad installed.

