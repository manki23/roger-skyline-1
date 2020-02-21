echo "==================================================================\n"
echo "            updating..."
echo "\n"
apt-get -y update
apt-get -y upgrade

echo "\n"
echo "==================================================================\n"
echo "            installing package..."
echo "\n"
apt-get install -y sudo git apache2 sendmail

echo "\n"
echo "==================================================================\n"
echo "            debian disk infos :"
echo "\n"

sudo fdisk -l
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            installing folder..."
echo "\n"

cd /root
git clone https://github.com/manki23/roger-skyline-1.git /root/roger-skyline-1
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            user creation..."
echo "\n"

echo "Adding sudo user... Username ? (default: 'roger')"
read Username
Username=${Username:-"roger"}
sudo adduser $Username
sudo adduser $Username sudo
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            INTERFACES"
echo "\n"

cp /etc/network/interfaces /etc/network/interfaces_save
rm -f /etc/network/interfaces
cp /root/roger-skyline-1/files/interfaces /etc/network

cp /root/roger-skyline-1/files/enp0s3 /etc/network/interfaces.d/

sudo service networking restart
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            SSHD_CONFIG"
echo "\n"

cp /etc/ssh/sshd_config /etc/ssh/sshd_config_save
rm -rf /etc/ssh/sshd_config
cp /root/roger-skyline-1/files/sshd_config /etc/ssh/
mkdir -pv /home/$Username/.ssh
yes '/root/roger-skyline-1/files/id_rsa' | ssh-keygen
cat /root/roger-skyline-1/files/id_rsa.pub >> /home/$Username/.ssh/authorized_keys
ssh-copy-id -i /root/roger-skyline-1/files/id_rsa.pub manki@10.11.45.33 -p 3333

/etc/init.d/ssh restart
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            FIREWALL"
echo "\n"

sh /root/roger-skyline-1/scripts/firewall.sh
echo "done."
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            DDOS PROTECTION"
echo "\n"

sh /root/roger-skyline-1/scripts/ddos.sh
echo "done."
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            PORTS SCAN"
echo "\n"

sh /root/roger-skyline-1/scripts/ports.sh
echo "done."
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            making the configuration persistent..."
echo "\n"

apt-get install -y iptables-persistent

echo "\n"
echo "==================================================================\n"
echo "            MAIL SERVER"
echo "\n"

yes 'Y' | sudo sendmailconfig
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            UPDATE SCRIPT"
echo "\n"

mkdir /root/scripts
cp /root/roger-skyline-1/scripts/script_log.sh /root/scripts/
chmod 755 /root/scripts/script_log.sh
chown root /root/scripts/script_log.sh

echo "0 4 * * wed root /root/scripts/script_log.sh\n" >> /etc/crontab
echo "@reboot root /root/scripts/script_log.sh\n" >> /etc/crontab

echo "0 4 * * wed root /root/scripts/script_log.sh\n" >> /var/spool/cron/crontabs/root
echo "@reboot root /root/scripts/script_log.sh\n" >> /var/spool/cron/crontabs/root

echo "done."
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            CRONTAB SCRIPT"
echo "\n"

cp /root/roger-skyline-1/scripts/script_crontab.sh /root/scripts/
cp /root/roger-skyline-1/files/mail_type.txt /root/scripts/
chmod 755 /root/scripts/script_crontab.sh
chown root /root/scripts/script_crontab.sh
chown root /root/scripts/mail_type.txt

echo "done."
sleep 3s

echo "0 0 * * * root /root/scripts/script_crontab.sh\n" >> /etc/crontab
echo "0 0 * * * root /root/scripts/script_crontab.sh\n" >> /var/spool/cron/crontabs/root

cat /etc/crontab > /root/scripts/tmp
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            WEB SERVER"
echo "\n"

systemctl start apache2

echo "done."
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            VIRTUAL HOST"
echo "\n"

mkdir -p /var/www/init.login.fr/html
chown -R $Username:$Username /var/www/init.login.fr/html
chmod -R 775 /var/www/init.login.fr

cp /root/roger-skyline-1/files/index.html /var/www/init.login.fr/html/
cp -r /root/roger-skyline-1/files/assets /var/www/init.login.fr/html/

cp /root/roger-skyline-1/files/init.login.fr.conf /etc/apache2/sites-available/

rm /etc/apache2/sites-enabled/000-default.conf
ln -s /etc/apache2/sites-available/init.login.fr.conf /etc/apache2/sites-enabled/
#systemctl restart apache2

echo "done."
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            SSL CERTIFICAT"
echo "\n"

cd /etc/ssl/certs/
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout roger.key -out roger.crt

sudo a2enmod ssl
sudo service apache2 restart
sleep 3s

echo "\n"
echo "==================================================================\n"
echo "            CLEANING"
echo "\n"

apt-get remove -y git
rm -rf /root/roger-skyline-1/
echo "Subject: Install done for $Username." | sudo sendmail -v manki@student.42.fr
echo "Work done."
