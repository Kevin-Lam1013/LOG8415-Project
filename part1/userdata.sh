#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Hardcoded password for MySQL so it will be easy to remember
MYSQL_PASSWORD='root'

# Installing MySQL
echo debconf mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo debconf mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections

apt-get update
apt-get -qq install mysql-server > /dev/null

# Install Expect
apt-get -qq install expect > /dev/null

# Build Expect script
tee ~/secure_our_mysql.sh > /dev/null << EOF
spawn $(which mysql_secure_installation)
expect "Enter password for user root:"
send "$MYSQL_PASSWORD\r"
expect "Press y|Y for Yes, any other key for No:"
send "y\r"
expect "Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:"
send "2\r"
expect "Change the password for root ? ((Press y|Y for Yes, any other key for No) :"
send "n\r"
expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Reload privilege tables now? (Press y|Y for Yes, any other key for No) :"
send "y\r"
EOF

# Run Expect script.
# This runs the "mysql_secure_installation" script which removes insecure defaults.
expect ~/secure_our_mysql.sh

# Cleanup
rm -v ~/secure_our_mysql.sh # Remove the generated Expect script

apt-get update && apt install python3.8 python3-pip dos2unix -y

# Python librairies needed for the proxy pattern
pip3 install sshtunnel
pip3 install PyMySQL
pip3 install pythonping