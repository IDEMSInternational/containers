FROM php:8.3-fpm-bookworm AS builder
ARG MOODLE_VERSION=4.5.10
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      curl \
      git \
      libfreetype6-dev \
      libicu-dev \
      libjpeg-dev \
      libpng-dev \
      libpq-dev \
      libxml2-dev \
      libzip-dev \
      zlib1g-dev
RUN docker-php-ext-install -j$(nproc) \
      gd \
      intl \
      pcntl \
      pgsql \
      pdo_pgsql \
      soap \
      zip
RUN git clone --depth 1 --branch v${MOODLE_VERSION} https://github.com/moodle/moodle.git /opt/idems/moodle
COPY plugins.* /staging/
RUN /staging/plugins.sh
RUN tar -C /opt/idems/moodle -czf /opt/idems/moodle.tar.gz .

FROM php:8.3-fpm-bookworm
RUN apt-get update && apt-get install --yes --no-install-recommends \
      gettext-base \
      libfreetype6 \
      libicu72 \
      libjpeg62-turbo \
      libpng16-16 \
      libpq5 \
      libxml2 \
      libzip4 \
      zlib1g \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
COPY --from=builder /opt/idems/moodle.tar.gz /opt/idems/moodle.tar.gz
COPY config.php.* cron.sh entrypoint.sh /opt/idems/
COPY idems-php.ini /usr/local/etc/php/conf.d/
RUN mkdir -p /var/www/html /var/www/moodledata
RUN chmod 755 /opt/idems/entrypoint.sh
ENTRYPOINT ["/opt/idems/entrypoint.sh"]
CMD ["php-fpm"]
