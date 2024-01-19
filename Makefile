# Include .env from Docker directory
include docker/.env

# Set variables
DOCKER_COMPOSE:=docker compose -f ${DOCKER_DIR}/${DOCKER_COMPOSE_FILE}
DOCKER_COMPOSE_DEV:=${DOCKER_COMPOSE} -f ${DOCKER_DIR}/${DOCKER_COMPOSE_DEV_FILE}

# ==================================================================================== #
# DOCKER
# ==================================================================================== #

## Build all services and start in detached mode.
docker-up-build:
	$(DOCKER_COMPOSE) up --build -d

## Build all services in development mode and start in detached mode.
docker-up-build-dev:
	$(DOCKER_COMPOSE_DEV) up --build -d

## Start all services in detached mode.
docker-up:
	$(DOCKER_COMPOSE) up -d

## Start all services in development mode and in detached mode.
docker-up-dev:
	$(DOCKER_COMPOSE_DEV) up -d

## Stop all running Docker containers.
docker-stop:
	$(DOCKER_COMPOSE) stop

## Stop all running Docker containers in development mode.
docker-stop-dev:
	$(DOCKER_COMPOSE_DEV) stop

## Stops and removes all running containers and networks.
docker-down:
	$(DOCKER_COMPOSE) down

## Stops and removes all running containers and networks in development mode.
docker-down-dev:
	$(DOCKER_COMPOSE_DEV) down

## Stops and removes all running containers, networks, images, and volumes.
docker-down-all:
	$(DOCKER_COMPOSE) down --rmi all -v

## Stops and removes all running containers, networks, images, and volumes in development mode.
docker-down-all-dev:
	$(DOCKER_COMPOSE_DEV) down --rmi all -v

## Checks Docker Compose configuration.
docker-config:
	$(DOCKER_COMPOSE) config

# ==================================================================================== #
# COMPOSER
# ==================================================================================== #