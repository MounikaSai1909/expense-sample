#!/bin/bash
USERID=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
       echo -e "$2...$R  FAILURE $N"
       exit 1
    else 
       echo -e "$2... $G  SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then 
    echo "Please run with super user"
    exit 1
else 
    echo "You are a super user"
fi

dnf install nginx -y 
VALIDATE $? "Installing nginx"

systemctl enable nginx
VALIDATE $? "Enabling nginx"

systemctl start nginx
VALIDATE $? "Starting nginx"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "Removing Existing Content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
VALIDATE $? "Downloading Frontend Code"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip
VALIDATE $? "unzipping frontend code"

systemctl restart nginx
VALIDATE $? "Restarting nginx"





