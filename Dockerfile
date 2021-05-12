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

ENV PWD=test1234

WORKDIR /root
RUN mkdir /code-server
WORKDIR /root/code-server

RUN wget https://github.com/cdr/code-server/releases/download/v3.10.0/code-server-3.10.0-linux-amd64.tar.gz 

RUN tar -xzvf code-server-3.10.0-linux-amd64.tar.gz 
WORKDIR /root/code-server/code-server-3.10.0-linux-amd64

RUN cp code-server /usr/local/bin
RUN mkdir /var/lib/code-server 

WORKDIR /lib/systemd/system
RUN echo "[Unit]\n" \
         "Description=code-server\n" \
         "After=nginx.service\n" \
         "\n" \
         "[Service]\n" \
         "Type=simple\n" \
         "Environment=PASSWORD=test123\n" \
         "ExecStart=/usr/local/bin/code-server --host 127.0.0.1 --user-data-dir /var/lib/code-server --auth password\n" \
         "Restart=always\n" \
         "\n" \
         "[Install]\n" \
         "WantedBy=multi-user.target" > code-server.service
         
CMD systemctl enable code-server
CMD systemctl start code-server

WORKDIR /etc/nginx/sites-available
RUN echo "server {\n" \
         "    listen 80;\n" \
         "    listen [::]:80;\n" \
         "\n" \
         "    server_name code.lab.frigew.ski;\n" \
         "\n" \
         "    location / {\n" \
         "        proxy_pass http://localhost:8080/;\n" \
         "        proxy_set_header Upgrade $http_upgrade;\n" \
         "        proxy_set_header Connection upgrade;\n" \
         "        proxy_set_header Accept-Encoding gzip;\n" \
         "    }\n" \
         "}\n" > code-server.conf

CMD ln -s /etc/nginx/sites-available/code-server.conf /etc/nginx/sites-enabled/code-server.conf
CMD nginx -t
CMD systemctl restart nginx

CMD add-apt-repository ppa:certbot/certbot
RUN apt-get install -y python-certbot-nginx
CMD ufw allow https
CMD ufw reload

EXPOSE 8080
