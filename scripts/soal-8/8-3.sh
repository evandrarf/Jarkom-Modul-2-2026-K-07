cat << 'EOF' >> /etc/bind/db.10.67.1
$TTL 604800
@   IN  SOA prab.k07.com. admin.k07.com. (
        1       ; serial
        604800  ; refresh
        86400   ; retry
        2419200 ; expire
        604800 ) ; minimum
@   IN  NS  prab.k07.com.
@   IN  NS  tedd.k07.com.

4   IN  PTR obladi.k07.com.
5   IN  PTR desmond.k07.com.
6   IN  PTR oblada.k07.com.
7   IN  PTR molly.k07.com.
EOF

cat << 'EOF' >> /etc/bind/db.10.67.4
$TTL 604800
@   IN  SOA prab.k07.com. admin.k07.com. (
        1       ; serial
        604800  ; refresh
        86400   ; retry
        2419200 ; expire
        604800 ) ; minimum
@   IN  NS  prab.k07.com.
@   IN  NS  tedd.k07.com.

2   IN  PTR abbey.k07.com.
EOF

cat << 'EOF' >> /etc/bind/db.10.67.5
$TTL 604800
@   IN  SOA prab.k07.com. admin.k07.com. (
        1       ; serial
        604800  ; refresh
        86400   ; retry
        2419200 ; expire
        604800 ) ; minimum
@   IN  NS  prab.k07.com.
@   IN  NS  tedd.k07.com.

2   IN  PTR penny.k07.com.
EOF
