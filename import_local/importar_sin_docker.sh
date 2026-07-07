#!/usr/bin/env bash
# ============================================================================
#  Importador SIN DOCKER - Dashboard SEE
#  Carga los datos en PostgreSQL (nativo de tu Mac) y sube los 16 dashboards
#  directamente a TU Grafana que ya esta corriendo (por defecto localhost:3000).
#  Uso:   ./importar_sin_docker.sh
# ============================================================================
set -e
cd "$(dirname "$0")"

DUMP="see_db_dump.sql"
DASH_DIR="dashboards"
PG_URL_FOR_GRAFANA="localhost:5432"

echo ""
echo "=========================================================="
echo "   Dashboard SEE  -  Importar SIN Docker"
echo "=========================================================="

# ---------------------------------------------------------------------------
# 1) Asegurar PostgreSQL (psql) disponible
# ---------------------------------------------------------------------------
if ! command -v psql >/dev/null 2>&1; then
  echo ""
  echo "⚠️  No se encontro PostgreSQL (psql) en tu Mac."
  if command -v brew >/dev/null 2>&1; then
    echo "   Instalando con Homebrew (postgresql@15)... (puede tardar unos minutos)"
    brew install postgresql@15
    export PATH="$(brew --prefix postgresql@15)/bin:$PATH"
    brew services start postgresql@15 || true
    sleep 5
  else
    echo "   No tienes Homebrew. La forma mas facil (sin terminal) es instalar Postgres.app:"
    echo "     1) Descarga:  https://postgresapp.com/"
    echo "     2) Abrelo y haz clic en 'Initialize' / 'Start'."
    echo "     3) Abre una terminal nueva y vuelve a ejecutar:  ./importar_sin_docker.sh"
    exit 1
  fi
fi

# Si postgres esta instalado pero no corriendo (Homebrew), intentar arrancarlo
if command -v brew >/dev/null 2>&1; then
  brew services start postgresql@15 >/dev/null 2>&1 || brew services start postgresql >/dev/null 2>&1 || true
fi

echo ""
echo "🐘 Preparando la base de datos PostgreSQL..."

# ---------------------------------------------------------------------------
# 2) Crear usuario y base, y cargar los datos
# ---------------------------------------------------------------------------
# El superusuario por defecto en Mac suele ser tu propio usuario.
psql -d postgres -v ON_ERROR_STOP=0 -c "CREATE ROLE see_user LOGIN PASSWORD 'see_pass_2026';" 2>/dev/null || echo "   (usuario see_user ya existia, ok)"
psql -d postgres -v ON_ERROR_STOP=0 -c "CREATE DATABASE see_db OWNER see_user;" 2>/dev/null || echo "   (base see_db ya existia, ok)"

echo "📥 Cargando los datos (esto tarda unos segundos)..."
PGPASSWORD=see_pass_2026 psql -h localhost -U see_user -d see_db -q -f "$DUMP"
FILAS=$(PGPASSWORD=see_pass_2026 psql -h localhost -U see_user -d see_db -tAc "SELECT count(*) FROM empleados" 2>/dev/null || echo "0")
echo "   ✅ Datos cargados (empleados en la base: $FILAS)"

# ---------------------------------------------------------------------------
# 3) Datos de tu Grafana
# ---------------------------------------------------------------------------
echo ""
read -r -p "URL de tu Grafana [http://localhost:3000]: " GRAFANA
GRAFANA=${GRAFANA:-http://localhost:3000}
read -r -p "Usuario admin de Grafana [admin]: " GUSER
GUSER=${GUSER:-admin}
read -r -s -p "Contraseña admin de Grafana [admin]: " GPASS
echo ""
GPASS=${GPASS:-admin}
AUTH="-u ${GUSER}:${GPASS}"
API="${GRAFANA%/}/api"

# Verificar conexion
if ! curl -sf $AUTH "$API/org" >/dev/null 2>&1; then
  echo "❌ No pude conectar a Grafana en $GRAFANA con ese usuario/contraseña."
  echo "   Verifica que Grafana este corriendo y que las credenciales admin sean correctas."
  exit 1
fi
echo "🔗 Conectado a Grafana correctamente."

# ---------------------------------------------------------------------------
# 4) Crear/renovar la fuente de datos PostgreSQL (uid: see_pg)
# ---------------------------------------------------------------------------
echo "🔌 Configurando la fuente de datos 'SEE PostgreSQL'..."
curl -s $AUTH -X DELETE "$API/datasources/uid/see_pg" >/dev/null 2>&1 || true
curl -s $AUTH -X POST "$API/datasources" -H "Content-Type: application/json" -d '{
  "name":"SEE PostgreSQL","uid":"see_pg","type":"postgres","access":"proxy",
  "url":"'"$PG_URL_FOR_GRAFANA"'","user":"see_user","database":"see_db","isDefault":true,
  "secureJsonData":{"password":"see_pass_2026"},
  "jsonData":{"sslmode":"disable","postgresVersion":1500}
}' >/dev/null
echo "   ✅ Fuente de datos lista (uid: see_pg)"

# ---------------------------------------------------------------------------
# 5) Crear la carpeta y subir los 16 dashboards
# ---------------------------------------------------------------------------
echo "📊 Creando carpeta y subiendo dashboards..."
curl -s $AUTH -X POST "$API/folders" -H "Content-Type: application/json" \
  -d '{"uid":"see-folder","title":"SEE - Sistema de Entrenamiento"}' >/dev/null 2>&1 || true

N=0
for f in "$DASH_DIR"/*.json; do
  TMP="$(mktemp)"
  printf '{"dashboard":' > "$TMP"
  cat "$f" >> "$TMP"
  printf ',"folderUid":"see-folder","overwrite":true}' >> "$TMP"
  RESP=$(curl -s $AUTH -X POST "$API/dashboards/db" -H "Content-Type: application/json" -d @"$TMP")
  rm -f "$TMP"
  if echo "$RESP" | grep -q '"status":"success"'; then
    N=$((N+1))
    echo "   ✅ $(basename "$f")"
  else
    echo "   ⚠️  Fallo $(basename "$f"): $RESP"
  fi
done

echo ""
echo "=========================================================="
echo "🎉 ¡Listo!  $N/16 dashboards importados en tu Grafana."
echo ""
echo "   Abrelos en:  $GRAFANA"
echo "   Menu izquierdo -> Dashboards -> carpeta 'SEE - Sistema de Entrenamiento'"
echo "=========================================================="
open "$GRAFANA/dashboards" >/dev/null 2>&1 || true
