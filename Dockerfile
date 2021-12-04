FROM alpine:latest

ENTRYPOINT ["/bin/ash"]
VOLUME [ "/var/approot" ]

ARG NGINX_HOST=localhost
ARG NGINX_PORT=80
ARG NGINX_DOCROOT=/var/www/localhost/htdocs
ARG TZ=Asia/Tokyo

RUN ["apk","update"]
RUN ["apk","add","tzdata","git","gettext","nginx",\
"php8","php8-fpm","php8-phar","php8-session","php8-dom",\
"php8-curl","php8-bcmath","php8-ctype","php8-fileinfo",\
"php8-mbstring","php8-openssl","php8-pdo","php8-pdo_mysql",\
"php8-tokenizer","php8-xml","php8-xmlwriter","php8-pecl-redis",\
"php8-pecl-xdebug","composer","nodejs","npm"]
RUN ["ln","-sf","/usr/bin/php8","/usr/bin/php"]
RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

COPY ["root/", "/root/"]
WORKDIR /root

RUN ["composer","self-update"]

RUN envsubst '$NGINX_HOST $NGINX_PORT $NGINX_DOCROOT' < nginx/laravel.conf > /etc/nginx/http.d/default.conf
RUN ["mkdir","-p","/var/log/nginx"]
RUN ["touch","/var/log/nginx/access.log","/var/log/nginx/error.log"]
# RUN ["ln","-sf","/dev/stdout","/var/log/nginx/access.log"]
# RUN ["ln","-sf","/dev/stderr","/var/log/nginx/error.log"]

RUN ["sed","-i","-f","php-fpm.sed","/etc/php8/php-fpm.d/www.conf"]
RUN ["mkdir","-p","/var/log/php8"]
RUN ["touch","/var/log/php8/error.log"]
# RUN ["ln","-sf","/dev/stderr","/var/log/php8/error.log"]
