FROM wordpress:6.0-php8.1-fpm-alpine


ARG PHP_EXTENSION_PATH=/usr/local/lib/php/extensions/no-debug-non-zts-20210902

ARG PHP_CONF_PATH=/usr/local/etc/php/conf.d

ARG IONCUBE_DOWNLOAD_URL=http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz

ARG WPCLI_DOWNLOAD_URL=http://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

ARG WPCLI_PATH=/usr/local/bin


# download and install ioncube
WORKDIR /tmp

RUN wget ${IONCUBE_DOWNLOAD_URL}

RUN tar -zxvf ioncube_loaders_lin_x86*

RUN cp ioncube/ioncube_loader_lin_8.1.so ${PHP_EXTENSION_PATH}

RUN echo "zend_extension = ${PHP_EXTENSION_PATH}/ioncube_loader_lin_8.1.so" > ${PHP_CONF_PATH}/00-ioncube.ini

RUN rm -rf ioncube_loaders_lin_x86* ioncube


# download and install wpcli
RUN wget ${WPCLI_DOWNLOAD_URL}

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar ${WPCLI_PATH}/wp


# change back working directory
WORKDIR /var/www/html