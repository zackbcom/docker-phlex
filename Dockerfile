FROM lsiobase/alpine.nginx:latest
MAINTAINER Zack Baldwin

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache \
	ca-certificates \
	curl \
	tar \
	vim && \


# install runtime packages
 apk add --no-cache \
	php7-dom \
	php7-curl \
	php7-phar \
	php7-sockets && \

# install composer
 ln -sf /usr/bin/php7 /usr/bin/php && \
 curl \
    -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/bin --filename=composer && \

# install phlex
 curl -o \
 	/tmp/phlex.tar.gz -L \
	"https://github.com/zackbcom/Phlex/archive/master.tar.gz" && \
 mkdir -p \
	/apps/phlex && \
 tar xf /tmp/phlex.tar.gz -C \
	/apps/phlex --strip-components=1 && \
 cd /apps/phlex && \
 rm -rf /apps/phlex/vendor && \
 touch /apps/d && \
 composer \
	install --no-dev --optimize-autoloader && \

# cleanup
 rm -rf \
	/root/.composer \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config