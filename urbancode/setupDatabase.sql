create database if not exists urban character set utf8 collate utf8_bin;
grant all privileges on urban.* to ibm@localhost identified by 'root';
flush privileges;
