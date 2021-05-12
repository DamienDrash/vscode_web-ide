ARG DEBIAN_FRONTEND=noninteractive 

# Source: https://dev.to/kyorohiro/code-server-with-flutter-web-at-vps-11mg
FROM ubuntu:20.04

MAINTAINER Damien Frigewski <dfrigewski@gmail.com>
LABEL maintainer="dfrigewski@gmail.com"
LABEL Code-Server with pre-installed Python, Dart and Flutter
LABEL version="1.0"
LABEL description="This is a dockerfile for a web based flutter solution \
and also enclosed a VSC IDE for coding."

USER root

RUN apt-get -yq update

RUN apt-get install -y --no-install-recommends tzdata
RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN apt-get install -y wget
RUN apt-get install -y systemd

#############################################################################
############################## Run Code-server ##############################
#############################################################################

WORKDIR /root
RUN mkdir /code-server
RUN cd /code-server

# RUN wget https://github.com/cdr/code-server/releases/download/2.1692-vsc1.39.2/code-server2.1692-vsc1.39.2-linux-x86_64.tar.gz

RUN wget https://github.com/cdr/code-server/releases/download/v3.10.0/code-server-3.10.0-linux-amd64.tar.gz 

RUN tar -xzvf code-server-3.10.0-linux-amd64.tar.gz 
RUN cd code-server-3.10.0-linux-amd64

RUN cp code-server /usr/local/bin
RUN mkdir /var/lib/code-server 
 

