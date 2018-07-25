#!/bin/bash
echo "\n\n"
echo "#=============================================================================="
echo "# title       : LAPP UBUNTU >= 16 PHP7.1"
echo "# description : INSTALANDO O AMBIENTE PARA DESENVOLVIMENTO LINUX APACHE POSTGRESQL PHP. (LAPP) "
echo "# author      : Claudio Alexssandro Lino"
echo "# site        : http://cecdigitalmaker.com.br"
echo "# github      : https://github.com/codigosecafe"
echo "# date        : 25/07/2018"
echo "# version     : 2.1"
echo "#=============================================================================="
echo "\n"
cd ~/
echo "|----------------------------------------------------|"
echo "##### => Lendo e atualizando os pacotes do sistema"
echo "|----------------------------------------------------|"
sudo apt-get update 
sudo apt-get -y upgrade 
echo "\n"
echo "|----------------------------------------------------|"
echo "##### => Atualizando a distribução do sistema"
echo "|----------------------------------------------------|"
sudo apt-get -y dist-upgrade
echo "\n"
echo "|----------------------------------------------------------------------------------------------|"
echo "##### => Instalando alguns pacotes que serão necessários para realizar nossa configuração."
echo "|----------------------------------------------------------------------------------------------|"
sudo apt-get install -y software-properties-common python-software-properties build-essential libssl-dev
sudo apt-get install -y curl unzip mcrypt git lynx vim aptitude
echo "\n"
echo "|----------------------------------------------------|"
echo "##### => instalando PostgreSQL"
echo "|----------------------------------------------------|"
sudo aptitude install -y postgresql libpq5 postgresql-9.5 postgresql-client-9.5 postgresql-client-common postgresql-contrib

echo "\n"
echo "|----------------------------------------------------|"
echo "##### => Instalando o Apache"
echo "|----------------------------------------------------|"
sudo apt-get install apache2 apache2-utils -y
sudo vim /etc/apache2/envvars
echo "##### => MELHORANDO SEGURANÇA DO APACHE"
sudo vim /etc/apache2/conf-available/security.conf
sudo a2enmod rewrite 
sudo a2enmod deflate
sudo /etc/init.d/apache2 restart
echo "\n"
echo "|----------------------------------------------------|"
echo "##### => Instalando o PHP 7.1"
echo "|----------------------------------------------------|"
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update -y
sudo apt-cache pkgnames | grep php7.1
sudo apt-get install php7.1 php7.1-common php-pear -y
sudo apt-get install php7.1-cli php7.1-gd libapache2-mod-php7.1 php7.1-pgsql php7.1-curl php7.1-json php7.1-soap php-memcached php7.1-dev php7.1-mcrypt php7.1-sqlite3 php7.1-mbstring php7.1-zip php7.1-xml -y
sudo apt-cache pkgnames | grep php7.1
sudo a2dismod php7.2 
sudo a2enmod php7.1 
sudo update-alternatives --set php /usr/bin/php7.1  
php -i | grep /etc/php/7.1/apache2/php.ini
php --ini
sudo /etc/init.d/apache2 restart
echo "\n"
echo "|----------------------------------------------------|"
echo "##### => Instalar o Composer"
echo "|----------------------------------------------------|"
cd ~/
env -i curl -sS https://getcomposer.org/installer | php
env -i sudo mv composer.phar /usr/local/bin/composer
echo "\n"
sudo apt-get update 
sudo apt-get -y upgrade 
sudo apt-get -y clean
sudo apt-get -y autoclean
echo "\n"
echo "#=============================================================================="
echo "# ADICIONANDO PHPPGADMIN"
echo "#=============================================================================="
sudo apt install -y phppgadmin
sudo vim /etc/apache2/conf-available/phppgadmin.conf
sudo vim /etc/phppgadmin/config.inc.php
sudo /etc/init.d/postgresql restart
sudo /etc/init.d/apache2 restart

echo "\n"
echo "#=============================================================================="
echo "# ADICIONANDO MODELO PADROA PARA VHOST"
echo "#=============================================================================="
cd ~/
env -i echo '<VirtualHost *:80>
        ServerAdmin webmaster@localhost

        ServerName dev.padrao
         DocumentRoot /var/www/padrao/public

        <Directory /var/www/padrao/public>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all

                SetOutputFilter DEFLATE
                AddOutputFilterByType DEFLATE text/html
                AddOutputFilterByType DEFLATE text/plain
                AddOutputFilterByType DEFLATE text/xml
                AddOutputFilterByType DEFLATE text/css
                AddOutputFilterByType DEFLATE text/javascript
                AddOutputFilterByType DEFLATE application/javascript
                AddOutputFilterByType DEFLATE application/xhtml+xml
                AddOutputFilterByType DEFLATE application/xml
                AddOutputFilterByType DEFLATE application/rss+xml
                AddOutputFilterByType DEFLATE application/atom_xml
                AddOutputFilterByType DEFLATE application/x-javascript
                AddOutputFilterByType DEFLATE application/x-httpd-php
                AddOutputFilterByType DEFLATE application/x-httpd-fastphp
                AddOutputFilterByType DEFLATE application/x-httpd-eruby
                AddOutputFilterByType DEFLATE image/svg+xml 
                AddOutputFilterByType DEFLATE text/plain
    			AddOutputFilterByType DEFLATE application/json
    			AddOutputFilterByType DEFLATE font/otf
    			AddOutputFilterByType DEFLATE font/ttf

        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/padrao_error.log
        CustomLog ${APACHE_LOG_DIR}/padrao_access.log combined

</VirtualHost>' > ~/padraoCECSERVER.conf
env -i sudo mv padraoCECSERVER.conf /etc/apache2/sites-available/

echo "\n"
echo "#=============================================================================="
echo "# AMBIENTE DE DESENVOLVIMENTO CRIADO"
echo "#=============================================================================="

env -i echo '<?php phpinfo(); ?>' > /var/www/html/cecphp.php
echo "# visualizar PHP INFO:   http://localhost/cecphp.php"

apache2 -v
php -v
pg_config --version
echo "\n"
echo "#=========================== FIM DO SCRIPT ===================================="
echo "\n\n"