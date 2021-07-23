#!/usr/bin/env bash
#user check
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
  echo -e "\e[31mYou should be root user / sudo user to run this script\e[0m"
  exit 2
fi

#Log file details
LOG=/tmp/roboshop.log
rm -f $LOG



# Validation whether the software already installed or not;
INSTALL_STATUS(){
STATUS=$(yum list installed | grep $1* | wc -l)
  if [ $STATUS != 0 ]; then
    Error "$1 Already Installed"
    exit 1
  fi
}

# IP address change in Config file $1 will be the Search item,
# $2 will be the replace item,$3 will be the file location

IP_ADDRESS_CHANGE(){
  sed -i -e "s/$1/$2/" $3
}


MSG() {
  echo -e "\e[32m $1\e[0m"
}
PRINT() {
  echo -n -e "\e[34m$1\e[0m\t\t"
}
Error() {
  echo  -e "\e[31m$1\e[0m\t\t"
}



# Status Check
STAT_CHECK() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m done\e[0m"
  else
    echo -e "\e[31m fail\e[0m"
    exit 1
  fi
}