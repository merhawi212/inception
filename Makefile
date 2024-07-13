up:
	docker compose -f ./srcs/docker-compose.yml up --build

nginx:
	docker exec -it nginx sh

wp:
	docker exec -it wordpress sh

mariadb:
	docker exec -it mariadb sh

down:
	docker compose -f ./srcs/docker-compose.yml down

re	: down up

clean:
	docker stop $$(docker ps -qa);				\
	docker rm $$(docker ps -qa);				\
	docker rmi -f $$(docker images -qa);		\
	docker volume rm $$(docker volume ls -q);	\
	docker network rm $$(docker network ls -q);	\
	docker system prune -af						\

.PHONY: all re down clean