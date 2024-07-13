FROM alpine:3.19

# Update and install PHP 8.1 (and other needed packages)
RUN apk update && apk upgrade && apk add --no-cache \
    curl  php81 php81-fpm php81-phar \
    php81-mysqli php81-curl php81-iconv php81-dom \
    php81-exif php81-gd php81-json php81-fileinfo \
    php81-mbstring php81-openssl php81-xml php81-zip \
    && rm -rf /var/cache/apk/*


RUN mkdir -p /var/www/html/wordpress

# COPY ./conf/www.conf /etc/php81/php-fpm.d/

# downloading wp-cli executable
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

# Set PATH environment variable to include php81
ENV PATH="/usr/bin:${PATH}"
# Create symbolic link for php
RUN ln -s /usr/bin/php81 /usr/bin/php
# Set the working directory
WORKDIR /var/www/html/wordpress

COPY ./tools/wp_entrypoint.sh /tmp/wp_entrypoint.sh

RUN chmod 755 /tmp/wp_entrypoint.sh


LABEL maintainer="Merhawi, mkiflema" \
      version="1.0.0"

ENTRYPOINT [ "sh", "/tmp/wp_entrypoint.sh" ]