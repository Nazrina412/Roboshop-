dnf module disbale redis -y
dnf module enable redis:7 -y
dnf install redis -y
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
sed -i '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
#update redis config file
systemctl enable redis
systemctl start redis

