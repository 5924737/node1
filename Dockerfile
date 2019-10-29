# Version: 0.1
FROM ubuntu:18.04
MAINTAINER Kir <5924737@gmail.com>

ADD image/id_rsa /root/.ssh/id_rsa

RUN apt-get update && apt-get install -y tzdata \
&& ln -snf /usr/share/zoneinfo/Europe/Kiev /etc/localtime \
&& echo Europe/Kiev > /etc/timezone \
&& apt-get install -y cron \
&& apt-get install -y nginx \
&& apt-get install -y php7.2-fpm \
&& apt-get install -y sqlite php7.2-sqlite \
&& apt-get install -y git \
&& mkdir -p /root/.ssh \
&& chmod 700 /root/.ssh/id_rsa \
&& echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config \
&& git clone git@github.com:5924737/node1.git /var/www/min \
&& chmod -R 777 /var/www/min/web \
&& chmod -R 777 /var/www/min/sqllite
#RUN apt-get install -y nano

ADD image/default /etc/nginx/sites-available/default
ADD image/htpasswd /etc/nginx/htpasswd
RUN rm -rf /root/.ssh/ \
&& rm -rf /var/www/min/image \
&& rm -f /var/www/min/Dockerfile

# Copy hello-cron file to the cron.d directory
ADD image/hello-cron /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Apply cron job
RUN crontab /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log


EXPOSE 80
WORKDIR /var/www/min
CMD service php7.2-fpm start \
&& service cron start \
&& nginx -g 'daemon off;' \
&& service nginx start
#&& tail -f /var/log/cron.log
# docker run -ti -p1234:80 -v /etc/:/rrr/ --restart unless-stopped b8521afa74af
#&& nginx -g 'daemon off;' \