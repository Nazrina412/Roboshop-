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
  if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

  PRINT enable Nodejs 20 module
  dnf module enable nodejs:20 -y &>>LOG_FILE
  if [ $? -eq 0 ]; then
      echo success
      else
      echo failure
      fi

  PRINT install Nodejs
  dnf install nodejs -y &>>LOG_FILE
  if [ $? -eq 0 ]; then
      echo success
      else
      echo failure
      fi

PRINT copy service file
cp ${component}.service /etc/systemd/system/${component}.service &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

PRINT copy mongorepo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

PRINT adding application user
useradd roboshop &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

PRINT cleaning old content
rm -rf /app &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

PRINT creating app directory
mkdir /app &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

PRINT download app content
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi


cd /app

PRINT extract Nodejs Dependencies
unzip /tmp/${component}.zip &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

cd /app

PRINT downlad Nodejs dependencies
npm install &>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

PRINT start service
systemctl daemon-reload >/tmp/roboshop.log
systemctl enable ${component} &>LOG_FILE
systemctl restart ${component} &>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

}