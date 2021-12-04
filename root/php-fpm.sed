# change to unix domain socket
/^listen *= *127.0.0.1:9000/ {
    s/^/;; /
    a listen = /run/php-fpm8.sock
}

/;php_admin_value\[error_log\] = / {
    s/^;/;; /
    a php_admin_value[error_log] = /var/log/php8/error.log
}
