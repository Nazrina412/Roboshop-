LOG_FILE=/tmp/roboshop.log

NODEJS() {
  echo disable Nodejs Default vesion
  dnf module disable nodejs -y >$LOG_FILE

  echo enable Nodejs 20 module
  dnf module enable nodejs:20 -y >$LOG_FILE
  echo install Nodejs
  dnf install nodejs -y >$LOG_FILE
echo copy service file
cp ${component}.service /etc/systemd/system/${component}.service >$LOG_FILE

echo copy mongorepo file
cp mongo.repo /etc/yum.repos.d/mongo.repo >$LOG_FILE

echo adding application user
useradd roboshop >$LOG_FILE

echo cleaning old content
rm -rf /app >$LOG_FILE

echo creating app directory
mkdir /app >$LOG_FILE

echo download app content
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip >$LOG_FILE


cd /app

echo extract Nodejs Dependencies
unzip /tmp/${component}.zip >$LOG_FILE


cd /app

echo downlad Nodejs dependencies
npm install >$LOG_FILE

echo start service
systemctl daemon-reload >/tmp/roboshop.log
systemctl enable ${component} >$LOG_FILE
systemctl restart ${component} >$LOG_FILE

}