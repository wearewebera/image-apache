# Webera Apache Image

Repository used to maintain container image with Apache web server running
as unprivileged user. The image Entrypoint manage SIGTERM signal correctly
to graceful stop the container. To use this image:

    docker run --rm -d -p 8080:8080 webera/apache

This image requires PHP-fpm available on fcgi://php:9000/. To disable this
for some test, run inside container:

    a2dismod proxy_fcgi
    apachectl -k graceful

[See on Docker HUB.](https://hub.docker.com/r/webera/apache)
