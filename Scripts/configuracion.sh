#!/bin/bash

# Solicitar entrada al usuario para la contraseña
read -p "Contraseña para Mysql: " -s contrasena

# Cambiar la contraseña del usuario root en mysql usando la contraseña ingresada
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$contrasena';"

# Salir de MySQL y crear un usuario, contraseña y una base de datos para Nextcloud
mysql -u root -p -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY '$contrasena';"
mysql -u root -p -e "CREATE DATABASE nextcloud;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';"
mysql -u root -p -e "FLUSH PRIVILEGES;"

# Instalar y configurar Apache
apt install -y apache2 libapache2-mod-php
cd /etc/apache2/sites-available/
touch nextcloud.conf
a2dissite 000-default.conf
systemctl reload apache2

# Agregar la configuración necesaria al archivo de configuración de Apache
echo "<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/nextcloud

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

<Directory /var/www/html/nextcloud>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
        SetEnv HOME /var/www/html/nextcloud
        SetEnv HTTP_HOME /var/www/html/nextcloud
        <IfModule mod_dav.c>
          Dav off
        </IfModule>
</Directory>" | tee -a /etc/apache2/sites-available/nextcloud.conf

# Habilitar los módulos necesarios de Apache
a2enmod rewrite dir mime env headers

# Reiniciar el servicio de Apache
service apache2 restart

# Crear y descargar Nextcloud en el directorio correcto
cd /var/www/html
mkdir nextcloud
chmod 750 nextcloud/
chown www-data:www-data nextcloud/
cd nextcloud/
wget https://download.nextcloud.com/server/installer/setup-nextcloud.php
chown www-data:www-data setup-nextcloud.php

# Habilitar el sitio de Nextcloud en Apache y reiniciar el servicio
a2ensite nextcloud.conf
service apache2 restart
