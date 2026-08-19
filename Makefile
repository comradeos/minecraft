SHELL := /bin/bash

.DEFAULT_GOAL := help

COMPOSE := docker compose
ENV_FILE := .env

.PHONY: help env doctor config up down restart logs ps pull

help:
	@echo "Available targets:"
	@echo "  make env           Create .env from .env.example"
	@echo "  make doctor        Print runtime diagnostics"
	@echo "  make config        Render resolved Compose config"
	@echo "  make up            Create data dir and start server"
	@echo "  make down          Stop server"
	@echo "  make restart       Restart server"
	@echo "  make logs          Follow server logs"
	@echo "  make ps            Show running containers"
	@echo "  make pull          Pull the configured image"

env:
	@if [[ -f "$(ENV_FILE)" ]]; then \
		echo ".env already exists"; \
	else \
		cp .env.example "$(ENV_FILE)" && echo "Created .env from .env.example"; \
	fi

doctor:
	@bash ./scripts/doctor.sh

config:
	@if [[ ! -f "$(ENV_FILE)" ]]; then \
		echo "Missing .env. Run: make env"; \
		exit 1; \
	fi
	@$(COMPOSE) config

up:
	@if [[ ! -f "$(ENV_FILE)" ]]; then \
		echo "Missing .env. Run: make env"; \
		exit 1; \
	fi
	@set -a; source "$(ENV_FILE)"; set +a; mkdir -p "$${DATA_DIR:-./data}"
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

restart:
	@$(MAKE) down
	@$(MAKE) up

logs:
	@$(COMPOSE) logs -f minecraft

ps:
	@$(COMPOSE) ps

pull:
	@$(COMPOSE) pull
