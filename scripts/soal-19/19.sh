cat << 'EOF' >> /etc/bind/db.k07.com
outbound    IN    CNAME    http.badssl.com.
EOF

named-checkzone k07.com /etc/bind/db.k07.com
rndc reload