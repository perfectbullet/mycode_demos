#!/bin/bash
# by feixueruge 2019.03.22
# install mysql-server by shell scripts
apt-get install mysql-server    # 输入密码 123456 作为mysqldb的root用户密码
# stop mysql server
service mysql stop

# make dir for data base
mkdir -p /disk_d/database/mysql
# modify dir permissions
chmod 700 /disk_d/database/mysql/
# modify dir owner
chown mysql:mysql /disk_d/database/mysql
# copy and stay the permissions
cp -av /var/lib/mysql/* /disk_d/database/mysql/
# delete the logs 
rm -rf /disk_d/database/mysql/ib_logfile0
rm -rf /disk_d/database/mysql/ib_logfile1

# 将 datadir = /var/lib/mysql   修改为 datadir = /disk_d/database/mysql
sed -i /datadir/s/var/disk_d/g /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i /datadir/s/lib/database/g /etc/mysql/mysql.conf.d/mysqld.cnf
# all access is allowed
sed -i 's/^bind-address/#&/' /etc/mysql/mysql.conf.d/mysqld.cnf
# modify /etc/apparmor.d/usr.sbin.mysqld
a="\/var\/lib\/mysql\/"
b="\/disk_d\/database\/mysql\/"
sed -i /$a/s/$a/$b/g /etc/apparmor.d/usr.sbin.mysqld
# restart mysql-service and log in
/etc/init.d/apparmor restart
/etc/init.d/mysql restart
mysql -uroot -p123456 -e "source create_mhsb.sql"
mysql -uroot -p123456 -e "source create_mhsb_tables.sql"
