FROM alpine:3.19


RUN	apk update && \
		apk upgrade && \
		apk add --no-cache nginx openssl

# creating necessary directories:
# /etc/nginx - will hold the configuration files
# /run/nginx - will hold the runtime files
# /usr/share/nginx/html - will hold static html files
RUN mkdir -p /etc/nginx/ssl /run/nginx /usr/share/nginx/html

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/mkiflema_ssl.cert \
        -keyout /etc/nginx/ssl/mkiflema_ssl.key \
        -subj "/C=AE/ST=Abu Dhabi /L=Abu Dhabi/O=42abudhabi/OU=mkiflema/CN=mkiflema/"

# copy the script to the docker image
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx_entrypoint.sh /tmp/nginx_entrypoint.sh

LABEL maintainer="Merhawi, mkiflema" \
      version="1.0.0"
#run the script
# ENTRYPOINT ["sh", "/tmp/nginx_entrypoint.sh"]
# Start nginx
# CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
CMD ["nginx", "-g", "daemon off;"]