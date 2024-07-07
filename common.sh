LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT() {
  echo
  echo
  echo "########################## $* #################################"

}

NODEJS() {
 PRINT disable Nodejs Default vesion
  dnf module disable nodejs -y &>>LOG_FILE

  PRINT enable Nodejs 20 module
  dnf module enable nodejs:20 -y &>>LOG_FILE
  PRINT install Nodejs
  dnf install nodejs -y &>>LOG_FILE
PRINT copy service file
cp ${component}.service /etc/systemd/system/${component}.service &>>LOG_FILE

PRINT copy mongorepo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_FILE

PRINT adding application user
useradd roboshop &>>LOG_FILE

PRINT cleaning old content
rm -rf /app &>>LOG_FILE

PRINT creating app directory
mkdir /app &>>LOG_FILE

PRINT download app content
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>LOG_FILE


cd /app

PRINT extract Nodejs Dependencies
unzip /tmp/${component}.zip &>>LOG_FILE


cd /app

PRINT downlad Nodejs dependencies
npm install &>LOG_FILE

PRINT start service
systemctl daemon-reload >/tmp/roboshop.log
systemctl enable ${component} &>LOG_FILE
systemctl restart ${component} &>LOG_FILE

}