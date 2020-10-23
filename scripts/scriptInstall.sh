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
	cp /vagrant/consul-configs/server.hcl /etc/consul.d/consul.hcl
else
	cp /vagrant/consul-configs/client.hcl /etc/consul.d/consul.hcl
fi
cp /vagrant/systemd-units/consul.service /etc/systemd/system/consul.service
sudo systemctl enable consul.service
sudo systemctl start consul


echo install nomad 
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install nomad
echo Enabling nomad systemd unit...
if [[ "$HOSTNAME" == "server" ]]; then
	cp /vagrant/nomad-configs/server.hcl /etc/nomad.d/nomad.hcl
else
	cp /vagrant/nomad-configs/client.hcl /etc/nomad.d/nomad.hcl
fi
cp /vagrant/systemd-units/nomad.service /etc/systemd/system/nomad.service
systemctl enable nomad.service
systemctl start nomad.service
