all: setup
	docker compose -f ./srcs/docker-compose.yml up --build -d

setup:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a

fclean: clean
	@sudo rm -rf /home/$(USER)/data
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean all

.PHONY: all setup down clean fclean re