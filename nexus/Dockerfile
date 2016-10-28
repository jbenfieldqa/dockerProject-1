FROM ubuntu
MAINTAINER Dan

RUN apt-get -y update && apt-get -y install wget default-jre default-jdk
WORKDIR /opt
RUN wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.0.2-02-unix.tar.gz
RUN tar -zxvf /opt/nexus-3.0.2-02-unix.tar.gz
RUN chmod 755 /opt/nexus-3.0.2-02/bin/nexus
EXPOSE 8081
ENTRYPOINT /opt/nexus-3.0.2-02/bin/nexus run && /opt/nexus-3.0.2-02/bin/nexus start && /bin/bash -c "tail -F /dev/null"
