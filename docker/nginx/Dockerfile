# syntax=docker/dockerfile:1

ARG TARGET_NGINX_VERSION
FROM nginx:${TARGET_NGINX_VERSION}-alpine as development

COPY docker/nginx/conf.d /etc/nginx/conf.d

FROM nginx:${TARGET_NGINX_VERSION}-alpine as production

ARG APP_CODE_PATH
ENV APP_CODE_PATH=${APP_CODE_PATH}

COPY docker/nginx/conf.d /etc/nginx/conf.d
COPY src/public ${APP_CODE_PATH}/public