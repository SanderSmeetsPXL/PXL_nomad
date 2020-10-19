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
(
cat <<-EOF
  [Unit]
  Description=consul agent
  Requires=network-online.target
  After=network-online.target
  [Service]
  Restart=on-failure
  ExecStart=/usr/bin/consul agent -dev
  ExecReload=/bin/kill -HUP $MAINPID
  [Install]
  WantedBy=multi-user.target
EOF
) | sudo tee /etc/systemd/system/consul.service
sudo systemctl enable consul.service
sudo systemctl start consul


echo install nomad 
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install nomad
sudo systemctl start nomad.service



