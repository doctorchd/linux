# Policy based routing configuration
#
# files:
# /etc/sysconfig/network-scripts/ifcfg-eth0
# /etc/sysconfig/network-scripts/ifcfg-eth1
# /etc/sysconfig/network-scripts/rule-eth0
# /etc/sysconfig/network-scripts/rule-eth1
# /etc/iproute2/rt_tables
# 
# applying:
# systemctl restart netwotk
#
# checking:
# ip route show
# ip rule show
# ip route show table policy-eth0
# ip route show table policy-eth1
# 
