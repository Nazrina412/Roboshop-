LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT() {
  echo
  echo
  echo "########################## $* #################################"  &>>LOG_FILE
  echo $*

  }
  STAT() {
    # shellcheck disable=SC1072
   if [ $1 -eq 0 ]; then
      echo -e "\e[32mSUCCESS\e[0m"
      else
        echo -e "\e[31mFAILURE\e[0m"
        fi
  }


NODEJS() {
 PRINT disable Nodejs Default vesion
  dnf module disable nodejs -y &>>LOG_FILE
STAT $?


  PRINT enable Nodejs 20 module
  dnf module enable nodejs:20 -y &>>LOG_FILE
 STAT $?

  PRINT install Nodejs
  dnf install nodejs -y &>>LOG_FILE
  STAT $?

PRINT copy service file
cp ${component}.service /etc/systemd/system/${component}.service &>>LOG_FILE
STAT $?

PRINT copy mongorepo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_FILE
STAT $?

PRINT adding application user
useradd roboshop &>>LOG_FILE
STAT $?

PRINT cleaning old content
rm -rf /app &>>LOG_FILE
STAT $?

PRINT creating app directory
mkdir /app &>>LOG_FILE
STAT $?

PRINT download app content
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>LOG_FILE
STAT $?


cd /app

PRINT extract Nodejs Dependencies
unzip /tmp/${component}.zip &>>LOG_FILE
STAT $?

cd /app

PRINT downlad Nodejs dependencies
npm install &>LOG_FILE
STAT $?

PRINT start service
systemctl daemon-reload >/tmp/roboshop.log
systemctl enable ${component} &>LOG_FILE
systemctl restart ${component} &>LOG_FILE
STAT $?

}