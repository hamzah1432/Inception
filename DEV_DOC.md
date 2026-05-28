# Developer Documentation

## Setting Up the Environment from Scratch
1. **Prerequisites**: Ensure Docker, Docker Compose, and `make` are installed on your host machine.
2. **Hosts File Configuration**: To allow the local Nginx server to resolve the required domain name, add the following line to your `/etc/hosts` file:
   `127.0.0.1 halmuhis.42.fr`
3. **Configuration & Secrets**:
   - Create a `.env` file inside the `srcs` directory. This file must contain the required environment variables such as `DOMAIN_NAME`, `MYSQL_DATABASE`, `MYSQL_USER`, etc.
   - *Security Note*: Ensure that real passwords and API keys are strictly kept local and are never pushed to the Git repository.

## Building and Launching the Project
The project uses a `Makefile` at the root directory to orchestrate Docker Compose commands:
- Run `make all` (or simply `make`): This command ensures the correct data directories are created on the host (`/home/halmuhis/data/mariadb` and `/home/halmuhis/data/wordpress`), builds the Docker images from the provided Dockerfiles, and starts the containers in detached mode.

## Managing Containers and Volumes
Use the following commands from the root directory to manage the infrastructure:
- **Stop containers**: `make down`
- **Light cleanup**: `make clean` — stops containers and removes images, volumes, and orphan resources, but keeps the host data directories.
- **Full cleanup**: `make fclean` — performs `clean` then wipes `/home/halmuhis/data` on the host.
- **Rebuild from scratch**: `make re` — equivalent to `make fclean && make all`.
- **View container logs**: `docker compose -f srcs/docker-compose.yml logs -f`
- **Access a container's shell**: `docker exec -it <container_name> bash`

## Container Entrypoint Patterns (PID 1)
Each container runs its main process as PID 1 so that signals (SIGTERM from `docker stop`) reach it directly and child processes are reaped:
- **nginx**: `CMD ["nginx", "-g", "daemon off;"]` — exec form, foreground.
- **wordpress**: entrypoint script ends with `exec /usr/sbin/php-fpm8.2 -F` — `-F` runs php-fpm in foreground.
- **mariadb**: entrypoint script first bootstraps the database with a temporary `mysqld --skip-grant-tables` instance (to create users and set the root password), waits for it via `mysqladmin ping`, shuts it down cleanly with `mysqladmin shutdown`, then `exec mysqld --user=mysql` to take over as PID 1 with privilege tables enforced.
- **wait-for-mariadb**: the wordpress entrypoint polls `mariadb-admin ping -h mariadb` instead of using a fixed sleep — this is race-free and survives slow first-boots of the database container.

## Data Storage and Persistence
Project data is designed to persist across container restarts and removals. Data is stored on the host machine using Docker named volumes, mapped to specific host paths using the local driver:
- **Database Volume** (`mariadb_data`): Persists MariaDB raw data, stored locally at `/home/halmuhis/data/mariadb`.
- **Website Volume** (`wordpress_data`): Persists WordPress core files, themes, plugins, and user uploads, stored locally at `/home/halmuhis/data/wordpress`.