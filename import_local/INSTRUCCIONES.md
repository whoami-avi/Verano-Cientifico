# Importar el proyecto "Dashboard SEE" en tu Mac

Este paquete contiene TODO lo necesario para ver los 16 dashboards en Grafana:

```
import_local/
├── see_db_dump.sql          # Respaldo completo de la base de datos (datos + esquema)
├── dashboards/              # Los 16 dashboards en formato JSON
├── docker-compose.yml       # Levanta Postgres + Grafana ya configurados (OPCIÓN A)
├── provisioning/            # Configuración automática de fuente de datos y dashboards
│   ├── datasources/see.yaml
│   └── dashboards/see.yaml
├── generar_datos.py         # (opcional) regenerar datos ficticios
├── generar_dashboards.py    # (opcional) regenerar los dashboards
└── INSTRUCCIONES.md         # este archivo
```

> IMPORTANTE: Los dashboards leen sus datos de una base de datos **PostgreSQL**.
> Por eso, además de importar los JSON, necesitas cargar la base de datos y conectar
> una **fuente de datos PostgreSQL** en Grafana. Elige UNA de las dos opciones:

---

## 🚀 LA FORMA MÁS RÁPIDA — Script automático

Requisito: *Docker Desktop* instalado. Solo abre la Terminal y ejecuta:
```bash
cd ruta/al/proyecto/import_local
./importar.sh
```
El script verifica Docker, levanta todo, espera a que Grafana esté lista y **abre el
navegador automáticamente** en http://localhost:3001. Para detener: `./detener.sh`.

(Si tu Mac no deja ejecutarlo, corre antes: `chmod +x importar.sh detener.sh`.)

---

---

## OPCIÓN A — Todo automático con Docker (RECOMENDADA) ✅

Levanta una base PostgreSQL con los datos + una segunda Grafana ya lista, en un solo
comando. No toca tu Grafana actual (usa el puerto 3001).

**Requisito:** tener instalado *Docker Desktop* en tu Mac (https://www.docker.com/products/docker-desktop/).

1. Abre la Terminal y entra a la carpeta del proyecto:
   ```bash
   cd ruta/al/proyecto/import_local
   ```
2. Ejecuta:
   ```bash
   docker compose up -d
   ```
3. Espera ~30 segundos (la base carga los datos la primera vez) y abre:
   ```
   http://localhost:3001
   ```
   ¡Listo! Verás la carpeta **"SEE - Sistema de Entrenamiento"** con los 16 dashboards,
   ya con datos, en español y sin necesidad de iniciar sesión.

Para detenerlo: `docker compose down`  (los datos quedan guardados).

---

## OPCIÓN B — Usar tu Grafana que ya tienes corriendo (localhost:3000)

Necesitas: (1) cargar la base de datos en un PostgreSQL, (2) conectar la fuente de
datos, (3) importar los dashboards.

### Paso 1 — Tener un PostgreSQL con los datos
La forma más rápida (usando Docker solo para la base):
```bash
cd ruta/al/proyecto/import_local
docker run -d --name see_postgres -p 5433:5432 \
  -e POSTGRES_DB=see_db -e POSTGRES_USER=see_user -e POSTGRES_PASSWORD=see_pass_2026 \
  -v "$PWD/see_db_dump.sql:/docker-entrypoint-initdb.d/init.sql:ro" \
  postgres:15
```
La base quedará en **localhost:5433**.

> ¿Prefieres Postgres nativo (Postgres.app / Homebrew)? Crea la base y el usuario,
> y luego carga el respaldo:
> ```bash
> psql -h localhost -U see_user -d see_db -f see_db_dump.sql
> ```

### Paso 2 — Conectar la fuente de datos en tu Grafana
Tienes dos caminos:

**2a. Automático (provisioning):** copia los archivos de `provisioning/` a la carpeta
de provisioning de tu Grafana y reinicia Grafana.
- En Mac con Homebrew (Apple Silicon): `/opt/homebrew/etc/grafana/provisioning/`
- En Mac con Homebrew (Intel): `/usr/local/etc/grafana/provisioning/`
```bash
GRAFANA_PROV=/opt/homebrew/etc/grafana/provisioning   # ajusta según tu instalación
cp provisioning/datasources/see.yaml  "$GRAFANA_PROV/datasources/"
cp provisioning/dashboards/see.yaml   "$GRAFANA_PROV/dashboards/"
mkdir -p /opt/homebrew/var/lib/grafana/dashboards
cp dashboards/*.json /opt/homebrew/var/lib/grafana/dashboards/
```
IMPORTANTE: edita `datasources/see.yaml` y pon la línea de la URL como:
`url: localhost:5433` (o `localhost:5432` si usaste Postgres nativo).
Luego reinicia Grafana: `brew services restart grafana`.
Al terminar tendrás la fuente de datos **y** los 16 dashboards cargados. (Fin.)

**2b. Manual (desde la interfaz):** en tu Grafana ve a
**Connections → Data sources → Add data source → PostgreSQL** y captura:
- Host URL: `localhost:5433`
- Database: `see_db`  •  User: `see_user`  •  Password: `see_pass_2026`
- TLS/SSL Mode: `disable`
- **Importante:** abre la pestaña de configuración avanzada y fija el **UID** de la
  fuente de datos en `see_pg` (los dashboards buscan ese UID). Guarda.

### Paso 3 — Importar los dashboards (solo si hiciste el 2b manual)
Por cada archivo de la carpeta `dashboards/` (son 16):
**Dashboards → New → Import → Upload JSON file** → selecciona el archivo →
elige la fuente de datos **SEE PostgreSQL** → **Import**.

---

## Credenciales
| Recurso | Valor |
| :-- | :-- |
| Grafana admin | `admin` / `SEE_admin_2026` |
| Base de datos | `see_db` / usuario `see_user` / contraseña `see_pass_2026` |

## Los 16 dashboards
00 Ejecutivo · 01 Cumplimiento por Departamento · 02 Cumplimiento por Planta ·
03 Competencias por Puesto · 04 Brechas de Competencias · 05 Diagnóstico de Necesidades ·
06 Plan Maestro · 07 Cursos Programados · 08 Evidencias Digitales · 09 IATF 16949 ·
10 ISO 9001 · 11 Autorizaciones · 12 Productividad · 13 Auditorías · 14 Usuarios Activos ·
15 Reportes Predictivos.

## Consejo
Si algún panel dice "No data", casi siempre es porque la fuente de datos PostgreSQL no
tiene el UID `see_pg` o la URL/puerto no coincide. Revisa el Paso 2.
