# Makefile

SHELL = /bin/bash

ifndef VERBOSE
MAKEFLAGS += --no-print-directory
endif

help:
	@printf '		'
	@make print-color-blue TEXT='** Available commands **\n\n'
	@make print-color-green TEXT='up-containers'
	@printf '		running docker containers\n'
	@make print-color-green TEXT='up-backend'
	@printf '		running backend services\n'

up-backend: up-containers
	@make composer-install
	@make init-env

up-containers:
	@make docker-compose-exec COMPOSE_CMD="up -d --build"

composer-install:
	@make docker-exec CONTAINER="app" CONTAINER_CMD="composer install -n"

init-env:
	@test -f .env || cp .env .env.local

docker-exec:
	@docker exec -it $(APP_NAME)-$(CONTAINER) $(CONTAINER_CMD)

docker-compose-exec:
	@docker compose $(COMPOSE_CMD)

print-color-green:
	@printf '\033[0;32m${TEXT}\033[0m'

print-color-blue:
	@printf '\033[0;36m${TEXT}\033[0m'
