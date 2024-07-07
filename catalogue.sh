source common.sh
component=catalogue
app_path=/app
NODEJS

PRINT installing mongodb
dnf install mongodb-mongosh -y &>>LOG_FILE
STAT $?

PRINT connecting to master data
mongosh --host mongodb.dev.naifah.online </app/db/master-data.js &>>LOG_FILE
STAT $?

