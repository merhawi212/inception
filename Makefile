LOCAL_DATA_VOLUME = ./srcs/data
up:
# bash ./srcs/requirements/tools/init_vp.sh
	mkdir -p /home/${USER}/data/db
	mkdir -p /home/${USER}/data/wp
	docker compose -f ./srcs/docker-compose.yml up --build

nginx:
	docker exec -it nginx sh

wp:
	docker exec -it wordpress sh

mariadb:
	docker exec -it mariadb sh

down:
	docker compose -f ./srcs/docker-compose.yml down

start:
	docker compose -f ./srcs/docker-compose.yml start

stop:
	docker compose -f ./srcs/docker-compose.yml stop

re: down up

restart: stop start

clean:
	rm -rf $(LOCAL_DATA_VOLUME)
	docker stop $$(docker ps -qa);				\
	docker rm $$(docker ps -qa);				\
	docker rmi -f $$(docker images -qa);		\
	docker volume rm $$(docker volume ls -q);	\
	docker network rm $$(docker network ls -q);	\
	docker system prune -af						\

rebuild: clean up

.PHONY: all re down clean