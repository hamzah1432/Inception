all: setup
	docker compose -f ./srcs/docker-compose.yml up --build -d

setup:
	@mkdir -p /home/halmuhis/data/mariadb
	@mkdir -p /home/halmuhis/data/wordpress

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker compose -f ./srcs/docker-compose.yml down -v --rmi all --remove-orphans

fclean: clean
	@sudo rm -rf /home/halmuhis/data

re: fclean all

.PHONY: all setup down clean fclean re