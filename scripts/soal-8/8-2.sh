cat << 'EOF' >> /etc/bind/named.conf.local

zone "1.67.10.in-addr.arpa" {
    type master;
    file "/etc/bind/db.10.67.1";
    notify yes;
    also-notify { 10.67.1.3; };
    allow-transfer { 10.67.1.3; };
};

zone "4.67.10.in-addr.arpa" {
    type master;
    file "/etc/bind/db.10.67.4";
    notify yes;
    also-notify { 10.67.1.3; };
    allow-transfer { 10.67.1.3; };
};

zone "5.67.10.in-addr.arpa" {
    type master;
    file "/etc/bind/db.10.67.5";
    notify yes;
    also-notify { 10.67.1.3; };
    allow-transfer { 10.67.1.3; };
};
EOF