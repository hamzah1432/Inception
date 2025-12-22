LOGIN = $(USER)

all: setup
	docker compose -f ./srcs/docker-compose.yml up --build -d

setup:
	@mkdir -p /home/$(LOGIN)/data/mariadb
	@mkdir -p /home/$(LOGIN)/data/wordpress

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a

fclean: clean
	@sudo rm -rf /home/$(LOGIN)/data
	docker volume rm $$(docker volume ls -q)

re: fclean all

.PHONY: all setup down clean fclean re