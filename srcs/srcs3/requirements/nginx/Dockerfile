FROM debian:bookworm

# Update and install NGINX and OpenSSL to create certificates
RUN apt-get update && apt-get install -y \
    nginx \
    openssl && \
    rm -rf /var/lib/apt/lists/*

# Create directories to store certificates
RUN mkdir -p /etc/ssl/private /etc/ssl/certs

# Generate a self-signed SSL certificate to enable the TLS protocol
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=JO/L=Amman/O=42/OU=student/CN=hamza.42.fr"

# Copy our custom configuration file from the host to the container
COPY requirements/nginx/conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]