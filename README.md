*This project has been created as part of the 42 curriculum by halmuhis.*

## Description
Inception is a system administration project that introduces Docker and docker-compose. The goal is to broaden system administration knowledge by virtualizing several Docker images and setting up a small web infrastructure consisting of Nginx, WordPress, and MariaDB. Each service runs in its own dedicated container and follows strict security and configuration rules.

## Instructions
1. Map the domain name to your local IP by adding the following line to your `/etc/hosts` file:
   `127.0.0.1 halmuhis.42.fr`
2. Ensure you have the necessary environment variables and configuration files set up in the `srcs` directory.
3. Run `make` at the root of the repository. This will build the Docker images and start the containers.
4. Access the website at `https://halmuhis.42.fr`.
5. Run `make down` to gracefully stop the infrastructure.

## Theoretical Concepts & Comparisons

### Virtual Machines vs Docker
Virtual Machines (VMs) virtualize the entire hardware layer and require a full guest Operating System for each instance, making them heavy, resource-intensive, and slow to boot. Docker, on the other hand, virtualizes only the application layer (OS-level virtualization). Containers share the host machine's kernel, making them extremely lightweight, fast to start, and highly portable.

### Secrets vs Environment Variables
Environment variables are easy to use for configuration but can be insecure for sensitive data, as they can be easily exposed through process lists, crash dumps, or container inspections. Docker Secrets provide a secure mechanism to inject sensitive information (like database passwords) directly into the containers in-memory (typically mounted in `/run/secrets/`), ensuring they are never exposed in the image history or plain environment logs.

### Docker Network vs Host Network
Using a Host Network removes network isolation between the container and the Docker host, allowing the container to use the host's networking namespace directly (which is forbidden in this project). A Docker Network (like the custom bridge network used here) creates an isolated, private network where containers can securely resolve and communicate with each other using their container names, while only explicitly mapped ports (like 443) are exposed to the outside world.

### Docker Volumes vs Bind Mounts
Bind Mounts link a specific path on the host machine directly into the container. They are highly dependent on the host's exact directory structure and OS permissions, which can cause portability issues. Docker Volumes are entirely managed by Docker within a specific storage directory on the host. They are safer, easier to back up, and provide consistent behavior regardless of the host OS, making them the preferred choice for persistent storage.

## Resources
- Docker Official Documentation: https://docs.docker.com/
- Nginx, WordPress, and MariaDB official documentation.
- **AI Usage:** Artificial Intelligence was used during the development of this project to brainstorm best practices for PID 1 management inside containers, structure the documentation files, and clarify the technical differences between Docker Volumes and Bind Mounts.