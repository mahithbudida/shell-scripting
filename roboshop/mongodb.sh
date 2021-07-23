#!/usr/bin/env bash

# It will contain al the common functions
source common.shset-

MSG "Mongo DB Setup process got initiated....!\t"

# Checking whether MONGO DB installed or Not
INSTALL_STATUS "mongodb"

#Setup of MongoDB repo
PRINT "MongoDB Repository Setup\t"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' > /etc/yum.repos.d/mongodb.repo
STAT_CHECK $?

#installing MongoDB
PRINT "MONGO DB Installation..\t"
yum install mongodb-org -y &>>$LOG
STAT_CHECK $?

PRINT "IP address will change from 127.0.0.1 to 0.0.0.0\t"
IP_ADDRESS_CHANGE "127.0.0.1" "0.0.0.0" "/etc/mongod.conf"
STAT_CHECK $?

PRINT "Enabling MONGO DB\t\t"
systemctl enable mongod  &>>$LOG
STAT_CHECK $?

PRINT "Starting MONGO DB\t\t"
systemctl restart mongod  &>>$LOG
STAT_CHECK $?

PRINT "Download MongoDB supported files\t"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"&>>$LOG
STAT_CHECK $?

PRINT "Going to the mongodb files path"
cd /tmp &>>$LOG && unzip mongodb.zip &>>$LOG && cd mongodb-main
STAT_CHECK $?

PRINT "Insert the Catalogue.js file into MONGO DB"
mongo < catalogue.js
STAT_CHECK $?

PRINT "Insert the users.js file into MONGO DB"
mongo < users.js
STAT_CHECK $?

MSG "Mongo DB Setup process got completed.\t"