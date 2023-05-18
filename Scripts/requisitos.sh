#!/bin/bash

# Actualizar paquetes y sistema
apt update
apt upgrade

# Agregar repositorio PHP
add-apt-repository ppa:ondrej/php

# Instalar PHP 8.1 y sus extensiones necesarias
apt-get install php8.1 php8.1-common php8.1-mysql php8.1-pgsql php8.1-xml php8.1-mbstring php8.1-curl php8.1-gd php8.1-zip php8.1-intl

# Actualizar paquetes de nuevo
apt-get update

# Instalar servidor MySQL y configurarlo
apt install mysql-server -y