# LOG8415 Project

## Create all the instances 

You can create all the instances using the `main.tf` 

- Go to the directpry with the `main.tg`
- `terraform init`
- `terraform plan`
- `terraform apply` 

## Running MySQL Cluster on Amazon EC2

### 1. Master steps:

execute those following commands in order in the master instance

```
git clone https://github.com/Kevin-Lam1013/LOG8415-Project.git
cd LOG8415-Project/part1/commands
chmod 777 master-command.sh
./master-command.sh
```

### 2. Slaves steps:

execute those following commands in order for each slave instance

```
git clone https://github.com/Kevin-Lam1013/LOG8415-Project.git
cd LOG8415-Project/part1/commands
chmod 777 slave-command.sh
./slave-command.sh
```

### 3. Master steps:

execute those following commands in order in the master instance

```
chmod 777 sql-command.sh
./sql-command.sh
cd ~
cd install/
sudo dpkg -i mysql-cluster-community-server_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-server_7.6.6-1ubuntu18.04_amd64.deb
```

Use the command: `sudo nano /etc/mysql/my.cnf`

Add the following content:

```
[mysqld]
ndbcluster  # run NDB storage engine
bind-address=0.0.0.0

[mysql_cluster]
ndb-connectstring=ip-172-31-35-156.ec2.internal # location of management server
```

Verify that the modification are done properly using: `sudo nano /etc/mysql/my.cnf`

Execute the following commands

```
sudo systemctl restart mysql
sudo systemctl enable mysql
```

#### Sakila installation

Execute the following commands in order

```
wget https://downloads.mysql.com/docs/sakila-db.tar.gz
sudo tar -xvzf sakila-db.tar.gz
mysql -u root -p
SOURCE /tmp/sakila-db/sakila-schema.sql;
SOURCE /tmp/sakila-db/sakila-data.sql;
```

Execute the following commands in order in sakila

```
USE sakila;
SHOW FULL TABLES;
```

A table should appear in your terminal
