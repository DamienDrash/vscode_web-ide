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
