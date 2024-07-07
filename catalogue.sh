source common.sh
component=catalogue
NODEJS

PRINT installing mongodb
dnf install mongodb-mongosh -y &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

PRINT connecting to master data
mongosh --host mongodb.dev.naifah.online </app/db/master-data.js &>>LOG_FILE
if [ $? -eq 0 ]; then
    echo success
    else
    echo failure
    fi

