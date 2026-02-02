FROM alpine:3.23

EXPOSE 9000

RUN apk update && apk add --no-cache php84 php-fpm php-common php-json php-session php-mysqli php84-phar mariadb-client php84-iconv php84-mbstring curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN adduser -S nginx && addgroup -S nginx
RUN echo "memory_limit=1G" >> /etc/php84/php.ini

COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf

COPY ./tools/tool.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/tool.sh

ENTRYPOINT ["/usr/local/bin/tool.sh"]

WORKDIR /var/www/wordpress

CMD ["/usr/sbin/php-fpm84", "-F"]
