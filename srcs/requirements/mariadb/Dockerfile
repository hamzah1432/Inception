FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY requirements/mariadb/conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY requirements/mariadb/tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup.sh"]