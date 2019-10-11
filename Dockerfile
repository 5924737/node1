FROM ubuntu
MAINTAINER Kirill <5924737@gmail.com>
RUN apt-get update && apt-get install -y tzdata 
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
&& apt-get install -y git \
&& apt-get install -y nginx \
&& apt-get install -y php7.2 php7.2-common php7.2-cli php7.2-fpm php7.2-gd php7.2-mysql php7.2-curl php7.2-simplexml php7.2-zip \
&& apt-get install -y nano

#WORKDIR ~/.ssh
RUN apt-get -y install ssh
RUN mkdir ~/.ssh
#ADD id_rsa /home/id_rsa
#RUN mkdir /var/www/node
#RUN ssh-keyscan -t rsa domain.com >> ~/.ssh/known_hosts
#RUN git clone git@github.com:5924737/node1.git /var/www/node

#&& apt-get install -y mc
#CMD mkdir
#COPY nginx.conf /etc/nginx/nginx.conf

#COPY nginx/sites-available /etc/nginx/sites-available
#COPY nginx/sites-enabled /etc/nginx/sites-enabled
#COPY site /var/www/site
