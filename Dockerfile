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
RUN apt-get install -y curl
RUN apt-get install -y systemd

#############################################################################
############################## Run Code-server ##############################
#############################################################################

ENV PWD=test1234

RUN apt-get -yq update
RUN curl -fsSL https://code-server.dev/install.sh | sh
CMD systemctl enable --now code-server@root

WORKDIR /root
RUN mkdir /root/.config
RUN mkdir /root/.config/code-server
WORKDIR /root/.config/code-server
RUN echo "bind-addr: 0.0.0.0:8080\n" \
         "auth: password\n" \
         "password: MyFlutter-0213f\n" \
         "cert: false" > config.yaml

CMD systemctl restart code-server@root

WORKDIR /root

EXPOSE 8080
