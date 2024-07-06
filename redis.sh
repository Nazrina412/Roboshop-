dnf module disbale redis -y
dnf module enable redis:7 -y
dnf install redis -y
#update redis config file
systemctl enable redis
systemctl start redis

