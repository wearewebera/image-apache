# Webera Apache Image

Repository used to maintain container image with Apache web server. To use
this image:

    docker run --rm -d -p 8080:8080 webera/apache

This imagem requires PHP-fpm available on fcgi://php:9000/. To disable this
for some test, run inside container:

    a2dismod proxy_fcgi
    apachectl -k graceful

[See on Docker HUB.](https://hub.docker.com/repository/docker/webera/apache)
