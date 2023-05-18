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
           source Scripts/requisitos.sh
           echo -e "   \033[1m [+] Requisitos instalados \033[0m"
           sleep 1.5;;

           2) echo
           source Scripts/configuracion.sh;;

           3) echo
           source Scripts/directorios.sh;;

           4) echo
           clear
           echo -e "\033[1m [+] Adios\033[0m"
           exit;;
           
esac

echo

done