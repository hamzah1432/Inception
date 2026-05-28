# User Documentation

## Services Provided
This infrastructure provides a complete, secure web hosting stack:
- **Nginx**: The web server. It acts as the only entry point to the infrastructure, handling secure HTTPS connections (TLSv1.2/TLSv1.3) on port 443.
- **WordPress**: The content management system (CMS) used to build and manage the website content.
- **MariaDB**: The database server securely storing all website data, completely isolated from the outside network.

## Initial Setup
Before starting the project for the first time, you must map the project's domain to your local machine. Add the following line to your `/etc/hosts` file:
`127.0.0.1 halmuhis.42.fr`
Without this entry, the website URL will not resolve.

## Starting and Stopping the Project
- **To start the project**: Open a terminal in the project directory and run the command `make`. This will prepare the storage and launch all services in the background.
- **To stop the project**: Run the command `make down`. This will safely stop the services without losing any of your data.

## Accessing the Website and Administration Panel
- **Website**: Open a web browser and navigate to `https://halmuhis.42.fr`. *(Note: Your browser will show a security warning because the SSL certificate is self-signed for local development. You can safely choose to proceed).*
- **Admin Panel**: Navigate to `https://halmuhis.42.fr/wp-admin`. Log in using the administrator credentials.

## Locating and Managing Credentials
All system credentials (passwords, database users, and admin accounts) are configured by the developer during the initial setup. They are securely stored locally on the host machine in the `.env` file located inside the `srcs/` directory. To manage or change these credentials, the system administrator must update this file and rebuild the infrastructure with `make re`.

## Checking Service Status
To verify that all services are running correctly, open a terminal in the project folder and run:
`docker compose -f srcs/docker-compose.yml ps`
You should see `nginx`, `wordpress`, and `mariadb` listed with an "Up" status.

## Troubleshooting
- **Website does not load / `DNS_PROBE_FINISHED_NXDOMAIN`**: Confirm the `/etc/hosts` entry `127.0.0.1 halmuhis.42.fr` is present.
- **`502 Bad Gateway`**: The WordPress (php-fpm) container is not ready yet or has crashed. Check its logs with `docker logs wordpress`.
- **WordPress shows "Error establishing a database connection"**: MariaDB may still be initializing on first boot — wait ~10 seconds and refresh. If it persists, check `docker logs mariadb`.
- **Browser security warning on HTTPS**: Expected behavior, the certificate is self-signed. Proceed past the warning.