create database if not exists zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by 'vagrantup';
flush privileges;
