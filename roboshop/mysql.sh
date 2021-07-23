#!/usr/bin/env bash

# It will contain al the common functions
source common.sh

MSG "MYSQL setup will be initiated..."

# Checking whether MYSQL installed or Not
INSTALL_STATUS "MYSQL"

#Setup of MYSQL repo
PRINT "MongoDB Repository Setup\t"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT_CHECK $?

#Installation of MYSQL
PRINT "MYSQL DB Installation...\t"
yum install mysql-community-server -y &>> $LOG
STAT_CHECK $?

PRINT "Enabling MYSQL DB\t\t"
systemctl enable mysqld  &>>$LOG
STAT_CHECK $?

PRINT "Starting MYSQL DB\t\t"
systemctl restart mysqld  &>>$LOG
STAT_CHECK $?


MSG "MYSQL setup will Completed."