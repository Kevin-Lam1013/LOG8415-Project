import pymysql
import sys
import math
import random
from pythonping import ping
from sshtunnel import SSHTunnelForwarder

# SSH Tunnel implementation for the proxy pattern
def execute(slave_ip, master_ip, sql_query):
    with SSHTunnelForwarder(slave_ip, ssh_username='ubuntu', ssh_pkey='vockey.pem', remote_bind_address=(master_ip, 3306)) as tunnel:
        conn = pymysql.connect(host=master_ip, user='username',
                               password='password', db='sakila', port=3306, autocommit=True)
        cursor = conn.cursor()
        operation = sql_query
        cursor.execute(operation)
        return conn

# This function will get the ping of a specific instance with the ip
def get_ping(ip_address):
    return ping(target=ip_address, count=1, timeout=2).rtt_avg_ms

# We select the slave with lowest ping, it means that the instance have a quick response time
def get_best_slave(slaves):
    # we create a list of dictionnary, where each dict have the 
    # following format {"ip":ip_address, "time":ping_value}
    # I used a list of dict so we can exploit the python functions
    # to help us easly find the instance with the lowest ping
    slaves_dict = []
    for slave in slaves:
        slaves_dict.append({"ip":slave, "time":get_ping(slave)})
    
    return min(slaves_dict, key=lambda x:x['time'])['ip']

# The direct hit type will redirect SQL request to the master instance
def direct_hit(master_ip, query):
    execute(master_ip, master_ip, query)

# The random hit where we randomly select an instance to redirect the requests
def random_hit(slaves_ip, master_ip, query):
    execute(random.choice(slaves_ip), master_ip, query)

# The custimized hit where we redirect the request to the instance with the lowest ping
def customized_hit(slaves_ip, master_ip, query):
    execute(get_best_slave(slaves_ip), master_ip, query)

if __name__ == "__main__":

    all_ips = []

    for i in range(1,5):
        all_ips.append(sys.argv[i])

    hit_type = sys.argv[5]
    sql_query = sys.argv[6]

    if hit_type == "direct":
        # We select the first element of the list since the first parameter of that script
        # is a the ip of the master node
        direct_hit(all_ips[0], sql_query)
    elif hit_type == "random":
        # this list will contain every element of the original list without the first element
        random_hit(all_ips[1:],
                   all_ips[0], sql_query)
    elif hit_type == "customized":
        customized_hit(all_ips[1:], all_ips[0], sql_query)