#!/bin/bash

# Desactivar ServerSignature y establecer ServerTokens en Prod
sed -i 's/^ServerSignature On$/ServerSignature Off/' /etc/apache2/apache2.conf
sed -i 's/^ServerTokens OS$/ServerTokens Prod/' /etc/apache2/apache2.conf

# Reiniciar el servicio de Apache
service apache2 restart

# Desactivar el módulo autoindex
a2dismod --force autoindex

# Reiniciar el servicio de Apache nuevamente
service apache2 restart