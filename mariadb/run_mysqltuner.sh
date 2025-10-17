#!/bin/bash
set -e

echo "Running mysqltuner for initial diagnostic..."

ADMIN_BIN="$(command -v mariadb-admin || true)"
[ -z "$ADMIN_BIN" ] && ADMIN_BIN="$(command -v mysqladmin || true)"

if [ -n "$ADMIN_BIN" ]; then
  until "$ADMIN_BIN" ping -h 127.0.0.1 --silent; do
    sleep 2
  done
else
  until [ -S /var/run/mysqld/mysqld.sock ]; do
    sleep 2
  done
fi

mysqltuner --socket /var/run/mysqld/mysqld.sock \
  --user="${MARIADB_USER:-root}" \
  --pass="${MARIADB_PASSWORD:-$MARIADB_ROOT_PASSWORD}" \
  > /var/lib/mysql/mysqltuner-report.txt 2>&1 || true

echo "mysqltuner report saved to /var/lib/mysql/mysqltuner-report.txt"
