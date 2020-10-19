#!/bin/sh
(
cat <<-EOF
  [Unit]
  Description=nomad agent
  Requires=network-online.target
  After=consul.service
  [Service]
  ExecStart= /bin/sh -c "/usr/bin/nomad agent -config=/vagrant/nomad-configs/server.hcl"
  ExecReload=/bin/kill -HUP $MAINPID
  Restart=on-failure
  [Install]
  WantedBy=multi-user.target
EOF
) | tee /etc/systemd/system/nomad.service
systemctl enable nomad.service
systemctl start nomad.service
