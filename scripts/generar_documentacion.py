#!/usr/bin/env python3
"""Genera el documento entregable (Resultado esperado del simulador G2) en Markdown,
combinando narrativa profesional con el catalogo de dashboards y las consultas SQL
extraidas directamente de los tableros implementados."""
import json, glob, os, re

DASH_DIR = "/app/import_local/dashboards"
OUT = "/app/import_local/DOCUMENTACION_SEE.md"

# Orden y titulos oficiales
def load_dashboards():
    files = sorted(glob.glob(os.path.join(DASH_DIR, "*.json")))
    dashboards = []
    for f in files:
        d = json.load(open(f))
        panels = []
        for p in d.get("panels", []):
            sql = ""
            for t in p.get("targets", []):
                if t.get("rawSql"):
                    sql = t["rawSql"]
                    break
            panels.append({"title": p.get("title", ""), "type": p.get("type", ""), "sql": sql,
                           "desc": p.get("description", "")})
        dashboards.append({"title": d["title"], "tags": d.get("tags", []), "panels": panels})
    dashboards.sort(key=lambda x: x["title"])
    return dashboards

TIPO_ES = {
    "stat": "Tarjeta KPI", "gauge": "Medidor (gauge)", "bargauge": "Barra de medida",
    "barchart": "Grafica de barras", "piechart": "Grafica de pastel/dona",
    "timeseries": "Serie de tiempo", "table": "Tabla", "text": "Texto",
    "marcusolsson-calendar-panel": "Calendario", "state-timeline": "Linea de tiempo de estados",
}

INTERPRET = {
 "Dashboard Ejecutivo": "**Objetivo.** Ofrecer a la direccion una vista integral del estado del SEE en una sola pantalla. **Como leerlo.** Las tarjetas superiores resumen los cuatro indicadores clave (empleados activos, cumplimiento de competencias, avance del Plan Maestro y DDP autorizadas); los medidores muestran el semaforo global; la dona compara competentes contra brechas; las barras ordenan a los departamentos de mayor a menor cumplimiento; y la serie de tiempo evidencia la adopcion del sistema. Los filtros de Planta y Departamento permiten acotar todo el tablero. **Decision tipica.** Detectar de inmediato si algun indicador global esta en rojo y en que area concentrarse.",
 "Cumplimiento por Departamento": "**Objetivo.** Comparar el desempeno de los 18 departamentos. **Como leerlo.** La barra horizontal ordena de mayor a menor cumplimiento; la tabla detalla evaluaciones, competentes, brechas y porcentaje. La columna de brechas se colorea para resaltar los focos de atencion. **Decision tipica.** Priorizar apoyo a los departamentos por debajo de la meta (>= 95%).",
 "Cumplimiento por Planta": "**Objetivo.** Evaluar el desempeno entre las tres plantas. **Como leerlo.** Las barras y la tabla muestran el porcentaje por sitio; la grafica de pastel refleja la distribucion de personal. **Decision tipica.** Identificar plantas rezagadas y equilibrar recursos de capacitacion.",
 "Competencias por Puesto": "**Objetivo.** Analizar competencias requeridas frente a logradas. **Como leerlo.** Las barras apiladas (cifras oficiales del documento) muestran, por area normativa, las competencias cumplidas y la brecha, cuya suma es el total requerido; la tabla anade el porcentaje. Un segundo grafico apila logradas y brechas por puesto. **Decision tipica.** Enfocar cursos en las areas con mayor brecha relativa (p. ej. IATF y Lean).",
 "Brechas de Competencias": "**Objetivo.** Localizar donde faltan competencias. **Como leerlo.** El grafico y la tabla de brechas por departamento (cifras del documento) muestran las competencias faltantes; el mapa de calor cruza departamento y tipo de competencia, coloreando las celdas con mas brechas. **Decision tipica.** Construir el Plan Maestro atacando primero las mayores concentraciones de brecha.",
 "Diagnostico de Necesidades": "**Objetivo.** Mostrar el resultado del DDN. **Como leerlo.** La dona presenta 558 competentes (93%) contra 42 con brecha (7%); otra dona desglosa las brechas por prioridad; la serie de tiempo muestra el ritmo de evaluaciones; la tabla lista los diagnosticos recientes. **Decision tipica.** Atender primero las brechas de prioridad Alta.",
 "Plan Maestro": "**Objetivo.** Seguir la ejecucion del plan anual de capacitacion. **Como leerlo.** El cronograma lista los cursos con su semana, fechas y estatus; la dona y las barras apiladas resumen el estatus por departamento; la tabla muestra el estado de firmas por departamento y anio fiscal. **Decision tipica.** Reprogramar cursos atrasados y completar firmas pendientes.",
 "Cursos Programados": "**Objetivo.** Planear el calendario de cursos. **Como leerlo.** El Calendario ubica cada curso en su fecha; las barras muestran la carga por semana y por anio; la tabla lista los proximos cursos. **Decision tipica.** Balancear la carga de cursos a lo largo del anio y evitar semanas saturadas.",
 "Evidencias Digitales": "**Objetivo.** Verificar el soporte documental de la competencia. **Como leerlo.** Las tarjetas resumen evidencias cargadas, porcentaje con evidencia y competentes sin evidencia; las barras y la tabla detallan por departamento y registro. **Decision tipica.** Regularizar expedientes de competentes que aun no tienen evidencia cargada.",
 "Indicadores IATF 16949": "**Objetivo.** Demostrar el cumplimiento de la clausula 7.2/7.3 de IATF 16949. **Como leerlo.** Los medidores muestran el cumplimiento de competencias criticas (tipo Normativa), DDP autorizadas y planes firmados por el Gerente de Planta; la barra de medida detalla por competencia normativa; la tabla resume el estatus normativo por departamento. **Decision tipica.** Cerrar brechas normativas antes de una auditoria de certificacion.",
 "Indicadores ISO 9001": "**Objetivo.** Evidenciar el control de informacion documentada (clausula 7.5). **Como leerlo.** Los medidores y barras muestran DDP controladas/autorizadas frente a pendientes; la serie de tiempo grafica la creacion de documentos por mes. **Decision tipica.** Asegurar que el 100% de las DDP relevantes esten autorizadas y vigentes.",
 "Trazabilidad de Autorizaciones": "**Objetivo.** Auditar el flujo de firmas de las DDP. **Como leerlo.** Las tarjetas muestran el tiempo promedio de autorizacion (dias), pendientes de firma y porcentaje autorizado a tiempo; la barra compara el tiempo por departamento; la tabla detalla el flujo creada -> enviada -> autorizada con los dias transcurridos. **Decision tipica.** Agilizar las autorizaciones que exceden la meta de 3 dias.",
 "Productividad del Sistema": "**Objetivo.** Cuantificar el impacto de digitalizar el proceso. **Como leerlo.** Las barras comparan el tiempo (minutos) de cada proceso antes (manual) y despues (SEE); las tarjetas resumen la reduccion promedio y las horas ahorradas. **Decision tipica.** Justificar la inversion y replicar la mejora en otros procesos.",
 "Auditorias": "**Objetivo.** Preparar la evidencia para auditoria. **Como leerlo.** Las tarjetas y el medidor muestran cuantas DDP estan listas/no listas y el porcentaje de documentacion lista; el checklist detalla puesto, planta, revision y estatus de auditoria. **Decision tipica.** Completar la documentacion faltante antes de la fecha de auditoria.",
 "Usuarios Activos": "**Objetivo.** Monitorear la adopcion del sistema. **Como leerlo.** Las tarjetas resumen el promedio diario, el pico y las sesiones totales; la serie de tiempo y las barras mensuales muestran la tendencia de uso. **Decision tipica.** Detectar caidas de uso que indiquen problemas de adopcion o disponibilidad.",
 "Reportes Predictivos": "**Objetivo.** Anticipar riesgos. **Como leerlo.** Las tarjetas alertan sobre competencias/certificaciones por vencer, cursos a programar y departamentos en riesgo; las barras muestran los departamentos de mayor riesgo; la tendencia y la tabla listan lo que vence en los proximos 60 dias. **Decision tipica.** Reprogramar recertificaciones y reforzar departamentos en riesgo antes de que caigan en incumplimiento.",
}

PORTADA = """# Sistema de Entrenamiento Electronico (SEE)
## Plataforma de Business Intelligence en Grafana para la gestion de la capacitacion industrial

**Modulos:** Descripciones de Puesto (DDP) · Diagnostico de Necesidades (DDN) · Plan Maestro de Entrenamiento
**Cumplimiento normativo:** IATF 16949:2016 · ISO 9001:2015
**Herramienta:** Grafana 13 (OSS) + PostgreSQL 15
**Proyecto:** Verano Cientifico

---

## Indice

1. Resumen ejecutivo
2. Introduccion y contexto
3. Objetivos y alcance
4. El Sistema de Entrenamiento Electronico (SEE)
5. Arquitectura tecnica de la solucion
6. Modelo de datos
7. Metodologia y datos de simulacion
8. Catalogo de dashboards (16 reportes)
9. Diccionario de indicadores (KPIs)
10. Alineacion con IATF 16949:2016 e ISO 9001:2015
11. Modulo de reportes predictivos
12. Casos de uso
13. Resultados esperados y beneficios
14. Conclusiones y trabajo futuro
15. Anexo A: Consultas SQL documentadas
16. Anexo B: Guia de despliegue y acceso

---
"""

RESUMEN = """## 1. Resumen ejecutivo

El presente documento describe el diseno, la implementacion y la interpretacion de una
plataforma de **inteligencia de negocio (Business Intelligence)** construida sobre
**Grafana** y **PostgreSQL** para el **Sistema de Entrenamiento Electronico (SEE)** de
una organizacion manufacturera del sector automotriz.

El SEE digitaliza tres procesos criticos de la gestion del talento y la calidad:

- **Descripciones de Puesto (DDP):** definicion formal de cada puesto, sus competencias
  requeridas y su ciclo de elaboracion, envio y autorizacion.
- **Diagnostico de Necesidades (DDN):** evaluacion de cada colaborador contra las
  competencias de su puesto para identificar quien es *competente* y quien presenta
  *brechas* de capacitacion.
- **Plan Maestro de Entrenamiento:** programacion anual de cursos que cierra las brechas
  detectadas, con su calendario, estatus y flujo de firmas.

La solucion entrega **16 tableros (dashboards)** con mas de **35 indicadores (KPIs)**,
alimentados por una base de datos con **600 empleados, 18 departamentos, 3 plantas,
150 puestos y 3 anios de historia**. Los indicadores estan alineados a los requisitos
de competencia y toma de conciencia de **IATF 16949:2016 (clausula 7.2/7.3)** y al
control de informacion documentada de **ISO 9001:2015 (clausula 7.5)**.

Los resultados de referencia del sistema muestran un **93% de cumplimiento de
competencias** (558 de 600 colaboradores competentes), una reduccion promedio de tiempos
administrativos superior al **85%** frente al proceso manual, y una trazabilidad completa
de evidencias y autorizaciones lista para auditoria.
"""

INTRO = """## 2. Introduccion y contexto

En la industria automotriz, la norma **IATF 16949** exige demostrar que el personal que
afecta la calidad del producto es **competente** con base en educacion, formacion,
habilidades y experiencia, y que la organizacion **conserva informacion documentada** como
evidencia de dicha competencia. Gestionar esto de forma manual (hojas de calculo, formatos
en papel, firmas fisicas) es lento, propenso a errores y dificil de auditar.

El **Sistema de Entrenamiento Electronico (SEE)** nace para digitalizar este proceso. Sin
embargo, contar con los datos no basta: la direccion, los gerentes de departamento y los
auditores necesitan **visualizar** el estado de la capacitacion en tiempo real para tomar
decisiones. Ahi entra esta plataforma de dashboards, que convierte los datos operativos del
SEE en **informacion accionable**.

## 3. Objetivos y alcance

**Objetivo general.** Disenar e implementar una plataforma de dashboards en Grafana que
permita monitorear, analizar y auditar el desempeno del Sistema de Entrenamiento
Electronico, alineada a IATF 16949 e ISO 9001.

**Objetivos especificos.**

- Modelar en PostgreSQL los datos de DDP, DDN y Plan Maestro.
- Construir un conjunto de al menos 15 reportes con mas de 35 indicadores.
- Definir un diccionario de KPIs con formula, meta y frecuencia.
- Documentar las consultas SQL que alimentan cada visualizacion.
- Incorporar un modulo de reportes predictivos para anticipar riesgos.
- Alinear los indicadores a los requisitos normativos aplicables.

**Alcance.** El proyecto cubre la capa analitica (visualizacion e indicadores) sobre datos
simulados representativos. No incluye la captura transaccional del SEE (formularios de
alta/edicion), que corresponde al sistema operativo fuente.
"""

SEE = """## 4. El Sistema de Entrenamiento Electronico (SEE)

El SEE se compone de tres modulos encadenados:

### 4.1 Descripciones de Puesto (DDP)
Cada puesto de la organizacion cuenta con una descripcion formal que define su objetivo y,
sobre todo, el **conjunto de competencias requeridas**. La DDP sigue un flujo documental:
es *elaborada* por el manejador (MNJ) del departamento, *enviada* a Recursos Humanos y
finalmente *autorizada* (firmada). Una DDP autorizada es la base para poder evaluar al
personal y es un documento controlado bajo ISO 9001.

### 4.2 Diagnostico de Necesidades (DDN)
Para cada colaborador se evalua, competencia por competencia de su puesto, si es
**competente** o presenta una **brecha**. Cuando existe evidencia (constancia, certificado,
practica validada) se registra la *evidencia digital* asociada. El DDN clasifica las brechas
por **prioridad** (Alta, Media, Baja) para orientar el plan de capacitacion.

### 4.3 Plan Maestro de Entrenamiento
Con las brechas identificadas se construye, por departamento y anio fiscal, el **Plan
Maestro**: el catalogo de cursos, su **programacion** semanal, el estatus de cada curso
(Programado, En curso, Completado, Cancelado) y el flujo de firmas (MNJ del departamento,
MNJ de entrenamiento y Gerente de Planta). El Plan Maestro cierra el ciclo: detecta la
brecha (DDN), la atiende con un curso y vuelve a evaluar.
"""

ARQ = """## 5. Arquitectura tecnica de la solucion

La solucion sigue una arquitectura de tres capas: la fuente de datos, el motor analitico y
la capa de visualizacion. El siguiente diagrama resume el flujo de la informacion:

<img class="figura" src="assets/arquitectura_see.png" alt="Arquitectura SEE - PostgreSQL - Grafana">
<p class="figpie">Figura 1. Flujo de datos: el SEE alimenta PostgreSQL, y Grafana consulta la base para presentar los tableros al usuario.</p>

```
Navegador  --HTTPS-->  Grafana 13 (OSS)  -->  PostgreSQL 15 (base see_db)
                        |  16 dashboards provisionados
                        |  1 fuente de datos (uid: see_pg)
                        |  Idioma es-ES, tema oscuro, acceso anonimo de lectura
```

- **Grafana 13 (OSS):** motor de visualizacion. Los dashboards y la fuente de datos se
  cargan por *aprovisionamiento* (archivos de configuracion), lo que hace el despliegue
  reproducible y facil de mantener.
- **PostgreSQL 15:** almacen analitico. Cada panel ejecuta una consulta SQL directa.
- **Docker Compose:** orquesta ambos servicios en un solo comando; incluye el plugin
  *Business Calendar* para la vista de calendario.
- **Plugin de calendario:** `marcusolsson-calendar-panel` para el reporte de cursos
  programados.

Decisiones de diseno relevantes:

- Grafana se sirve bajo el subpath `/grafana` en el entorno de nube para no colisionar con
  la ruta reservada `/api`; en local (Docker) se sirve en la raiz del puerto 3001.
- Se fija `jsonData.database = see_db` en la fuente de datos (requisito de Grafana 10+),
  ademas del idioma `es-ES` para toda la interfaz.
"""

MODELO = """## 6. Modelo de datos

La base `see_db` implementa un modelo relacional normalizado. Tablas principales:

| Tabla | Descripcion |
| :-- | :-- |
| `plantas` | Catalogo de plantas (3) y su ubicacion. |
| `departamentos` | Catalogo de departamentos (18). |
| `areas` | Areas por departamento (55). |
| `puestos` | Catalogo de puestos (150) con su clasificacion. |
| `empleados` | Colaboradores (600), su puesto, planta, area y estatus activo. |
| `descripciones_puesto` | DDP (150): revision, fechas de creacion/envio/aprobacion, autorizada. |
| `competencias_puesto` | Competencias requeridas por DDP (~900), con su tipo. |
| `diagnosticos` | Evaluaciones del DDN: competente, prioridad, evidencia, vencimiento. |
| `cursos` | Cursos y sus horas. |
| `plan_maestro` | Plan Maestro por departamento y anio fiscal (54) con firmas. |
| `cursos_programados` | Programacion semanal de cursos y su estatus. |
| `cursos_participantes` | Asistencia de colaboradores a cursos. |
| `accesos_diarios` | Serie de tiempo de uso del sistema (3 anios). |
| `metricas_productividad` | Comparativo de tiempos antes/despues del SEE. |
| `rep_competencias`, `rep_brechas`, `rep_ddn` | Cifras oficiales de referencia del reporte. |

**Regla de evaluacion vigente.** Como un colaborador puede reevaluarse varias veces, los
indicadores usan la **ultima evaluacion** por combinacion colaborador-competencia mediante
`DISTINCT ON (no_reloj, id_competencia) ... ORDER BY fecha_registro DESC`.
"""

METODO = """## 7. Metodologia y datos de simulacion

Ante la ausencia de acceso a la base productiva, se genero un **conjunto de datos ficticio
pero realista** con distribuciones coherentes (antiguedad, rotacion ~6%, prioridades de
brecha, estacionalidad de uso). Las cifras de referencia de los reportes clave se ajustaron
a los **valores oficiales del documento simulador G2**:

| Indicador de referencia | Valor |
| :-- | :-- |
| Colaboradores competentes | 558 |
| Colaboradores con brecha | 42 |
| % de cumplimiento de competencias | 93% |
| Competencias por area normativa | Seguridad 596/600, Calidad 589/600, Manufactura 545/580, Lean 381/420, IATF 360/400, ISO 372/400 |
| Brechas por departamento | Produccion 25, Ingenieria 12, Calidad 8, Logistica 6, RH 3 |

Los datos se regeneran de forma reproducible con `generar_datos.py`.
"""

KPI_HEAD = """## 9. Diccionario de indicadores (KPIs)

Cada indicador se define con su formula, meta, frecuencia de revision e interpretacion.
Los umbrales de color siguen el semaforo: **rojo** (critico), **ambar/amarillo**
(en observacion) y **verde** (cumple).

| # | KPI | Formula | Meta | Frec. | Dashboard |
| :-: | :-- | :-- | :-: | :-: | :-- |
"""

KPIS = [
 ("% Cumplimiento de competencias", "Competencias competentes / evaluadas x 100", ">= 95%", "Mensual", "Ejecutivo, Depto, Planta"),
 ("Empleados activos", "Conteo de empleados con estatus activo", "-", "Diario", "Ejecutivo"),
 ("Competencias evaluadas", "Conteo de ultimas evaluaciones", "-", "Mensual", "Ejecutivo"),
 ("% Cumplimiento del Plan Maestro", "Cursos completados / (programados no cancelados) x 100", ">= 90%", "Mensual", "Ejecutivo, Plan Maestro"),
 ("% DDP autorizadas", "DDP firmadas / registradas x 100", "100%", "Semanal", "Ejecutivo, ISO 9001"),
 ("Cumplimiento global (gauge)", "Igual que % cumplimiento de competencias", ">= 95%", "Mensual", "Ejecutivo"),
 ("Empleados competentes (DDN)", "Conteo de competentes (558)", "-", "Mensual", "DDN, Ejecutivo"),
 ("Empleados con brecha (DDN)", "Conteo de no competentes (42)", "0", "Mensual", "DDN"),
 ("Brechas de prioridad Alta", "No competentes con prioridad Alta", "Minimizar", "Semanal", "DDN"),
 ("Cumplimiento por departamento", "% competentes por departamento", ">= 95%", "Mensual", "Depto"),
 ("Cumplimiento por planta", "% competentes por planta", ">= 95%", "Mensual", "Planta"),
 ("Competencias requeridas vs logradas", "Logradas / requeridas por puesto", ">= 95%", "Mensual", "Competencias por Puesto"),
 ("% por clasificacion de puesto", "% competentes por clasificacion", ">= 95%", "Mensual", "Competencias por Puesto"),
 ("Brechas por departamento", "Conteo de faltantes por depto", "Reducir", "Mensual", "Brechas"),
 ("Top competencias con brecha", "Conteo de no competentes por competencia", "Reducir", "Mensual", "Brechas"),
 ("Planes maestros registrados", "Conteo de planes", "54", "Anual", "Plan Maestro"),
 ("% Planes totalmente firmados", "Planes con 3 firmas / total x 100", "100%", "Trimestral", "Plan Maestro"),
 ("Cursos completados", "Conteo de cursos con estatus Completado", "-", "Mensual", "Plan Maestro"),
 ("Cursos en curso / programados", "Conteo con estatus En curso o Programado", "-", "Mensual", "Plan Maestro"),
 ("Horas de capacitacion programadas", "Suma de horas de cursos por anio", "-", "Anual", "Cursos Programados"),
 ("Evidencias cargadas", "Conteo de evidencias digitales", "-", "Mensual", "Evidencias"),
 ("% Competencias con evidencia", "Con evidencia / competentes x 100", ">= 95%", "Mensual", "Evidencias"),
 ("Competentes sin evidencia", "Competentes sin ruta de evidencia", "0", "Mensual", "Evidencias"),
 ("% Competencias criticas (IATF)", "% competentes de tipo Normativa", ">= 95%", "Mensual", "IATF 16949"),
 ("% Planes firmados por Gerente", "Planes con firma gerente / total x 100", "100%", "Trimestral", "IATF 16949"),
 ("Documentos controlados (DDP)", "% DDP autorizadas", ">= 95%", "Mensual", "ISO 9001"),
 ("Revision promedio de documentos", "Promedio de revisiones de DDP", "-", "Semestral", "ISO 9001"),
 ("Tiempo promedio de autorizacion", "Promedio(fecha_aprobacion - fecha_envio)", "<= 3 dias", "Semanal", "Trazabilidad"),
 ("DDP pendientes de firma", "Conteo de DDP no autorizadas", "0", "Semanal", "Trazabilidad"),
 ("% Autorizadas en <= 3 dias", "DDP autorizadas en 3 dias / autorizadas x 100", ">= 90%", "Semanal", "Trazabilidad"),
 ("Reduccion promedio de tiempo", "Promedio((antes - despues)/antes) x 100", "Maximizar", "Anual", "Productividad"),
 ("Horas ahorradas por ciclo", "Suma(antes - despues) / 60", "Maximizar", "Anual", "Productividad"),
 ("% Documentacion lista auditoria", "DDP autorizadas / total x 100", ">= 95%", "Mensual", "Auditorias"),
 ("Promedio usuarios activos/dia", "Promedio de usuarios (90 dias)", "-", "Diario", "Usuarios Activos"),
 ("Pico maximo de usuarios", "Maximo de usuarios activos", "-", "Diario", "Usuarios Activos"),
 ("Sesiones totales (3 anios)", "Suma de sesiones", "-", "Anual", "Usuarios Activos"),
 ("Competencias por vencer (30 dias)", "Competentes con vencimiento en 30 dias", "Minimizar", "Semanal", "Predictivo"),
 ("Empleados con certificacion por vencer", "Empleados con vencimiento en 60 dias", "Minimizar", "Semanal", "Predictivo"),
 ("Departamentos en riesgo (<80%)", "Deptos con cumplimiento < 80%", "0", "Mensual", "Predictivo"),
]

IATF_ISO = """## 10. Alineacion con IATF 16949:2016 e ISO 9001:2015

| Requisito normativo | Como lo evidencia la plataforma |
| :-- | :-- |
| **IATF 16949 - 7.2 Competencia** | Dashboard *Indicadores IATF 16949*: % de competencias criticas (tipo Normativa) cumplidas, cumplimiento por competencia y brechas normativas por departamento. |
| **IATF 16949 - 7.3 Toma de conciencia** | Cobertura de capacitacion (Plan Maestro) y seguimiento de asistencia a cursos. |
| **IATF 16949 - 7.2.3 Competencia de auditores** | Competencia "Auditoria IATF 16949" monitoreada en el reporte de competencias. |
| **ISO 9001 - 7.5 Informacion documentada** | Dashboard *Indicadores ISO 9001*: DDP como documentos controlados, % autorizadas, revision promedio y creacion de documentos por mes. |
| **ISO 9001 - 7.2 Competencia** | Evidencias digitales conservadas y trazabilidad de autorizaciones. |
| **Preparacion para auditoria** | Dashboard *Auditorias*: checklist de DDP listas/no listas y % de documentacion lista. |

La combinacion de estos tableros permite responder a un auditor, en segundos y con
evidencia, preguntas como: *"muestreme el % de personal competente en competencias criticas
del departamento de Calidad"* o *"que descripciones de puesto no estan autorizadas"*.
"""

PREDICTIVO = """## 11. Modulo de reportes predictivos

El dashboard *Modulo de Reportes Predictivos* anticipa riesgos antes de que se conviertan en
no conformidades:

- **Competencias por vencer (30 dias):** certificaciones proximas a expirar.
- **Empleados con certificacion por vencer (60 dias):** para reprogramar recertificaciones.
- **Cursos a programar (proximo mes):** carga de trabajo del area de entrenamiento.
- **Departamentos en riesgo (< 80%):** focos rojos de incumplimiento.
- **Departamentos con mayor riesgo:** ranking ascendente por % de cumplimiento.
- **Tendencia anual del Plan Maestro:** evolucion del cumplimiento en el tiempo.
- **Tabla de certificaciones proximas a vencer:** con dias restantes por colaborador.

Este enfoque convierte al SEE de un sistema *reactivo* a uno *preventivo*, en linea con el
pensamiento basado en riesgos de ISO 9001.
"""

CASOS = """## 12. Casos de uso

A continuacion, 20 escenarios reales de uso de la plataforma:

1. **Direccion general** revisa el Dashboard Ejecutivo para conocer el estado global de la
   capacitacion en un vistazo.
2. **Gerente de Planta** compara el cumplimiento entre las tres plantas.
3. **Gerente de departamento** identifica su posicion en el ranking de cumplimiento.
4. **Coordinador de entrenamiento** localiza las competencias con mayor brecha para priorizar
   cursos.
5. **Auditor IATF** verifica el % de competencias criticas cumplidas antes de una auditoria.
6. **Auditor ISO** confirma que todas las DDP relevantes estan autorizadas.
7. **RH** da seguimiento a las DDP pendientes de firma y su tiempo de autorizacion.
8. **Jefe de area** consulta que colaboradores presentan brecha en una competencia especifica.
9. **Entrenamiento** planea el calendario anual de cursos con la vista de Calendario.
10. **Control de produccion** revisa el cronograma del Plan Maestro por departamento.
11. **Calidad** monitorea el % de evidencias digitales cargadas.
12. **RH** detecta colaboradores competentes sin evidencia para regularizar expedientes.
13. **Seguridad e higiene** vigila el cumplimiento de la competencia de EPP.
14. **Direccion** cuantifica el ahorro de tiempo del sistema (dashboard de Productividad).
15. **Entrenamiento** anticipa recertificaciones con el modulo predictivo (30/60 dias).
16. **Gerencia** actua sobre los departamentos en riesgo (< 80%).
17. **Sistemas/TI** monitorea la adopcion del SEE con usuarios activos y sesiones.
18. **Auditor** exporta el checklist de auditoria de DDP.
19. **Direccion** evalua la tendencia anual del cumplimiento del Plan Maestro.
20. **Comite de calidad** usa los tableros como insumo para la revision por la direccion.
"""

RESULTADOS = """## 13. Resultados esperados y beneficios

- **Visibilidad total y en tiempo real** del estado de la capacitacion (competencias, brechas,
  cursos, evidencias, autorizaciones).
- **93% de cumplimiento** de competencias como linea base medible y comparable.
- **Reduccion de tiempos administrativos > 85%** frente al proceso manual (elaboracion y
  autorizacion de documentos, generacion de planes, consulta de evidencias para auditoria).
- **Trazabilidad y evidencia lista para auditoria** IATF/ISO, reduciendo el riesgo de no
  conformidades.
- **Toma de decisiones basada en datos** para priorizar la inversion en capacitacion donde
  mas impacta.
- **Enfoque preventivo** gracias al modulo predictivo (vencimientos y departamentos en riesgo).

## 14. Conclusiones y trabajo futuro

La plataforma cumple el objetivo de transformar los datos del SEE en informacion accionable,
con 16 dashboards, mas de 35 indicadores y alineacion normativa. Como trabajo futuro se
propone: (a) conectar la plataforma a la base productiva real del SEE; (b) habilitar alertas
automaticas de Grafana (correo/Slack) ante incumplimientos o vencimientos; (c) incorporar
autenticacion por roles (Direccion, RH, Auditor, Gerente) mapeada a equipos de Grafana; y
(d) anadir analitica avanzada (prediccion de brechas con modelos estadisticos).
"""

def sql_clean(sql):
    sql = re.sub(r"\s+", " ", sql).strip()
    return sql

def main():
    dbs = load_dashboards()

    # 8. Catalogo de dashboards
    cat = ["## 8. Catalogo de dashboards (16 reportes)\n",
           "La solucion entrega 16 tableros organizados en la carpeta *SEE - Sistema de "
           "Entrenamiento*. Para cada uno se indica su objetivo, sus paneles y como interpretarlo.\n"]
    for d in dbs:
        cat.append(f"### {d['title']}\n")
        key = next((k for k in INTERPRET if k in d["title"]), None)
        if key:
            cat.append(INTERPRET[key] + "\n")
        cat.append(
            f'<div class="captura">CAPTURA DE GRAFANA<br>'
            f'<span>Pega aqui la imagen del tablero &laquo;{d["title"]}&raquo; '
            f'(Grafana &rarr; localhost:3001)</span></div>\n')
        cat.append("**Paneles:**\n")
        cat.append("| Panel | Visualizacion |")
        cat.append("| :-- | :-- |")
        for p in d["panels"]:
            if p["type"] == "text":
                continue
            cat.append(f"| {p['title']} | {TIPO_ES.get(p['type'], p['type'])} |")
        cat.append("")

    # 15. Anexo SQL
    anexo = ["## 15. Anexo A: Consultas SQL documentadas\n",
             "Se documentan las consultas que alimentan cada visualizacion. Los parametros "
             "`$planta` y `$departamento` corresponden a los filtros interactivos; "
             "`$__timeFilter(campo)` aplica el rango de tiempo seleccionado.\n"]
    n = 0
    for d in dbs:
        anexo.append(f"### {d['title']}\n")
        for p in d["panels"]:
            if not p["sql"]:
                continue
            n += 1
            anexo.append(f"**{n}. {p['title']}**\n")
            anexo.append("```sql")
            anexo.append(sql_clean(p["sql"]))
            anexo.append("```\n")

    anexo.append(f"\n> Total de consultas documentadas: **{n}**.\n")

    kpi = [KPI_HEAD]
    for i, k in enumerate(KPIS, 1):
        kpi.append(f"| {i} | {k[0]} | {k[1]} | {k[2]} | {k[3]} | {k[4]} |")
    kpi.append(f"\n> Total: **{len(KPIS)} indicadores** documentados.\n")

    anexo_b = """## 16. Anexo B: Guia de despliegue y acceso

**Despliegue local (Docker):**
```bash
cd import_local
./importar.sh            # levanta PostgreSQL + Grafana con todo cargado
```
Acceso: http://localhost:3001 (o el subpath /grafana en la nube).

**Credenciales:**
- Grafana admin: `admin` / `SEE_admin_2026`
- Base de datos: `see_db` / `see_user` / `see_pass_2026`

**Reproducibilidad:** `generar_datos.py` regenera los datos y `generar_dashboards.py`
regenera los 16 tableros cuando se necesite partir de cero.
"""

    doc = "\n".join([
        PORTADA, RESUMEN, INTRO, SEE, ARQ, MODELO, METODO,
        "\n".join(cat),
        "\n".join(kpi),
        IATF_ISO, PREDICTIVO, CASOS, RESULTADOS,
        "\n".join(anexo),
        anexo_b,
    ])
    open(OUT, "w").write(doc)
    words = len(doc.split())
    print(f"Documento generado: {OUT}")
    print(f"Palabras: {words} (~{max(1, words//450)} paginas)")
    print(f"Dashboards: {len(dbs)} | Consultas SQL documentadas: {n} | KPIs: {len(KPIS)}")

if __name__ == "__main__":
    main()
