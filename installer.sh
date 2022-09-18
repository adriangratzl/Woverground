#!/bin/bash
#Woverground - v0.6
#installer.sh
#Adrian Gratzl - 2022


#Install dependencies
apt update
apt-get -y install jq apache2

#Install Woverground
mkdir -p /usr/share/woverground/
cd /usr/share/woverground/
wget https://github.com/adriangratzl/Woverground/raw/main/woverground.zip -O woverground.zip
unzip woverground.zip
rm -r woverground.zip

#Configure Apache2
rm -r /var/www/html
ln -s /usr/share/woverground/web/website /var/www/html

#Configure Variables and run first time genweb.sh
nano /usr/share/woverground/woverground.conf
bash /usr/share/woverground/web/genweb.sh

#Configure Crontab for automatic execution
crontab -l > mycron
echo "*/5 * * * * /usr/share/woverground/web/genweb.sh" >> mycron
crontab mycron
rm mycron