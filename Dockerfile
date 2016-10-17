FROM ubuntu:latest
MAINTAINER Dan

RUN apt-get -qq -y update
RUN apt-get -y install default-jre && apt-get -y install default-jdk
RUN apt-get -y install git
WORKDIR /home/ubuntu
CMD git clone https://github.com/CamHenlin/roguish.git
WORKDIR /roguish
CMD python -m SimpleHTTPServer 8000 &
CMD echo "All done!"
