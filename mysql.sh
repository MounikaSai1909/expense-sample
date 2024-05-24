!#/bin/bash
USERID=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
        then
            echo " $2 ....... SUCCESS"
        else
            echo " $2 ....... FAILURE"
    fi

}

if [ $USERID -ne 0]
    then
        echo " please run with root access "
    else    
        echo " you are a super user "
fi
