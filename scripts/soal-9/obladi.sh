apt-get update
apt-get install -y apache2

mkdir -p /var/www/html/arsip
echo "Ini arsip rahasia obladi" > /var/www/html/arsip/dokumen1.txt
echo "Catatan log obladi" > /var/www/html/arsip/catatan.txt

cat << 'EOF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerAdmin webmaster@k07.com
    ServerName obladi.k07.com
    ServerAlias vault.k07.com
    DocumentRoot /var/www/html

    # Aktifkan fitur autoindex khusus pada path /arsip
    <Directory /var/www/html/arsip>
        Options +Indexes
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

a2enmod autoindex
service apache2 restart