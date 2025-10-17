#!/bin/bash
set -euo pipefail

echo "Running mysqltuner for initial diagnostic..."

SOCKET="/var/run/mysqld/mysqld.sock"
REPORT="/var/lib/mysql/mysqltuner-report.txt"

for i in {1..120}; do
  [ -S "$SOCKET" ] && break
  sleep 1
done

mysqltuner --socket "$SOCKET" \
  --user="root" --pass="${MYSQL_ROOT_PASSWORD}" \
  > "$REPORT" 2>&1 || true

echo "mysqltuner report saved to $REPORT"
