# Inception - Secure Docker Infrastructure 🐳🛡️

*A system administration and infrastructure project developed as part of the 42 curriculum by halmuhis.*

## 📋 Overview

Inception is a system administration project focused on building a secure, containerized web infrastructure using **Docker** and **Docker Compose**. The goal is to deploy three separate services (**Nginx, WordPress, and MariaDB**) where each service operates strictly within its own isolated container.

**Key Security & Architectural Focus:**
*   **Container Isolation:** Implementing the principle of least privilege by ensuring each service runs in a dedicated container without sharing the host network namespace.
*   **Network Security:** Establishing an internal Docker network so containers communicate securely via service names. Only port `443` (HTTPS) is exposed to the outside world; all HTTP (`80`) traffic is strictly denied.
*   **Secure Communication:** Implementing TLS/SSL certificates within Nginx to encrypt all external traffic.
*   **Data Persistence:** Utilizing Docker Volumes (rather than bind mounts) to ensure data persistence for the database and web files safely and efficiently.

---

## 🛠️ Tech Stack & Services

*   **Reverse Proxy / Web Server:** Nginx (TLS/SSL configured)
*   **Database Management:** MariaDB
*   **Content Management System:** WordPress + PHP-FPM
*   **Infrastructure as Code:** Docker, Docker Compose, Alpine Linux / Debian

---

## 🚀 Installation & Usage

**1. Clone the repository:**
\`\`\`bash
git clone https://github.com/hamzah1432/Inception.git
cd Inception
\`\`\`

**2. Configure Environment Variables:**
Rename the example environment file and fill in your secure credentials (the `.env` file is ignored by git for security purposes):
\`\`\`bash
cp .env.example .env
# Edit .env with your preferred configurations
\`\`\`

**3. Setup Local Domain:**
Add the following line to your `/etc/hosts` file to route the domain locally:
\`\`\`text
127.0.0.1 halmuhis.42.fr
\`\`\`

**4. Build and Run the Infrastructure:**
Run the provided Makefile to build images and spin up the containers:
\`\`\`bash
make
\`\`\`
*Access the secure website at: `https://halmuhis.42.fr`*

**5. Stop and Clean Up:**
\`\`\`bash
make down
# To perform a full clean (remove volumes and images)
make fclean 
\`\`\`

---

## 🧠 Theoretical Concepts & Architectural Decisions

### 1. Virtual Machines vs. Docker
While VMs virtualize the entire hardware layer and require a full guest OS (resource-heavy), Docker virtualizes only the application layer. Containers share the host kernel, resulting in lightweight, highly portable, and fast-booting environments.

### 2. Environment Variables & Security
In this project, sensitive data (like database passwords) are managed via `.env` files. *Note: In a production environment, it is highly recommended to use **Docker Secrets** (`/run/secrets/`) to inject credentials directly in-memory, preventing exposure in process lists or logs.*

### 3. Docker Network (Network Isolation)
Instead of using the *Host Network* (which removes isolation), this project enforces a custom **Docker Network**. Containers communicate securely using DNS resolution based on their service names. External access to the database or WordPress backend is completely blocked; only Nginx is exposed via port 443.

### 4. Docker Volumes vs. Bind Mounts
**Docker Volumes** are utilized to persist MariaDB data and WordPress files. Unlike Bind Mounts (which rely on the host's specific directory structure), Volumes are managed directly by the Docker daemon, providing a safer, more consistent, and easily back-up-able data storage solution across different environments.

---

## 📚 Resources
*   [Docker Official Documentation](https://docs.docker.com/)
*   [Nginx Documentation](https://nginx.org/en/docs/)
*   [WordPress CLI](https://wp-cli.org/)
*   [MariaDB Documentation](https://mariadb.com/kb/en/)

*AI Usage: AI was utilized to brainstorm best practices for PID 1 management inside containers, understand the differences between Volumes and Bind Mounts, and structure this documentation.*