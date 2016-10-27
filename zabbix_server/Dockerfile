FROM ubuntu
MAINTAINER Dan

COPY setupDatabase.sql /opt
EXPOSE 3306
RUN groupadd zabbix
RUN useradd -g zabbix zabbix

RUN apt-get -y update\
&& apt-get install -y wget build-essential default-jre default-jdk

WORKDIR /opt
RUN wget http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix/zabbix_3.2.1.orig.tar.gz && tar -zxvf zabbix_3.2.1.orig.tar.gz

RUN echo "mysql-5.7-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-5.7-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install -y mysql-server-5.7 mysql-client-5.7 libmysqlclient20 libmysqlclient-dev libmysqld-dev
RUN mv /opt/setupDatabase.sql /opt/zabbix-3.2.1/database/mysql

WORKDIR /opt/zabbix-3.2.1/database/mysql/
RUN service mysql start && mysql -u root -proot < setupDatabase.sql\
&& mysql -u zabbix -pvagrantup zabbix < schema.sql\
&& mysql -u zabbix -pvagrantup zabbix < images.sql\
&& mysql -u zabbix -pvagrantup zabbix < data.sql

WORKDIR /opt/zabbix-3.2.1
RUN service mysql start && ./configure --enable-server --with-mysql
RUN make install
RUN sed -i 's/# DBPassword=/# DBPassword=\n\nDBPassword=vagrantup/g' /usr/local/etc/zabbix_server.conf

RUN apt-get install -y php-xmlwriter apache2 apache2-doc apache2-utils php-mysql php-gd libapache2-mod-php php php7.0-mbstring php-bcmath

RUN mkdir /var/www/html/zabbix
WORKDIR /opt/zabbix-3.2.1/frontends/php
RUN cp -a . /var/www/html/zabbix

RUN sed -i 's/max_size = 8/max_size = 16/g' /etc/php/7.0/apache2/php.ini
RUN sed -i 's/on_time = 30/on_time = 300/g' /etc/php/7.0/apache2/php.ini
RUN sed -i 's/max_input_time = 60/max_input_time = 300/g' /etc/php/7.0/apache2/php.ini
RUN sed -i 's/;date.timezone =/date.timezone = UTC/g' /etc/php/7.0/apache2/php.ini

COPY zabbix.conf.php /var/www/html/zabbix/conf/
EXPOSE 10051
ENTRYPOINT service mysql start && service apache2 start && zabbix_server && /bin/bash -c "tail -F /dev/null"
