FROM gcr.io/webera/base

RUN apt-get update \
  && apt-get install -y apache2  \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
