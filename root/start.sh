#!/bin/sh

if [ -S /run/php-fpm8.sock ] ; then
  ps aux | awk '/php-fpm: master process \(\// {print $1; exit 0}' | xargs kill
fi
php-fpm8 -D
chmod 777 /run/php-fpm8.sock

if [ -e /run/nginx/nginx.pid ] ; then
  nginx -s quit
fi
nginx

tail -f /var/approot/myapp/storage/logs/laravel.log
