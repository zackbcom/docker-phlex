FROM alpine:3.6
MAINTAINER Digitalhigh

# Install teh thingz
RUN apk update \
    && apk --no-cache add \
        openssl \
        apache2 \
        apache2-ssl \
        apache2-http2 \
        git \
        iptables \
        php7 \
        php7-apache2 \
        php7-curl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-memcached \
        php7-openssl \
        php7-session \
        php7-sockets \
        php7-xml \
        php7-simplexml \

    && rm /var/cache/apk/* \

    # Run required config / setup for apache
    # Ensure apache can create pid file
    && mkdir /run/apache2 \
    # Allow for custom apache configs
    && mkdir /etc/apache2/conf.d/custom \
    && mv /var/www/modules /etc/apache2/modules \
    && mv /var/www/run /etc/apache2/run \
    && mv /var/www/logs /etc/apache2/logs

WORKDIR /var/www
ADD /config/httpd.conf /etc/apache2/httpd.conf
ADD /config/ssl.conf /etc/apache2/conf.d/ssl.conf
ADD /config/php.ini /etc/php7/php.ini
ADD scripts/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

# Export http and https
EXPOSE 80 443

ENTRYPOINT ["/scripts/run.sh"]
# Run apache in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
