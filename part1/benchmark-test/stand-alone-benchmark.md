# Benchmark test in the Stand-alone

**Make sure to always do the prepare, run and cleanup command in that order to properly run the tests**

## oltp_read_write
```
sudo sysbench /usr/share/sysbench/oltp_read_write.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --tables=18 --table-size=10000 prepare

sudo sysbench /usr/share/sysbench/oltp_read_write.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --tables=18 --table-size=10000 run

sudo sysbench /usr/share/sysbench/oltp_read_write.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --tables=18 --table-size=10000 cleanup
```

## oltp_read_write without number of tables
```
sudo sysbench /usr/share/sysbench/oltp_read_write.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_read_write.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_read_write.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```

## oltp_write_only
```
sudo sysbench /usr/share/sysbench/oltp_write_only.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_write_only.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_write_only.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```

## oltp_read_only
```
sudo sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```

## oltp_point_select
```
sudo sysbench /usr/share/sysbench/oltp_point_select.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_point_select.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_point_select.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```

## oltp_update_index
```
sudo sysbench /usr/share/sysbench/oltp_update_index.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_update_index.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_update_index.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```

## oltp_update_non_index
```
sudo sysbench /usr/share/sysbench/oltp_update_non_index.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_update_non_index.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_update_non_index.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```

## oltp_delete.lua
```
sudo sysbench /usr/share/sysbench/oltp_delete.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_delete.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_delete.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```

## oltp_insert.lua
```
sudo sysbench /usr/share/sysbench/oltp_insert.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 prepare

sudo sysbench /usr/share/sysbench/oltp_insert.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 run

sudo sysbench /usr/share/sysbench/oltp_insert.lua --mysql-user=root --mysql-password='root' --mysql-db=sakila --threads=6 --db-driver=mysql --table-size=100000 cleanup
```
