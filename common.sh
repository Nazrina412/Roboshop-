

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

APP
 APP_PREREQ(){
rm -rf ${app_path} &>>$LOG_FILE
STAT $?


print create app directory
mkdir{app_path} &>>LOG_FILE
STAT $?

PRINT Download application content
curl -o /tmp/{component}.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
STAT $?

Print Extract application content
cd /usr/share/nginx/html
unzip /tmp/{component}.zip  &>>LOG_FILE
STAT $?
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
id roboshop &>>LOG_FILE
 if [ $? -ne 0 ]; then
    useradd roboshop &>>$LOG_FILE
  fi
STAT $?


cd /app

PRINT extract Nodejs Dependencies
unzip /tmp/${component}.zip &>>LOG_FILE
STAT $?

cd /app

PRINT downlad Nodejs dependencies
npm install &>>LOG_FILE
STAT $?

PRINT start service
systemctl daemon-reload >/tmp/roboshop.log
systemctl enable ${component} &>>LOG_FILE
systemctl restart ${component} &>>LOG_FILE
STAT $?

}