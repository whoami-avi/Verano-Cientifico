#!/usr/bin/env python3
"""Genera los dashboards de Grafana (JSON provisionado) para el Sistema de
Entrenamiento Electronico (SEE). ~15 reportes, ~35 KPIs, IATF 16949 / ISO 9001."""
import json, os

OUT = "/opt/grafana/conf/provisioning/dashboards/json"
os.makedirs(OUT, exist_ok=True)
DS = {"type": "grafana-postgresql-datasource", "uid": "see_pg"}

# ---------- helpers ----------
def tgt(sql, fmt="table", ref="A"):
    return {"refId": ref, "format": fmt, "datasource": DS, "rawSql": sql,
            "editorMode": "code", "rawQuery": True}

def thr(steps):
    return {"mode": "absolute", "steps": steps}

PCT_THR = thr([{"color": "red", "value": None}, {"color": "orange", "value": 70},
               {"color": "yellow", "value": 85}, {"color": "green", "value": 95}])

def base_field(unit="", decimals=1, thresholds=None, color_by_thr=False, minv=None, maxv=None):
    d = {"unit": unit, "decimals": decimals, "mappings": []}
    if thresholds:
        d["thresholds"] = thresholds
    if color_by_thr:
        d["color"] = {"mode": "thresholds"}
    else:
        d["color"] = {"mode": "palette-classic"}
    if minv is not None: d["min"] = minv
    if maxv is not None: d["max"] = maxv
    return d

def stat(pid, title, sql, unit="", decimals=1, thresholds=None, graph=False,
         color_mode="background", desc=""):
    return {
        "id": pid, "type": "stat", "title": title, "description": desc,
        "datasource": DS, "targets": [tgt(sql)],
        "fieldConfig": {"defaults": base_field(unit, decimals, thresholds, bool(thresholds)),
                        "overrides": []},
        "options": {"reduceOptions": {"calcs": ["lastNotNull"], "fields": "", "values": False},
                    "colorMode": color_mode, "graphMode": "area" if graph else "none",
                    "textMode": "auto", "justifyMode": "auto", "orientation": "auto"},
    }

def gauge(pid, title, sql, unit="percent", thresholds=PCT_THR, minv=0, maxv=100, desc=""):
    return {
        "id": pid, "type": "gauge", "title": title, "description": desc, "datasource": DS,
        "targets": [tgt(sql)],
        "fieldConfig": {"defaults": base_field(unit, 1, thresholds, True, minv, maxv),
                        "overrides": []},
        "options": {"reduceOptions": {"calcs": ["lastNotNull"], "fields": "", "values": False},
                    "showThresholdLabels": False, "showThresholdMarkers": True},
    }

def bargauge(pid, title, sql, unit="percent", thresholds=PCT_THR, minv=0, maxv=100, desc=""):
    return {
        "id": pid, "type": "bargauge", "title": title, "description": desc, "datasource": DS,
        "targets": [tgt(sql)],
        "fieldConfig": {"defaults": base_field(unit, 1, thresholds, True, minv, maxv),
                        "overrides": []},
        "options": {"reduceOptions": {"calcs": ["lastNotNull"], "fields": "", "values": True},
                    "displayMode": "gradient", "orientation": "horizontal", "showUnfilled": True},
    }

def barchart(pid, title, sql, horizontal=False, unit="", stacked=False, desc="", legend=True):
    stacking = {"mode": "normal", "group": "A"} if stacked else {"mode": "none", "group": "A"}
    return {
        "id": pid, "type": "barchart", "title": title, "description": desc, "datasource": DS,
        "targets": [tgt(sql)],
        "fieldConfig": {"defaults": {"unit": unit, "color": {"mode": "palette-classic"},
                        "custom": {"lineWidth": 1, "fillOpacity": 80, "gradientMode": "hue",
                                   "axisPlacement": "auto", "stacking": stacking}}, "overrides": []},
        "options": {"orientation": "horizontal" if horizontal else "vertical",
                    "showValue": "auto", "stacking": "normal" if stacked else "none",
                    "xTickLabelRotation": 0 if horizontal else -45, "xTickLabelSpacing": 100,
                    "legend": {"showLegend": legend, "displayMode": "list", "placement": "bottom"},
                    "tooltip": {"mode": "multi"}},
    }

def piechart(pid, title, sql, donut=True, desc=""):
    return {
        "id": pid, "type": "piechart", "title": title, "description": desc, "datasource": DS,
        "targets": [tgt(sql)],
        "fieldConfig": {"defaults": {"unit": "short", "color": {"mode": "palette-classic"},
                        "custom": {"hideFrom": {"tooltip": False, "viz": False, "legend": False}}},
                        "overrides": []},
        "options": {"pieType": "donut" if donut else "pie",
                    "reduceOptions": {"calcs": ["lastNotNull"], "fields": "", "values": False},
                    "legend": {"showLegend": True, "displayMode": "table",
                               "placement": "right", "values": ["value", "percent"]},
                    "tooltip": {"mode": "single"}, "displayLabels": ["percent"]},
    }

def timeseries(pid, title, sql, unit="short", fill=25, desc=""):
    return {
        "id": pid, "type": "timeseries", "title": title, "description": desc, "datasource": DS,
        "targets": [tgt(sql, "time_series")],
        "fieldConfig": {"defaults": {"unit": unit, "color": {"mode": "palette-classic"},
                        "custom": {"drawStyle": "line", "lineInterpolation": "smooth",
                                   "lineWidth": 2, "fillOpacity": fill, "gradientMode": "opacity",
                                   "showPoints": "never", "spanNulls": True,
                                   "axisPlacement": "auto"}}, "overrides": []},
        "options": {"legend": {"showLegend": True, "displayMode": "list", "placement": "bottom"},
                    "tooltip": {"mode": "multi", "sort": "desc"}},
    }

def table(pid, title, sql, desc="", color_cols=None):
    overrides = []
    for col in (color_cols or []):
        overrides.append({"matcher": {"id": "byName", "options": col},
                          "properties": [{"id": "custom.cellOptions",
                                          "value": {"type": "color-background", "mode": "gradient"}},
                                         {"id": "color", "value": {"mode": "continuous-YlRd"}}]})
    return {
        "id": pid, "type": "table", "title": title, "description": desc, "datasource": DS,
        "targets": [tgt(sql)],
        "fieldConfig": {"defaults": {"custom": {"align": "auto", "cellOptions": {"type": "auto"},
                        "filterable": True}, "color": {"mode": "thresholds"}}, "overrides": overrides},
        "options": {"showHeader": True, "cellHeight": "sm", "footer": {"show": False},
                    "sortBy": []},
    }

def calendar_panel(pid, title, sql, desc=""):
    return {
        "id": pid, "type": "marcusolsson-calendar-panel", "title": title, "description": desc,
        "datasource": DS, "targets": [tgt(sql)],
        "options": {"autoScroll": True, "colors": "frame", "displayTime": True,
                    "defaultView": "month", "textField": "name",
                    "timeField": "start_time", "endTimeField": "end_time", "quickLinks": False},
        "fieldConfig": {"defaults": {"custom": {}}, "overrides": []},
    }

def gantt_panel(pid, title, sql, desc=""):
    return {
        "id": pid, "type": "marcusolsson-gantt-panel", "title": title, "description": desc,
        "datasource": DS, "targets": [tgt(sql)],
        "options": {"colorField": "estatus", "labelFields": ["curso"], "textField": "curso",
                    "startField": "start_time", "endField": "end_time",
                    "groupByField": "departamento", "showYAxis": True,
                    "sortBy": "startTime", "sortOrder": "asc"},
        "fieldConfig": {"defaults": {"custom": {}}, "overrides": []},
    }

def text_panel(pid, title, content):
    return {"id": pid, "type": "text", "title": title,
            "options": {"mode": "markdown", "content": content}, "transparent": False}

# ---------- layout ----------
def layout(panels_specs):
    """panels_specs: list of (panel, w, h). Flows left-to-right on a 24-col grid."""
    x = 0; y = 0; row_h = 0; out = []
    for panel, w, h in panels_specs:
        if x + w > 24:
            x = 0; y += row_h; row_h = 0
        panel["gridPos"] = {"h": h, "w": w, "x": x, "y": y}
        x += w; row_h = max(row_h, h)
        out.append(panel)
    return out

VARS = [
    {"name": "planta", "type": "query", "datasource": DS, "label": "Planta",
     "query": "SELECT planta AS __text, clave_planta::text AS __value FROM plantas ORDER BY 1",
     "multi": True, "includeAll": True, "refresh": 1, "sort": 1,
     "current": {"selected": True, "text": ["All"], "value": ["$__all"]}},
    {"name": "departamento", "type": "query", "datasource": DS, "label": "Departamento",
     "query": "SELECT departamento AS __text, id_departamento::text AS __value FROM departamentos ORDER BY 1",
     "multi": True, "includeAll": True, "refresh": 1, "sort": 1,
     "current": {"selected": True, "text": ["All"], "value": ["$__all"]}},
]

def dashboard(uid, title, tags, panels, with_vars=False, time_from="now-3y",
              refresh="", link_others=True):
    templating = {"list": VARS if with_vars else []}
    links = []
    if link_others:
        links = [{"title": "Reportes SEE", "type": "dashboards", "tags": ["see"],
                  "asDropdown": True, "icon": "external link", "includeVars": True,
                  "keepTime": True, "targetBlank": False}]
    return {
        "uid": uid, "title": title, "tags": tags, "timezone": "browser",
        "schemaVersion": 39, "version": 1, "refresh": refresh, "editable": True,
        "style": "dark", "graphTooltip": 1, "links": links,
        "time": {"from": time_from, "to": "now"},
        "templating": templating, "panels": panels,
        "annotations": {"list": [{"builtIn": 1, "datasource": {"type": "grafana", "uid": "-- Grafana --"},
                                  "enable": True, "hide": True, "type": "dashboard"}]},
    }

# ============ filtro por variables (para SQL) ============
FILT_E = "e.clave_planta IN ($planta) AND e.id_departamento IN ($departamento)"

# CTE ultima evaluacion por empleado-competencia
ULT = ("WITH ult AS (SELECT DISTINCT ON (no_reloj, id_competencia) * FROM diagnosticos "
       "ORDER BY no_reloj, id_competencia, fecha_registro DESC)")

# =====================================================================
# 00 - DASHBOARD EJECUTIVO
# =====================================================================
p = []
p.append((text_panel(1, "", "## Sistema de Entrenamiento Electronico (SEE)\n"
    "Panorama general de **Descripciones de Puesto (DDP)**, **Diagnostico de Necesidades (DDN)** "
    "y **Plan Maestro de Entrenamiento**. Cumplimiento **IATF 16949:2016** e **ISO 9001:2015**."), 24, 3))
p.append((stat(2, "Empleados Activos", f"SELECT count(*) FROM empleados e WHERE activo AND {FILT_E}",
               "short", 0, thr([{"color": "blue", "value": None}])), 4, 4))
p.append((stat(3, "Competencias Evaluadas",
               f"{ULT} SELECT count(*) FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj WHERE {FILT_E}",
               "short", 0, thr([{"color": "purple", "value": None}])), 4, 4))
p.append((stat(4, "% Cumplimiento Competencias",
               f"{ULT} SELECT round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) "
               f"FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj WHERE {FILT_E}",
               "percent", 1, PCT_THR, graph=False), 5, 4))
p.append((stat(5, "% Plan Maestro Cumplido",
               "SELECT round(100.0*count(*) FILTER (WHERE estatus='Completado')/"
               "nullif(count(*) FILTER (WHERE estatus<>'Cancelado'),0),1) FROM cursos_programados",
               "percent", 1, PCT_THR), 5, 4))
p.append((stat(6, "% DDP Autorizadas",
               "SELECT round(100.0*sum(CASE WHEN autorizada THEN 1 ELSE 0 END)/nullif(count(*),0),1) "
               "FROM descripciones_puesto", "percent", 1, PCT_THR), 6, 4))
p.append((gauge(7, "Cumplimiento Global de Competencias",
                f"{ULT} SELECT round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) "
                f"FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj WHERE {FILT_E}"), 6, 8))
p.append((gauge(8, "Cumplimiento Plan Maestro",
                "SELECT round(100.0*count(*) FILTER (WHERE estatus='Completado')/"
                "nullif(count(*) FILTER (WHERE estatus<>'Cancelado'),0),1) FROM cursos_programados"), 6, 8))
p.append((piechart(9, "Diagnostico: Competente vs No Competente",
                   f"{ULT} SELECT sum(CASE WHEN ult.competente THEN 1 ELSE 0 END) AS \"Competente\", "
                   f"sum(CASE WHEN NOT ult.competente THEN 1 ELSE 0 END) AS \"No competente\" "
                   f"FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj WHERE {FILT_E}"), 6, 8))
p.append((barchart(10, "Cumplimiento por Departamento (%)",
                   f"{ULT} SELECT d.departamento, round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/"
                   f"nullif(count(*),0),1) AS cumplimiento FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj "
                   f"JOIN departamentos d ON e.id_departamento=d.id_departamento WHERE {FILT_E} "
                   f"GROUP BY d.departamento ORDER BY cumplimiento DESC", horizontal=True, unit="percent"), 6, 8))
p.append((timeseries(11, "Usuarios Activos del Sistema",
                     "SELECT fecha AS \"time\", usuarios_activos AS \"Usuarios activos\" "
                     "FROM accesos_diarios WHERE $__timeFilter(fecha) ORDER BY fecha"), 24, 7))
dash = dashboard("see-ejecutivo", "00 - Dashboard Ejecutivo", ["see", "ejecutivo"],
                 layout(p), with_vars=True, refresh="")
open(f"{OUT}/00_ejecutivo.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 01 - CUMPLIMIENTO POR DEPARTAMENTO
# =====================================================================
p = []
p.append((barchart(1, "Cumplimiento de Competencias por Departamento (%)",
    f"{ULT} SELECT d.departamento, round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) "
    f"AS cumplimiento FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj "
    f"JOIN departamentos d ON e.id_departamento=d.id_departamento GROUP BY d.departamento ORDER BY cumplimiento DESC",
    horizontal=True, unit="percent", desc="Meta >= 95%"), 24, 11))
p.append((table(2, "Detalle por Departamento",
    f"{ULT} SELECT d.departamento AS \"Departamento\", count(*) AS \"Evaluaciones\", "
    "sum(CASE WHEN ult.competente THEN 1 ELSE 0 END) AS \"Competentes\", "
    "sum(CASE WHEN NOT ult.competente THEN 1 ELSE 0 END) AS \"Brechas\", "
    "round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) AS \"% Cumplimiento\" "
    "FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj JOIN departamentos d ON e.id_departamento=d.id_departamento "
    "GROUP BY d.departamento ORDER BY \"% Cumplimiento\" DESC", color_cols=["Brechas"]), 24, 11))
dash = dashboard("see-dept", "01 - Cumplimiento por Departamento", ["see", "cumplimiento"], layout(p))
open(f"{OUT}/01_departamento.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 02 - CUMPLIMIENTO POR PLANTA
# =====================================================================
p = []
p.append((barchart(1, "Cumplimiento por Planta (%)",
    f"{ULT} SELECT pl.planta, round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) "
    f"AS cumplimiento FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj "
    f"JOIN plantas pl ON e.clave_planta=pl.clave_planta GROUP BY pl.planta ORDER BY cumplimiento DESC",
    unit="percent"), 12, 9))
p.append((piechart(2, "Distribucion de Empleados por Planta",
    "SELECT pl.planta AS metric, count(*) AS value FROM empleados e "
    "JOIN plantas pl ON e.clave_planta=pl.clave_planta WHERE e.activo GROUP BY pl.planta", donut=False), 12, 9))
p.append((table(3, "Resumen por Planta",
    f"{ULT} SELECT pl.planta AS \"Planta\", pl.ubicacion AS \"Ubicacion\", "
    "count(DISTINCT e.no_reloj) AS \"Empleados\", count(*) AS \"Evaluaciones\", "
    "round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) AS \"% Cumplimiento\" "
    "FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj JOIN plantas pl ON e.clave_planta=pl.clave_planta "
    "GROUP BY pl.planta, pl.ubicacion ORDER BY \"% Cumplimiento\" DESC"), 24, 8))
dash = dashboard("see-planta", "02 - Cumplimiento por Planta", ["see", "cumplimiento"], layout(p))
open(f"{OUT}/02_planta.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 03 - COMPETENCIAS POR PUESTO (Requeridas vs Logradas)
# =====================================================================
p = []
p.append((barchart(1, "Top 15 Puestos: Competencias Logradas vs Brechas (apiladas = requeridas)",
    f"{ULT} SELECT pu.puesto, sum(CASE WHEN ult.competente THEN 1 ELSE 0 END) AS \"Logradas\", "
    "sum(CASE WHEN NOT ult.competente THEN 1 ELSE 0 END) AS \"Brechas\" "
    "FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj JOIN puestos pu ON e.clave_puesto=pu.clave_puesto "
    "GROUP BY pu.puesto ORDER BY count(*) DESC LIMIT 15", stacked=True), 24, 11))
p.append((barchart(2, "Cumplimiento por Clasificacion de Puesto (%)",
    f"{ULT} SELECT pu.clasificacion, round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/"
    "nullif(count(*),0),1) AS cumplimiento FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj "
    "JOIN puestos pu ON e.clave_puesto=pu.clave_puesto GROUP BY pu.clasificacion ORDER BY cumplimiento DESC",
    horizontal=True, unit="percent"), 12, 9))
p.append((piechart(3, "Competencias por Tipo",
    "SELECT tipo AS metric, count(*) AS value FROM competencias_puesto GROUP BY tipo", donut=True), 12, 9))
dash = dashboard("see-comp-puesto", "03 - Competencias por Puesto", ["see", "competencias"], layout(p))
open(f"{OUT}/03_competencias_puesto.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 04 - BRECHAS DE COMPETENCIAS (Heatmap / Mapa de calor)
# =====================================================================
tipos = ["Normativa", "Tecnica", "Operativa", "Blanda", "Administrativa"]
filters = ", ".join([f"count(*) FILTER (WHERE NOT ult.competente AND cp.tipo='{t}') AS \"{t}\"" for t in tipos])
p = []
p.append((table(1, "Mapa de Calor de Brechas (No competentes por Departamento y Tipo)",
    f"{ULT} SELECT d.departamento AS \"Departamento\", {filters}, "
    "count(*) FILTER (WHERE NOT ult.competente) AS \"Total brechas\" "
    "FROM ult JOIN competencias_puesto cp ON ult.id_competencia=cp.id_competencia "
    "JOIN empleados e ON ult.no_reloj=e.no_reloj JOIN departamentos d ON e.id_departamento=d.id_departamento "
    "GROUP BY d.departamento ORDER BY \"Total brechas\" DESC",
    color_cols=tipos + ["Total brechas"]), 24, 11))
p.append((barchart(2, "Top 15 Competencias con Mayor Brecha",
    f"{ULT} SELECT cp.descripcion_competencia, count(*) AS brechas FROM ult "
    "JOIN competencias_puesto cp ON ult.id_competencia=cp.id_competencia WHERE NOT ult.competente "
    "GROUP BY cp.descripcion_competencia ORDER BY brechas DESC LIMIT 15", horizontal=True), 24, 12))
dash = dashboard("see-gaps", "04 - Brechas de Competencias", ["see", "competencias"], layout(p))
open(f"{OUT}/04_brechas.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 05 - DIAGNOSTICO DE NECESIDADES (DDN)
# =====================================================================
p = []
p.append((piechart(1, "Competente vs No Competente",
    f"{ULT} SELECT sum(CASE WHEN ult.competente THEN 1 ELSE 0 END) AS \"Competente\", "
    "sum(CASE WHEN NOT ult.competente THEN 1 ELSE 0 END) AS \"No competente\" FROM ult"), 8, 9))
p.append((piechart(2, "Brechas por Prioridad",
    f"{ULT} SELECT prioridad AS metric, count(*) AS value FROM ult WHERE NOT competente "
    "GROUP BY prioridad", donut=True), 8, 9))
p.append((stat(3, "Diagnosticos No Competentes (Prioridad Alta)",
    f"{ULT} SELECT count(*) FROM ult WHERE NOT competente AND prioridad='Alta'", "short", 0,
    thr([{"color": "red", "value": None}])), 8, 9))
p.append((timeseries(4, "Evaluaciones Registradas por Mes",
    "SELECT date_trunc('month', fecha_registro)::date AS \"time\", count(*) AS \"Evaluaciones\", "
    "count(*) FILTER (WHERE NOT competente) AS \"No competentes\" FROM diagnosticos "
    "WHERE $__timeFilter(fecha_registro) GROUP BY 1 ORDER BY 1", fill=15), 24, 8))
p.append((table(5, "Diagnosticos Recientes",
    "SELECT em.nombre AS \"Empleado\", d.departamento AS \"Departamento\", cp.descripcion_competencia AS \"Competencia\", "
    "CASE WHEN di.competente THEN 'Si' ELSE 'No' END AS \"Competente\", di.prioridad AS \"Prioridad\", "
    "di.fecha_registro AS \"Fecha\" FROM diagnosticos di JOIN empleados em ON di.no_reloj=em.no_reloj "
    "JOIN departamentos d ON em.id_departamento=d.id_departamento "
    "JOIN competencias_puesto cp ON di.id_competencia=cp.id_competencia ORDER BY di.fecha_registro DESC LIMIT 100"), 24, 10))
dash = dashboard("see-ddn", "05 - Diagnostico de Necesidades (DDN)", ["see", "ddn"], layout(p))
open(f"{OUT}/05_ddn.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 06 - PLAN MAESTRO DE ENTRENAMIENTO
# =====================================================================
p = []
p.append((gantt_panel(8, "Gantt - Cursos del Plan Maestro (2026)",
    "SELECT c.nombre_curso AS curso, cpr.fecha_inicio::timestamp AS start_time, "
    "cpr.fecha_fin::timestamp AS end_time, cpr.estatus AS estatus, d.departamento AS departamento "
    "FROM cursos_programados cpr JOIN cursos c ON cpr.id_curso=c.id_curso "
    "JOIN plan_maestro pm ON cpr.id_plan_maestro=pm.id_plan_maestro "
    "JOIN departamentos d ON pm.id_departamento=d.id_departamento "
    "WHERE cpr.anio_fiscal=2026 ORDER BY cpr.fecha_inicio LIMIT 60",
    desc="Cronograma tipo Gantt de los cursos programados"), 24, 11))
p.append((piechart(1, "Estatus de Cursos Programados",
    "SELECT estatus AS metric, count(*) AS value FROM cursos_programados GROUP BY estatus", donut=True), 8, 9))
p.append((stat(2, "Planes Maestros Registrados", "SELECT count(*) FROM plan_maestro", "short", 0,
    thr([{"color": "blue", "value": None}])), 4, 4))
p.append((stat(3, "% Planes Totalmente Firmados",
    "SELECT round(100.0*count(*) FILTER (WHERE firma_mnj_depto AND firma_mnj_entto AND firma_gerente)/"
    "nullif(count(*),0),1) FROM plan_maestro", "percent", 1, PCT_THR), 4, 4))
p.append((stat(4, "Cursos Completados",
    "SELECT count(*) FROM cursos_programados WHERE estatus='Completado'", "short", 0,
    thr([{"color": "green", "value": None}])), 4, 4))
p.append((stat(5, "Cursos En Curso / Programados",
    "SELECT count(*) FROM cursos_programados WHERE estatus IN ('En curso','Programado')", "short", 0,
    thr([{"color": "orange", "value": None}])), 4, 4))
p.append((barchart(6, "Estatus de Cursos por Departamento",
    "SELECT d.departamento, count(*) FILTER (WHERE cpr.estatus='Completado') AS \"Completado\", "
    "count(*) FILTER (WHERE cpr.estatus='En curso') AS \"En curso\", "
    "count(*) FILTER (WHERE cpr.estatus='Programado') AS \"Programado\", "
    "count(*) FILTER (WHERE cpr.estatus='Cancelado') AS \"Cancelado\" "
    "FROM cursos_programados cpr JOIN plan_maestro pm ON cpr.id_plan_maestro=pm.id_plan_maestro "
    "JOIN departamentos d ON pm.id_departamento=d.id_departamento GROUP BY d.departamento ORDER BY d.departamento",
    horizontal=True, stacked=True), 24, 12))
p.append((table(7, "Plan Maestro por Departamento y Anio Fiscal",
    "SELECT d.departamento AS \"Departamento\", pm.anio_fiscal AS \"Anio Fiscal\", pm.revision AS \"Revision\", "
    "CASE WHEN pm.firma_mnj_depto THEN 'Si' ELSE 'No' END AS \"Firma MNJ Depto\", "
    "CASE WHEN pm.firma_mnj_entto THEN 'Si' ELSE 'No' END AS \"Firma MNJ Entto\", "
    "CASE WHEN pm.firma_gerente THEN 'Si' ELSE 'No' END AS \"Firma Gerente\" "
    "FROM plan_maestro pm JOIN departamentos d ON pm.id_departamento=d.id_departamento "
    "ORDER BY pm.anio_fiscal DESC, d.departamento"), 24, 10))
dash = dashboard("see-plan-maestro", "06 - Plan Maestro de Entrenamiento", ["see", "plan-maestro"], layout(p))
open(f"{OUT}/06_plan_maestro.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 07 - CURSOS PROGRAMADOS (Calendario anual)
# =====================================================================
p = []
p.append((calendar_panel(8, "Calendario Anual de Cursos (2026)",
    "SELECT c.nombre_curso AS name, cpr.fecha_inicio::timestamp AS start_time, "
    "cpr.fecha_fin::timestamp AS end_time, cpr.estatus AS estatus "
    "FROM cursos_programados cpr JOIN cursos c ON cpr.id_curso=c.id_curso "
    "WHERE cpr.anio_fiscal=2026 ORDER BY cpr.fecha_inicio",
    desc="Vista de calendario de los cursos programados"), 24, 12))
p.append((barchart(1, "Cursos Programados por Semana (2026)",
    "SELECT semana AS \"Semana\", count(*) AS \"Cursos\" FROM cursos_programados WHERE anio_fiscal=2026 "
    "GROUP BY semana ORDER BY semana", legend=False), 24, 9))
p.append((barchart(2, "Cursos por Anio Fiscal",
    "SELECT anio_fiscal::text AS \"Anio\", count(*) AS \"Cursos\" FROM cursos_programados "
    "GROUP BY anio_fiscal ORDER BY anio_fiscal", legend=False), 12, 8))
p.append((barchart(3, "Horas de Capacitacion Programadas por Anio",
    "SELECT cpr.anio_fiscal::text AS \"Anio\", sum(c.horas) AS \"Horas\" FROM cursos_programados cpr "
    "JOIN cursos c ON cpr.id_curso=c.id_curso GROUP BY cpr.anio_fiscal ORDER BY cpr.anio_fiscal",
    unit="h", legend=False), 12, 8))
p.append((table(4, "Calendario de Cursos Proximos (2026)",
    "SELECT c.nombre_curso AS \"Curso\", cpr.semana AS \"Semana\", cpr.fecha_inicio AS \"Inicio\", "
    "cpr.fecha_fin AS \"Fin\", c.horas AS \"Horas\", cpr.estatus AS \"Estatus\" "
    "FROM cursos_programados cpr JOIN cursos c ON cpr.id_curso=c.id_curso "
    "WHERE cpr.anio_fiscal=2026 AND cpr.estatus IN ('Programado','En curso') "
    "ORDER BY cpr.fecha_inicio LIMIT 100"), 24, 10))
dash = dashboard("see-cursos-prog", "07 - Cursos Programados", ["see", "plan-maestro"], layout(p))
open(f"{OUT}/07_cursos_programados.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 08 - EVIDENCIAS DIGITALES
# =====================================================================
p = []
p.append((stat(1, "Evidencias Cargadas",
    "SELECT count(*) FROM diagnosticos WHERE ruta_evidencia IS NOT NULL", "short", 0,
    thr([{"color": "green", "value": None}])), 6, 4))
p.append((stat(2, "% Competencias con Evidencia",
    f"{ULT} SELECT round(100.0*count(*) FILTER (WHERE ruta_evidencia IS NOT NULL)/"
    "nullif(count(*) FILTER (WHERE competente),0),1) FROM ult", "percent", 1, PCT_THR), 6, 4))
p.append((stat(3, "Competentes sin Evidencia",
    f"{ULT} SELECT count(*) FROM ult WHERE competente AND ruta_evidencia IS NULL", "short", 0,
    thr([{"color": "red", "value": None}])), 6, 4))
p.append((barchart(4, "Evidencias por Departamento",
    "SELECT d.departamento, count(*) AS \"Evidencias\" FROM diagnosticos di "
    "JOIN empleados e ON di.no_reloj=e.no_reloj JOIN departamentos d ON e.id_departamento=d.id_departamento "
    "WHERE di.ruta_evidencia IS NOT NULL GROUP BY d.departamento ORDER BY \"Evidencias\" DESC", horizontal=True), 6, 12))
p.append((table(5, "Registro de Evidencias Digitales",
    "SELECT em.nombre AS \"Empleado\", cp.descripcion_competencia AS \"Competencia\", di.ruta_evidencia AS \"Ruta Evidencia\", "
    "di.fecha_registro AS \"Fecha Registro\", di.fecha_vencimiento AS \"Vence\" "
    "FROM diagnosticos di JOIN empleados em ON di.no_reloj=em.no_reloj "
    "JOIN competencias_puesto cp ON di.id_competencia=cp.id_competencia "
    "WHERE di.ruta_evidencia IS NOT NULL ORDER BY di.fecha_registro DESC LIMIT 150"), 18, 12))
dash = dashboard("see-evidencias", "08 - Evidencias Digitales", ["see", "auditoria"], layout(p))
open(f"{OUT}/08_evidencias.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 09 - METRICAS IATF 16949
# =====================================================================
p = []
p.append((text_panel(1, "", "### IATF 16949:2016 - Competencia, toma de conciencia y formacion\n"
    "Indicadores de control normativo del sistema de gestion de calidad automotriz."), 24, 3))
p.append((gauge(2, "Cumplimiento Competencias Criticas (Normativas)",
    f"{ULT} SELECT round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) "
    "FROM ult JOIN competencias_puesto cp ON ult.id_competencia=cp.id_competencia WHERE cp.tipo='Normativa'"), 8, 8))
p.append((gauge(3, "DDP Autorizadas (Meta 100%)",
    "SELECT round(100.0*sum(CASE WHEN autorizada THEN 1 ELSE 0 END)/nullif(count(*),0),1) FROM descripciones_puesto",
    thresholds=thr([{"color": "red", "value": None}, {"color": "yellow", "value": 90}, {"color": "green", "value": 100}])), 8, 8))
p.append((gauge(4, "Planes Maestros Firmados por Gerente de Planta",
    "SELECT round(100.0*sum(CASE WHEN firma_gerente THEN 1 ELSE 0 END)/nullif(count(*),0),1) FROM plan_maestro"), 8, 8))
p.append((bargauge(5, "Cumplimiento por Competencia Normativa (%)",
    f"{ULT} SELECT cp.descripcion_competencia AS metric, "
    "round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) AS value "
    "FROM ult JOIN competencias_puesto cp ON ult.id_competencia=cp.id_competencia WHERE cp.tipo='Normativa' "
    "GROUP BY cp.descripcion_competencia ORDER BY value DESC"), 12, 12))
p.append((table(6, "Estatus Normativo por Departamento",
    f"{ULT} SELECT d.departamento AS \"Departamento\", "
    "round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) AS \"% Competencias Normativas\", "
    "count(*) FILTER (WHERE NOT ult.competente) AS \"Brechas Normativas\" "
    "FROM ult JOIN competencias_puesto cp ON ult.id_competencia=cp.id_competencia "
    "JOIN empleados e ON ult.no_reloj=e.no_reloj JOIN departamentos d ON e.id_departamento=d.id_departamento "
    "WHERE cp.tipo='Normativa' GROUP BY d.departamento ORDER BY \"% Competencias Normativas\"",
    color_cols=["Brechas Normativas"]), 12, 12))
dash = dashboard("see-iatf", "09 - Metricas IATF 16949", ["see", "normativa", "iatf"], layout(p))
open(f"{OUT}/09_iatf.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 10 - METRICAS ISO 9001
# =====================================================================
p = []
p.append((text_panel(1, "", "### ISO 9001:2015 - Control de Documentos e Informacion Documentada\n"
    "Indicadores de control documental de Descripciones de Puesto y Plan Maestro."), 24, 3))
p.append((gauge(2, "Documentos Controlados (DDP Autorizadas)",
    "SELECT round(100.0*sum(CASE WHEN autorizada THEN 1 ELSE 0 END)/nullif(count(*),0),1) FROM descripciones_puesto"), 8, 8))
p.append((stat(3, "Descripciones de Puesto Registradas", "SELECT count(*) FROM descripciones_puesto", "short", 0,
    thr([{"color": "blue", "value": None}])), 8, 8))
p.append((stat(4, "Revision Promedio de Documentos",
    "SELECT round(avg(revision),1) FROM descripciones_puesto", "short", 1,
    thr([{"color": "purple", "value": None}])), 8, 8))
p.append((barchart(5, "DDP Autorizadas vs Pendientes por Departamento",
    "SELECT d.departamento, count(*) FILTER (WHERE dp.autorizada) AS \"Autorizadas\", "
    "count(*) FILTER (WHERE NOT dp.autorizada) AS \"Pendientes\" FROM descripciones_puesto dp "
    "JOIN departamentos d ON dp.id_departamento=d.id_departamento GROUP BY d.departamento ORDER BY d.departamento",
    horizontal=True, stacked=True), 12, 12))
p.append((piechart(6, "Estatus Documental de DDP",
    "SELECT CASE WHEN autorizada THEN 'Autorizada' ELSE 'Pendiente' END AS metric, count(*) AS value "
    "FROM descripciones_puesto GROUP BY 1", donut=True), 12, 12))
p.append((timeseries(7, "Documentos Creados por Mes",
    "SELECT date_trunc('month', fecha_creacion)::date AS \"time\", count(*) AS \"DDP creadas\" "
    "FROM descripciones_puesto WHERE $__timeFilter(fecha_creacion) GROUP BY 1 ORDER BY 1"), 24, 8))
dash = dashboard("see-iso", "10 - Metricas ISO 9001", ["see", "normativa", "iso"], layout(p))
open(f"{OUT}/10_iso.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 11 - SEGUIMIENTO DE AUTORIZACIONES (Timeline)
# =====================================================================
p = []
p.append((stat(1, "Tiempo Promedio de Autorizacion",
    "SELECT round(avg(fecha_aprobacion - fecha_envio),1) FROM descripciones_puesto WHERE autorizada", "d", 1,
    thr([{"color": "green", "value": None}, {"color": "yellow", "value": 3}, {"color": "red", "value": 5}])), 8, 5))
p.append((stat(2, "DDP Pendientes de Firma",
    "SELECT count(*) FROM descripciones_puesto WHERE NOT autorizada", "short", 0,
    thr([{"color": "red", "value": None}])), 8, 5))
p.append((stat(3, "% Autorizadas en <= 3 dias",
    "SELECT round(100.0*count(*) FILTER (WHERE (fecha_aprobacion-fecha_envio)<=3)/"
    "nullif(count(*) FILTER (WHERE autorizada),0),1) FROM descripciones_puesto", "percent", 1, PCT_THR), 8, 5))
p.append((barchart(4, "Tiempo Promedio de Autorizacion por Departamento (dias)",
    "SELECT d.departamento, round(avg(dp.fecha_aprobacion - dp.fecha_envio),1) AS dias "
    "FROM descripciones_puesto dp JOIN departamentos d ON dp.id_departamento=d.id_departamento "
    "WHERE dp.autorizada GROUP BY d.departamento ORDER BY dias DESC", horizontal=True, unit="d"), 24, 11))
p.append((table(5, "Flujo de Firmas - Autorizaciones Recientes",
    "SELECT pu.puesto AS \"Puesto\", d.departamento AS \"Departamento\", dp.elaborado_por AS \"Elaboro\", "
    "dp.fecha_creacion AS \"Creada\", dp.fecha_envio AS \"Enviada a RH\", dp.fecha_aprobacion AS \"Autorizada\", "
    "(dp.fecha_aprobacion - dp.fecha_envio) AS \"Dias\", "
    "CASE WHEN dp.autorizada THEN 'Autorizada' ELSE 'Pendiente' END AS \"Estatus\" "
    "FROM descripciones_puesto dp JOIN puestos pu ON dp.clave_puesto=pu.clave_puesto "
    "JOIN departamentos d ON dp.id_departamento=d.id_departamento ORDER BY dp.fecha_envio DESC LIMIT 100",
    color_cols=["Dias"]), 24, 11))
dash = dashboard("see-autorizaciones", "11 - Seguimiento de Autorizaciones", ["see", "auditoria"], layout(p))
open(f"{OUT}/11_autorizaciones.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 12 - PRODUCTIVIDAD DEL SISTEMA (Antes vs Despues)
# =====================================================================
p = []
p.append((text_panel(1, "", "### Impacto de la digitalizacion\n"
    "Comparativo de tiempos (minutos) de los procesos **antes** (manual) y **despues** (sistema SEE)."), 24, 3))
p.append((barchart(2, "Tiempo por Proceso: Antes vs Despues (minutos)",
    "SELECT proceso AS \"Proceso\", tiempo_antes_min AS \"Antes (manual)\", tiempo_despues_min AS \"Despues (SEE)\" "
    "FROM metricas_productividad ORDER BY tiempo_antes_min DESC", horizontal=True), 24, 12))
p.append((stat(3, "Reduccion Promedio de Tiempo",
    "SELECT round(avg(100.0*(tiempo_antes_min - tiempo_despues_min)/nullif(tiempo_antes_min,0)),1) "
    "FROM metricas_productividad", "percent", 1,
    thr([{"color": "green", "value": None}]), color_mode="value"), 8, 6))
p.append((stat(4, "Horas Ahorradas (por ciclo completo)",
    "SELECT round(sum(tiempo_antes_min - tiempo_despues_min)/60.0,1) FROM metricas_productividad", "h", 1,
    thr([{"color": "blue", "value": None}])), 8, 6))
p.append((table(5, "Detalle de Productividad",
    "SELECT proceso AS \"Proceso\", tiempo_antes_min AS \"Antes (min)\", tiempo_despues_min AS \"Despues (min)\", "
    "round(100.0*(tiempo_antes_min - tiempo_despues_min)/nullif(tiempo_antes_min,0),1) AS \"% Reduccion\" "
    "FROM metricas_productividad ORDER BY \"% Reduccion\" DESC"), 8, 6))
dash = dashboard("see-productividad", "12 - Productividad del Sistema", ["see", "productividad"], layout(p))
open(f"{OUT}/12_productividad.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 13 - AUDITORIAS (Documentos listos)
# =====================================================================
p = []
p.append((stat(1, "DDP Listas para Auditoria",
    "SELECT count(*) FROM descripciones_puesto WHERE autorizada", "short", 0,
    thr([{"color": "green", "value": None}])), 6, 4))
p.append((stat(2, "DDP No Listas (sin firma)",
    "SELECT count(*) FROM descripciones_puesto WHERE NOT autorizada", "short", 0,
    thr([{"color": "red", "value": None}])), 6, 4))
p.append((gauge(3, "% Documentacion Lista para Auditoria",
    "SELECT round(100.0*sum(CASE WHEN autorizada THEN 1 ELSE 0 END)/nullif(count(*),0),1) FROM descripciones_puesto"), 12, 8))
p.append((barchart(4, "Documentos Listos para Auditoria por Departamento",
    "SELECT d.departamento, count(*) FILTER (WHERE dp.autorizada) AS \"Listos\", "
    "count(*) FILTER (WHERE NOT dp.autorizada) AS \"No listos\" FROM descripciones_puesto dp "
    "JOIN departamentos d ON dp.id_departamento=d.id_departamento GROUP BY d.departamento ORDER BY d.departamento",
    horizontal=True, stacked=True), 12, 8))
p.append((table(5, "Checklist de Auditoria (DDP)",
    "SELECT pu.puesto AS \"Puesto\", d.departamento AS \"Departamento\", pl.planta AS \"Planta\", "
    "dp.revision AS \"Revision\", CASE WHEN dp.autorizada THEN 'LISTO' ELSE 'PENDIENTE' END AS \"Estatus Auditoria\", "
    "dp.fecha_aprobacion AS \"Fecha Autorizacion\" FROM descripciones_puesto dp "
    "JOIN puestos pu ON dp.clave_puesto=pu.clave_puesto JOIN departamentos d ON dp.id_departamento=d.id_departamento "
    "JOIN plantas pl ON dp.clave_planta=pl.clave_planta ORDER BY dp.autorizada, d.departamento LIMIT 150"), 24, 11))
dash = dashboard("see-auditorias", "13 - Auditorias", ["see", "auditoria"], layout(p))
open(f"{OUT}/13_auditorias.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 14 - USUARIOS ACTIVOS (Uso del sistema)
# =====================================================================
p = []
p.append((stat(1, "Promedio Usuarios Activos / dia",
    "SELECT round(avg(usuarios_activos),0) FROM accesos_diarios WHERE fecha >= now() - interval '90 days'",
    "short", 0, thr([{"color": "blue", "value": None}]), graph=True), 8, 6))
p.append((stat(2, "Pico Maximo de Usuarios",
    "SELECT max(usuarios_activos) FROM accesos_diarios", "short", 0,
    thr([{"color": "green", "value": None}])), 8, 6))
p.append((stat(3, "Sesiones Totales (3 anios)",
    "SELECT sum(sesiones) FROM accesos_diarios", "short", 0,
    thr([{"color": "purple", "value": None}])), 8, 6))
p.append((timeseries(4, "Usuarios Activos y Sesiones (Serie de Tiempo)",
    "SELECT fecha AS \"time\", usuarios_activos AS \"Usuarios activos\", sesiones AS \"Sesiones\" "
    "FROM accesos_diarios WHERE $__timeFilter(fecha) ORDER BY fecha"), 24, 10))
p.append((barchart(5, "Promedio de Usuarios Activos por Mes",
    "SELECT to_char(date_trunc('month', fecha),'YYYY-MM') AS \"Mes\", round(avg(usuarios_activos),0) AS \"Promedio\" "
    "FROM accesos_diarios WHERE fecha >= now() - interval '12 months' GROUP BY 1 ORDER BY 1", legend=False), 24, 8))
dash = dashboard("see-usuarios", "14 - Usuarios Activos", ["see", "uso"], layout(p))
open(f"{OUT}/14_usuarios.json", "w").write(json.dumps(dash, indent=2))

# =====================================================================
# 15 - REPORTES PREDICTIVOS (Business Intelligence)
# =====================================================================
p = []
p.append((text_panel(1, "", "### Modulo Predictivo / Inteligencia de Negocio\n"
    "Alertas tempranas de riesgo de incumplimiento, vencimientos y necesidades de programacion."), 24, 3))
p.append((stat(2, "Competencias por Vencer (30 dias)",
    f"{ULT} SELECT count(*) FROM ult WHERE competente AND fecha_vencimiento BETWEEN now() AND now() + interval '30 days'",
    "short", 0, thr([{"color": "orange", "value": None}])), 6, 5))
p.append((stat(3, "Empleados con Certificacion por Vencer",
    f"{ULT} SELECT count(DISTINCT no_reloj) FROM ult WHERE competente AND "
    "fecha_vencimiento BETWEEN now() AND now() + interval '60 days'", "short", 0,
    thr([{"color": "red", "value": None}])), 6, 5))
p.append((stat(4, "Cursos a Programar (proximo mes)",
    "SELECT count(*) FROM cursos_programados WHERE estatus='Programado' AND "
    "fecha_inicio BETWEEN now() AND now() + interval '30 days'", "short", 0,
    thr([{"color": "yellow", "value": None}])), 6, 5))
p.append((stat(5, "Departamentos en Riesgo (<80%)",
    f"{ULT} SELECT count(*) FROM (SELECT e.id_departamento, "
    "100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0) AS pct "
    "FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj GROUP BY e.id_departamento) t WHERE pct < 80",
    "short", 0, thr([{"color": "red", "value": None}])), 6, 5))
p.append((barchart(6, "Departamentos con Mayor Riesgo de Incumplimiento (menor % cumplimiento)",
    f"{ULT} SELECT d.departamento, round(100.0*sum(CASE WHEN ult.competente THEN 1 ELSE 0 END)/nullif(count(*),0),1) "
    "AS cumplimiento FROM ult JOIN empleados e ON ult.no_reloj=e.no_reloj "
    "JOIN departamentos d ON e.id_departamento=d.id_departamento GROUP BY d.departamento "
    "ORDER BY cumplimiento ASC LIMIT 10", horizontal=True, unit="percent"), 12, 11))
p.append((timeseries(7, "Tendencia Anual de Cumplimiento del Plan Maestro",
    "SELECT make_date(anio_fiscal,1,1) AS \"time\", "
    "round(100.0*count(*) FILTER (WHERE estatus='Completado')/nullif(count(*) FILTER (WHERE estatus<>'Cancelado'),0),1) "
    "AS \"% Cumplimiento Plan Maestro\" FROM cursos_programados GROUP BY anio_fiscal ORDER BY anio_fiscal",
    unit="percent"), 12, 11))
p.append((table(8, "Certificaciones Proximas a Vencer (siguientes 60 dias)",
    f"{ULT} SELECT em.nombre AS \"Empleado\", d.departamento AS \"Departamento\", "
    "cp.descripcion_competencia AS \"Competencia\", ult.fecha_vencimiento AS \"Vence\", "
    "(ult.fecha_vencimiento - CURRENT_DATE) AS \"Dias restantes\" "
    "FROM ult JOIN empleados em ON ult.no_reloj=em.no_reloj JOIN departamentos d ON em.id_departamento=d.id_departamento "
    "JOIN competencias_puesto cp ON ult.id_competencia=cp.id_competencia "
    "WHERE ult.competente AND ult.fecha_vencimiento BETWEEN now() AND now() + interval '60 days' "
    "ORDER BY ult.fecha_vencimiento LIMIT 100", color_cols=["Dias restantes"]), 24, 11))
dash = dashboard("see-predictivo", "15 - Reportes Predictivos", ["see", "predictivo", "bi"], layout(p))
open(f"{OUT}/15_predictivo.json", "w").write(json.dumps(dash, indent=2))

print("Dashboards generados en", OUT)
for f in sorted(os.listdir(OUT)):
    print("  -", f)
