# PRD — Dashboard SEE (Sistema de Entrenamiento Electrónico) en Grafana

## Problema original
El usuario solicitó la **creación de un dashboard con Grafana o Metabase** siguiendo
dos documentos: `PRESENTACION1.pdf` (manual/diseño de la base de datos de los módulos
DDP y DDN del Sistema de Entrenamiento Electrónico) y `simulador G2.pdf` (especificación
de ~15 reportes, ~35 KPIs, cumplimiento IATF 16949 / ISO 9001, datos ficticios de ~600
empleados, 18 departamentos, 150 puestos, ~7,000 competencias y 3 años de historia).

## Decisiones del usuario
- Herramienta: **Grafana real** (obligatorio, no un clon en React).
- Idioma: **Español**.
- Datos: **generados automáticamente** (ficticios, realistas).
- Alcance: **los ~15 reportes completos desde el inicio**.
- Diseño: libre, acorde al contexto (tema oscuro corporativo).

## Arquitectura
- Grafana OSS 13.1 en puerto 3000, subpath `/grafana` (evita colisión con `/api`).
- PostgreSQL 15 (`see_db`) como fuente de datos analítica.
- Aprovisionamiento por archivos (datasource + 16 dashboards JSON).
- Supervisor: programas `postgresql` y `grafana`. Proceso `frontend` neutralizado
  (no-op) para liberar el puerto 3000.
- Shim de saneo de locale inyectado en `index.html` de Grafana.

## Implementado (2026-06)
- Esquema PostgreSQL de 14 tablas (catálogos + DDP + DDN + Plan Maestro + accesos +
  productividad) y generador de datos ficticios (`/app/scripts/generar_datos.py`).
- Datos: 600 empleados, 18 deptos, 55 áreas, 150 puestos, 150 DDP, ~900 competencias,
  ~5,000 diagnósticos, ~580 cursos, 54 planes maestros, ~1,160 cursos programados,
  1,096 días de accesos (3 años).
- **16 dashboards** (`/app/scripts/generar_dashboards.py`) con **78 paneles** y sus
  consultas SQL, cubriendo los 15 reportes del documento + módulo predictivo.
- **~35+ KPIs** con umbrales/metas, alineados a IATF 16949 e ISO 9001.
- Interfaz en español, tema oscuro, acceso anónimo, filtros por Planta/Departamento.
- Validación: 78/78 consultas SQL ejecutan sin error; salud de Grafana OK; sin errores
  de arranque; shell de Grafana renderiza en español (verificado por captura).

## Personas
- Directivos / Gerente de Planta: Dashboard Ejecutivo, Productividad, Predictivo.
- MNJ de Entrenamiento / RH: Plan Maestro, DDN, Autorizaciones, Auditorías.
- MNJ de Departamento: Cumplimiento por Depto, Competencias por Puesto, Brechas.
- Auditores IATF/ISO: Dashboards 09, 10, 13 (Evidencias, Auditorías).

## Backlog / Próximos pasos (P1/P2)
- P1: Documentación extensa (30–40 páginas) con diccionario completo de ~35 KPIs,
  ~40 consultas SQL comentadas y ~20 casos de uso (entregable del `simulador G2.pdf`).
- P1: Panel tipo Gantt real para Plan Maestro (plugin comunitario) y vista calendario.
- P2: Exportación a PDF de dashboards (requiere image-renderer; no disponible en arm64,
  evaluar alternativa como reporte HTML o servicio de render externo).
- P2: Autenticación por roles (Creador / Autorizador / Firmantes) mapeada a equipos de Grafana.
- P2: Alertas automáticas de Grafana (competencias por vencer, deptos en riesgo).

## Notas
- El renderizado a imagen del dashboard no pudo capturarse por la herramienta de
  screenshot (timeout corto vs. arranque del SPA) ni por image-renderer (sin build arm64),
  pero la funcionalidad quedó verificada vía API/SQL y captura del shell en español.

## Actualizacion (documento entregable) - 2026
- Alineacion total al documento simulador G2: datos exactos (DDN 558/42 = 93%, reporte de
  competencias por area, brechas por depto), nombres/orden de dashboards exactos, todo en espanol.
- Correcciones: datasource jsonData.database=see_db, tipo grafana-postgresql-datasource,
  unidades de tiempo en espanol, Gantt (plugin archivado) reemplazado por cronograma nativo,
  Calendario via plugin marcusolsson-calendar-panel, semana::text en barras, keepTime=false.
- ENTREGABLE "Resultado esperado": /app/import_local/DOCUMENTACION_SEE.md (y .html estilizado):
  16 dashboards documentados, 39 KPIs, 84 consultas SQL, 20 casos de uso, alineacion IATF/ISO,
  modulo predictivo. Generadores: generar_documentacion.py + md_a_html.py.

## Actualizacion documento - humanizacion y capturas (2026-06)
- Se agregaron 16 espacios/placeholders "CAPTURA DE GRAFANA" (uno por tablero) con marco
  punteado en el HTML (.captura) para que el usuario pegue sus propias capturas de localhost:3001.
- Se eliminaron todas las referencias a Git/repositorio del contenido del documento (peticion
  del usuario: GitHub solo es canal de sincronizacion agente<->usuario, no debe aparecer en el doc).
- Documento regenerado: 8276 palabras (~18 pag), HTML 82 KB. Sincronizacion al Mac del usuario
  via boton "Save to Github" + git pull.

## Actualizacion portada + PDF + diagrama (2026-06)
- Portada institucional en el HTML (md_a_html.py): logo Instituto Tecnologico de Pochutla,
  titulo del proyecto, alumno Jefte Abimael Lopez Jarquin (matricula 20161240), docente
  Dra. Ruth de la Pena Martinez, programa Verano Cientifico, fecha automatica.
- Diagrama de arquitectura (SEE -> PostgreSQL -> Grafana) generado y embebido como Figura 1
  (assets/arquitectura_see.png). Assets nuevos en /app/import_local/assets/ (logo_itp.png,
  arquitectura_see.png) que se sincronizan por git pull.
- Estilos de impresion @page A4 + aviso (solo pantalla) para exportar a PDF con Chrome y
  activar "Encabezados y pies de pagina" (numeracion automatica).
- Verificado visualmente por screenshot (portada + diagrama renderizan correctamente).
- Pendiente del usuario: subir sus 16 capturas de Grafana (via Drive) para incrustarlas en
  los espacios "CAPTURA DE GRAFANA".

## Ajuste alineacion al PDF (2026-06)
- Bug corregido: la tabla del Diccionario de KPIs se rompia (renderizaba como texto con pipes)
  por doble salto de linea tras la fila separadora en KPI_HEAD; se elimino el \n final.
- Se elimino "Anexo B: Guia de despliegue y acceso" (y su item del indice) porque el
  simulador G2.pdf NO lo pide en el "Resultado esperado". El PDF solo pide: +20 dashboards,
  ~35 KPIs, ~40 SQL, ~20 casos de uso, diccionario de indicadores e interpretacion tecnica.
- Documento estrictamente apegado al PDF; 15 secciones (Anexo A SQL es la ultima).
- Se descargaron las 16 capturas de Grafana del Drive del usuario y se guardaron en
  /app/import_local/assets/capturas/ (01.png ... 16.png), mapeadas 1:1 al orden de tableros.
- generar_documentacion.py ahora incrusta cada captura como <img class="figura shot"> bajo su
  dashboard (con pie de foto) si el archivo existe; si no, deja el placeholder.
- Documento final: portada institucional + diagrama arquitectura + 16 capturas reales + 39 KPIs
  + 84 SQL + casos de uso. Verificado visualmente por screenshot.
