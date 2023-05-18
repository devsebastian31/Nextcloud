#!/bin/bash

# Cambiar la contraseña del usuario root en mysql
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'Password444@';"

# Salir de MySQL y crear un usuario, contraseña y una base de datos para Nextcloud
exit
mysql -u root -p -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'Password444@';"
mysql -u root -p -e "CREATE DATABASE nextcloud;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';"
mysql -u root -p -e "FLUSH PRIVILEGES;"

# Instalar y configurar Apache
apt install -y apache2 libapache2-mod-php
cd /etc/apache2/sites-available/
cp 000-default.conf nextcloud.conf
a2dissite 000-default.conf
systemctl reload apache2

# Agregar la configuración necesaria al archivo de configuración de Apache
echo "
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
