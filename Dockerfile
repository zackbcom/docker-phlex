FROM nginx:alpine

MAINTAINER Digitalhigh

RUN apk add --no-cache \
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

# add local files, set custom NGINX directory
COPY root/ /

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Digitalhigh version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# ports and volumes

VOLUME /config

ENV HTTPPORT=5066
ENV HTTPSPORT=5067
ENV FASTCGIPORT=9000
ENV TZ=America/Chicago

EXPOSE 5066 5067 9000
