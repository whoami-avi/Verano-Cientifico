#!/usr/bin/env bash
# ============================================================================
#  Importador automatico - Dashboard SEE (Sistema de Entrenamiento Electronico)
#  Levanta PostgreSQL (con los datos) + Grafana (16 dashboards) en tu Mac.
#  Uso:   ./importar.sh
# ============================================================================
set -e

# Ir a la carpeta donde vive este script
cd "$(dirname "$0")"

GRAFANA_URL="http://localhost:3001"

echo ""
echo "=========================================================="
echo "   Dashboard SEE  -  Importacion automatica"
echo "=========================================================="
echo ""

# 1) Verificar Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "❌ No se encontro Docker."
  echo "   Instala 'Docker Desktop' desde: https://www.docker.com/products/docker-desktop/"
  echo "   Luego vuelve a ejecutar: ./importar.sh"
  exit 1
fi

# 2) Verificar que el motor de Docker este corriendo
if ! docker info >/dev/null 2>&1; then
  echo "⚠️  Docker esta instalado pero no esta corriendo."
  echo "   Abre la app 'Docker Desktop' y espera a que diga 'Running'."
  # Intentar abrirlo automaticamente en Mac
  open -a Docker >/dev/null 2>&1 || true
  echo "   Esperando a que Docker inicie..."
  for i in $(seq 1 60); do
    if docker info >/dev/null 2>&1; then break; fi
    sleep 2
  done
  if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker no arranco. Abre Docker Desktop manualmente y reintenta."
    exit 1
  fi
fi

# 3) Elegir comando compose (v2 'docker compose' o v1 'docker-compose')
if docker compose version >/dev/null 2>&1; then
  COMPOSE="docker compose"
elif command -v docker-compose >/dev/null 2>&1; then
  COMPOSE="docker-compose"
else
  echo "❌ No se encontro Docker Compose. Actualiza Docker Desktop."
  exit 1
fi

echo "🚀 Levantando servicios (PostgreSQL + Grafana)..."
$COMPOSE up -d

# 4) Esperar a que Grafana responda
echo "⏳ Esperando a que Grafana este lista (esto tarda ~30s la primera vez)..."
OK=0
for i in $(seq 1 60); do
  if curl -sf "$GRAFANA_URL/api/health" >/dev/null 2>&1; then OK=1; break; fi
  sleep 2
done

echo ""
if [ "$OK" = "1" ]; then
  echo "✅ ¡Listo! El Dashboard SEE ya esta corriendo."
  echo ""
  echo "   Abrelo en:  $GRAFANA_URL"
  echo "   (Carpeta 'SEE - Sistema de Entrenamiento' -> 16 dashboards)"
  echo ""
  echo "   Admin:  usuario 'admin'  /  contraseña 'SEE_admin_2026'"
  echo ""
  # Abrir el navegador automaticamente en Mac
  open "$GRAFANA_URL" >/dev/null 2>&1 || true
else
  echo "⚠️  Grafana tardo mas de lo normal. Revisa con:  $COMPOSE logs -f grafana"
  echo "   Y luego abre manualmente: $GRAFANA_URL"
fi

echo "----------------------------------------------------------"
echo "Para DETENER todo:  ./detener.sh   (o  $COMPOSE down)"
echo "Los datos quedan guardados; la proxima vez inicia al instante."
echo "----------------------------------------------------------"
