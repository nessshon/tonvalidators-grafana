#!/bin/bash
echo "Running mysqltuner for initial diagnostic..."

until mysqladmin ping -h localhost --silent; do
  sleep 3
done

mysqltuner --socket /var/run/mysqld/mysqld.sock \
  --user="${MARIADB_USER:-root}" \
  --pass="${MARIADB_PASSWORD:-$MARIADB_ROOT_PASSWORD}" \
  > /var/lib/mysql/mysqltuner-report.txt 2>&1 || true

echo "mysqltuner report saved to /var/lib/mysql/mysqltuner-report.txt"
