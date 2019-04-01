#!/bin/bash
# by feixueruge 2019.03.22
# install mongo-server by shell scripts


#install mongodb
apt install -y mongodb
sleep 10

# stop the service
echo "stop mongodb"
service mongodb stop
# mongodbpath=/disk_d/database/mongodb
mkdir -p /disk_d/database/mongodb
chown mongodb:mongodb /disk_d/database/mongodb
cp -ra /var/lib/mongodb  /disk_d/database/mongodb
sleep 10
# modify the config
sed -i /dbpath/s/var/disk_d/g /etc/mongodb.conf
sed -i /dbpath/s/lib/database/g /etc/mongodb.conf
# start the mongodb
echo "start mongodb***************************************************"
service mongodb start
sleep 10

#create user and mhsb database
mongo 127.0.0.1/admin --eval "db.createRole({role:'sysadmin',roles:[], privileges:[{resource:{anyResource:true},actions:['anyAction']}]})"
mongo 127.0.0.1/mhsb --eval "db.createUser({user:'root',pwd:'123456',roles:[{role:'sysadmin',db:'admin'}]})"
# wait for over
sleep 10


# stop the service
echo "stop mongodb"
service mongodb stop
sleep 10
# modify the config
sed -i 's/^bind_ip/#&/' /etc/mongodb.conf
sed -i 's/#port = 27017/port = 8051/' /etc/mongodb.conf
sed -i 's/#auth/auth/' /etc/mongodb.conf
# start the mongodb
echo "start mongodb***************************************************"
service mongodb start
echo "finshed"


