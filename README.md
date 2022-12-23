# LOG8415 Project

## Create all the instances 

You can create all the instances using the `main.tf` 

- Go to the directpry with the `main.tg`
- `terraform init`
- `terraform plan`
- `terraform apply` 

## MySQL stand-alone server, MySQL Cluster, and Sakila

### 1. Master steps:

execute those following commands in order in the master instance

```
git clone https://github.com/Kevin-Lam1013/LOG8415-Project.git
cd LOG8415-Project/part1/commands
chmod 777 master-command.sh
./master-command.sh <master_ip> <slave1_ip> <slave2_ip> <slave3_ip>
```

### 2. Slaves steps:

execute those following commands in order for each slave instance

```
git clone https://github.com/Kevin-Lam1013/LOG8415-Project.git
cd LOG8415-Project/part1/commands
chmod 777 slave-command.sh
./slave-command.sh <master_ip>
```

### 3. Master steps:

execute those following commands in order in the master instance

```
chmod 777 sql-command.sh
./sql-command.sh
cd ~/install/
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
ndb-connectstring=<master-ip> # location of management server
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
sudo wget https://downloads.mysql.com/docs/sakila-db.tar.gz
sudo tar -xvzf sakila-db.tar.gz
sudo cp -r sakila-db /tmp/
mysql -u root -p
```

Execute the following commands in order in mysql

```
SOURCE /tmp/sakila-db/sakila-schema.sql;
SOURCE /tmp/sakila-db/sakila-data.sql;
USE sakila;
SHOW FULL TABLES;
```

A table should appear in your terminal

### 4. Benchmark steps:

1. In the Master
- Execute: `sudo apt-get install sysbench`
- Execute all the benchmark tests manually, the test commands are in the dir: `benchmark-test/master-benchmark.md`

2. In the Stand-alone
- Install sakila using the steps above
- Execute: `sudo apt-get install sysbench`
- Execute all the benchmark tests manually, the test commands are in the dir: `benchmark-test/stand-alone-benchmark.md`


## Cloud patterns - Proxy

### Add user in proxy instance

- Execute the following commands in order in the master instance:
```
mysql -u root -p

CREATE USER 'username'@'host' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON _._ TO 'username'@'host';
```

- `username`: a username for the user 
- `host`: the public IPv4 address of the proxy instance
- `password`: a password for the user

- Execute the following commands in order in the proxy instance:
```
git clone https://github.com/Kevin-Lam1013/LOG8415-Project.git
cd LOG8415-Project/part2
sudo python3 proxy-pattern.py <master_ip> <slave1_ip> <slave2_ip> <slave3_ip> <hit_type> <sql_query>
```

**In this case the ip are the public IPv4 address**