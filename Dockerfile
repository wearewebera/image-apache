FROM gcr.io/webera/base

RUN apt-get update \
  && apt-get install -y apache2  \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up the apache environment variables
ENV APACHE_HOME /var/www/public_html
ENV APACHE_HEALTH /var/www/public_html/health
ENV SERVER_ROOT /etc/apache2/
ENV APACHE_PORT 8080
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR $APACHE_HOME $APACHE_HEALTH \
  && chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_HOME $APACHE_LOG_DIR \    
  & sed -i '/Listen/d' /etc/apache2/ports.conf \    
  && a2enmod rewrite proxy_fcgi 

COPY ./misc/apache2.conf "${SERVER_ROOT}/apache2.conf"

COPY ./misc/000-default.conf "${SERVER_ROOT}/sites-enabled/000-default.conf"

COPY ./misc/health.html "${APACHE_HEALTH}/health.html"

USER www-data

STOPSIGNAL SIGWINCH

EXPOSE 8080

CMD [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND"]