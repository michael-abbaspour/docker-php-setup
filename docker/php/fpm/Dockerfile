# syntax=docker/dockerfile:1

ARG PHP_VERSION
ARG PHP_FPM_ALPINE_VERSION
ARG COMPOSER_VERSION

FROM composer:${COMPOSER_VERSION} AS composer-dev-deps

WORKDIR /dependencies

COPY composer.* .

RUN composer install --no-interaction

FROM composer:${COMPOSER_VERSION} AS composer-prod-deps

WORKDIR /dependencies

COPY composer.* .

RUN composer install --no-interaction --no-dev

FROM php:${PHP_VERSION}-fpm-alpine${PHP_FPM_ALPINE_VERSION} AS base

# Add development dependencies
RUN apk add --no-cache --virtual .build-deps \
    curl-dev \
    libc-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev

# Add production dependencies
RUN apk add --no-cache \
    ca-certificates \
    curl \
    git \
    make \
    freetype \
    libjpeg-turbo \
    libpng \
    libxml2 \
    libzip

# Install PHP extensions
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-configure zip --with-zip \
        && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) exif

FROM base AS development

ARG APP_CODE_PATH
ARG APP_PHP_INI_DIR
ARG HOST_PHP_INI_DIR
ARG PHP_INI_FILE
ENV APP_CODE_PATH=${APP_CODE_PATH}
ENV APP_PHP_INI_PATH=${APP_PHP_INI_DIR}/${PHP_INI_FILE}
ENV HOST_PHP_INI_PATH=${HOST_PHP_INI_DIR}/${PHP_INI_FILE}

COPY $HOST_PHP_INI_PATH ${APP_PHP_INI_PATH}

WORKDIR ${APP_CODE_PATH}

COPY --from=composer-dev-deps /dependencies/vendor ${APP_CODE_PATH}/vendor

FROM base AS production

ARG APP_CODE_PATH
ARG APP_PHP_INI_DIR
ARG HOST_PHP_INI_DIR
ARG PHP_INI_FILE
ENV APP_CODE_PATH=${APP_CODE_PATH}
ENV APP_PHP_INI_PATH=${APP_PHP_INI_DIR}/${PHP_INI_FILE}
ENV HOST_PHP_INI_PATH=${HOST_PHP_INI_DIR}/${PHP_INI_FILE}

COPY $HOST_PHP_INI_PATH ${APP_PHP_INI_PATH}

WORKDIR ${APP_CODE_PATH}

COPY src .

COPY --from=composer-prod-deps /dependencies/vendor ${APP_CODE_PATH}/vendor