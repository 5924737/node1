FROM ubuntu
MAINTAINER Kirill <5924737@gmail.com>

RUN apt-get -y update \
&& apt-get -y upgrade \
&& apt-get -y dist-upgrade \
&& apt-get install -y git \
&& apt-get install -y nginx \
&& apt-get install -y php7.2 php7.2-common php7.2-cli php7.2-fpm php7.2-gd php7.2-mysql php7.2-curl php7.2-simplexml php7.2-zip \

&& apt-get install -y nano \
&& git clone https://github.com/5924737/node1.git /var/www/node/

#&& apt-get install -y mc
#CMD mkdir
#COPY nginx.conf /etc/nginx/nginx.conf

COPY /nginx/sites-available /etc/nginx/sites-available
COPY /nginx/sites-enabled /etc/nginx/sites-enabled
#COPY site /var/www/site
