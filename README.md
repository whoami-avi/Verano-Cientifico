# Dashboard SEE — Sistema de Entrenamiento Electrónico (Grafana)

Solución de **Business Intelligence en Grafana** para el Sistema de Entrenamiento
Electrónico (SEE), que digitaliza los procesos de **Descripciones de Puesto (DDP)**,
**Diagnóstico de Necesidades (DDN)** y **Plan Maestro de Entrenamiento**, con
cumplimiento **IATF 16949:2016** e **ISO 9001:2015**.

---

## 1. Acceso

| Recurso | Valor |
| :-- | :-- |
| **URL del Dashboard** | `https://data-display-36.preview.emergentagent.com/grafana/` |
| Acceso de solo lectura | **Anónimo** (no requiere iniciar sesión, rol Editor) |
| Usuario administrador | `admin` |
| Contraseña administrador | `SEE_admin_2026` |
| Idioma de la interfaz | Español (es-ES) |
| Tema | Oscuro |

> La página raíz redirige automáticamente a `/grafana/`. Al entrar se muestra el
> **Dashboard Ejecutivo** como página de inicio.

---

## 2. Arquitectura

```
Navegador ──HTTPS──> Ingress ──/grafana/*──> Grafana 13 (puerto 3000, subpath /grafana)
                                                   │
                                                   └── Fuente de datos: PostgreSQL 15 (see_db)
```

- **Grafana OSS 13.1** servido bajo el subpath `/grafana` (para no colisionar con la
  ruta `/api` del ingress).
- **PostgreSQL 15** como almacén analítico (base `see_db`, usuario `see_user`).
- **Aprovisionamiento automático**: la fuente de datos y los 16 dashboards se
  cargan desde archivos (`/opt/grafana/conf/provisioning/`), versionables en git.
- Servicios administrados por **supervisor** (`postgresql`, `grafana`).

### Datos ficticios (simulación realista)
| Entidad | Cantidad |
| :-- | :-- |
| Empleados | 600 (≈564 activos) |
| Departamentos | 18 |
| Áreas | 55 |
| Puestos | 150 |
| Descripciones de Puesto (DDP) | 150 |
| Competencias requeridas | ~900 |
| Diagnósticos / evaluaciones | ~5,000 |
| Cursos | ~580 |
| Planes Maestros | 54 (18 deptos × 3 años) |
| Cursos programados | ~1,160 |
| Historial | 3 años (2023–2026) |

---

## 3. Reportes / Dashboards (16)

| # | Dashboard | Objetivo | Visualizaciones |
| :-: | :-- | :-- | :-- |
| 00 | **Dashboard Ejecutivo** | Estado general del sistema | Tarjetas KPI, gauges, donut, barras, serie de tiempo |
| 01 | **Cumplimiento por Departamento** | Comparar departamentos | Barras horizontales + tabla |
| 02 | **Cumplimiento por Planta** | Comparar sitios | Barras, pastel, tabla |
| 03 | **Competencias por Puesto** | Requeridas vs logradas | Barras agrupadas, donut |
| 04 | **Brechas de Competencias** | Detectar faltantes | Mapa de calor (tabla) + barras |
| 05 | **Diagnóstico de Necesidades (DDN)** | Competente vs no competente | Donut, serie de tiempo, tabla |
| 06 | **Plan Maestro de Entrenamiento** | Estatus de cursos | Donut, barras apiladas, tabla |
| 07 | **Cursos Programados** | Vista anual / calendario | Barras por semana, tabla |
| 08 | **Evidencias Digitales** | Documentos cargados | KPIs, barras, tabla |
| 09 | **Métricas IATF 16949** | Cumplimiento normativo | Gauges, bar gauge, tabla |
| 10 | **Métricas ISO 9001** | Control documental | Gauges, barras, serie de tiempo |
| 11 | **Seguimiento de Autorizaciones** | Flujo de firmas | KPIs de tiempo, barras, tabla (timeline) |
| 12 | **Productividad del Sistema** | Tiempo antes vs después | Barras comparativas, KPIs |
| 13 | **Auditorías** | Documentos listos | Gauge, barras, checklist |
| 14 | **Usuarios Activos** | Uso del sistema | Serie de tiempo, barras por mes |
| 15 | **Reportes Predictivos** | Alertas e inteligencia | KPIs de riesgo, barras, tendencia, tabla |

El **Dashboard Ejecutivo** incluye **filtros interactivos** por **Planta** y
**Departamento** (variables de plantilla).

---

## 4. Diccionario de KPIs (principales)

| KPI | Fórmula | Meta | Frecuencia |
| :-- | :-- | :-: | :-: |
| % Cumplimiento de Competencias | (Competencias cumplidas / requeridas) × 100 | ≥ 95% | Mensual |
| % Cumplimiento Plan Maestro | (Cursos realizados / programados) × 100 | ≥ 90% | Mensual |
| % DDP Autorizadas | (DDP firmadas / registradas) × 100 | 100% | Semanal |
| Tiempo de Autorización | Fecha autorización − Fecha envío | ≤ 3 días | Semanal |
| Empleados Activos | Conteo de empleados con estado activo | — | Diario |
| Competencias Evaluadas | Conteo de evaluaciones (última por empleado-competencia) | — | Mensual |
| % Competencias Críticas (IATF) | (Competentes de tipo Normativa / total) × 100 | ≥ 95% | Mensual |
| % Planes Firmados por Gerente | (Planes con firma gerente / total) × 100 | 100% | Trimestral |
| % Documentación Lista Auditoría | (DDP autorizadas / total) × 100 | ≥ 95% | Mensual |
| % Competencias con Evidencia | (Con evidencia / competentes) × 100 | ≥ 95% | Mensual |
| Reducción de Tiempo (productividad) | (Tiempo antes − después) / antes × 100 | ↑ | Anual |
| Competencias por Vencer (30 días) | Conteo con vencimiento en 30 días | ↓ | Semanal |
| Departamentos en Riesgo | Conteo con cumplimiento < 80% | 0 | Mensual |

> Cada panel implementa el KPI con su consulta SQL, umbrales de color (rojo/ámbar/verde)
> y su meta asociada.

---

## 5. Alineación normativa

- **IATF 16949:2016** (Dashboard 09): cláusula 7.2 Competencia y 7.3 Toma de
  conciencia — seguimiento de competencias críticas (tipo *Normativa*), DDP
  autorizadas y firmas del Gerente de Planta.
- **ISO 9001:2015** (Dashboard 10): cláusula 7.5 Información documentada — control
  de documentos (DDP), revisiones y estado de autorización.

---

## 6. Estructura del proyecto

```
/app/scripts/
├── generar_datos.py        # Crea el esquema PostgreSQL y los datos ficticios
├── generar_dashboards.py   # Genera los 16 dashboards (JSON provisionado)
└── validar_queries.py      # Ejecuta las 78 consultas SQL para validarlas

/opt/grafana/conf/
├── see.ini                 # Configuración de Grafana (subpath, idioma, anónimo)
└── provisioning/
    ├── datasources/see.yaml
    └── dashboards/
        ├── see.yaml
        └── json/           # 16 archivos de dashboard
```

### Regenerar datos
```bash
cd /app/scripts && python3 generar_datos.py
```
### Regenerar dashboards
```bash
cd /app/scripts && python3 generar_dashboards.py && sudo supervisorctl restart grafana
```

---

## 7. Notas técnicas

- La API interna de Grafana vive en `/grafana/api/*`, por lo que **no** colisiona con
  la ruta `/api` del entorno (reservada al backend).
- Se inyectó un pequeño *shim* en `index.html` que sanea locales de navegador
  malformados (p. ej. `en-US@posix`) para garantizar el arranque en cualquier entorno.
- El proceso `frontend` (React) fue deshabilitado; el puerto 3000 lo sirve Grafana.
