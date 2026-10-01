
apt-get update
apt-get install -y apache2

mkdir -p /var/www/html/arsip
echo "Ini arsip rahasia desmond" > /var/www/html/arsip/file_desmond.txt
echo "Data cadangan desmond" > /var/www/html/arsip/backup.txt

cat > /etc/apache2/sites-available/000-default.conf <<'CONF'
<VirtualHost *:80>
    ServerAdmin webmaster@k07.com
    ServerName desmond.k07.com
    ServerAlias vault.k07.com
    DocumentRoot /var/www/html

    <Directory /var/www/html/arsip>
        Options +Indexes
        AllowOverride None
        Require all granted
    </Directory>

    SetEnvIf X-Real-IP "^(.*)$" REALIP=$1
    LogFormat "%{REALIP}e %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" realip_combined
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log realip_combined
</VirtualHost>
CONF

a2enmod autoindex
apache2ctl configtest && (service apache2 reload 2>/dev/null || service apache2 start)
