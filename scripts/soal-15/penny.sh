
#!/bin/bash
command -v apache2 >/dev/null || { apt-get update && apt-get install -y apache2 apache2-utils; }
#command -v php-fpm >/dev/null || { apt-get update && apt-get install -y php-fpm libapache2-mod-php; }

service apache2 stop 2>/dev/null
pkill -9 apache2 2>/dev/null

a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers auth_basic 2>/dev/null

DOMAIN_WWW="www.k07.com"
DOMAIN_PENNY="penny.k07.com"

cat > /etc/apache2/sites-available/000-default.conf <<CONF
<VirtualHost *:80>
    ServerName ${DOMAIN_PENNY}
    Redirect permanent / http://${DOMAIN_WWW}/
</VirtualHost>

<VirtualHost *:80>
    ServerName ${DOMAIN_WWW}
    ProxyPreserveHost On

    ProxyPass /admin !
    ProxyPass /eternal !
    ProxyPass / balancer://vaultcluster/
    ProxyPassReverse / balancer://vaultcluster/

    <Proxy balancer://vaultcluster>
        BalancerMember http://10.67.1.4
        BalancerMember http://10.67.1.5
    </Proxy>

    RequestHeader set X-Real-IP "expr=%{REMOTE_ADDR}"
    RequestHeader set X-Forwarded-For "expr=%{REMOTE_ADDR}"

    <Location /admin>
        AuthType Basic
        AuthName "Restricted Area"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
    </Location>

    Alias /eternal /var/www/eternal
    <Directory /var/www/eternal>
        Options -Indexes
        AllowOverride None
        Require all granted
        DirectoryIndex index.php
    </Directory>
</VirtualHost>
CONF

#mkdir -p /var/www/html/admin
#echo "10 dosa besar tedprab" > /var/www/html/admin/index.html
#[ -f /etc/apache2/.htpasswd ] || htpasswd -cb /etc/apache2/.htpasswd prabs 'pakar_pinter_jadi_gob***'

#mkdir -p /var/www/eternal
#cat > /var/www/eternal/index.php <<'PHP'
#<?php
#echo "<h1>Eternal Path - PENNY</h1>";
#echo "<p>PHP works. Time: " . date("Y-m-d H:i:s") . "</p>";
#?>
#PHP

service apache2 start
