sudo apt update
sudo apt install apache2 libapache2-mod-fcgid php php-fpm php-cli libapache2-mod-php
sudo a2enmod actions fcgid alias proxy_fcgi 
sudo vi /etc/apache2/sites-available/example.conf
```bash
<VirtualHost *:80>
    ServerAdmin admin@geekforgeek.com
    ServerName geekforgeek.com
    ServerAlias www.geekforgeek.com
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        Options -Indexes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>
 
    <FilesMatch \.php$>
        # 2.4.10+ can proxy to unix socket
        SetHandler "proxy:unix:/var/run/php/php7.4-fpm.sock|fcgi://localhost"
    </FilesMatch>
 
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
sudo systemctl restart apache2
sudo vi /var/www/html/info.php
```bash
<?php


    phpinfo();


?>
```
So open web browser and go to http://localhost/info.php or you can also use system IP instead of localhost.

### Install php8.0

sudo apt install python-software-properties 
sudo add-apt-repository ppa:ondrej/php
apt install php8.0 php8.0-fpm
sudo systemctl status php8.0-fpm
sudo a2enmod actions alias proxy_fcgi setenvif
sudo vi /etc/apache2/sites-available/gfg1.conf
```bash
<VirtualHost *:8888>
    ServerAdmin admin@geekforgeek.com
    ServerName geekforgeek.com
    ServerAlias www.geekforgeek.com
    DocumentRoot /var/www/gfg

    <Directory /var/www/gfg>
        Options -Indexes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>
 
    <FilesMatch \.php$>
        # 2.4.10+ can proxy to unix socket
        SetHandler "proxy:unix:/var/run/php/php8.0-fpm.sock|fcgi://localhost"
    </FilesMatch>
 
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
sudo systemctl restart apache2
sudo a2enmod proxy_fcgi setenvif 
sudo a2enconf php8.0-fpm

#### Chaging mpm module
sudo a2dismod php8.0 mpm_prefork
sudo a2enmod mpm_event
sudo systemctl restart apache2
sudo apachectl -V | grep MPM
cd /etc/apache2/mods-enabled/
sudo vi mpm_event.conf
```bash
<IfModule mpm_event_module> 
    KeepAlive On
    KeepAliveTimeout 5 
    MaxKeepAliveRequests 128

    ServerLimit 10
    StartServers 4
    ThreadLimit 128 
    ThreadsPerChild 128 
    MinSpareThreads 256 
    MaxSpareThreads 512 
    MaxRequestWorkers 1280 
    MaxConnectionsPerChild 2048
</IfModule>
```
cd /etc/php/7.3/fpm/pool.d/
sudo vi www.conf
```bash
pm = dynamic
pm.max_children = 100 
pm.start_servers = 20 
pm.min_spare_servers = 10 
pm.max_spare_servers = 30 
pm.process_idle_timeout = 10s;
```
sudo systemctl restart php8.0-fpm
sudo systemctl restart apache2 

sudo vi /etc/apache2/ports.conf
```bash
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 8888                

<IfModule ssl_module>
    Listen 443
</IfModule>

<IfModule mod_gnutls.c>
    Listen 443
</IfModule>
```
sudo a2ensite gfg1.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
sudo mkdir /var/www/gfg
echo “<?php phpinfo(); ?>” > /var/www/gfg/index.php 

https://www.geeksforgeeks.org/how-to-install-apache-with-php-fpm-on-ubuntu/
https://dev.to/joetancy/php-fpm-with-apache2-2mk0
