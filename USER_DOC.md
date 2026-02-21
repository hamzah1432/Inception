# User Documentation

## Services Provided
This infrastructure provides a complete, secure web hosting stack:
- **Nginx**: The web server. It acts as the only entry point to the infrastructure, handling secure HTTPS connections (TLSv1.2/TLSv1.3) on port 443.
- **WordPress**: The content management system (CMS) used to build and manage the website content.
- **MariaDB**: The database server securely storing all website data, completely isolated from the outside network.

## Starting and Stopping the Project
- **To start the project**: Open a terminal in the project directory and run the command `make`. This will prepare the storage and launch all services in the background.
- **To stop the project**: Run the command `make down`. This will safely stop the services without losing any of your data.

## Accessing the Website and Administration Panel
- **Website**: Open a web browser and navigate to `https://halmuhis.42.fr`. *(Note: Your browser will show a security warning because the SSL certificate is self-signed for local development. You can safely choose to proceed).*
- **Admin Panel**: Navigate to `https://halmuhis.42.fr/wp-admin`. Log in using the administrator credentials.

## Locating and Managing Credentials
All system credentials (passwords, database users, and admin accounts) are configured by the developer during the initial setup. They are securely stored locally on the host machine in the `.env` file (or using Docker secrets). To manage or change these credentials, the system administrator must update these local configuration files and rebuild the infrastructure.

## Checking Service Status
To verify that all services are running correctly, open a terminal in the project folder and run:
`docker compose -f srcs/docker-compose.yml ps`
You should see `nginx`, `wordpress`, and `mariadb` listed with an "Up" status.