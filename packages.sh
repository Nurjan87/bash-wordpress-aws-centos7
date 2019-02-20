#!/bin/bash

#This script works on AWS, CentOS7 Instances.

#This script will install the following packages:
# -wget, -vim, -httpd, -wordpress, -mysql, -php-gd, -php, -php-mysql

yum install wget vim httpd php php-gd php-mysql mysql -y

#This line starts and makes 'Apache' boot-persistent.
systemctl start httpd && systemctl enable httpd

#This line gets the tar file of Wordpress.
wget https://wordpress.org/latest.tar.gz

#This line extracts and copies the folder to '/var/www/html'.
tar xzvf /root/latest.tar.gz && rsync -avP /root/wordpress/ /var/www/html/

#This line creates 'health.html' file under '/var/www/html' for load-balancer's healt-check target.
touch /var/www/html/health.html

#This line changes the ownership of '/var/www/html' to 'apache'.
chown -R apache:apache /var/www/html/

#This line changes 'SELinux' status to 'disabled'.
sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config

#This line reboots the server.
reboot
