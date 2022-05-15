ifndef BUILD_ENV
$(error BUILD_ENV is not set)
endif

ifeq ($(BUILD_ENV),local)
include .dev.makerc
export
endif

# Assume this is an empty environment, i.e first time pulling the repo
# Build templates, run docker build
init: \
	build_templates \
	local_build \
	start \
	create_initial_database

build_templates: \
	template_local_env \
	template_pgpass \
	template_pgadmin_servers

template_local_env:
	@echo "Creating local.env 🏡";
	@envsubst < .docker/templates/local.env.tpl > ./local.env

template_pgpass:
	@echo "Creating pgpass credentials 🔑";
	@envsubst < .docker/templates/pgpass.tpl > .docker/pgadmin/pgpass

template_pgadmin_servers:
	@echo "Creating pgadmin server connection string 🔗";
	@envsubst < .docker/templates/servers.json.tpl > .docker/pgadmin/servers.json

local_build:
	@echo "Building Docker images (silently, might take a while) 🛠:";
	@docker-compose build -q

start:
	@echo "Starting Docker services 🏁:";
	@docker-compose up -d --quiet-pull

create_initial_database:
	@echo "Creating inital database for application 🔁";
	@docker-compose run web rake db:create

lint:
	@echo "Running Rubocop 👮‍♂️";
	@docker-compose run web rubocop

ps:
	@docker-compose ps

db-logs:
	@docker-compose logs -f postgres

db-shell:
	@docker-compose exec -it postgres /bin/sh

web-logs:
	@docker-compose logs -f web

web-shell:
	@docker-compose exec -it web /bin/sh

stop:
	@echo "Stopping Docker services 🛑:";
	@docker-compose down; \
    if [ -f "tmp/pids/server.pid" ]; then \
        echo "Deleting stale pidfile"; \
		rm -rfv "tmp/pids/server.pid"; \
    fi

cleanup: stop
	@echo "Cleaning up Docker env 🚦";
	@docker-compose down --remove-orphans

full_docker_purge: \
	stop \
	prune_build_cache \
	prune_images \
	prune_volumes

prune_images:
	@echo "Cleaning up ALL docker images 🧹";
	@docker image prune -a;

prune_build_cache:
	@echo "Cleaning up docker build cache 🧹";
	@docker builder prune -a;

prune_volumes:
	@echo "Cleaning up ALL docker volumes 🧹";
	@docker volume prune;

build_push_docker_image:
	@echo "Example command if running in a pipeline, i.e as BUILD_ENV=CI_PROD make build_prod_image";
	@echo "docker build, tag, push etc. Grabbing variables via pipelines rather than a dotenv file."