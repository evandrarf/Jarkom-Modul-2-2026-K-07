#!/bin/bash
apt -o Acquire::ForceIPv4=true update
command -v nginx >/dev/null || apt -o Acquire::ForceIPv4=true install -y nginx

rm -f /etc/nginx/sites-enabled/*

mkdir -p /var/www/orion
cat > /var/www/orion/index.html <<'HTML'
<h1>Orion Path - ABBEY</h1>
<p>Static only, no PHP rendering.</p>
HTML

cat > /etc/nginx/sites-available/abbey.conf <<'CONF'
upstream corecluster {
    server 10.67.1.6;
    server 10.67.1.7;
}

server {
    listen 80 default_server;
    server_name abbey.k07.com _;
    return 302 http://static.k07.com$request_uri;
}

server {
    listen 80;
    server_name static.k07.com;

    location /orion {
        alias /var/www/orion;
        autoindex off;
        location ~ \.php$ {
            deny all;
        }
    }

    location / {
        proxy_pass http://corecluster;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
CONF

ln -sf /etc/nginx/sites-available/abbey.conf /etc/nginx/sites-enabled/abbey.conf

cat > /etc/resolv.conf <<'RSV'
nameserver 10.67.1.2
nameserver 10.67.1.3
nameserver 192.168.122.1
RSV

hostname abbey
echo abbey > /etc/hostname
grep -q abbey.k07.com /etc/hosts || echo "10.67.4.2 abbey.k07.com abbey" >> /etc/hosts

nginx -t && (service nginx start)
