#!/usr/bin/env bash

# It will contain al the common functions
source common.sh

MSG "Front End Server Setup process got initiated....\t"

# Checking whether Nginx installed or Not
INSTALL_STATUS "nginx"

#installing Nginx
PRINT "Nginx Installation..\t"
yum install nginx -y &>>$LOG
STAT_CHECK $?

#Downloading the code the server and placing it in  Nginx Path
PRINT "Download Frontend\t"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"&>>$LOG
STAT_CHECK $?

PRINT "Remove Old HTML documents"
cd /usr/share/nginx/html &>>$LOG && rm -rf * &>>$LOG
STAT_CHECK $?

PRINT "Extract Frontend Archive"
unzip /tmp/frontend.zip &>>$LOG && mv frontend-main/* . &>>$LOG && mv static/* . &>>$LOG  && rm -rf frontend-master static &>>$LOG
STAT_CHECK $?

PRINT "Update RoboShop Config\t"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
STAT_CHECK $?

PRINT "Enabling Nginx\t\t"
systemctl enable nginx  &>>$LOG
STAT_CHECK $?

PRINT "Starting Nginx\t\t"
systemctl restart nginx  &>>$LOG
STAT_CHECK $?

MSG "Front End Server Setup process got initiated\t"