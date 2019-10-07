FROM ubuntu
MAINTAINER Kirill <5924737@gmail.com>

RUN apt-get -y update \
&& apt-get -y upgrade \
&& apt-get -y dist-upgrade \
&& apt-get install -y nginx \
&& apt-get install -y php-fpm \
&& apt-get install -y git \
&& apt-get install -y nano \
&& git clone https://github.com/5924737/dell.git /var/www/site/ \
&& apt-get install -y mc 

#CMD mkdir 
#COPY nginx.conf /etc/nginx/nginx.conf
#COPY sites-available /etc/nginx/sites-available
#COPY sites-enabled /etc/nginx/sites-enabled
#COPY site /var/www/site
