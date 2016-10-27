FROM ubuntu
MAINTAINER Dan

RUN apt-get update && apt-get install -y wget
#RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -
#RUN echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list
RUN wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | apt-key add -
RUN echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list
RUN apt-get -y update && apt-get install -y  openjdk-8-jre maven jenkins
EXPOSE 8080
RUN chown jenkins /var/lib/jenkins 
ENTRYPOINT service jenkins start && /bin/bash -c "tail -F /dev/null"
