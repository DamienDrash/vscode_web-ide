# Source: https://dev.to/kyorohiro/code-server-with-flutter-web-at-vps-11mg
FROM ghcr.io/linuxserver/code-server:latest

MAINTAINER Damien Frigewski <dfrigewski@gmail.com>
LABEL maintainer="dfrigewski@gmail.com"
LABEL Code-Server with pre-installed Python, Dart and Flutter
LABEL version="1.0"
LABEL description="This is a dockerfile for a web based flutter solution \
and also enclosed a VSC IDE for coding."

USER root

ENTRYPOINT /init

ENV PUID=1000
ENV PGID=1000
ENV TZ=Europe/Berlin
ENV PASSWORD=DDrash2305
ENV SUDO_PASSWORD=DDrash2305
ENV PROXY_DOMAIN=code.lab.frigew.ski
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV HOME=/config
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM=xterm

WORKDIR /root

#####################################################################
############################## FLUTTER ##############################
#####################################################################

RUN apt-get install curl -y
RUN apt-get install git -y
RUN apt-get install unzip -y
RUN apt-get install zip -y
RUN git clone https://github.com/flutter/flutter.git
RUN export PATH="$PATH:/root/flutter/bin"
RUN flutter doctor

RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter devices

######################################################################
################################ DART ################################
######################################################################

RUN apt-get update
RUN apt-get install apt-transport-https
RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
 
RUN apt-get update
RUN apt-get install dart

ENV PATH="$PATH:/usr/lib/dart/bin"
RUN echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile

######################################################################
############################### PYTHON ###############################
######################################################################

RUN apt-get install python3
RUN apt install python3-pip
