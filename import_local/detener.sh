#!/usr/bin/env bash
# Detiene el Dashboard SEE (Postgres + Grafana). Los datos se conservan.
cd "$(dirname "$0")"
if docker compose version >/dev/null 2>&1; then
  docker compose down
else
  docker-compose down
fi
echo "🛑 Dashboard SEE detenido. Vuelve a iniciarlo con ./importar.sh"
