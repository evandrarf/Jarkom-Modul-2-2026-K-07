# prab
#!/bin/bash
command -v named >/dev/null || { apt update && apt install -y bind9 bind9utils dnsutils; }
mkdir -p /run/named
chown bind:bind /run/named

cat > /etc/bind/named.conf.options <<'OPT'
options {
    directory "/var/cache/bind";
    listen-on { any; };
    allow-query { any; };
    recursion yes;
    allow-recursion { any; };
    forwarders { 192.168.122.1; };
    dnssec-validation no;
};
OPT

cat > /etc/bind/named.conf.local <<'LOC'
zone "k07.com" {
    type master;
    file "/etc/bind/db.k07.com";
    notify yes;
    also-notify { 10.67.1.3; };
    allow-transfer { 10.67.1.3; };
};
LOC

cat > /etc/bind/db.k07.com <<'ZONE'
$TTL 604800
@   IN  SOA prab.k07.com. admin.k07.com. (
        2       ; serial
        30      ; refresh
        10      ; retry
        2419200 ; expire
        604800 ) ; minimum
@        IN  NS  prab.k07.com.
@        IN  NS  tedd.k07.com.
prab     IN  A   10.67.1.2
tedd     IN  A   10.67.1.3
@        IN  A   10.67.5.2
rootkit  IN  A   10.67.1.1
obladi   IN  A   10.67.1.4
desmond  IN  A   10.67.1.5
oblada   IN  A   10.67.1.6
molly    IN  A   10.67.1.7
abbey    IN  A   10.67.4.2
penny    IN  A   10.67.5.2
alpha    IN  A   10.67.6.2
beta     IN  A   10.67.6.3
gamma    IN  A   10.67.6.4
delta    IN  A   10.67.7.2
epsilon  IN  A   10.67.7.3
ZONE

pkill -9 named 2>/dev/null
sleep 1
named -u bind

#tedd

#!/bin/bash
command -v named >/dev/null || { apt update && apt install -y bind9 bind9utils dnsutils; }
mkdir -p /run/named
chown bind:bind /run/named

cat > /etc/bind/named.conf.options <<'OPT'
options {
    directory "/var/cache/bind";
    listen-on { any; };
    allow-query { any; };
    recursion yes;
    allow-recursion { any; };
    forwarders { 192.168.122.1; };
    dnssec-validation no;
};
OPT

cat > /etc/bind/named.conf.local <<'LOC'
zone "k07.com" {
    type slave;
    masters { 10.67.1.2; };
    file "/var/cache/bind/db.k07.com";
};
LOC

pkill -9 named 2>/dev/null
sleep 1
named -u bind
