cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
systemctl enable mongod
systemctl start mongod
systemctl restart mongod
sed -i '/127.0.0.1/0.0.0.0/' mongo.sh