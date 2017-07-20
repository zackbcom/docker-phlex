FROM lsiobase/alpine:3.6
MAINTAINER Digitalhigh

# install packages
RUN \
 apk add --no-cache \
	apache2-utils \
	git \
	iptables \
	gettext \
	libressl2.5-libssl \
	logrotate \
	nano \
	nginx \
	openssl \
	php7 \
	php7-fileinfo \
	php7-fpm \
	php7-json \
	php7-mbstring \
	php7-openssl \
	php7-session \
	php7-simplexml \
	php7-xml \
	php7-xmlwriter \
	php7-zlib && \
	
	# configure nginx
 echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	/etc/nginx/fastcgi_params && \
 rm -f /etc/nginx/conf.d/default.conf && \

# fix logrotate
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf
 
# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Digitalhigh version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# add local files, set custom NGINX directory
COPY root/ /

# ports and volumes

VOLUME /config

ENV HTTPPORT=5666
ENV HTTPSPORT=5667
ENV FASTCGIPORT=9000
ENV TZ=America/Chicago

EXPOSE 5666 5667 9000
