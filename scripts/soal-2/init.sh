#!/bin/bash

ip link set eth0 up
ip addr flush dev eth0
ip addr add 192.168.122.2/24 dev eth0
ip route replace default via 192.168.122.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf


command -v iptables >/dev/null || { apt update && apt install -y iptables; }


echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -F
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
