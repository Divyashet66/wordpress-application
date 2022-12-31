FROM wordpress:apache
# WORKDIR /usr/src/wordpress
# RUN set -eux; \
#     find /etc/apache2 -name '*.conf' -type f -exec sed -ri -e "s!/var/www/html!$PWD!g" -e "s!Directory /var/www/!Directory $PWD!g" '{}' +; \
#     cp -s wp-config-docker.php wp-config.php

# COPY wp-content /var/www/html/wp-content/*
# COPY . ./
# COPY . /var/www/html/
# COPY . /var/www/html
COPY . /var/www/html
COPY wp-content/themes /var/www/html/wp-content/themes/
COPY wp-content/plugins /var/www/html/wp-content/plugins/
COPY wp-content/uploads/ /var/www/html/wp-content/uploads/

# WORKDIR /var/www/html/wp-content/uploads/2022/12
# RUN ls
ENV WORDPRESS_DB_HOST='34.70.223.78' \
    WORDPRESS_DB_USER='cloud-sql-for-wordpress' \
    WORDPRESS_DB_PASSWORD='password' \
    WORDPRESS_DB_NAME='db' \
    WORDPRESS_TABLE_PREFIX='wp_'
# FROM wordpress:php7.1-apache
# COPY . /var/www/ 