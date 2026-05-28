*This project has been created as part of the 42 curriculum by halmuhis.*

## Description
Inception is a system administration project that introduces Docker and 
docker-compose. The goal is to set up a small web infrastructure composed 
of three services — Nginx, WordPress, and MariaDB — each running in its 
own dedicated container, following strict security and configuration rules.

## Instructions
1. Add the domain to your `/etc/hosts` file:
   `127.0.0.1 halmuhis.42.fr`
2. Make sure Docker and Docker Compose are installed.
3. Run `make` at the root of the repository.
4. Access the website at `https://halmuhis.42.fr`.
5. Run `make down` to stop the infrastructure.

## Theoretical Concepts & Comparisons

### Virtual Machines vs Docker
Virtual Machines virtualize the entire hardware layer and require a full 
guest OS for each instance — heavy, slow to boot, and resource-intensive.
Docker virtualizes only the application layer. Containers share the host 
kernel, making them lightweight, fast to start, and portable.

### Secrets vs Environment Variables
Environment variables are simple but insecure — exposed through process 
lists, crash dumps, or `docker inspect`. Docker Secrets inject sensitive 
data directly into containers in-memory via `/run/secrets/`, never 
appearing in image history or plain logs.

### Docker Network vs Host Network
Host Network removes isolation between the container and the host — the 
container uses the host's network namespace directly (forbidden in this 
project). Docker Network creates an isolated private network where 
containers communicate using their service names, with only port 443 
exposed to the outside.

### Docker Volumes vs Bind Mounts
Bind Mounts link a specific host path directly into the container — 
dependent on the host directory structure and can break across machines.
Docker Volumes are managed entirely by Docker, safer, easier to back up, 
and consistent regardless of the host OS.

## Resources
- Docker Official Documentation: https://docs.docker.com/
- Nginx Documentation: https://nginx.org/en/docs/
- WordPress CLI: https://wp-cli.org/
- MariaDB Documentation: https://mariadb.com/kb/en/
- **AI Usage:** AI was used to brainstorm best practices for PID 1 
  management inside containers, understand the difference between 
  Docker Volumes and Bind Mounts, and structure the documentation files.