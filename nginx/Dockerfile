FROM debian:jessie

RUN apt-get update && apt-get install -y \
  nginx

RUN mkdir /etc/nginx/templates/

# Set environment variables
ENV NGINX_HOST tripfez.dev
ENV NGINX_MOBILE_HOST m.tripfez.dev

COPY nginx.tpl /etc/nginx/nginx.conf
COPY site.tpl /etc/nginx/sites-available/${NGINX_HOST}
COPY site-mobile.tpl /etc/nginx/sites-available/${NGINX_MOBILE_HOST}

RUN ln -s /etc/nginx/sites-available/${NGINX_HOST} /etc/nginx/sites-enabled/${NGINX_HOST}
RUN ln -s /etc/nginx/sites-available/${NGINX_MOBILE_HOST} /etc/nginx/sites-enabled/${NGINX_MOBILE_HOST}
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

VOLUME /var/www
WORKDIR /var/www

EXPOSE 80
EXPOSE 443


CMD ["nginx"]
