FROM ubuntu
MAINTAINER Dan

#INSTALLS
RUN apt-get update && apt-get install -y wget build-essential zabbix-agent

WORKDIR /etc/zabbix/

RUN sed -i 's/# ListenPort=10050/ListenPort=10050/g' zabbix_agentd.conf 
RUN sed -i "s/Server=127.0.0.1/Server=172.17.0.2/g" zabbix_agentd.conf
RUN sed -i 's/ServerActive=127.0.0.1/ServerActive=172.17.0.2/g' zabbix_agentd.conf

EXPOSE 10050
ENTRYPOINT /etc/init.d/zabbix-agent start && /bin/bash -c "tail -F /dev/null"
