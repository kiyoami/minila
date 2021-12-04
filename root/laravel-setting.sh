# laravel アプリの準備
chmod 755 -R /var/approot/

cd /var/approot/myapp/

chmod 777 -R bootstrap/cache
chmod 777 -R storage
composer install --optimize-autoloader
php artisan config:cache
php artisan route:cache
php artisan view:cache
