FROM webera/base

# Set up the apache environment variables
ENV APACHE_HOME /var/www/public_html
ENV HEALTH_HOME /var/www/health
ENV SERVER_ROOT /etc/apache2/
ENV APACHE_PORT 8080
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/

COPY assets/build.sh /bin
RUN /bin/build.sh && rm /bin/build.sh

COPY ./assets/apache2.conf "${SERVER_ROOT}/"
COPY ./assets/health.html "${HEALTH_HOME}/index.html"
COPY ./assets/000-default.conf "${SERVER_ROOT}/sites-enabled/"
COPY ./assets/health.conf "${SERVER_ROOT}/sites-enabled/"
COPY --chown=33:33 ./assets/index.php "${APACHE_HOME}/"
COPY ./assets/entrypoint.sh /bin/

USER www-data
EXPOSE 8080
ENTRYPOINT ["/bin/entrypoint.sh"]
