FROM ubuntu:latest
MAINTAINER Dan

RUN apt-get -qq -y update
RUN apt-get -y install default-jre && apt-get -y install default-jdk
RUN apt-get -y install git
RUN apt-get -y install apache2
WORKDIR /var/www/html
RUN git clone https://github.com/ondras/custom-tetris.git
WORKDIR /etc/apache2
RUN sed -i 's/Listen 80/Listen 80\nListen 8089/g' /etc/apache2/ports.conf
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
RUN a2enconf fqdn
ENTRYPOINT service apache2 start &
