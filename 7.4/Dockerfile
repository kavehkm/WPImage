# base image
FROM wordpress:6.0-php7.4-fpm


# args
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG PHP_EXTENSION_PATH=/usr/local/lib/php/extensions/no-debug-non-zts-20190902
ARG PHP_CONF_PATH=/usr/local/etc/php/conf.d
ARG WPCLI_PATH=/usr/local/bin


# workdir
WORKDIR /tmp


# install ioncube
COPY extensions/ioncube_loaders_lin_x86-64.tar.gz .
RUN tar -zxvf ioncube_loaders_lin_x86*
RUN cp ioncube/ioncube_loader_lin_7.4.so ${PHP_EXTENSION_PATH}
RUN echo "zend_extension = ${PHP_EXTENSION_PATH}/ioncube_loader_lin_7.4.so" > ${PHP_CONF_PATH}/00-ioncube.ini
RUN rm -rf ioncube_loaders_lin_x86* ioncube


# install sourceguardian
COPY extensions/ixed.7.4.lin ${PHP_EXTENSION_PATH}
RUN echo "extension = ${PHP_EXTENSION_PATH}/ixed.7.4.lin" > ${PHP_CONF_PATH}/01-sourceguardian.ini

# install wpcli
COPY extensions/wp-cli.phar .
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar ${WPCLI_PATH}/wp


# install soap extension
RUN apt-get -yqq update &&\
    apt-get -y install libxml2-dev &&\
    docker-php-ext-install soap


# customize php upload settings
COPY confs/upload.ini ${PHP_CONF_PATH}


# customize php-fpm settings
COPY confs/www.conf /usr/local/etc/php-fpm.d/www.conf


# add php production settings
RUN mv ${PHP_INI_DIR}/php.ini-production ${PHP_CONF_PATH}/php.ini


# map www-data to host-user
RUN userdel -f www-data &&\
    if getent group www-data ; then groupdel www-data; fi &&\
    groupadd -g ${GROUP_ID} www-data &&\
    useradd -l -u ${USER_ID} -g www-data www-data &&\
    install -d -m 0755 -o www-data -g www-data /home/www-data &&\
    chown --changes --silent --no-dereference --recursive \
          --from=33:33 ${USER_ID}:${GROUP_ID} \
        /home/www-data


# workdir
WORKDIR /var/www/html