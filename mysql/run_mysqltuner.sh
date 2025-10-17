#!/bin/bash
set -e

echo "Running mysqltuner for initial diagnostic..."

SOCKET="/var/run/mysqld/mysqld.sock"
until mysqladmin --socket="$SOCKET" ping --silent; do
  sleep 2
done

mysqltuner --socket "$SOCKET" \
  --user="${MYSQL_USER:-root}" \
  --pass="${MYSQL_PASSWORD:-$MYSQL_ROOT_PASSWORD}" \
  > /var/lib/mysql/mysqltuner-report.txt 2>&1 || true

echo "mysqltuner report saved to /var/lib/mysql/mysqltuner-report.txt"
