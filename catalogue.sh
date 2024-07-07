source common.sh
component=catalogue
NODEJS

echo installing mongodb
dnf install mongodb-mongosh -y &>LOG_FILE

echo connecting to master data
mongosh --host mongodb.dev.naifah.online </app/db/master-data.js &>LOG_FILE


