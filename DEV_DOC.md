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
- Run `make all` (or simply `make`): This command ensures the correct data directories are created on the host (`/home/$USER/data/...`), builds the Docker images from the provided Dockerfiles, and starts the containers in detached mode.

## Managing Containers and Volumes
Use the following commands from the root directory to manage the infrastructure:
- **Stop containers**: `make down`
- **View container logs**: `docker compose -f srcs/docker-compose.yml logs -f`
- **Access a container's shell**: `docker exec -it <container_name> bash`
- **Full Cleanup**: Run `make fclean`. This will stop all containers, remove the built images, delete the Docker networks, and completely wipe the persistent data volumes on the host machine.

## Data Storage and Persistence
Project data is designed to persist across container restarts and removals. Data is stored on the host machine using Docker named volumes, mapped to specific host paths using the local driver:
- **Database Volume** (`mariadb_data`): Persists MariaDB raw data, stored locally at `/home/halmuhis/data/mariadb`.
- **Website Volume** (`wordpress_data`): Persists WordPress core files, themes, plugins, and user uploads, stored locally at `/home/halmuhis/data/wordpress`.