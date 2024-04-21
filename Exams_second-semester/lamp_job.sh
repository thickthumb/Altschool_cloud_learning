#!/bin/bash




# Variables
projectname=alt_exam
projectname_root=/var/www/$projectname/resources/views/welcome.blade.php
r2entry=1234
userentry=123456
appurl=http://127.0.0.1
dbconnect=mysql
host=127.0.0.1
sqluser=madu
laravel_repo=https://github.com/laravel/laravel.git
dbdb=laravel
dbport=3306
dbhost=127.0.0.1
adminmail=main@taiwodavid.tech
domainaddress=laravel.taiwodavid.tech

#CODE START  <<<<<<<<<<<<<< Edit beyond here only if you are a Dev >>>>>>>>>

echo "Hello World i am Thickthumb !!! "

sudo apt update
sudo apt upgrade -y

#installing the Lamp stack on ubuntu

sudo apt install apache2 -y 

sudo apt install mysql-server -y

#installing php using ppa
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install php8.3 php8.3-{cli,curl,mysql,gd,intl,mbstring,xml,zip,bcmath} -y

sudo phpenmod xml
sudo phpenmod dom
sudo phpenmod curl

sleep 2

#installing composer latest version
curl -sS https://getcomposer.org/installer -o composer-setup.php

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo composer self-update

#git cloning repository and managing ownership

if [ -d "/var/www/$projectname" ]; then
    echo "Replacing existing folder..."
    sudo rm -r "/var/www/$projectname"
fi

echo "Creating new folder..."

sudo mkdir /var/www/$projectname
sudo chown -R $USER:$USER /var/www/$projectname
cd /var/www/$projectname
git clone $laravel_repo .
echo "Cloned succefully"
sudo cp .env.example .env
sudo chown -R $USER:$USER /var/www/$projectname/.env



#configuring .env credentials for database(mysql)

cd /var/www/$projectname/

if [ -f ~/.my.cnf ]; then
    echo "replacing credentials >>>>>>"
    sudo rm ~/.my.cnf
else
    echo "creating default user confs >>>>"
fi

sudo touch ~/.my.cnf
sudo chown $USER:$USER ~/.my.cnf

echo "[client]
user = root
password = $r2entry" >> ~/.my.cnf
echo "defauls succesfully created>>>4>>>MYSQL."

echo "APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=$dbhost
DB_PORT=3306
DB_DATABASE=$dbdb
DB_USERNAME=root
DB_PASSWORD=$r2entry " >> /var/www/$projectname/.env


 
echo "=========>.env UPDATED<================"


echo "STARTING apache2 configuration>>>>>>>>>>>>>>>>>>>>>>"

#configuring apache2 to host laravel project
sudo touch /etc/apache2/sites-available/$projectname.conf

sudo chown -R $USER:$USER /etc/apache2/sites-available/$projectname.conf

echo "<VirtualHost *:80>

    ServerAdmin $adminmail
    ServerName $domainaddress
    DocumentRoot $projectname_root

    <Directory $projectname_root>
       Options +FollowSymlinks
       AllowOverride All
       Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" > /etc/apache2/sites-available/$projectname.conf

sudo a2enmod rewrite
sudo a2dissite 000-default.conf
sudo a2ensite $projectname.conf

sudo systemctl restart apache2

echo "+++++++++++++++APACHE2 IS NOW ++++++++++++++++++++++++"
echo "+++++++++++++++ HOSTING LARAVEL APP +++++++++++++++++++++++"

#configure mysql database and set-up  user so you can access database as root and a new user.

sudo service mysql start

# Set the root password
#sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$r2entry'; FLUSH PRIVILEGES;"


#mysql -u root -p${r2entry} -e "CREATE DATABASE ${dbdb} /*\!40100 DEFAULT CHARACTER SET utf8 */;"

#mysql -u root -p${r2entry} -e "CREATE USER ${sqluser}@localhost IDENTIFIED BY '${userentry}';"

#mysql -u root -p${r2entry} -e "GRANT ALL PRIVILEGES ON $dbdb.* TO '${sqluser}'@'localhost'; FLUSH PRIVILEGES;"

sudo service mysql restart

echo "+++++++++++++++SUCCESS !!!!+++++++++++++++++++++++"
echo "Successfully created Database and user for $dbconnect"



#setting up laravel to serve...
if [ -f ~/comp.log ]; then
    echo "Replacing existing log..."
    sudo  rm  ~/comp.log
else
    sudo touch ~/comp.log
fi

composer install > ~/comp.log

#php artisan cache:clear
php artisan view:clear
php artisan route:clear

# Stop all existing Laravel servers

echo "All Laravel servers have been stopped."

php artisan key:generate
php artisan migrate 
php artisan db:seed
php artisan serve 

echo "|+|+||+|+||+|+|+|+|+|+|++|+|=======+++++++JOB DONE ++++++=========|+|+|+|+|+|+|+||+|+|"

exit

