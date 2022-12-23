import pymysql
import sys
import math
import random
from pythonping import ping
from sshtunnel import SSHTunnelForwarder

def execute(slave_ip, master_ip, sql_query):
    with SSHTunnelForwarder(slave_ip, ssh_username='ubuntu', ssh_pkey='labsuser.pem', remote_bind_address=(master_ip, 3306)) as tunnel:
        conn = pymysql.connect(host=master_ip, user='kevin',
                               password='1234', db='sakila', port=3306, autocommit=True)
        cursor = conn.cursor()
        operation = sql_query
        cursor.execute(operation)
        return conn

def get_ping(ip_address):
    return ping(target=ip_address, count=1, timeout=2).rtt_avg_ms

def get_slowest_slave(slaves):
    slaves_dict = []
    for slave in slaves:
        slaves_dict.append({"ip":slave, "time":get_ping(slave)})
    
    return min(slaves_dict, key=lambda x:x['time'])['ip']

def direct_hit(master_ip, query):
    execute(master_ip, master_ip, query)

def random_hit(slaves_ip, master_ip, query):
    execute(random.choice(slaves_ip), master_ip, query)

def customized_hit(slaves_ip, master_ip, query):
    execute(get_slowest_slave(slaves_ip), master_ip, query)

if __name__ == "__main__":

    all_ips = []

    for i in range(1,5):
        all_ips.append(sys.argv[i])

    hit_type = sys.argv[5]
    sql_query = sys.argv[6]

    if hit_type == "direct":
        direct_hit(all_ips[0], sql_query)
    elif hit_type == "random":
        random_hit(all_ips[1:],
                   all_ips[0], sql_query)
    elif hit_type == "customized":
        customized_hit(all_ips[1:], all_ips[0], sql_query)