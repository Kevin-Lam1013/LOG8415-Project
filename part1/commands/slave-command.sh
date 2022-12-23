
#!/bin/bash

MASTER_IP="ip-172-31-28-136.ec2.internal"

# Install Dependancies
sudo apt update && sudo apt install libclass-methodmaker-perl
cd ~


# Install MySQL
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb


# Create config file
cat <<EOF >my.cnf
[mysql_cluster]
# Options for NDB Cluster processes:
ndb-connectstring=$MASTER_IP  # location of cluster manager
EOF

sudo cp my.cnf /etc/
sudo mkdir -p /usr/local/mysql/data


# Create service file
cat <<EOF >ndbd.service
[Unit]
Description=MySQL NDB Data Node Daemon
After=network.target auditd.service

[Service]
Type=forking
ExecStart=/usr/sbin/ndbd
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
sudo cp ndbd.service /etc/systemd/system/


# Start service
sudo systemctl daemon-reload
sudo systemctl enable ndbd
sudo systemctl start ndbd