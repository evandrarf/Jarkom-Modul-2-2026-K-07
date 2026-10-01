#!/bin/bash
command -v apache2 >/dev/null || { apt-get update && apt-get install -y apache2; }

service apache2 stop 2>/dev/null
pkill -9 apache2 2>/dev/null

mkdir -p /var/www/html/arsip
echo "Ini arsip rahasia obladi" > /var/www/html/arsip/dokumen1.txt
echo "Catatan log obladi" > /var/www/html/arsip/catatan.txt

DOMAIN_SELF="obladi.k07.com"
DOMAIN_ALIAS="vault.k07.com"

cat > /etc/apache2/sites-available/000-default.conf <<CONF
<VirtualHost *:80>
    ServerAdmin webmaster@k07.com
    ServerName ${DOMAIN_SELF}
    ServerAlias ${DOMAIN_ALIAS}
    DocumentRoot /var/www/html

    <Directory /var/www/html/arsip>
        Options +Indexes
        AllowOverride None
        Require all granted
    </Directory>

    LogFormat "%{X-Real-IP}i %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" realip_combined
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log realip_combined
</VirtualHost>
CONF

a2enmod autoindex 2>/dev/null
service apache2 start
