FROM linuxserver/nginx:latest
MAINTAINER Digitalhigh

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Digitalhigh version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# add local files, set custom NGINX directory
COPY root/ /

# ports and volumes
VOLUME /config
RUN ln -sf /dev/stdout /config/www/Phlex/logs/Phlex.log
RUN ln -sf /dev/stderr /config/www/Phlex/logs/Phlex_error.log

ENV HTTPPORT=5666
ENV HTTPSPORT=5667
ENV FASTCGIPORT=9000


