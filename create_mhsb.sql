-- inid data base
create database if not exists mhsb default charset utf8 collate utf8_general_ci;
create user 'Ubuntu'@'%' IDENTIFIED BY '123456';
grant all on mhsb.* TO 'Ubuntu'@'%';




