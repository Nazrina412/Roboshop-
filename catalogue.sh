source common.sh
component=catalogue
NODEJS

dnf install mongodb-mongosh -y
mongosh --host mongodb.dev.naifah.online </app/db/master-data.js


