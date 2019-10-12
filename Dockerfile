# Version: 0.1
FROM ubuntu:18.04
MAINTAINER Kir <5924737@gmail.com>

RUN apt-get update && apt-get install -y tzdata
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install -y php-fpm

RUN apt-get install -y ssh
RUN apt-get install -y git
RUN apt-get install -y nano
RUN apt-get install -y nginx

#WORKDIR /home/kir/.ssh/

RUN mkdir -p /root/.ssh
ADD image/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

WORKDIR /var/www/min
RUN git clone git@github.com:5924737/node1.git /var/www/min
RUN chmod -R 777 /var/www/min/web


# Remove SSH keys
RUN rm -rf /root/.ssh/
RUN rm -rf /var/www/min/image

ADD image/sites-available /etc/nginx/sites-available
ADD image/sites-enabled /etc/nginx/sites-enabled

#RUN echo 'Hi, I am in your container'>/var/www/html/index.html

EXPOSE 80
CMD service nginx start && service php7.2-fpm start && tail -F /var/log/mysql/error.log
#ENTRYPOINT service nginx restart && bash
#CMD /bin/bash /etc/init.d/nginx start
#CMD /bin/bash service nginx start
