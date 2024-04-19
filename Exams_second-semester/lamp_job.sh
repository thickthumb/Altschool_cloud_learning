#!/bin/bash

projectname=alt_exam
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


echo "Hello World i am Thickthumb !!! "

sudo apt update
#sudo apt upgrade -y

#installing the Lamp stack on ubuntu

sudo apt install apache2 -y 

sudo apt install mysql-server -y

#installing php using ppa
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install php8.2 php8.2-{cli,curl,mysql,gd,intl,mbstring,xml,zip,bcmath} -y

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


echo "APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=$dbhost
DB_PORT=3306
DB_DATABASE=$dbdb
DB_USERNAME=$sqluser
DB_PASSWORD= " >> /var/www/$projectname/.env

 #sed -i~ '/^APP_URL=/s/=.*/=$appurl/' .env
 #sed -i~ '/^DB_CONNECTION=/s/=.*/=mysql/' .env
 #sed -i~ '/^DB_HOST=/s/=.*/=$dbhost/' .env
 #sed -i~ '/^DB_PORT=/s/=.*/=$dbport/' .env
 #sed -i~ '/^DB_DATABASE=/s/=.*/=$dbdb/' .env
 #sed -i~ '/^DB_USERNAME=/s/=.*/=$sqluser/' .env
 #sed -i~ '/^DB_PASSWORD=/s/=.*/=$userentry/' .env
echo "=========>.env UPDATED<================"


echo "STARTING apache2 configuration>>>>>>>>>>>>>>>>>>>>>>"
#configuring apache2 to host laravel project
sudo touch /etc/apache2/sites-available/$projectname.conf
sudo chown -R $USER:$USER /etc/apache2/sites-available/$projectname.conf

echo "<VirtualHost *:80>

    ServerAdmin $adminmail
    ServerName $domainaddress
    DocumentRoot /var/www/$projectname/public

    <Directory /var/www/$projectname/public>
       Options +FollowSymlinks
       AllowOverride All
       Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" >> /etc/apache2/sites-available/$projectname.conf

sudo a2enmod rewrite
sudo a2dissite 000-default.conf
sudo a2ensite $projectname.conf

sudo systemctl restart apache2

echo "+++++++++++++++APACHE2 IS NOW ++++++++++++++++++++++++"
echo "+++++++++++++++ HOSTING LARAVEL APP +++++++++++++++++++++++"

#configure mysql database and set-up  users

sudo service mysql start

# Set the root password
#sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$r2entry'; FLUSH PRIVILEGES;"

# Restart MySQL service
sudo service mysql restart

#mysql -u root -p${r2entry} -e "CREATE DATABASE ${dbdb} /*\!40100 DEFAULT CHARACTER SET utf8 */;"

#mysql -u root -p${r2entry} -e "CREATE USER ${sqluser}@localhost IDENTIFIED BY '${userentry}';"

#mysql -u root -p${r2entry} -e "GRANT ALL PRIVILEGES ON $dbdb.* TO '${sqluser}'@'localhost'; FLUSH PRIVILEGES;"

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

php artisan cache:clear
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
