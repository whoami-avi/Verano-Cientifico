#!/usr/bin/env python3
"""Generador de esquema y datos ficticios realistas para el Sistema de Entrenamiento
Electronico (SEE): modulos DDP (Descripciones de Puesto), DDN (Diagnostico de
Necesidades) y Plan Maestro de Entrenamiento. Cumplimiento IATF 16949 / ISO 9001.
"""
import random
from datetime import datetime, timedelta, date
import psycopg2
from psycopg2.extras import execute_values

random.seed(2026)

CONN = dict(host="127.0.0.1", dbname="see_db", user="see_user", password="see_pass_2026")

SCHEMA = """
DROP TABLE IF EXISTS cursos_participantes, cursos_programados, plan_maestro,
    cursos, diagnosticos, competencias_puesto, descripciones_puesto, empleados,
    puestos, areas, departamentos, plantas, accesos_diarios, metricas_productividad CASCADE;

CREATE TABLE plantas (
    clave_planta   INT PRIMARY KEY,
    planta         TEXT NOT NULL,
    ubicacion      TEXT
);
CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY,
    departamento    TEXT NOT NULL
);
CREATE TABLE areas (
    clave_area      INT PRIMARY KEY,
    id_departamento INT REFERENCES departamentos(id_departamento),
    area            TEXT NOT NULL
);
CREATE TABLE puestos (
    clave_puesto    INT PRIMARY KEY,
    puesto          TEXT NOT NULL,
    clasificacion   TEXT NOT NULL,
    id_departamento INT REFERENCES departamentos(id_departamento)
);
CREATE TABLE empleados (
    no_reloj        INT PRIMARY KEY,
    nombre          TEXT NOT NULL,
    email           TEXT,
    clave_planta    INT REFERENCES plantas(clave_planta),
    id_departamento INT REFERENCES departamentos(id_departamento),
    clave_area      INT REFERENCES areas(clave_area),
    clave_puesto    INT REFERENCES puestos(clave_puesto),
    fecha_ingreso   DATE,
    activo          BOOLEAN,
    es_mnj          BOOLEAN
);
CREATE TABLE descripciones_puesto (
    id_descripcion_puesto INT PRIMARY KEY,
    clave_planta    INT REFERENCES plantas(clave_planta),
    clave_puesto    INT REFERENCES puestos(clave_puesto),
    clave_area      INT REFERENCES areas(clave_area),
    id_departamento INT REFERENCES departamentos(id_departamento),
    revision        INT,
    elaborado_por   TEXT,
    objetivo        TEXT,
    fecha_creacion  DATE,
    fecha_envio     DATE,
    fecha_aprobacion DATE,
    autorizada      BOOLEAN
);
CREATE TABLE competencias_puesto (
    id_competencia  INT PRIMARY KEY,
    id_descripcion_puesto INT REFERENCES descripciones_puesto(id_descripcion_puesto),
    descripcion_competencia TEXT NOT NULL,
    tipo            TEXT
);
CREATE TABLE cursos (
    id_curso        INT PRIMARY KEY,
    id_competencia  INT REFERENCES competencias_puesto(id_competencia),
    nombre_curso    TEXT NOT NULL,
    horas           INT
);
CREATE TABLE diagnosticos (
    id_diagnostico  INT PRIMARY KEY,
    no_reloj        INT REFERENCES empleados(no_reloj),
    id_descripcion_puesto INT REFERENCES descripciones_puesto(id_descripcion_puesto),
    id_competencia  INT REFERENCES competencias_puesto(id_competencia),
    competente      BOOLEAN,
    prioridad       TEXT,
    ruta_evidencia  TEXT,
    fecha_registro  DATE,
    fecha_vencimiento DATE
);
CREATE TABLE plan_maestro (
    id_plan_maestro INT PRIMARY KEY,
    id_departamento INT REFERENCES departamentos(id_departamento),
    anio_fiscal     INT,
    fecha           DATE,
    revision        INT,
    firma_mnj_depto BOOLEAN,
    firma_mnj_entto BOOLEAN,
    firma_gerente   BOOLEAN
);
CREATE TABLE cursos_programados (
    id_curso_programado INT PRIMARY KEY,
    id_curso        INT REFERENCES cursos(id_curso),
    id_plan_maestro INT REFERENCES plan_maestro(id_plan_maestro),
    anio_fiscal     INT,
    semana          INT,
    fecha_inicio    DATE,
    fecha_fin       DATE,
    estatus         TEXT
);
CREATE TABLE cursos_participantes (
    id              SERIAL PRIMARY KEY,
    id_curso_programado INT REFERENCES cursos_programados(id_curso_programado),
    no_reloj        INT REFERENCES empleados(no_reloj),
    asistio         BOOLEAN
);
CREATE TABLE accesos_diarios (
    fecha           DATE PRIMARY KEY,
    usuarios_activos INT,
    sesiones        INT
);
CREATE TABLE metricas_productividad (
    proceso         TEXT PRIMARY KEY,
    tiempo_antes_min INT,
    tiempo_despues_min INT
);
"""

DEPARTAMENTOS = [
    "Produccion", "Calidad", "Ingenieria", "Mantenimiento", "Logistica",
    "Recursos Humanos", "Seguridad e Higiene", "Compras", "Almacen",
    "Control de Produccion", "Metrologia", "Herramentales", "Inyeccion",
    "Ensamble", "Pintura", "Sistemas", "Finanzas", "Entrenamiento",
]
AREAS_POR_DEPTO = ["Linea A", "Linea B", "Turno Matutino", "Turno Vespertino", "Soporte"]
CLASIF = ["Operativo", "Tecnico", "Administrativo", "Supervision", "Gerencial"]
PUESTOS_BASE = [
    "Operador de Produccion", "Inspector de Calidad", "Ingeniero de Procesos",
    "Tecnico de Mantenimiento", "Auxiliar de Logistica", "Analista de RH",
    "Supervisor de Linea", "Comprador", "Almacenista", "Planeador",
    "Metrologo", "Diseñador de Herramentales", "Operador de Inyeccion",
    "Ensamblador", "Pintor Industrial", "Analista de Sistemas", "Contador",
    "Coordinador de Entrenamiento", "Lider de Celula", "Auditor Interno",
]
COMPETENCIAS = [
    ("Control Estadistico de Proceso (SPC)", "Tecnica"),
    ("Lectura e interpretacion de planos", "Tecnica"),
    ("Manejo de montacargas", "Operativa"),
    ("AMEF / FMEA", "Normativa"),
    ("Auditoria IATF 16949", "Normativa"),
    ("Calibracion de instrumentos", "Tecnica"),
    ("Soldadura MIG/MAG", "Operativa"),
    ("Inyeccion de plastico", "Operativa"),
    ("Analisis de causa raiz (8D)", "Tecnica"),
    ("Sistema de gestion ISO 9001", "Normativa"),
    ("Seguridad industrial y EPP", "Normativa"),
    ("Manejo de PLC", "Tecnica"),
    ("Metrologia dimensional", "Tecnica"),
    ("Control de documentos", "Normativa"),
    ("Trabajo en equipo", "Blanda"),
    ("Comunicacion efectiva", "Blanda"),
    ("Manufactura esbelta (Lean)", "Tecnica"),
    ("Kaizen y mejora continua", "Tecnica"),
    ("PPAP y APQP", "Normativa"),
    ("Plan de control", "Normativa"),
    ("Manejo de materiales peligrosos", "Operativa"),
    ("Mantenimiento productivo total (TPM)", "Tecnica"),
    ("Programacion CNC", "Tecnica"),
    ("Gestion de proveedores", "Administrativa"),
    ("Core Tools automotrices", "Normativa"),
]
PRIORIDADES = ["Alta", "Media", "Baja"]
NOMBRES = ["Juan", "Maria", "Carlos", "Ana", "Luis", "Sofia", "Miguel", "Laura",
    "Jose", "Elena", "Pedro", "Carmen", "Jorge", "Isabel", "Ricardo", "Patricia",
    "Fernando", "Gabriela", "Roberto", "Adriana", "Raul", "Monica", "Hector", "Diana"]
APELLIDOS = ["Garcia", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez",
    "Perez", "Sanchez", "Ramirez", "Torres", "Flores", "Rivera", "Gomez", "Diaz",
    "Reyes", "Morales", "Cruz", "Ortiz", "Gutierrez", "Chavez", "Ramos", "Ruiz"]

def main():
    conn = psycopg2.connect(**CONN)
    conn.autocommit = False
    cur = conn.cursor()
    print("Creando esquema...")
    cur.execute(SCHEMA)

    # Plantas
    plantas = [(1, "Planta Norte - Monterrey", "Nuevo Leon"),
               (2, "Planta Bajio - Queretaro", "Queretaro"),
               (3, "Planta Centro - Toluca", "Estado de Mexico")]
    execute_values(cur, "INSERT INTO plantas VALUES %s", plantas)

    # Departamentos
    deptos = [(i + 1, d) for i, d in enumerate(DEPARTAMENTOS)]
    execute_values(cur, "INSERT INTO departamentos VALUES %s", deptos)

    # Areas (2-4 por depto)
    areas = []
    ac = 0
    for did, _ in deptos:
        for a in random.sample(AREAS_POR_DEPTO, random.randint(2, 4)):
            ac += 1
            areas.append((ac, did, a))
    execute_values(cur, "INSERT INTO areas VALUES %s", areas)
    areas_por_depto = {}
    for cae, did, _ in areas:
        areas_por_depto.setdefault(did, []).append(cae)

    # Puestos (150)
    puestos = []
    for i in range(150):
        base = PUESTOS_BASE[i % len(PUESTOS_BASE)]
        did = (i % len(deptos)) + 1
        clasif = random.choice(CLASIF)
        nombre = base if i < len(PUESTOS_BASE) else f"{base} {clasif} N{i//len(PUESTOS_BASE)}"
        puestos.append((i + 1, nombre, clasif, did))
    execute_values(cur, "INSERT INTO puestos VALUES %s", puestos)

    # Empleados (600)
    empleados = []
    hoy = date(2026, 6, 1)
    for i in range(600):
        p = random.choice(puestos)
        did = p[3]
        cae = random.choice(areas_por_depto[did])
        nombre = f"{random.choice(NOMBRES)} {random.choice(APELLIDOS)} {random.choice(APELLIDOS)}"
        ingreso = hoy - timedelta(days=random.randint(120, 365 * 8))
        activo = random.random() > 0.06
        no_reloj = 10000 + i
        email = f"emp{no_reloj}@empresa.com"
        empleados.append((no_reloj, nombre, email, random.choice([1, 2, 3]), did,
                          cae, p[0], ingreso, activo, False))
    # marcar un MNJ por departamento
    mnj_por_depto = {}
    for did, _ in deptos:
        cand = [e for e in empleados if e[4] == did]
        if cand:
            elegido = random.choice(cand)
            mnj_por_depto[did] = elegido[0]
    empleados = [(e[:9] + (True,)) if e[0] in mnj_por_depto.values() else e for e in empleados]
    execute_values(cur, "INSERT INTO empleados VALUES %s", empleados)

    # Descripciones de Puesto (una por puesto = 150)
    descripciones = []
    for p in puestos:
        idp = p[0]
        did = p[3]
        cae = random.choice(areas_por_depto[did])
        creacion = hoy - timedelta(days=random.randint(200, 900))
        autorizada = random.random() > 0.22  # ~78% autorizadas
        envio = creacion + timedelta(days=random.randint(1, 15))
        aprob = None
        if autorizada:
            aprob = envio + timedelta(days=random.randint(0, 10))
        rev = random.randint(0, 4)
        elaborado = f"MNJ {DEPARTAMENTOS[did-1]}"
        descripciones.append((idp, random.choice([1, 2, 3]), p[0], cae, did, rev,
                              elaborado, f"Asegurar la operacion de {p[1]}",
                              creacion, envio, aprob, autorizada))
    execute_values(cur, "INSERT INTO descripciones_puesto VALUES %s", descripciones)

    # Competencias por puesto (4-8 c/u)
    competencias = []
    cid = 0
    comp_por_desc = {}
    for d in descripciones:
        idp = d[0]
        seleccion = random.sample(COMPETENCIAS, random.randint(4, 8))
        for desc, tipo in seleccion:
            cid += 1
            competencias.append((cid, idp, desc, tipo))
            comp_por_desc.setdefault(idp, []).append((cid, desc, tipo))
    execute_values(cur, "INSERT INTO competencias_puesto VALUES %s", competencias)

    # Cursos (uno por cada competencia distinta requerida -> aprox por competencia)
    cursos = []
    curso_por_comp = {}
    curid = 0
    for c in competencias:
        if random.random() > 0.35:  # no todas generan curso formal
            curid += 1
            horas = random.choice([4, 8, 16, 24, 40])
            cursos.append((curid, c[0], f"Curso: {c[2]}", horas))
            curso_por_comp[c[0]] = curid
    execute_values(cur, "INSERT INTO cursos VALUES %s", cursos)

    # Diagnosticos (evaluaciones) ~7000 sobre 3 anios
    diagnosticos = []
    did_seq = 0
    empleados_activos = [e for e in empleados if e[8]]
    # mapa puesto -> descripcion
    desc_por_puesto = {d[2]: d[0] for d in descripciones}
    for e in empleados_activos:
        idp = desc_por_puesto.get(e[6])
        if not idp or idp not in comp_por_desc:
            continue
        comps = comp_por_desc[idp]
        # cada empleado evaluado en sus competencias, 1-2 veces en 3 anios
        for (cidc, cdesc, ctipo) in comps:
            evaluaciones = random.randint(1, 2)
            for ev in range(evaluaciones):
                did_seq += 1
                competente = random.random() > 0.28  # ~72% competentes
                prioridad = random.choices(PRIORIDADES, weights=[0.3, 0.45, 0.25])[0]
                freg = hoy - timedelta(days=random.randint(1, 365 * 3))
                venc = freg + timedelta(days=random.choice([365, 730]))
                ruta = f"/evidencias/{e[0]}_{cidc}.pdf" if competente else None
                diagnosticos.append((did_seq, e[0], idp, cidc, competente,
                                     prioridad, ruta, freg, venc))
    execute_values(cur, "INSERT INTO diagnosticos VALUES %s", diagnosticos, page_size=1000)

    # Plan Maestro (18 deptos x 3 anios fiscales)
    planes = []
    plan_seq = 0
    plan_por_depto_anio = {}
    for did, _ in deptos:
        for anio in [2024, 2025, 2026]:
            plan_seq += 1
            fecha = date(anio, 1, random.randint(5, 28))
            fd = anio < 2026 or random.random() > 0.3
            fe = anio < 2026 or random.random() > 0.4
            fg = anio < 2026 or random.random() > 0.5
            planes.append((plan_seq, did, anio, fecha, random.randint(0, 3), fd, fe, fg))
            plan_por_depto_anio[(did, anio)] = plan_seq
    execute_values(cur, "INSERT INTO plan_maestro VALUES %s", planes)

    # Cursos programados (ligados a plan maestro por depto/anio)
    programados = []
    prog_seq = 0
    desc_depto = {d[0]: d[4] for d in descripciones}
    comp_desc = {c[0]: c[1] for c in competencias}
    for cu in cursos:
        idc, idcomp = cu[0], cu[1]
        iddesc = comp_desc[idcomp]
        did = desc_depto[iddesc]
        anio = random.choice([2024, 2025, 2026])
        plan = plan_por_depto_anio.get((did, anio))
        # varias programaciones
        for _ in range(random.randint(1, 3)):
            prog_seq += 1
            semana = random.randint(1, 52)
            finicio = date(anio, 1, 1) + timedelta(weeks=semana - 1)
            ffin = finicio + timedelta(days=random.randint(1, 5))
            if anio < 2026:
                estatus = random.choices(["Completado", "Programado", "Cancelado"],
                                         weights=[0.86, 0.09, 0.05])[0]
            else:
                estatus = random.choices(["Completado", "En curso", "Programado", "Cancelado"],
                                         weights=[0.4, 0.2, 0.3, 0.1])[0]
            programados.append((prog_seq, idc, plan, anio, semana, finicio, ffin, estatus))
    execute_values(cur, "INSERT INTO cursos_programados VALUES %s", programados)

    # Participantes (empleados no competentes asignados a cursos)
    participantes = []
    no_comp = [d for d in diagnosticos if not d[4]]
    prog_ids = [p[0] for p in programados]
    for d in random.sample(no_comp, min(len(no_comp), 4000)):
        prog = random.choice(prog_ids)
        asistio = random.random() > 0.15
        participantes.append((prog, d[1], asistio))
    execute_values(cur, "INSERT INTO cursos_participantes (id_curso_programado, no_reloj, asistio) VALUES %s",
                   participantes, page_size=1000)

    # Accesos diarios (serie de tiempo, 3 anios)
    accesos = []
    d0 = date(2023, 6, 1)
    for i in range((hoy - d0).days):
        f = d0 + timedelta(days=i)
        base = 120 if f.weekday() < 5 else 25
        usuarios = max(5, int(random.gauss(base, base * 0.25)) + i // 40)
        usuarios = min(usuarios, 580)
        sesiones = int(usuarios * random.uniform(1.2, 2.1))
        accesos.append((f, usuarios, sesiones))
    execute_values(cur, "INSERT INTO accesos_diarios VALUES %s", accesos, page_size=1000)

    # Metricas de productividad (antes vs despues del sistema)
    prod = [
        ("Elaborar Descripcion de Puesto", 240, 45),
        ("Autorizar Descripcion de Puesto", 2880, 180),
        ("Realizar Diagnostico de Necesidades", 180, 30),
        ("Generar Plan Maestro de Entrenamiento", 1440, 120),
        ("Programar Curso", 90, 15),
        ("Consultar evidencia para auditoria", 60, 3),
        ("Firmar documentos (flujo completo)", 4320, 240),
    ]
    execute_values(cur, "INSERT INTO metricas_productividad VALUES %s", prod)

    conn.commit()

    # Resumen
    for t in ["plantas", "departamentos", "areas", "puestos", "empleados",
              "descripciones_puesto", "competencias_puesto", "cursos",
              "diagnosticos", "plan_maestro", "cursos_programados",
              "cursos_participantes", "accesos_diarios"]:
        cur.execute(f"SELECT count(*) FROM {t}")
        print(f"  {t}: {cur.fetchone()[0]}")
    cur.close()
    conn.close()
    print("Datos generados correctamente.")

if __name__ == "__main__":
    main()
