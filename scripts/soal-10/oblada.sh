apt-get update
apt-get install -y nginx php-fpm

PHP_SOCK=$(ls /run/php/php*-fpm.sock | head -n 1)
echo "Socket aktif: $PHP_SOCK"

mkdir -p /var/www/html

# Halaman Beranda
cat << 'EOF' > /var/www/html/index.php
<?php
echo "<h1>Selamat Datang di Beranda - OBLADA</h1>";
echo "<p>Host: " . gethostname() . "</p>";
?>
EOF

# Halaman Profil
cat << 'EOF' > /var/www/html/profil.php
<?php
echo "<h1>Halaman Profil - OBLADA</h1>";
echo "<p>Identitas: Node Dinamis Oblada (Area Core)</p>";
?>
EOF

PHP_SOCK=$(ls /run/php/php*-fpm.sock | head -n 1)

cat << EOF > /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.php index.html;

    server_name oblada.k07.com core.k07.com;

    # Clean URL /profil -> profil.php
    location = /profil {
        try_files /profil.php =404;
        include fastcgi_params;
        fastcgi_pass unix:$PHP_SOCK;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    # Handler umum untuk file PHP
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:$PHP_SOCK;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

nginx -t
service nginx restart
service $(ls /etc/init.d/ | grep php.*-fpm) restart