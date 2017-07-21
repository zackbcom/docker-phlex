FROM scratch
ADD rootfs.tar.gz /
MAINTAINER Digitalhigh

# set arch for s6 overlay
ARG OVERLAY_ARCH="${OVERLAY_ARCH:-amd64}"

# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)$ " \
HOME="/root" \
TERM="xterm"
# install packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	tar && \
	
 apk add --no-cache \
	bash \
	ca-certificates \
	coreutils \
	shadow \
	tzdata && \

# add s6 overlay
  OVERLAY_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/s6-overlay.tar.gz -L \
	"https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz" && \
 tar xfz \
	/tmp/s6-overlay.tar.gz -C / && \
	
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
	
 # create abc user
 groupmod -g 1000 users && \
 useradd -u 911 -U -d /config -s /bin/false abc && \
 usermod -G users abc && \

# make our folders
 mkdir -p \
	/app \
	/config \
	/defaults && \
	
	# configure nginx
 echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	/etc/nginx/fastcgi_params && \
 rm -f /etc/nginx/conf.d/default.conf && \

# clean up
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/* && \

# fix logrotate
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf
 


# add local files, set custom NGINX directory
COPY root/ /

ENTRYPOINT ["/init"]

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
