FROM ubuntu
MAINTAINER Dan

RUN groupadd ibm
RUN useradd -g ibm ibm

WORKDIR /opt
#COPY URBANCODE_DEPLOY_6.2.2_EN_EVAL.zip setupDatabase.sql install.properties /opt/ 
RUN wget https://www.dropbox.com/s/5se6yyeagdbmuot/URBANCODE_DEPLOY_6.2.2_EN_EVAL.zip?dl=0
RUN echo "mysql-5.7-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-5.7-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get -y update && apt-get install -y default-jdk default-jre mysql-server-5.7 libmysql-java unzip sysv-rc-conf sed

RUN service mysql start && mysql -u root -proot < setupDatabase.sql

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN unzip URBANCODE_DEPLOY_6.2.2_EN_EVAL.zip?dl=0
RUN cp /usr/share/java/mysql.jar ibm-ucd-install/lib/ext
RUN cp install.properties /opt/ibm-ucd-install
RUN chmod 755 /opt/ibm-ucd-install/install-server.sh
WORKDIR /opt/ibm-ucd-install

RUN sed -i '/chmod +x "opt\/apache-ant-\${OUR_ANT_VERSION}\/bin\/ant"/ s/$/; sync/' install-server.sh\
&& chmod +x install-server.sh; sync

RUN service mysql start && printf '\n\n' | ./install-server.sh
RUN sed -i 's/@SERVER_USER@/"root"/g' /opt/ibm-ucd/server/bin/init/server
RUN sed -i 's/@SERVER_GROUP@/"root"/g' /opt/ibm-ucd/server/bin/init/server
WORKDIR /etc/init.d
RUN ln -s /opt/ibm-ucd/server/bin/init/server ucdserver
RUN sysv-rc-conf udcserver on

ENTRYPOINT service mysql start && service ucdserver start && /opt/ibm-ucd/server/bin/server run && /bin/bash -c "tail -F /dev/null"
