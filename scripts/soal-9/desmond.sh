apt-get update
apt-get install -y apache2

mkdir -p /var/www/html/arsip
echo "Ini arsip rahasia desmond" > /var/www/html/arsip/file_desmond.txt
echo "Data cadangan desmond" > /var/www/html/arsip/backup.txt

cat << 'EOF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerAdmin webmaster@k07.com
    ServerName desmond.k07.com
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