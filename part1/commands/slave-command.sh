
#!/bin/bash

MASTER_IP="$1"

# Installing dependencies
sudo apt update && sudo apt install libclass-methodmaker-perl
cd ~


# MySQL installation command
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb


# Create and set up config file
cat <<EOF >my.cnf
[mysql_cluster]
# Options for NDB Cluster processes:
ndb-connectstring=$MASTER_IP  # location of cluster manager
EOF

sudo cp my.cnf /etc/
sudo mkdir -p /usr/local/mysql/data


# Create and set up service file
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