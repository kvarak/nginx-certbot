FROM ubuntu:18.04

# install nginx
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:nginx/stable  && \
    apt-get update -y && \
    apt-get install -y nginx

# install certbot
RUN add-apt-repository ppa:certbot/certbot && \
    apt-get update -y && \
    apt-get install -y certbot python-certbot-nginx

# deamon mode off
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx

# expose ports
EXPOSE 80 443

# add nginx staging conf
ADD config/staging.conf /etc/nginx/sites-available/kvarak.net

# create symlinks
RUN ln -s /etc/nginx/sites-available/kvarak.net /etc/nginx/sites-enabled/kvarak

# work dir
WORKDIR /etc/nginx

# make certs dir as volume
VOLUME ["/etc/letsencrypt"]
