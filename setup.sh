#!/bin/bash

while :
do

clear

echo 

banner(){
echo


echo -e "\033[34m ███    ██ ███████ ██   ██ ████████  ██████ ██       ██████  ██    ██ ██████   \033[0m"
echo -e "\033[34m ████   ██ ██       ██ ██     ██    ██      ██      ██    ██ ██    ██ ██   ██  \033[0m"
echo -e "\033[34m ██ ██  ██ █████     ███      ██    ██      ██      ██    ██ ██    ██ ██   ██  \033[0m"
echo -e "\033[34m ██  ██ ██ ██       ██ ██     ██    ██      ██      ██    ██ ██    ██ ██   ██  \033[0m"
echo -e "\033[34m ██   ████ ███████ ██   ██    ██     ██████ ███████  ██████   ██████  ██████   \033[0m"
echo -e "\033[34m                                                                               \033[0m"
echo -e "\033[34m                            https://github.com/bl4ck44                         \033[0m"                                                                                                                                                       

}

banner
echo

int_handler (){
    clear
    echo
    echo -e "\033[1m [+] Adios \033[0m"
    kill $PPID
    exit 1
}

trap 'int_handler' INT

if [ "$(id -u)" != "0" ]; then
   echo -e "\033[1m Ejecute este script como root (usando sudo). \033[0m"
   exit 1
fi

echo

   echo
   echo -e "   \033[1m [1] Instalar Requisitos \033[0m"
   echo -e "   \033[1m [2] Configurar Nextcloud \033[0m"
   echo -e "   \033[1m [3] Configurar seguridad de Directorios \033[0m"
   echo -e "   \033[1m [4] Salir \033[0m"

   echo

   read -p $'\033[1m [+] Seleccione una opción: \033[0m' opcion

   case $opcion in

           1) echo
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
           echo -e "   \033[1m [+] Requisitos instalados \033[0m"
           sleep 1.5;;

           2) echo
           source Scripts/configuracion.sh;;

           3) echo
           source Scripts/directorios.sh
           sleep 1.5;;

           4) echo
           clear
           echo -e "\033[1m [+] Adios\033[0m"
           exit;;
           
esac

echo

done