FROM ubuntu
MAINTAINER Dan

RUN apt-get -y update && apt-get -y install wget default-jre default-jdk
WORKDIR /opt 
RUN wget https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.2.3-x64.bin -O jira.bin
COPY response.varfile /opt
RUN chmod 755 /opt/jira.bin
RUN /opt/jira.bin -q -varfile response.varfile
EXPOSE 8082
ENTRYPOINT /opt/atlassian/jira/bin/start-jira.sh -fg && /bin/bash -c "tail -F /dev/null"
