FROM ubuntu:latest
MAINTAINER Dan

RUN apt-get -qq -y update
RUN apt-get -y install default-jre && apt-get -y install default-jdk
RUN apt-get -y git
CMD echo "All done!"
