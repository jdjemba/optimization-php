# Executables (local)
DOCKER_COMPOSE := docker compose

## —— 🐳 Docker Makefile 🐳 ————————————————————————————————————————————————————
.PHONY: help
help: ## Outputs this help screen
	@echo ""
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
	@echo ""

## ——————————————————————————————————————————————————————————————————————————————
.PHONY: up
up: ## Start the docker hub in detached mode (no logs)
	$(DOCKER_COMPOSE) up -d --build

.PHONY: down
down: ## Stop the docker hub
	$(DOCKER_COMPOSE) down --remove-orphans

.PHONY: install
install: ## Install composer.json dependencies
	$(DOCKER_COMPOSE) exec optimization-php composer install

.PHONY: ddc
ddc: ## Initialize the database
	$(DOCKER_COMPOSE) exec optimization-php bin/console d:d:c
	psql postgres://postgres:password@localhost/guitareboissieres -f app/var/db.sql

.PHONY: start
start: ## Start the web server
	$(DOCKER_COMPOSE) exec optimization-php php -s 0.0.0.0:8000 -t public/

.PHONY: init
init: ## Initialize the docker containers
	up install

.PHONY: restart
restart: ## Restart the docker containers
	down init
