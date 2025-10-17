#!/bin/bash
set -euo pipefail

echo "Running mysqltuner for initial diagnostic..."

SOCKET="/run/mysqld/mysqld.sock"
REPORT="/var/lib/mysql/mysqltuner-report.txt"

ADMIN_BIN="$(command -v mariadb-admin || true)"
[ -z "$ADMIN_BIN" ] && ADMIN_BIN="$(command -v mysqladmin || true)"

for i in {1..90}; do
  if [ -S "$SOCKET" ]; then
    break
  fi
  if [ -n "$ADMIN_BIN" ]; then
    if "$ADMIN_BIN" --socket="$SOCKET" ping --silent >/dev/null 2>&1; then
      break
    fi
  fi
  sleep 2
done

nohup mysqltuner \
  --socket "$SOCKET" \
  --user="${MARIADB_USER:-root}" \
  --pass="${MARIADB_PASSWORD:-${MARIADB_ROOT_PASSWORD:-}}" \
  --silent \
  > "$REPORT" 2>&1 &

echo "mysqltuner started in background; report will be at $REPORT"
