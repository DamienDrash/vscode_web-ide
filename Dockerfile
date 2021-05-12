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

#############################################################################
############################## Run Code-server ##############################
#############################################################################

RUN apt-get install -y systemd
RUN apt-get install -y curl
RUN curl -fsSL https://code-server.dev/install.sh | sh
