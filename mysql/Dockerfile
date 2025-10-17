FROM mysql:8.0

RUN apt-get update && apt-get install -y --no-install-recommends perl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY mysqltuner.pl /usr/local/bin/mysqltuner
RUN chmod +x /usr/local/bin/mysqltuner

COPY run_mysqltuner.sh /docker-entrypoint-initdb.d/run_mysqltuner.sh
RUN chmod +x /docker-entrypoint-initdb.d/run_mysqltuner.sh
