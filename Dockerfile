ARG DEBIAN_FRONTEND=noninteractive

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

ENV PUID=0
ENV PGID=0
ENV DOCKER_USER=root
ENV TZ=Europe/Berlin
ENV PASSWORD=DDrash2305
ENV SUDO_PASSWORD=DDrash2305
ENV PROXY_DOMAIN=lab.frigew.ski
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/flutter/bin:/usr/lib/dart/bin
ENV HOME=/config
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM=xterm

WORKDIR /

#####################################################################
############################## FLUTTER ##############################
#####################################################################

RUN apt-get update -y
RUN apt-get install curl --yes \
&& apt-get install git unzip zip --yes
RUN git clone https://github.com/flutter/flutter.git
ENV PATH="/flutter/bin:$PATH"
RUN export PATH="/flutter/bin:$PATH"
RUN flutter doctor

RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter devices

######################################################################
################################ DART ################################
######################################################################

RUN apt-get update -y
RUN apt-get install apt-transport-https -y
RUN apt-get install wget -y
RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

RUN apt-get update
RUN apt-get install dart

ENV PATH="/usr/lib/dart/bin:$PATH"
RUN echo 'export PATH="/usr/lib/dart/bin:$PATH"' >> ~/.profile

######################################################################
############################### PYTHON ###############################
######################################################################

RUN apt-get install python3 -y
RUN apt install python3-pip -y

RUN code-server --install-extension alexisvt.flutter-snippets
RUN code-server --install-extension dart-code.flutter
RUN code-server --install-extension ms-toolsai.jupyter
RUN code-server --install-extension redhat.vscode-yaml
RUN code-server --install-extension dart-code.dart-code
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension nash.awesome-flutter-snippets
RUN code-server --install-extension tushortz.python-extended-snippets

CMD ["/bin/bash"]
