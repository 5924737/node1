# Version: 0.1
FROM ubuntu:18.04
MAINTAINER Kir <5924737@gmail.com>

RUN apt-get update && apt-get install -y tzdata
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install -y ssh
RUN apt-get install -y git
RUN apt-get install -y nano
RUN apt-get install -y nginx
RUN apt-get install -y php7.2 php7.2-common php7.2-cli php7.2-fpm php7.2-gd php7.2-mysql php7.2-curl php7.2-simplexml php7.2-zip
#WORKDIR /home/kir/.ssh/

RUN mkdir -p /root/.ssh
ADD image/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

WORKDIR /var/www/node1
RUN git clone git@github.com:5924737/node1.git .

# Remove SSH keys
RUN rm -rf /root/.ssh/
RUN rm -rf /var/www/node1/image

ADD image/sites-available /etc/nginx/sites-available
ADD image/sites-enabled /etc/nginx/sites-enabled
#RUN echo 'Hi, I am in your container'>/var/www/html/index.html
EXPOSE 80
CMD service nginx start && tail -F /var/log/mysql/error.log
#ENTRYPOINT service nginx restart && bash
#CMD /bin/bash /etc/init.d/nginx start
#CMD /bin/bash service nginx start
