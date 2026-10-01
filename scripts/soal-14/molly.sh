apt-get update
apt-get install -y nginx php-fpm

mkdir -p /var/www/html

cat > /var/www/html/index.php <<'PHP'
<?php
echo "<h1>Selamat Datang di Beranda - MOLLY</h1>";
echo "<p>Host: " . gethostname() . "</p>";
?>
PHP

cat > /var/www/html/profil.php <<'PHP'
<?php
echo "<h1>Halaman Profil - MOLLY</h1>";
echo "<p>Identitas: Node Dinamis Molly (Area Core)</p>";
?>
PHP

PHP_SOCK=$(ls /run/php/php*-fpm.sock | head -n 1)

cat > /etc/nginx/sites-available/default <<EOF2
log_format realip '\$http_x_real_ip - \$remote_user [\$time_local] '
                   '"\$request" \$status \$body_bytes_sent '
                   '"\$http_referer" "\$http_user_agent"';

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.php index.html;

    server_name molly.k07.com core.k07.com;

    access_log /var/log/nginx/access.log realip;

    location = /profil {
        try_files /profil.php =404;
        include fastcgi_params;
        fastcgi_pass unix:$PHP_SOCK;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:$PHP_SOCK;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF2

nginx -t
service nginx restart
service $(ls /etc/init.d/ | grep php.*-fpm) restart
