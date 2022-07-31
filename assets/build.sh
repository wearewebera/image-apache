#!/bin/bash

#
# Install packages
#
apt-get update
apt-get install -y --no-install-recommends apache2
apt-get clean
rm -rf /var/lib/apt/lists/*

#
# Set up directories and permissions
#
mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR $APACHE_HOME $HEALTH_HOME
chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_HOME $APACHE_LOG_DIR

#
# Set up Apache customization
#
sed -i '/Listen/d' /etc/apache2/ports.conf
a2enmod rewrite proxy_fcgi
