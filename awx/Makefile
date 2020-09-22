################################################################################
# 変数
################################################################################
REDIS_SOCKET_DIR_PATH := /tmp/AWX/redis-socket/
AWX_PROJECTS_DIR_PATH := /tmp/AWX/var/lib/awx/projects/
AWX_DATABASE_DIR_PATH := /tmp/AWX/postgresql-docker/10/data/

################################################################################
# マクロ
################################################################################

################################################################################
# タスク
################################################################################
.PHONY: up
up: ## ディレクトリ等を用意してdocker-compose up
	@mkdir -p $(REDIS_SOCKET_DIR_PATH)
	@chmod 777 $(REDIS_SOCKET_DIR_PATH)
	@mkdir -p $(AWX_PROJECTS_DIR_PATH)
	@mkdir -p $(AWX_DATABASE_DIR_PATH)
	REDIS_SOCKET_DIR_PATH=$(REDIS_SOCKET_DIR_PATH) \
	AWX_PROJECTS_DIR_PATH=$(AWX_PROJECTS_DIR_PATH) \
	AWX_DATABASE_DIR_PATH=$(AWX_DATABASE_DIR_PATH) \
		docker-compose --compatibility up

# '/usr/bin/update-ca-trust'
.PHONY: update-ca-trust
update-ca-trust:
	docker-compose exec web  /usr/bin/update-ca-trust
	docker-compose exec task /usr/bin/update-ca-trust

.PHONY: down
down: ## docker-compose down
	docker-compose down

.PHONY: clean
clean:
	make down
	docker network prune
	docker volume prune
	sudo rm -rf $(REDIS_SOCKET_DIR_PATH)
	sudo rm -rf $(AWX_PROJECTS_DIR_PATH)
	sudo rm -rf $(AWX_DATABASE_DIR_PATH)
