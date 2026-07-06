--
-- PostgreSQL database dump
--

\restrict x6dvnTSBu5ansMvB7pbrRZ0cGSe9U3bH6cPXk2oLnIrQe4NZ9x39fB7F5WfobYn

-- Dumped from database version 15.18 (Debian 15.18-0+deb12u1)
-- Dumped by pg_dump version 15.18 (Debian 15.18-0+deb12u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.puestos DROP CONSTRAINT IF EXISTS puestos_id_departamento_fkey;
ALTER TABLE IF EXISTS ONLY public.plan_maestro DROP CONSTRAINT IF EXISTS plan_maestro_id_departamento_fkey;
ALTER TABLE IF EXISTS ONLY public.empleados DROP CONSTRAINT IF EXISTS empleados_id_departamento_fkey;
ALTER TABLE IF EXISTS ONLY public.empleados DROP CONSTRAINT IF EXISTS empleados_clave_puesto_fkey;
ALTER TABLE IF EXISTS ONLY public.empleados DROP CONSTRAINT IF EXISTS empleados_clave_planta_fkey;
ALTER TABLE IF EXISTS ONLY public.empleados DROP CONSTRAINT IF EXISTS empleados_clave_area_fkey;
ALTER TABLE IF EXISTS ONLY public.diagnosticos DROP CONSTRAINT IF EXISTS diagnosticos_no_reloj_fkey;
ALTER TABLE IF EXISTS ONLY public.diagnosticos DROP CONSTRAINT IF EXISTS diagnosticos_id_descripcion_puesto_fkey;
ALTER TABLE IF EXISTS ONLY public.diagnosticos DROP CONSTRAINT IF EXISTS diagnosticos_id_competencia_fkey;
ALTER TABLE IF EXISTS ONLY public.descripciones_puesto DROP CONSTRAINT IF EXISTS descripciones_puesto_id_departamento_fkey;
ALTER TABLE IF EXISTS ONLY public.descripciones_puesto DROP CONSTRAINT IF EXISTS descripciones_puesto_clave_puesto_fkey;
ALTER TABLE IF EXISTS ONLY public.descripciones_puesto DROP CONSTRAINT IF EXISTS descripciones_puesto_clave_planta_fkey;
ALTER TABLE IF EXISTS ONLY public.descripciones_puesto DROP CONSTRAINT IF EXISTS descripciones_puesto_clave_area_fkey;
ALTER TABLE IF EXISTS ONLY public.cursos_programados DROP CONSTRAINT IF EXISTS cursos_programados_id_plan_maestro_fkey;
ALTER TABLE IF EXISTS ONLY public.cursos_programados DROP CONSTRAINT IF EXISTS cursos_programados_id_curso_fkey;
ALTER TABLE IF EXISTS ONLY public.cursos_participantes DROP CONSTRAINT IF EXISTS cursos_participantes_no_reloj_fkey;
ALTER TABLE IF EXISTS ONLY public.cursos_participantes DROP CONSTRAINT IF EXISTS cursos_participantes_id_curso_programado_fkey;
ALTER TABLE IF EXISTS ONLY public.cursos DROP CONSTRAINT IF EXISTS cursos_id_competencia_fkey;
ALTER TABLE IF EXISTS ONLY public.competencias_puesto DROP CONSTRAINT IF EXISTS competencias_puesto_id_descripcion_puesto_fkey;
ALTER TABLE IF EXISTS ONLY public.areas DROP CONSTRAINT IF EXISTS areas_id_departamento_fkey;
ALTER TABLE IF EXISTS ONLY public.puestos DROP CONSTRAINT IF EXISTS puestos_pkey;
ALTER TABLE IF EXISTS ONLY public.plantas DROP CONSTRAINT IF EXISTS plantas_pkey;
ALTER TABLE IF EXISTS ONLY public.plan_maestro DROP CONSTRAINT IF EXISTS plan_maestro_pkey;
ALTER TABLE IF EXISTS ONLY public.metricas_productividad DROP CONSTRAINT IF EXISTS metricas_productividad_pkey;
ALTER TABLE IF EXISTS ONLY public.empleados DROP CONSTRAINT IF EXISTS empleados_pkey;
ALTER TABLE IF EXISTS ONLY public.diagnosticos DROP CONSTRAINT IF EXISTS diagnosticos_pkey;
ALTER TABLE IF EXISTS ONLY public.descripciones_puesto DROP CONSTRAINT IF EXISTS descripciones_puesto_pkey;
ALTER TABLE IF EXISTS ONLY public.departamentos DROP CONSTRAINT IF EXISTS departamentos_pkey;
ALTER TABLE IF EXISTS ONLY public.cursos_programados DROP CONSTRAINT IF EXISTS cursos_programados_pkey;
ALTER TABLE IF EXISTS ONLY public.cursos DROP CONSTRAINT IF EXISTS cursos_pkey;
ALTER TABLE IF EXISTS ONLY public.cursos_participantes DROP CONSTRAINT IF EXISTS cursos_participantes_pkey;
ALTER TABLE IF EXISTS ONLY public.competencias_puesto DROP CONSTRAINT IF EXISTS competencias_puesto_pkey;
ALTER TABLE IF EXISTS ONLY public.areas DROP CONSTRAINT IF EXISTS areas_pkey;
ALTER TABLE IF EXISTS ONLY public.accesos_diarios DROP CONSTRAINT IF EXISTS accesos_diarios_pkey;
ALTER TABLE IF EXISTS public.cursos_participantes ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.puestos;
DROP TABLE IF EXISTS public.plantas;
DROP TABLE IF EXISTS public.plan_maestro;
DROP TABLE IF EXISTS public.metricas_productividad;
DROP TABLE IF EXISTS public.empleados;
DROP TABLE IF EXISTS public.diagnosticos;
DROP TABLE IF EXISTS public.descripciones_puesto;
DROP TABLE IF EXISTS public.departamentos;
DROP TABLE IF EXISTS public.cursos_programados;
DROP SEQUENCE IF EXISTS public.cursos_participantes_id_seq;
DROP TABLE IF EXISTS public.cursos_participantes;
DROP TABLE IF EXISTS public.cursos;
DROP TABLE IF EXISTS public.competencias_puesto;
DROP TABLE IF EXISTS public.areas;
DROP TABLE IF EXISTS public.accesos_diarios;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accesos_diarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accesos_diarios (
    fecha date NOT NULL,
    usuarios_activos integer,
    sesiones integer
);


--
-- Name: areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.areas (
    clave_area integer NOT NULL,
    id_departamento integer,
    area text NOT NULL
);


--
-- Name: competencias_puesto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.competencias_puesto (
    id_competencia integer NOT NULL,
    id_descripcion_puesto integer,
    descripcion_competencia text NOT NULL,
    tipo text
);


--
-- Name: cursos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cursos (
    id_curso integer NOT NULL,
    id_competencia integer,
    nombre_curso text NOT NULL,
    horas integer
);


--
-- Name: cursos_participantes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cursos_participantes (
    id integer NOT NULL,
    id_curso_programado integer,
    no_reloj integer,
    asistio boolean
);


--
-- Name: cursos_participantes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cursos_participantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cursos_participantes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cursos_participantes_id_seq OWNED BY public.cursos_participantes.id;


--
-- Name: cursos_programados; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cursos_programados (
    id_curso_programado integer NOT NULL,
    id_curso integer,
    id_plan_maestro integer,
    anio_fiscal integer,
    semana integer,
    fecha_inicio date,
    fecha_fin date,
    estatus text
);


--
-- Name: departamentos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.departamentos (
    id_departamento integer NOT NULL,
    departamento text NOT NULL
);


--
-- Name: descripciones_puesto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.descripciones_puesto (
    id_descripcion_puesto integer NOT NULL,
    clave_planta integer,
    clave_puesto integer,
    clave_area integer,
    id_departamento integer,
    revision integer,
    elaborado_por text,
    objetivo text,
    fecha_creacion date,
    fecha_envio date,
    fecha_aprobacion date,
    autorizada boolean
);


--
-- Name: diagnosticos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diagnosticos (
    id_diagnostico integer NOT NULL,
    no_reloj integer,
    id_descripcion_puesto integer,
    id_competencia integer,
    competente boolean,
    prioridad text,
    ruta_evidencia text,
    fecha_registro date,
    fecha_vencimiento date
);


--
-- Name: empleados; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empleados (
    no_reloj integer NOT NULL,
    nombre text NOT NULL,
    email text,
    clave_planta integer,
    id_departamento integer,
    clave_area integer,
    clave_puesto integer,
    fecha_ingreso date,
    activo boolean,
    es_mnj boolean
);


--
-- Name: metricas_productividad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metricas_productividad (
    proceso text NOT NULL,
    tiempo_antes_min integer,
    tiempo_despues_min integer
);


--
-- Name: plan_maestro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plan_maestro (
    id_plan_maestro integer NOT NULL,
    id_departamento integer,
    anio_fiscal integer,
    fecha date,
    revision integer,
    firma_mnj_depto boolean,
    firma_mnj_entto boolean,
    firma_gerente boolean
);


--
-- Name: plantas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plantas (
    clave_planta integer NOT NULL,
    planta text NOT NULL,
    ubicacion text
);


--
-- Name: puestos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.puestos (
    clave_puesto integer NOT NULL,
    puesto text NOT NULL,
    clasificacion text NOT NULL,
    id_departamento integer
);


--
-- Name: cursos_participantes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos_participantes ALTER COLUMN id SET DEFAULT nextval('public.cursos_participantes_id_seq'::regclass);


--
-- Data for Name: accesos_diarios; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accesos_diarios (fecha, usuarios_activos, sesiones) FROM stdin;
2023-06-01	117	238
2023-06-02	129	256
2023-06-03	17	31
2023-06-04	14	22
2023-06-05	113	224
2023-06-06	114	238
2023-06-07	128	172
2023-06-08	108	179
2023-06-09	102	196
2023-06-10	29	45
2023-06-11	28	37
2023-06-12	156	300
2023-06-13	149	304
2023-06-14	126	221
2023-06-15	161	304
2023-06-16	151	264
2023-06-17	28	41
2023-06-18	29	41
2023-06-19	143	287
2023-06-20	155	279
2023-06-21	116	211
2023-06-22	112	174
2023-06-23	164	267
2023-06-24	39	72
2023-06-25	27	43
2023-06-26	75	142
2023-06-27	117	224
2023-06-28	154	269
2023-06-29	93	155
2023-06-30	141	234
2023-07-01	26	51
2023-07-02	28	54
2023-07-03	105	215
2023-07-04	92	158
2023-07-05	106	156
2023-07-06	87	139
2023-07-07	160	218
2023-07-08	37	48
2023-07-09	21	31
2023-07-10	65	94
2023-07-11	127	261
2023-07-12	56	108
2023-07-13	90	123
2023-07-14	142	237
2023-07-15	29	54
2023-07-16	17	20
2023-07-17	152	229
2023-07-18	88	115
2023-07-19	85	117
2023-07-20	136	255
2023-07-21	104	205
2023-07-22	37	62
2023-07-23	24	44
2023-07-24	143	249
2023-07-25	151	213
2023-07-26	149	235
2023-07-27	128	233
2023-07-28	99	141
2023-07-29	28	44
2023-07-30	26	53
2023-07-31	130	174
2023-08-01	181	379
2023-08-02	158	277
2023-08-03	136	233
2023-08-04	163	271
2023-08-05	24	41
2023-08-06	23	37
2023-08-07	137	248
2023-08-08	110	158
2023-08-09	128	207
2023-08-10	166	270
2023-08-11	123	163
2023-08-12	25	37
2023-08-13	25	32
2023-08-14	102	177
2023-08-15	91	171
2023-08-16	97	164
2023-08-17	80	143
2023-08-18	183	279
2023-08-19	31	37
2023-08-20	32	64
2023-08-21	81	161
2023-08-22	154	283
2023-08-23	104	194
2023-08-24	122	185
2023-08-25	157	245
2023-08-26	16	21
2023-08-27	29	38
2023-08-28	152	318
2023-08-29	143	288
2023-08-30	96	119
2023-08-31	125	164
2023-09-01	82	120
2023-09-02	32	59
2023-09-03	23	29
2023-09-04	153	265
2023-09-05	136	181
2023-09-06	96	134
2023-09-07	69	99
2023-09-08	131	205
2023-09-09	25	50
2023-09-10	28	54
2023-09-11	112	183
2023-09-12	132	204
2023-09-13	109	148
2023-09-14	95	158
2023-09-15	131	256
2023-09-16	30	60
2023-09-17	32	60
2023-09-18	101	203
2023-09-19	113	176
2023-09-20	153	195
2023-09-21	125	191
2023-09-22	150	210
2023-09-23	24	39
2023-09-24	22	38
2023-09-25	90	148
2023-09-26	112	184
2023-09-27	114	234
2023-09-28	136	164
2023-09-29	123	196
2023-09-30	32	57
2023-10-01	44	92
2023-10-02	148	205
2023-10-03	99	151
2023-10-04	102	198
2023-10-05	164	234
2023-10-06	124	173
2023-10-07	20	39
2023-10-08	24	46
2023-10-09	148	182
2023-10-10	98	138
2023-10-11	62	77
2023-10-12	104	136
2023-10-13	181	280
2023-10-14	18	35
2023-10-15	24	37
2023-10-16	130	236
2023-10-17	99	128
2023-10-18	95	175
2023-10-19	130	156
2023-10-20	161	221
2023-10-21	29	46
2023-10-22	28	35
2023-10-23	51	96
2023-10-24	124	223
2023-10-25	180	258
2023-10-26	178	261
2023-10-27	115	210
2023-10-28	37	62
2023-10-29	26	34
2023-10-30	120	221
2023-10-31	126	203
2023-11-01	159	219
2023-11-02	118	166
2023-11-03	126	232
2023-11-04	22	43
2023-11-05	23	33
2023-11-06	125	233
2023-11-07	68	99
2023-11-08	144	280
2023-11-09	92	123
2023-11-10	131	231
2023-11-11	41	72
2023-11-12	29	58
2023-11-13	109	174
2023-11-14	144	242
2023-11-15	114	183
2023-11-16	124	253
2023-11-17	128	259
2023-11-18	30	61
2023-11-19	32	42
2023-11-20	48	100
2023-11-21	90	126
2023-11-22	141	249
2023-11-23	87	163
2023-11-24	120	207
2023-11-25	20	34
2023-11-26	32	44
2023-11-27	101	157
2023-11-28	115	219
2023-11-29	133	258
2023-11-30	131	263
2023-12-01	119	174
2023-12-02	31	43
2023-12-03	42	77
2023-12-04	113	186
2023-12-05	150	278
2023-12-06	108	153
2023-12-07	50	76
2023-12-08	155	223
2023-12-09	26	41
2023-12-10	29	59
2023-12-11	121	153
2023-12-12	178	242
2023-12-13	144	299
2023-12-14	98	124
2023-12-15	62	85
2023-12-16	29	37
2023-12-17	35	67
2023-12-18	121	186
2023-12-19	150	202
2023-12-20	95	196
2023-12-21	128	245
2023-12-22	63	116
2023-12-23	28	56
2023-12-24	33	62
2023-12-25	137	278
2023-12-26	92	123
2023-12-27	123	247
2023-12-28	115	161
2023-12-29	109	169
2023-12-30	39	55
2023-12-31	38	65
2024-01-01	144	269
2024-01-02	102	160
2024-01-03	94	115
2024-01-04	107	133
2024-01-05	108	172
2024-01-06	19	39
2024-01-07	33	42
2024-01-08	118	179
2024-01-09	100	197
2024-01-10	70	138
2024-01-11	129	221
2024-01-12	119	231
2024-01-13	31	43
2024-01-14	31	43
2024-01-15	110	178
2024-01-16	84	150
2024-01-17	55	114
2024-01-18	160	263
2024-01-19	87	134
2024-01-20	22	38
2024-01-21	38	64
2024-01-22	124	200
2024-01-23	135	270
2024-01-24	54	87
2024-01-25	112	200
2024-01-26	133	230
2024-01-27	27	44
2024-01-28	35	63
2024-01-29	108	157
2024-01-30	128	212
2024-01-31	172	243
2024-02-01	169	266
2024-02-02	184	232
2024-02-03	33	52
2024-02-04	34	43
2024-02-05	174	230
2024-02-06	149	285
2024-02-07	172	291
2024-02-08	137	274
2024-02-09	118	189
2024-02-10	27	47
2024-02-11	26	41
2024-02-12	130	265
2024-02-13	115	210
2024-02-14	126	157
2024-02-15	82	105
2024-02-16	150	286
2024-02-17	35	66
2024-02-18	24	30
2024-02-19	151	211
2024-02-20	130	270
2024-02-21	118	162
2024-02-22	108	220
2024-02-23	151	272
2024-02-24	35	53
2024-02-25	24	42
2024-02-26	163	314
2024-02-27	152	283
2024-02-28	79	113
2024-02-29	150	292
2024-03-01	183	244
2024-03-02	45	78
2024-03-03	23	35
2024-03-04	161	256
2024-03-05	153	187
2024-03-06	71	96
2024-03-07	111	143
2024-03-08	138	174
2024-03-09	31	49
2024-03-10	29	37
2024-03-11	180	236
2024-03-12	127	232
2024-03-13	117	238
2024-03-14	121	159
2024-03-15	159	281
2024-03-16	27	41
2024-03-17	36	51
2024-03-18	112	205
2024-03-19	90	188
2024-03-20	185	225
2024-03-21	122	185
2024-03-22	170	264
2024-03-23	35	73
2024-03-24	25	41
2024-03-25	108	186
2024-03-26	130	216
2024-03-27	87	147
2024-03-28	98	139
2024-03-29	159	200
2024-03-30	32	40
2024-03-31	32	58
2024-04-01	89	158
2024-04-02	132	253
2024-04-03	137	242
2024-04-04	113	177
2024-04-05	159	291
2024-04-06	32	41
2024-04-07	37	67
2024-04-08	73	119
2024-04-09	118	238
2024-04-10	85	161
2024-04-11	130	249
2024-04-12	104	210
2024-04-13	37	59
2024-04-14	42	69
2024-04-15	132	265
2024-04-16	203	344
2024-04-17	159	307
2024-04-18	124	208
2024-04-19	130	195
2024-04-20	39	59
2024-04-21	19	37
2024-04-22	187	255
2024-04-23	123	170
2024-04-24	92	136
2024-04-25	135	254
2024-04-26	122	172
2024-04-27	46	57
2024-04-28	34	46
2024-04-29	163	275
2024-04-30	183	368
2024-05-01	132	189
2024-05-02	120	149
2024-05-03	148	249
2024-05-04	40	61
2024-05-05	35	42
2024-05-06	157	316
2024-05-07	152	306
2024-05-08	119	171
2024-05-09	133	261
2024-05-10	142	284
2024-05-11	37	58
2024-05-12	20	29
2024-05-13	191	307
2024-05-14	130	268
2024-05-15	122	218
2024-05-16	145	224
2024-05-17	194	320
2024-05-18	31	50
2024-05-19	38	50
2024-05-20	163	336
2024-05-21	88	146
2024-05-22	157	189
2024-05-23	121	209
2024-05-24	105	147
2024-05-25	32	56
2024-05-26	32	38
2024-05-27	186	263
2024-05-28	145	286
2024-05-29	129	170
2024-05-30	157	261
2024-05-31	62	101
2024-06-01	21	36
2024-06-02	33	39
2024-06-03	164	317
2024-06-04	133	262
2024-06-05	155	274
2024-06-06	74	90
2024-06-07	169	246
2024-06-08	31	59
2024-06-09	28	43
2024-06-10	96	143
2024-06-11	158	296
2024-06-12	21	26
2024-06-13	126	207
2024-06-14	132	219
2024-06-15	35	50
2024-06-16	33	56
2024-06-17	150	268
2024-06-18	173	331
2024-06-19	105	136
2024-06-20	150	202
2024-06-21	135	271
2024-06-22	40	71
2024-06-23	33	54
2024-06-24	164	342
2024-06-25	124	194
2024-06-26	187	320
2024-06-27	136	218
2024-06-28	143	295
2024-06-29	30	50
2024-06-30	38	67
2024-07-01	100	148
2024-07-02	115	209
2024-07-03	110	202
2024-07-04	133	254
2024-07-05	85	135
2024-07-06	44	59
2024-07-07	39	50
2024-07-08	106	197
2024-07-09	175	357
2024-07-10	147	252
2024-07-11	124	256
2024-07-12	122	198
2024-07-13	40	74
2024-07-14	34	51
2024-07-15	84	146
2024-07-16	128	203
2024-07-17	130	250
2024-07-18	116	177
2024-07-19	108	176
2024-07-20	41	50
2024-07-21	41	62
2024-07-22	162	313
2024-07-23	129	235
2024-07-24	113	160
2024-07-25	114	171
2024-07-26	205	428
2024-07-27	28	43
2024-07-28	32	64
2024-07-29	114	153
2024-07-30	155	250
2024-07-31	135	279
2024-08-01	136	210
2024-08-02	121	237
2024-08-03	38	70
2024-08-04	37	57
2024-08-05	118	182
2024-08-06	74	128
2024-08-07	160	222
2024-08-08	128	175
2024-08-09	214	325
2024-08-10	29	49
2024-08-11	33	42
2024-08-12	139	231
2024-08-13	144	276
2024-08-14	125	170
2024-08-15	101	126
2024-08-16	129	163
2024-08-17	42	55
2024-08-18	42	87
2024-08-19	87	173
2024-08-20	117	174
2024-08-21	158	304
2024-08-22	123	160
2024-08-23	75	114
2024-08-24	41	80
2024-08-25	31	46
2024-08-26	121	184
2024-08-27	165	222
2024-08-28	129	215
2024-08-29	131	178
2024-08-30	138	170
2024-08-31	37	54
2024-09-01	38	77
2024-09-02	150	284
2024-09-03	119	157
2024-09-04	176	229
2024-09-05	92	191
2024-09-06	179	333
2024-09-07	44	74
2024-09-08	40	58
2024-09-09	101	126
2024-09-10	112	204
2024-09-11	147	215
2024-09-12	131	203
2024-09-13	160	331
2024-09-14	38	79
2024-09-15	33	64
2024-09-16	169	214
2024-09-17	156	220
2024-09-18	196	302
2024-09-19	145	280
2024-09-20	82	167
2024-09-21	42	55
2024-09-22	39	58
2024-09-23	104	214
2024-09-24	112	141
2024-09-25	104	128
2024-09-26	168	310
2024-09-27	111	144
2024-09-28	32	48
2024-09-29	46	82
2024-09-30	135	224
2024-10-01	142	221
2024-10-02	100	125
2024-10-03	98	205
2024-10-04	117	190
2024-10-05	31	55
2024-10-06	33	54
2024-10-07	119	174
2024-10-08	140	210
2024-10-09	127	259
2024-10-10	154	230
2024-10-11	166	330
2024-10-12	40	69
2024-10-13	35	55
2024-10-14	167	235
2024-10-15	194	251
2024-10-16	151	304
2024-10-17	170	340
2024-10-18	97	179
2024-10-19	34	67
2024-10-20	34	50
2024-10-21	118	159
2024-10-22	125	242
2024-10-23	167	264
2024-10-24	111	136
2024-10-25	85	131
2024-10-26	33	62
2024-10-27	43	76
2024-10-28	93	175
2024-10-29	141	288
2024-10-30	111	147
2024-10-31	144	288
2024-11-01	134	210
2024-11-02	35	60
2024-11-03	40	61
2024-11-04	117	218
2024-11-05	145	207
2024-11-06	201	384
2024-11-07	144	252
2024-11-08	184	249
2024-11-09	38	50
2024-11-10	34	41
2024-11-11	84	154
2024-11-12	146	204
2024-11-13	133	256
2024-11-14	142	212
2024-11-15	108	201
2024-11-16	38	53
2024-11-17	42	51
2024-11-18	130	195
2024-11-19	100	196
2024-11-20	154	220
2024-11-21	89	165
2024-11-22	135	177
2024-11-23	39	70
2024-11-24	44	61
2024-11-25	142	234
2024-11-26	152	253
2024-11-27	140	283
2024-11-28	150	271
2024-11-29	137	242
2024-11-30	36	56
2024-12-01	42	84
2024-12-02	88	129
2024-12-03	136	269
2024-12-04	141	198
2024-12-05	150	283
2024-12-06	112	152
2024-12-07	36	62
2024-12-08	31	44
2024-12-09	150	297
2024-12-10	95	186
2024-12-11	99	166
2024-12-12	145	227
2024-12-13	104	142
2024-12-14	33	49
2024-12-15	29	48
2024-12-16	117	174
2024-12-17	114	211
2024-12-18	151	309
2024-12-19	125	160
2024-12-20	164	319
2024-12-21	30	47
2024-12-22	38	55
2024-12-23	186	242
2024-12-24	111	165
2024-12-25	169	227
2024-12-26	107	223
2024-12-27	112	160
2024-12-28	39	76
2024-12-29	38	71
2024-12-30	122	229
2024-12-31	145	294
2025-01-01	100	152
2025-01-02	99	177
2025-01-03	141	268
2025-01-04	46	83
2025-01-05	32	55
2025-01-06	129	241
2025-01-07	189	327
2025-01-08	109	212
2025-01-09	158	257
2025-01-10	107	133
2025-01-11	47	62
2025-01-12	39	68
2025-01-13	121	202
2025-01-14	125	185
2025-01-15	128	168
2025-01-16	90	164
2025-01-17	150	280
2025-01-18	35	47
2025-01-19	39	69
2025-01-20	115	169
2025-01-21	113	198
2025-01-22	114	206
2025-01-23	140	258
2025-01-24	175	248
2025-01-25	40	80
2025-01-26	36	44
2025-01-27	131	211
2025-01-28	155	318
2025-01-29	148	252
2025-01-30	189	260
2025-01-31	178	249
2025-02-01	39	72
2025-02-02	33	49
2025-02-03	145	255
2025-02-04	77	109
2025-02-05	122	149
2025-02-06	114	193
2025-02-07	125	249
2025-02-08	45	66
2025-02-09	49	97
2025-02-10	129	249
2025-02-11	150	185
2025-02-12	133	188
2025-02-13	128	257
2025-02-14	34	67
2025-02-15	34	65
2025-02-16	37	54
2025-02-17	205	295
2025-02-18	129	213
2025-02-19	168	267
2025-02-20	146	285
2025-02-21	121	154
2025-02-22	33	40
2025-02-23	28	39
2025-02-24	138	168
2025-02-25	141	276
2025-02-26	145	255
2025-02-27	139	199
2025-02-28	142	235
2025-03-01	38	45
2025-03-02	34	69
2025-03-03	113	199
2025-03-04	125	205
2025-03-05	142	258
2025-03-06	164	202
2025-03-07	144	262
2025-03-08	42	87
2025-03-09	42	54
2025-03-10	116	152
2025-03-11	84	132
2025-03-12	115	225
2025-03-13	99	127
2025-03-14	146	175
2025-03-15	44	77
2025-03-16	39	58
2025-03-17	132	253
2025-03-18	148	231
2025-03-19	169	238
2025-03-20	88	133
2025-03-21	131	211
2025-03-22	42	65
2025-03-23	40	63
2025-03-24	94	192
2025-03-25	215	442
2025-03-26	115	202
2025-03-27	130	158
2025-03-28	95	162
2025-03-29	42	84
2025-03-30	31	56
2025-03-31	148	209
2025-04-01	120	150
2025-04-02	125	243
2025-04-03	85	155
2025-04-04	111	139
2025-04-05	44	56
2025-04-06	30	56
2025-04-07	151	224
2025-04-08	120	171
2025-04-09	107	139
2025-04-10	129	250
2025-04-11	58	85
2025-04-12	50	72
2025-04-13	44	91
2025-04-14	148	213
2025-04-15	124	154
2025-04-16	164	319
2025-04-17	106	164
2025-04-18	180	318
2025-04-19	48	86
2025-04-20	41	59
2025-04-21	215	335
2025-04-22	123	232
2025-04-23	103	209
2025-04-24	172	285
2025-04-25	192	381
2025-04-26	38	65
2025-04-27	30	56
2025-04-28	166	283
2025-04-29	174	332
2025-04-30	114	194
2025-05-01	101	196
2025-05-02	130	267
2025-05-03	31	46
2025-05-04	27	48
2025-05-05	140	220
2025-05-06	161	204
2025-05-07	162	252
2025-05-08	147	263
2025-05-09	137	174
2025-05-10	42	78
2025-05-11	37	63
2025-05-12	157	244
2025-05-13	158	222
2025-05-14	109	134
2025-05-15	124	230
2025-05-16	144	268
2025-05-17	43	67
2025-05-18	33	55
2025-05-19	168	336
2025-05-20	183	238
2025-05-21	147	213
2025-05-22	77	144
2025-05-23	179	303
2025-05-24	43	70
2025-05-25	49	83
2025-05-26	129	211
2025-05-27	123	191
2025-05-28	196	272
2025-05-29	154	263
2025-05-30	165	336
2025-05-31	49	76
2025-06-01	42	62
2025-06-02	108	166
2025-06-03	110	174
2025-06-04	128	178
2025-06-05	105	212
2025-06-06	179	224
2025-06-07	46	59
2025-06-08	59	72
2025-06-09	146	182
2025-06-10	178	233
2025-06-11	160	321
2025-06-12	150	225
2025-06-13	134	192
2025-06-14	32	41
2025-06-15	39	68
2025-06-16	165	266
2025-06-17	90	139
2025-06-18	146	233
2025-06-19	145	289
2025-06-20	143	239
2025-06-21	47	90
2025-06-22	42	85
2025-06-23	115	234
2025-06-24	114	170
2025-06-25	156	223
2025-06-26	128	171
2025-06-27	172	273
2025-06-28	42	63
2025-06-29	38	46
2025-06-30	142	244
2025-07-01	86	175
2025-07-02	125	227
2025-07-03	136	197
2025-07-04	148	295
2025-07-05	41	86
2025-07-06	45	73
2025-07-07	151	187
2025-07-08	130	168
2025-07-09	132	233
2025-07-10	123	215
2025-07-11	151	247
2025-07-12	44	63
2025-07-13	43	74
2025-07-14	172	281
2025-07-15	161	317
2025-07-16	118	179
2025-07-17	131	252
2025-07-18	184	287
2025-07-19	32	43
2025-07-20	48	58
2025-07-21	174	278
2025-07-22	178	339
2025-07-23	137	165
2025-07-24	123	181
2025-07-25	146	225
2025-07-26	45	82
2025-07-27	38	56
2025-07-28	97	123
2025-07-29	109	166
2025-07-30	162	208
2025-07-31	149	303
2025-08-01	150	186
2025-08-02	27	52
2025-08-03	45	73
2025-08-04	121	209
2025-08-05	110	157
2025-08-06	177	291
2025-08-07	116	228
2025-08-08	172	286
2025-08-09	41	73
2025-08-10	55	95
2025-08-11	155	308
2025-08-12	150	301
2025-08-13	126	175
2025-08-14	167	339
2025-08-15	154	295
2025-08-16	55	88
2025-08-17	38	67
2025-08-18	95	193
2025-08-19	139	227
2025-08-20	126	204
2025-08-21	140	256
2025-08-22	152	245
2025-08-23	37	46
2025-08-24	41	68
2025-08-25	130	268
2025-08-26	136	268
2025-08-27	139	218
2025-08-28	165	225
2025-08-29	122	180
2025-08-30	38	58
2025-08-31	41	61
2025-09-01	180	324
2025-09-02	158	247
2025-09-03	184	316
2025-09-04	151	304
2025-09-05	89	177
2025-09-06	43	59
2025-09-07	50	79
2025-09-08	148	207
2025-09-09	195	338
2025-09-10	102	159
2025-09-11	114	163
2025-09-12	152	275
2025-09-13	33	39
2025-09-14	50	81
2025-09-15	160	243
2025-09-16	178	298
2025-09-17	154	191
2025-09-18	181	336
2025-09-19	191	248
2025-09-20	43	69
2025-09-21	48	60
2025-09-22	166	222
2025-09-23	139	250
2025-09-24	128	252
2025-09-25	137	236
2025-09-26	103	156
2025-09-27	45	73
2025-09-28	49	100
2025-09-29	161	236
2025-09-30	214	388
2025-10-01	116	184
2025-10-02	114	147
2025-10-03	120	240
2025-10-04	53	79
2025-10-05	45	93
2025-10-06	135	270
2025-10-07	184	377
2025-10-08	191	282
2025-10-09	146	229
2025-10-10	132	276
2025-10-11	44	75
2025-10-12	32	47
2025-10-13	107	215
2025-10-14	192	303
2025-10-15	103	183
2025-10-16	130	158
2025-10-17	119	227
2025-10-18	47	98
2025-10-19	54	77
2025-10-20	144	186
2025-10-21	145	189
2025-10-22	122	215
2025-10-23	133	243
2025-10-24	104	172
2025-10-25	45	70
2025-10-26	44	72
2025-10-27	113	229
2025-10-28	127	187
2025-10-29	168	269
2025-10-30	145	178
2025-10-31	94	182
2025-11-01	35	49
2025-11-02	50	62
2025-11-03	123	255
2025-11-04	155	305
2025-11-05	150	191
2025-11-06	145	244
2025-11-07	115	208
2025-11-08	56	96
2025-11-09	40	49
2025-11-10	143	293
2025-11-11	113	211
2025-11-12	132	216
2025-11-13	154	220
2025-11-14	179	252
2025-11-15	36	45
2025-11-16	49	99
2025-11-17	177	369
2025-11-18	111	174
2025-11-19	178	306
2025-11-20	100	208
2025-11-21	121	231
2025-11-22	49	98
2025-11-23	53	73
2025-11-24	119	244
2025-11-25	219	418
2025-11-26	206	417
2025-11-27	157	226
2025-11-28	85	176
2025-11-29	32	57
2025-11-30	48	89
2025-12-01	102	139
2025-12-02	130	181
2025-12-03	160	224
2025-12-04	113	186
2025-12-05	134	269
2025-12-06	44	91
2025-12-07	43	75
2025-12-08	122	155
2025-12-09	151	296
2025-12-10	135	282
2025-12-11	127	219
2025-12-12	165	340
2025-12-13	50	101
2025-12-14	40	51
2025-12-15	172	274
2025-12-16	150	221
2025-12-17	105	143
2025-12-18	145	214
2025-12-19	135	270
2025-12-20	54	106
2025-12-21	44	65
2025-12-22	154	185
2025-12-23	136	255
2025-12-24	153	266
2025-12-25	128	161
2025-12-26	145	280
2025-12-27	50	91
2025-12-28	51	104
2025-12-29	173	244
2025-12-30	110	218
2025-12-31	185	375
2026-01-01	171	222
2026-01-02	128	227
2026-01-03	47	57
2026-01-04	48	82
2026-01-05	177	290
2026-01-06	94	188
2026-01-07	112	162
2026-01-08	137	171
2026-01-09	120	202
2026-01-10	46	82
2026-01-11	41	60
2026-01-12	162	253
2026-01-13	121	153
2026-01-14	125	179
2026-01-15	121	199
2026-01-16	95	195
2026-01-17	39	81
2026-01-18	56	78
2026-01-19	150	220
2026-01-20	170	279
2026-01-21	176	310
2026-01-22	157	218
2026-01-23	121	169
2026-01-24	57	87
2026-01-25	56	78
2026-01-26	97	156
2026-01-27	149	184
2026-01-28	140	293
2026-01-29	146	211
2026-01-30	125	229
2026-01-31	58	121
2026-02-01	57	103
2026-02-02	140	175
2026-02-03	161	314
2026-02-04	132	227
2026-02-05	174	356
2026-02-06	185	322
2026-02-07	53	80
2026-02-08	40	59
2026-02-09	164	296
2026-02-10	178	346
2026-02-11	120	161
2026-02-12	156	217
2026-02-13	137	191
2026-02-14	31	62
2026-02-15	50	61
2026-02-16	133	164
2026-02-17	110	185
2026-02-18	103	135
2026-02-19	218	397
2026-02-20	120	222
2026-02-21	50	101
2026-02-22	48	84
2026-02-23	116	158
2026-02-24	116	173
2026-02-25	146	191
2026-02-26	105	172
2026-02-27	179	348
2026-02-28	57	92
2026-03-01	50	104
2026-03-02	196	275
2026-03-03	187	344
2026-03-04	118	183
2026-03-05	164	247
2026-03-06	145	268
2026-03-07	54	108
2026-03-08	54	112
2026-03-09	143	175
2026-03-10	151	185
2026-03-11	98	132
2026-03-12	133	163
2026-03-13	165	255
2026-03-14	43	85
2026-03-15	42	54
2026-03-16	218	289
2026-03-17	179	276
2026-03-18	142	286
2026-03-19	126	216
2026-03-20	113	180
2026-03-21	40	61
2026-03-22	40	72
2026-03-23	189	393
2026-03-24	109	131
2026-03-25	179	256
2026-03-26	178	228
2026-03-27	89	141
2026-03-28	48	84
2026-03-29	51	85
2026-03-30	163	332
2026-03-31	117	170
2026-04-01	100	181
2026-04-02	140	276
2026-04-03	150	221
2026-04-04	49	80
2026-04-05	64	123
2026-04-06	125	166
2026-04-07	179	231
2026-04-08	147	292
2026-04-09	190	308
2026-04-10	150	303
2026-04-11	55	91
2026-04-12	56	91
2026-04-13	86	122
2026-04-14	197	341
2026-04-15	192	308
2026-04-16	122	218
2026-04-17	182	239
2026-04-18	54	65
2026-04-19	53	101
2026-04-20	132	191
2026-04-21	150	275
2026-04-22	130	245
2026-04-23	126	263
2026-04-24	130	201
2026-04-25	37	58
2026-04-26	50	84
2026-04-27	120	233
2026-04-28	106	209
2026-04-29	147	292
2026-04-30	164	270
2026-05-01	169	299
2026-05-02	52	76
2026-05-03	43	88
2026-05-04	92	127
2026-05-05	158	326
2026-05-06	148	221
2026-05-07	128	253
2026-05-08	118	220
2026-05-09	45	64
2026-05-10	43	71
2026-05-11	123	153
2026-05-12	170	222
2026-05-13	161	216
2026-05-14	172	321
2026-05-15	130	157
2026-05-16	47	71
2026-05-17	52	88
2026-05-18	180	354
2026-05-19	108	219
2026-05-20	191	261
2026-05-21	140	215
2026-05-22	100	142
2026-05-23	64	115
2026-05-24	50	88
2026-05-25	122	242
2026-05-26	146	192
2026-05-27	156	200
2026-05-28	182	372
2026-05-29	132	168
2026-05-30	61	103
2026-05-31	52	88
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.areas (clave_area, id_departamento, area) FROM stdin;
1	1	Turno Matutino
2	1	Linea A
3	2	Soporte
4	2	Turno Vespertino
5	3	Soporte
6	3	Turno Vespertino
7	3	Turno Matutino
8	3	Linea B
9	4	Linea A
10	4	Soporte
11	5	Turno Matutino
12	5	Linea A
13	6	Linea A
14	6	Turno Vespertino
15	6	Turno Matutino
16	7	Linea B
17	7	Turno Vespertino
18	7	Soporte
19	8	Turno Matutino
20	8	Turno Vespertino
21	8	Soporte
22	9	Linea A
23	9	Turno Matutino
24	9	Soporte
25	9	Linea B
26	10	Turno Vespertino
27	10	Linea B
28	10	Turno Matutino
29	11	Soporte
30	11	Turno Matutino
31	11	Linea A
32	11	Linea B
33	12	Turno Vespertino
34	12	Soporte
35	12	Linea A
36	13	Soporte
37	13	Turno Vespertino
38	13	Linea A
39	14	Soporte
40	14	Turno Vespertino
41	14	Linea B
42	15	Turno Matutino
43	15	Turno Vespertino
44	15	Soporte
45	15	Linea B
46	16	Soporte
47	16	Linea A
48	16	Turno Matutino
49	16	Turno Vespertino
50	17	Linea A
51	17	Soporte
52	18	Soporte
53	18	Turno Vespertino
54	18	Linea B
55	18	Linea A
\.


--
-- Data for Name: competencias_puesto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.competencias_puesto (id_competencia, id_descripcion_puesto, descripcion_competencia, tipo) FROM stdin;
1	1	Control Estadistico de Proceso (SPC)	Tecnica
2	1	Programacion CNC	Tecnica
3	1	Lectura e interpretacion de planos	Tecnica
4	1	Sistema de gestion ISO 9001	Normativa
5	1	Plan de control	Normativa
6	1	Trabajo en equipo	Blanda
7	1	Mantenimiento productivo total (TPM)	Tecnica
8	2	PPAP y APQP	Normativa
9	2	Seguridad industrial y EPP	Normativa
10	2	Lectura e interpretacion de planos	Tecnica
11	2	Metrologia dimensional	Tecnica
12	2	Manejo de montacargas	Operativa
13	2	Programacion CNC	Tecnica
14	3	Manejo de montacargas	Operativa
15	3	Manufactura esbelta (Lean)	Tecnica
16	3	Core Tools automotrices	Normativa
17	3	Kaizen y mejora continua	Tecnica
18	3	Manejo de materiales peligrosos	Operativa
19	3	Comunicacion efectiva	Blanda
20	3	Auditoria IATF 16949	Normativa
21	3	PPAP y APQP	Normativa
22	4	Metrologia dimensional	Tecnica
23	4	Manejo de PLC	Tecnica
24	4	Sistema de gestion ISO 9001	Normativa
25	4	Soldadura MIG/MAG	Operativa
26	4	Mantenimiento productivo total (TPM)	Tecnica
27	5	Manejo de materiales peligrosos	Operativa
28	5	Manejo de montacargas	Operativa
29	5	Inyeccion de plastico	Operativa
30	5	Mantenimiento productivo total (TPM)	Tecnica
31	5	PPAP y APQP	Normativa
32	5	Soldadura MIG/MAG	Operativa
33	6	Manejo de PLC	Tecnica
34	6	Core Tools automotrices	Normativa
35	6	Control de documentos	Normativa
36	6	Plan de control	Normativa
37	6	Sistema de gestion ISO 9001	Normativa
38	6	Soldadura MIG/MAG	Operativa
39	6	Metrologia dimensional	Tecnica
40	7	Kaizen y mejora continua	Tecnica
41	7	Plan de control	Normativa
42	7	Gestion de proveedores	Administrativa
43	7	AMEF / FMEA	Normativa
44	7	Analisis de causa raiz (8D)	Tecnica
45	7	Inyeccion de plastico	Operativa
46	8	Metrologia dimensional	Tecnica
47	8	AMEF / FMEA	Normativa
48	8	Mantenimiento productivo total (TPM)	Tecnica
49	8	Soldadura MIG/MAG	Operativa
50	8	Control Estadistico de Proceso (SPC)	Tecnica
51	8	Plan de control	Normativa
52	9	Soldadura MIG/MAG	Operativa
53	9	Control de documentos	Normativa
54	9	Calibracion de instrumentos	Tecnica
55	9	Comunicacion efectiva	Blanda
56	9	Mantenimiento productivo total (TPM)	Tecnica
57	9	Control Estadistico de Proceso (SPC)	Tecnica
58	9	Lectura e interpretacion de planos	Tecnica
59	10	AMEF / FMEA	Normativa
60	10	Trabajo en equipo	Blanda
61	10	Calibracion de instrumentos	Tecnica
62	10	PPAP y APQP	Normativa
63	10	Metrologia dimensional	Tecnica
64	10	Manejo de montacargas	Operativa
65	10	Comunicacion efectiva	Blanda
66	10	Kaizen y mejora continua	Tecnica
67	11	Trabajo en equipo	Blanda
68	11	Manejo de PLC	Tecnica
69	11	PPAP y APQP	Normativa
70	11	Gestion de proveedores	Administrativa
71	12	Gestion de proveedores	Administrativa
72	12	Core Tools automotrices	Normativa
73	12	Manufactura esbelta (Lean)	Tecnica
74	12	Control de documentos	Normativa
75	12	Lectura e interpretacion de planos	Tecnica
76	12	Trabajo en equipo	Blanda
77	13	Analisis de causa raiz (8D)	Tecnica
78	13	Sistema de gestion ISO 9001	Normativa
79	13	Kaizen y mejora continua	Tecnica
80	13	AMEF / FMEA	Normativa
81	14	Plan de control	Normativa
82	14	Mantenimiento productivo total (TPM)	Tecnica
83	14	Core Tools automotrices	Normativa
84	14	Kaizen y mejora continua	Tecnica
85	14	Control Estadistico de Proceso (SPC)	Tecnica
86	14	Gestion de proveedores	Administrativa
87	15	Seguridad industrial y EPP	Normativa
88	15	Calibracion de instrumentos	Tecnica
89	15	Auditoria IATF 16949	Normativa
90	15	Core Tools automotrices	Normativa
91	15	Manejo de PLC	Tecnica
92	16	Programacion CNC	Tecnica
93	16	Mantenimiento productivo total (TPM)	Tecnica
94	16	Metrologia dimensional	Tecnica
95	16	Manejo de PLC	Tecnica
96	16	Soldadura MIG/MAG	Operativa
97	17	Plan de control	Normativa
98	17	Manejo de PLC	Tecnica
99	17	Programacion CNC	Tecnica
100	17	Analisis de causa raiz (8D)	Tecnica
101	17	Lectura e interpretacion de planos	Tecnica
102	17	AMEF / FMEA	Normativa
103	17	Trabajo en equipo	Blanda
104	18	Control Estadistico de Proceso (SPC)	Tecnica
105	18	PPAP y APQP	Normativa
106	18	Mantenimiento productivo total (TPM)	Tecnica
107	18	Manejo de PLC	Tecnica
108	19	PPAP y APQP	Normativa
109	19	Seguridad industrial y EPP	Normativa
110	19	Plan de control	Normativa
111	19	AMEF / FMEA	Normativa
112	19	Programacion CNC	Tecnica
113	20	Manejo de materiales peligrosos	Operativa
114	20	Auditoria IATF 16949	Normativa
115	20	Seguridad industrial y EPP	Normativa
116	20	Manejo de montacargas	Operativa
117	20	Core Tools automotrices	Normativa
118	20	Lectura e interpretacion de planos	Tecnica
119	21	PPAP y APQP	Normativa
120	21	Trabajo en equipo	Blanda
121	21	Core Tools automotrices	Normativa
122	21	Kaizen y mejora continua	Tecnica
123	21	Lectura e interpretacion de planos	Tecnica
124	21	Analisis de causa raiz (8D)	Tecnica
125	22	Soldadura MIG/MAG	Operativa
126	22	Plan de control	Normativa
127	22	Trabajo en equipo	Blanda
128	22	Analisis de causa raiz (8D)	Tecnica
129	22	Programacion CNC	Tecnica
130	23	Calibracion de instrumentos	Tecnica
131	23	Plan de control	Normativa
132	23	Manufactura esbelta (Lean)	Tecnica
133	23	Core Tools automotrices	Normativa
134	23	Kaizen y mejora continua	Tecnica
135	24	Sistema de gestion ISO 9001	Normativa
136	24	Comunicacion efectiva	Blanda
137	24	Core Tools automotrices	Normativa
138	24	Calibracion de instrumentos	Tecnica
139	24	Control Estadistico de Proceso (SPC)	Tecnica
140	25	Metrologia dimensional	Tecnica
141	25	Auditoria IATF 16949	Normativa
142	25	Comunicacion efectiva	Blanda
143	25	Analisis de causa raiz (8D)	Tecnica
144	25	Mantenimiento productivo total (TPM)	Tecnica
145	26	Trabajo en equipo	Blanda
146	26	Core Tools automotrices	Normativa
147	26	Inyeccion de plastico	Operativa
148	26	Manufactura esbelta (Lean)	Tecnica
149	27	Mantenimiento productivo total (TPM)	Tecnica
150	27	Gestion de proveedores	Administrativa
151	27	Metrologia dimensional	Tecnica
152	27	Inyeccion de plastico	Operativa
153	27	Analisis de causa raiz (8D)	Tecnica
154	27	Control de documentos	Normativa
155	27	Calibracion de instrumentos	Tecnica
156	28	Control Estadistico de Proceso (SPC)	Tecnica
157	28	AMEF / FMEA	Normativa
158	28	Manufactura esbelta (Lean)	Tecnica
159	28	Programacion CNC	Tecnica
160	28	Metrologia dimensional	Tecnica
161	28	Comunicacion efectiva	Blanda
162	29	PPAP y APQP	Normativa
163	29	Control Estadistico de Proceso (SPC)	Tecnica
164	29	AMEF / FMEA	Normativa
165	29	Control de documentos	Normativa
166	30	Manejo de materiales peligrosos	Operativa
167	30	Programacion CNC	Tecnica
168	30	Gestion de proveedores	Administrativa
169	30	Auditoria IATF 16949	Normativa
170	30	Manejo de montacargas	Operativa
171	30	Kaizen y mejora continua	Tecnica
172	30	Manejo de PLC	Tecnica
173	31	Calibracion de instrumentos	Tecnica
174	31	AMEF / FMEA	Normativa
175	31	Inyeccion de plastico	Operativa
176	31	Metrologia dimensional	Tecnica
177	31	Comunicacion efectiva	Blanda
178	32	Manejo de PLC	Tecnica
179	32	AMEF / FMEA	Normativa
180	32	Gestion de proveedores	Administrativa
181	32	Kaizen y mejora continua	Tecnica
182	32	Seguridad industrial y EPP	Normativa
183	32	Manufactura esbelta (Lean)	Tecnica
184	32	Lectura e interpretacion de planos	Tecnica
185	33	Core Tools automotrices	Normativa
186	33	Seguridad industrial y EPP	Normativa
187	33	Analisis de causa raiz (8D)	Tecnica
188	33	Control Estadistico de Proceso (SPC)	Tecnica
189	33	Programacion CNC	Tecnica
190	33	Kaizen y mejora continua	Tecnica
191	33	Manejo de PLC	Tecnica
192	33	Mantenimiento productivo total (TPM)	Tecnica
193	34	Manejo de montacargas	Operativa
194	34	Sistema de gestion ISO 9001	Normativa
195	34	Analisis de causa raiz (8D)	Tecnica
196	34	Gestion de proveedores	Administrativa
197	34	Manejo de materiales peligrosos	Operativa
198	34	Mantenimiento productivo total (TPM)	Tecnica
199	34	Kaizen y mejora continua	Tecnica
200	34	Control Estadistico de Proceso (SPC)	Tecnica
201	35	Control Estadistico de Proceso (SPC)	Tecnica
202	35	Programacion CNC	Tecnica
203	35	Manufactura esbelta (Lean)	Tecnica
204	35	Control de documentos	Normativa
205	35	Auditoria IATF 16949	Normativa
206	36	Auditoria IATF 16949	Normativa
207	36	Inyeccion de plastico	Operativa
208	36	Sistema de gestion ISO 9001	Normativa
209	36	Core Tools automotrices	Normativa
210	37	Core Tools automotrices	Normativa
211	37	Analisis de causa raiz (8D)	Tecnica
212	37	Auditoria IATF 16949	Normativa
213	37	Control de documentos	Normativa
214	37	PPAP y APQP	Normativa
215	38	Lectura e interpretacion de planos	Tecnica
216	38	Programacion CNC	Tecnica
217	38	Manejo de montacargas	Operativa
218	38	Control Estadistico de Proceso (SPC)	Tecnica
219	38	Calibracion de instrumentos	Tecnica
220	39	Trabajo en equipo	Blanda
221	39	Seguridad industrial y EPP	Normativa
222	39	PPAP y APQP	Normativa
223	39	Kaizen y mejora continua	Tecnica
224	39	Manejo de materiales peligrosos	Operativa
225	39	Manufactura esbelta (Lean)	Tecnica
226	40	Gestion de proveedores	Administrativa
227	40	Calibracion de instrumentos	Tecnica
228	40	Manufactura esbelta (Lean)	Tecnica
229	40	Comunicacion efectiva	Blanda
230	40	Mantenimiento productivo total (TPM)	Tecnica
231	40	Manejo de montacargas	Operativa
232	41	Trabajo en equipo	Blanda
233	41	Auditoria IATF 16949	Normativa
234	41	Manejo de montacargas	Operativa
235	41	Programacion CNC	Tecnica
236	41	Control Estadistico de Proceso (SPC)	Tecnica
237	41	Manejo de PLC	Tecnica
238	41	Soldadura MIG/MAG	Operativa
239	42	Control Estadistico de Proceso (SPC)	Tecnica
240	42	Plan de control	Normativa
241	42	Inyeccion de plastico	Operativa
242	42	Core Tools automotrices	Normativa
243	42	Manejo de montacargas	Operativa
244	42	PPAP y APQP	Normativa
245	42	Programacion CNC	Tecnica
246	42	Lectura e interpretacion de planos	Tecnica
247	43	Control Estadistico de Proceso (SPC)	Tecnica
248	43	Trabajo en equipo	Blanda
249	43	Manejo de materiales peligrosos	Operativa
250	43	Inyeccion de plastico	Operativa
251	43	Soldadura MIG/MAG	Operativa
252	43	Control de documentos	Normativa
253	44	Manejo de montacargas	Operativa
254	44	Programacion CNC	Tecnica
255	44	Soldadura MIG/MAG	Operativa
256	44	Mantenimiento productivo total (TPM)	Tecnica
257	45	Programacion CNC	Tecnica
258	45	Auditoria IATF 16949	Normativa
259	45	Manejo de PLC	Tecnica
260	45	Inyeccion de plastico	Operativa
261	45	Plan de control	Normativa
262	45	Core Tools automotrices	Normativa
263	45	Comunicacion efectiva	Blanda
264	45	Trabajo en equipo	Blanda
265	46	Inyeccion de plastico	Operativa
266	46	Mantenimiento productivo total (TPM)	Tecnica
267	46	Kaizen y mejora continua	Tecnica
268	46	Metrologia dimensional	Tecnica
269	46	AMEF / FMEA	Normativa
270	47	Manufactura esbelta (Lean)	Tecnica
271	47	Trabajo en equipo	Blanda
272	47	Control de documentos	Normativa
273	47	Gestion de proveedores	Administrativa
274	47	Manejo de PLC	Tecnica
275	47	Control Estadistico de Proceso (SPC)	Tecnica
276	47	Analisis de causa raiz (8D)	Tecnica
277	48	Metrologia dimensional	Tecnica
278	48	Seguridad industrial y EPP	Normativa
279	48	Auditoria IATF 16949	Normativa
280	48	Manejo de montacargas	Operativa
281	48	Programacion CNC	Tecnica
282	48	Core Tools automotrices	Normativa
283	48	Gestion de proveedores	Administrativa
284	48	Lectura e interpretacion de planos	Tecnica
285	49	Control de documentos	Normativa
286	49	Auditoria IATF 16949	Normativa
287	49	Manufactura esbelta (Lean)	Tecnica
288	49	Gestion de proveedores	Administrativa
289	50	Sistema de gestion ISO 9001	Normativa
290	50	Soldadura MIG/MAG	Operativa
291	50	Comunicacion efectiva	Blanda
292	50	Manejo de PLC	Tecnica
293	50	Manejo de montacargas	Operativa
294	50	Analisis de causa raiz (8D)	Tecnica
295	51	Manejo de PLC	Tecnica
296	51	Kaizen y mejora continua	Tecnica
297	51	Auditoria IATF 16949	Normativa
298	51	AMEF / FMEA	Normativa
299	51	Calibracion de instrumentos	Tecnica
300	51	Plan de control	Normativa
301	51	Control de documentos	Normativa
302	51	Programacion CNC	Tecnica
303	52	Metrologia dimensional	Tecnica
304	52	Mantenimiento productivo total (TPM)	Tecnica
305	52	Soldadura MIG/MAG	Operativa
306	52	Manejo de PLC	Tecnica
307	52	Manejo de montacargas	Operativa
308	52	Kaizen y mejora continua	Tecnica
309	52	Core Tools automotrices	Normativa
310	52	Control Estadistico de Proceso (SPC)	Tecnica
311	53	Inyeccion de plastico	Operativa
312	53	Gestion de proveedores	Administrativa
313	53	Manejo de materiales peligrosos	Operativa
314	53	PPAP y APQP	Normativa
315	53	Calibracion de instrumentos	Tecnica
316	54	Seguridad industrial y EPP	Normativa
317	54	Lectura e interpretacion de planos	Tecnica
318	54	Inyeccion de plastico	Operativa
319	54	Auditoria IATF 16949	Normativa
320	54	Comunicacion efectiva	Blanda
321	55	Kaizen y mejora continua	Tecnica
322	55	Trabajo en equipo	Blanda
323	55	Soldadura MIG/MAG	Operativa
324	55	Control de documentos	Normativa
325	56	Inyeccion de plastico	Operativa
326	56	Seguridad industrial y EPP	Normativa
327	56	PPAP y APQP	Normativa
328	56	Gestion de proveedores	Administrativa
329	57	Programacion CNC	Tecnica
330	57	Manufactura esbelta (Lean)	Tecnica
331	57	Manejo de materiales peligrosos	Operativa
332	57	PPAP y APQP	Normativa
333	57	Core Tools automotrices	Normativa
334	58	Trabajo en equipo	Blanda
335	58	Soldadura MIG/MAG	Operativa
336	58	Analisis de causa raiz (8D)	Tecnica
337	58	Control de documentos	Normativa
338	59	Manejo de PLC	Tecnica
339	59	Calibracion de instrumentos	Tecnica
340	59	Lectura e interpretacion de planos	Tecnica
341	59	Manejo de materiales peligrosos	Operativa
342	59	Gestion de proveedores	Administrativa
343	60	Comunicacion efectiva	Blanda
344	60	Lectura e interpretacion de planos	Tecnica
345	60	Manejo de montacargas	Operativa
346	60	Analisis de causa raiz (8D)	Tecnica
347	60	Plan de control	Normativa
348	61	Inyeccion de plastico	Operativa
349	61	Programacion CNC	Tecnica
350	61	AMEF / FMEA	Normativa
351	61	Control Estadistico de Proceso (SPC)	Tecnica
352	62	Inyeccion de plastico	Operativa
353	62	Auditoria IATF 16949	Normativa
354	62	Sistema de gestion ISO 9001	Normativa
355	62	Plan de control	Normativa
356	62	Seguridad industrial y EPP	Normativa
357	62	Trabajo en equipo	Blanda
358	62	Manejo de materiales peligrosos	Operativa
359	62	Manejo de PLC	Tecnica
360	63	Control de documentos	Normativa
361	63	Manejo de PLC	Tecnica
362	63	Plan de control	Normativa
363	63	Manufactura esbelta (Lean)	Tecnica
364	63	Trabajo en equipo	Blanda
365	63	Analisis de causa raiz (8D)	Tecnica
366	63	Control Estadistico de Proceso (SPC)	Tecnica
367	64	Metrologia dimensional	Tecnica
368	64	Lectura e interpretacion de planos	Tecnica
369	64	Sistema de gestion ISO 9001	Normativa
370	64	Gestion de proveedores	Administrativa
371	64	Mantenimiento productivo total (TPM)	Tecnica
372	64	Manufactura esbelta (Lean)	Tecnica
373	64	Comunicacion efectiva	Blanda
374	65	Inyeccion de plastico	Operativa
375	65	Core Tools automotrices	Normativa
376	65	Metrologia dimensional	Tecnica
377	65	Trabajo en equipo	Blanda
378	65	Gestion de proveedores	Administrativa
379	65	AMEF / FMEA	Normativa
380	65	Lectura e interpretacion de planos	Tecnica
381	65	Programacion CNC	Tecnica
382	66	Kaizen y mejora continua	Tecnica
383	66	Trabajo en equipo	Blanda
384	66	Analisis de causa raiz (8D)	Tecnica
385	66	Lectura e interpretacion de planos	Tecnica
386	66	Calibracion de instrumentos	Tecnica
387	66	Control Estadistico de Proceso (SPC)	Tecnica
388	67	Sistema de gestion ISO 9001	Normativa
389	67	Inyeccion de plastico	Operativa
390	67	Manufactura esbelta (Lean)	Tecnica
391	67	Manejo de PLC	Tecnica
392	67	Auditoria IATF 16949	Normativa
393	67	Manejo de materiales peligrosos	Operativa
394	67	Seguridad industrial y EPP	Normativa
395	67	AMEF / FMEA	Normativa
396	68	Soldadura MIG/MAG	Operativa
397	68	Gestion de proveedores	Administrativa
398	68	Manufactura esbelta (Lean)	Tecnica
399	68	Auditoria IATF 16949	Normativa
400	68	Control de documentos	Normativa
401	68	AMEF / FMEA	Normativa
402	68	Control Estadistico de Proceso (SPC)	Tecnica
403	68	Core Tools automotrices	Normativa
404	69	Comunicacion efectiva	Blanda
405	69	Manejo de montacargas	Operativa
406	69	Auditoria IATF 16949	Normativa
407	69	Programacion CNC	Tecnica
408	69	Kaizen y mejora continua	Tecnica
409	69	Control Estadistico de Proceso (SPC)	Tecnica
410	70	Mantenimiento productivo total (TPM)	Tecnica
411	70	Control Estadistico de Proceso (SPC)	Tecnica
412	70	Trabajo en equipo	Blanda
413	70	Analisis de causa raiz (8D)	Tecnica
414	70	Metrologia dimensional	Tecnica
415	70	Auditoria IATF 16949	Normativa
416	70	Lectura e interpretacion de planos	Tecnica
417	71	Control de documentos	Normativa
418	71	Kaizen y mejora continua	Tecnica
419	71	Inyeccion de plastico	Operativa
420	71	Gestion de proveedores	Administrativa
421	71	Core Tools automotrices	Normativa
422	71	Analisis de causa raiz (8D)	Tecnica
423	71	Control Estadistico de Proceso (SPC)	Tecnica
424	71	Plan de control	Normativa
425	72	Inyeccion de plastico	Operativa
426	72	Gestion de proveedores	Administrativa
427	72	Mantenimiento productivo total (TPM)	Tecnica
428	72	Seguridad industrial y EPP	Normativa
429	72	Soldadura MIG/MAG	Operativa
430	72	Control de documentos	Normativa
431	72	Control Estadistico de Proceso (SPC)	Tecnica
432	73	AMEF / FMEA	Normativa
433	73	Programacion CNC	Tecnica
434	73	Control de documentos	Normativa
435	73	Trabajo en equipo	Blanda
436	73	Inyeccion de plastico	Operativa
437	74	PPAP y APQP	Normativa
438	74	Core Tools automotrices	Normativa
439	74	Analisis de causa raiz (8D)	Tecnica
440	74	Manufactura esbelta (Lean)	Tecnica
441	75	Comunicacion efectiva	Blanda
442	75	Manejo de PLC	Tecnica
443	75	Trabajo en equipo	Blanda
444	75	Sistema de gestion ISO 9001	Normativa
445	75	Plan de control	Normativa
446	75	Lectura e interpretacion de planos	Tecnica
447	76	Manufactura esbelta (Lean)	Tecnica
448	76	AMEF / FMEA	Normativa
449	76	Comunicacion efectiva	Blanda
450	76	Plan de control	Normativa
451	76	Seguridad industrial y EPP	Normativa
452	76	Manejo de materiales peligrosos	Operativa
453	76	Inyeccion de plastico	Operativa
454	77	Lectura e interpretacion de planos	Tecnica
455	77	Seguridad industrial y EPP	Normativa
456	77	Inyeccion de plastico	Operativa
457	77	PPAP y APQP	Normativa
458	77	AMEF / FMEA	Normativa
459	78	Lectura e interpretacion de planos	Tecnica
460	78	Analisis de causa raiz (8D)	Tecnica
461	78	Seguridad industrial y EPP	Normativa
462	78	Trabajo en equipo	Blanda
463	79	Manejo de PLC	Tecnica
464	79	Metrologia dimensional	Tecnica
465	79	Control Estadistico de Proceso (SPC)	Tecnica
466	79	Comunicacion efectiva	Blanda
467	79	Plan de control	Normativa
468	79	Core Tools automotrices	Normativa
469	80	AMEF / FMEA	Normativa
470	80	Manufactura esbelta (Lean)	Tecnica
471	80	Calibracion de instrumentos	Tecnica
472	80	Lectura e interpretacion de planos	Tecnica
473	80	Manejo de montacargas	Operativa
474	80	Auditoria IATF 16949	Normativa
475	81	Sistema de gestion ISO 9001	Normativa
476	81	Inyeccion de plastico	Operativa
477	81	Manejo de PLC	Tecnica
478	81	Core Tools automotrices	Normativa
479	81	Mantenimiento productivo total (TPM)	Tecnica
480	81	AMEF / FMEA	Normativa
481	81	Metrologia dimensional	Tecnica
482	82	Inyeccion de plastico	Operativa
483	82	Gestion de proveedores	Administrativa
484	82	Manufactura esbelta (Lean)	Tecnica
485	82	Mantenimiento productivo total (TPM)	Tecnica
486	82	Control Estadistico de Proceso (SPC)	Tecnica
487	82	Plan de control	Normativa
488	82	Manejo de montacargas	Operativa
489	83	Seguridad industrial y EPP	Normativa
490	83	AMEF / FMEA	Normativa
491	83	Manejo de montacargas	Operativa
492	83	Comunicacion efectiva	Blanda
493	83	Mantenimiento productivo total (TPM)	Tecnica
494	84	Programacion CNC	Tecnica
495	84	Inyeccion de plastico	Operativa
496	84	Manejo de PLC	Tecnica
497	84	Manejo de montacargas	Operativa
498	84	Metrologia dimensional	Tecnica
499	85	Comunicacion efectiva	Blanda
500	85	PPAP y APQP	Normativa
501	85	Plan de control	Normativa
502	85	Control de documentos	Normativa
503	85	Gestion de proveedores	Administrativa
504	85	Inyeccion de plastico	Operativa
505	85	Soldadura MIG/MAG	Operativa
506	86	Seguridad industrial y EPP	Normativa
507	86	Gestion de proveedores	Administrativa
508	86	Lectura e interpretacion de planos	Tecnica
509	86	Metrologia dimensional	Tecnica
510	86	AMEF / FMEA	Normativa
511	86	Inyeccion de plastico	Operativa
512	86	Calibracion de instrumentos	Tecnica
513	87	Trabajo en equipo	Blanda
514	87	Control de documentos	Normativa
515	87	Sistema de gestion ISO 9001	Normativa
516	87	AMEF / FMEA	Normativa
517	88	Soldadura MIG/MAG	Operativa
518	88	Manejo de materiales peligrosos	Operativa
519	88	Manufactura esbelta (Lean)	Tecnica
520	88	Core Tools automotrices	Normativa
521	88	Manejo de montacargas	Operativa
522	88	Seguridad industrial y EPP	Normativa
523	88	Analisis de causa raiz (8D)	Tecnica
524	89	Auditoria IATF 16949	Normativa
525	89	Gestion de proveedores	Administrativa
526	89	Soldadura MIG/MAG	Operativa
527	89	Trabajo en equipo	Blanda
528	89	Sistema de gestion ISO 9001	Normativa
529	89	Metrologia dimensional	Tecnica
530	89	Mantenimiento productivo total (TPM)	Tecnica
531	90	Manejo de PLC	Tecnica
532	90	Manejo de montacargas	Operativa
533	90	Mantenimiento productivo total (TPM)	Tecnica
534	90	Plan de control	Normativa
535	90	Sistema de gestion ISO 9001	Normativa
536	90	Calibracion de instrumentos	Tecnica
537	90	Soldadura MIG/MAG	Operativa
538	91	Soldadura MIG/MAG	Operativa
539	91	Programacion CNC	Tecnica
540	91	Mantenimiento productivo total (TPM)	Tecnica
541	91	Lectura e interpretacion de planos	Tecnica
542	91	Manejo de PLC	Tecnica
543	91	Manufactura esbelta (Lean)	Tecnica
544	91	Kaizen y mejora continua	Tecnica
545	92	PPAP y APQP	Normativa
546	92	Core Tools automotrices	Normativa
547	92	Gestion de proveedores	Administrativa
548	92	Metrologia dimensional	Tecnica
549	92	Control de documentos	Normativa
550	93	Inyeccion de plastico	Operativa
551	93	Control de documentos	Normativa
552	93	Manejo de materiales peligrosos	Operativa
553	93	Analisis de causa raiz (8D)	Tecnica
554	93	Metrologia dimensional	Tecnica
555	93	PPAP y APQP	Normativa
556	93	Lectura e interpretacion de planos	Tecnica
557	94	Lectura e interpretacion de planos	Tecnica
558	94	Sistema de gestion ISO 9001	Normativa
559	94	Kaizen y mejora continua	Tecnica
560	94	Comunicacion efectiva	Blanda
561	94	Gestion de proveedores	Administrativa
562	94	AMEF / FMEA	Normativa
563	94	Manufactura esbelta (Lean)	Tecnica
564	95	Manejo de PLC	Tecnica
565	95	Control Estadistico de Proceso (SPC)	Tecnica
566	95	Manufactura esbelta (Lean)	Tecnica
567	95	AMEF / FMEA	Normativa
568	95	Mantenimiento productivo total (TPM)	Tecnica
569	96	Core Tools automotrices	Normativa
570	96	Mantenimiento productivo total (TPM)	Tecnica
571	96	Comunicacion efectiva	Blanda
572	96	Manejo de materiales peligrosos	Operativa
573	96	Gestion de proveedores	Administrativa
574	96	Lectura e interpretacion de planos	Tecnica
575	96	Auditoria IATF 16949	Normativa
576	96	Control de documentos	Normativa
577	97	Manejo de materiales peligrosos	Operativa
578	97	Trabajo en equipo	Blanda
579	97	Programacion CNC	Tecnica
580	97	Gestion de proveedores	Administrativa
581	97	Calibracion de instrumentos	Tecnica
582	98	Sistema de gestion ISO 9001	Normativa
583	98	Gestion de proveedores	Administrativa
584	98	Manejo de PLC	Tecnica
585	98	Lectura e interpretacion de planos	Tecnica
586	98	Core Tools automotrices	Normativa
587	98	Manufactura esbelta (Lean)	Tecnica
588	98	Programacion CNC	Tecnica
589	99	Manejo de PLC	Tecnica
590	99	Lectura e interpretacion de planos	Tecnica
591	99	Plan de control	Normativa
592	99	Control de documentos	Normativa
593	99	Analisis de causa raiz (8D)	Tecnica
594	99	Core Tools automotrices	Normativa
595	100	Plan de control	Normativa
596	100	Control Estadistico de Proceso (SPC)	Tecnica
597	100	Soldadura MIG/MAG	Operativa
598	100	Manufactura esbelta (Lean)	Tecnica
599	100	Manejo de PLC	Tecnica
600	100	Auditoria IATF 16949	Normativa
601	100	Seguridad industrial y EPP	Normativa
602	100	Mantenimiento productivo total (TPM)	Tecnica
603	101	PPAP y APQP	Normativa
604	101	Seguridad industrial y EPP	Normativa
605	101	Sistema de gestion ISO 9001	Normativa
606	101	Calibracion de instrumentos	Tecnica
607	101	Soldadura MIG/MAG	Operativa
608	101	AMEF / FMEA	Normativa
609	102	Auditoria IATF 16949	Normativa
610	102	Calibracion de instrumentos	Tecnica
611	102	Control de documentos	Normativa
612	102	Manufactura esbelta (Lean)	Tecnica
613	102	Soldadura MIG/MAG	Operativa
614	102	Core Tools automotrices	Normativa
615	103	Seguridad industrial y EPP	Normativa
616	103	Programacion CNC	Tecnica
617	103	AMEF / FMEA	Normativa
618	103	Plan de control	Normativa
619	104	Manejo de PLC	Tecnica
620	104	Core Tools automotrices	Normativa
621	104	Calibracion de instrumentos	Tecnica
622	104	Programacion CNC	Tecnica
623	104	Mantenimiento productivo total (TPM)	Tecnica
624	104	Control Estadistico de Proceso (SPC)	Tecnica
625	104	Sistema de gestion ISO 9001	Normativa
626	105	Soldadura MIG/MAG	Operativa
627	105	Programacion CNC	Tecnica
628	105	Metrologia dimensional	Tecnica
629	105	Auditoria IATF 16949	Normativa
630	105	Control Estadistico de Proceso (SPC)	Tecnica
631	105	Kaizen y mejora continua	Tecnica
632	106	Control Estadistico de Proceso (SPC)	Tecnica
633	106	Sistema de gestion ISO 9001	Normativa
634	106	AMEF / FMEA	Normativa
635	106	Auditoria IATF 16949	Normativa
636	106	Comunicacion efectiva	Blanda
637	107	Inyeccion de plastico	Operativa
638	107	Control Estadistico de Proceso (SPC)	Tecnica
639	107	Trabajo en equipo	Blanda
640	107	Soldadura MIG/MAG	Operativa
641	107	Seguridad industrial y EPP	Normativa
642	107	Programacion CNC	Tecnica
643	107	Comunicacion efectiva	Blanda
644	108	Core Tools automotrices	Normativa
645	108	Seguridad industrial y EPP	Normativa
646	108	Metrologia dimensional	Tecnica
647	108	Calibracion de instrumentos	Tecnica
648	109	Mantenimiento productivo total (TPM)	Tecnica
649	109	Manufactura esbelta (Lean)	Tecnica
650	109	Metrologia dimensional	Tecnica
651	109	Soldadura MIG/MAG	Operativa
652	109	Inyeccion de plastico	Operativa
653	109	Control Estadistico de Proceso (SPC)	Tecnica
654	110	Auditoria IATF 16949	Normativa
655	110	Control Estadistico de Proceso (SPC)	Tecnica
656	110	Manufactura esbelta (Lean)	Tecnica
657	110	Comunicacion efectiva	Blanda
658	110	Manejo de materiales peligrosos	Operativa
659	111	Trabajo en equipo	Blanda
660	111	Lectura e interpretacion de planos	Tecnica
661	111	Manejo de montacargas	Operativa
662	111	Plan de control	Normativa
663	111	Core Tools automotrices	Normativa
664	111	PPAP y APQP	Normativa
665	112	AMEF / FMEA	Normativa
666	112	PPAP y APQP	Normativa
667	112	Metrologia dimensional	Tecnica
668	112	Control Estadistico de Proceso (SPC)	Tecnica
669	112	Comunicacion efectiva	Blanda
670	113	Analisis de causa raiz (8D)	Tecnica
671	113	AMEF / FMEA	Normativa
672	113	Trabajo en equipo	Blanda
673	113	Seguridad industrial y EPP	Normativa
674	113	Control de documentos	Normativa
675	113	Auditoria IATF 16949	Normativa
676	113	Mantenimiento productivo total (TPM)	Tecnica
677	113	Control Estadistico de Proceso (SPC)	Tecnica
678	114	Gestion de proveedores	Administrativa
679	114	Manejo de PLC	Tecnica
680	114	Manejo de montacargas	Operativa
681	114	Manejo de materiales peligrosos	Operativa
682	114	AMEF / FMEA	Normativa
683	114	Soldadura MIG/MAG	Operativa
684	114	Core Tools automotrices	Normativa
685	115	Core Tools automotrices	Normativa
686	115	Kaizen y mejora continua	Tecnica
687	115	Manufactura esbelta (Lean)	Tecnica
688	115	Calibracion de instrumentos	Tecnica
689	115	Metrologia dimensional	Tecnica
690	116	Gestion de proveedores	Administrativa
691	116	Kaizen y mejora continua	Tecnica
692	116	Plan de control	Normativa
693	116	Control Estadistico de Proceso (SPC)	Tecnica
694	117	Analisis de causa raiz (8D)	Tecnica
695	117	Soldadura MIG/MAG	Operativa
696	117	Programacion CNC	Tecnica
697	117	Comunicacion efectiva	Blanda
698	117	Gestion de proveedores	Administrativa
699	117	Manejo de PLC	Tecnica
700	117	Control de documentos	Normativa
701	118	Kaizen y mejora continua	Tecnica
702	118	Core Tools automotrices	Normativa
703	118	Inyeccion de plastico	Operativa
704	118	Seguridad industrial y EPP	Normativa
705	118	Soldadura MIG/MAG	Operativa
706	119	Manejo de PLC	Tecnica
707	119	Lectura e interpretacion de planos	Tecnica
708	119	Manejo de montacargas	Operativa
709	119	Comunicacion efectiva	Blanda
710	119	Control de documentos	Normativa
711	120	Comunicacion efectiva	Blanda
712	120	Auditoria IATF 16949	Normativa
713	120	Manejo de materiales peligrosos	Operativa
714	120	Inyeccion de plastico	Operativa
715	120	AMEF / FMEA	Normativa
716	120	Manejo de PLC	Tecnica
717	121	Auditoria IATF 16949	Normativa
718	121	Manejo de PLC	Tecnica
719	121	Gestion de proveedores	Administrativa
720	121	Core Tools automotrices	Normativa
721	121	Analisis de causa raiz (8D)	Tecnica
722	121	AMEF / FMEA	Normativa
723	121	Kaizen y mejora continua	Tecnica
724	122	Manejo de PLC	Tecnica
725	122	Plan de control	Normativa
726	122	PPAP y APQP	Normativa
727	122	Seguridad industrial y EPP	Normativa
728	122	Mantenimiento productivo total (TPM)	Tecnica
729	122	Kaizen y mejora continua	Tecnica
730	122	Trabajo en equipo	Blanda
731	122	Sistema de gestion ISO 9001	Normativa
732	123	Calibracion de instrumentos	Tecnica
733	123	Inyeccion de plastico	Operativa
734	123	Manejo de montacargas	Operativa
735	123	Programacion CNC	Tecnica
736	123	PPAP y APQP	Normativa
737	123	Trabajo en equipo	Blanda
738	123	Analisis de causa raiz (8D)	Tecnica
739	123	Core Tools automotrices	Normativa
740	124	Auditoria IATF 16949	Normativa
741	124	Seguridad industrial y EPP	Normativa
742	124	Manejo de PLC	Tecnica
743	124	Kaizen y mejora continua	Tecnica
744	124	Programacion CNC	Tecnica
745	124	Inyeccion de plastico	Operativa
746	125	Plan de control	Normativa
747	125	Sistema de gestion ISO 9001	Normativa
748	125	Lectura e interpretacion de planos	Tecnica
749	125	Trabajo en equipo	Blanda
750	125	Manejo de montacargas	Operativa
751	125	Manufactura esbelta (Lean)	Tecnica
752	125	Control Estadistico de Proceso (SPC)	Tecnica
753	126	Control de documentos	Normativa
754	126	Calibracion de instrumentos	Tecnica
755	126	Lectura e interpretacion de planos	Tecnica
756	126	Manejo de PLC	Tecnica
757	127	Inyeccion de plastico	Operativa
758	127	Analisis de causa raiz (8D)	Tecnica
759	127	Kaizen y mejora continua	Tecnica
760	127	Manejo de PLC	Tecnica
761	127	Core Tools automotrices	Normativa
762	127	Programacion CNC	Tecnica
763	128	Mantenimiento productivo total (TPM)	Tecnica
764	128	Control de documentos	Normativa
765	128	Soldadura MIG/MAG	Operativa
766	128	Sistema de gestion ISO 9001	Normativa
767	128	Plan de control	Normativa
768	128	Inyeccion de plastico	Operativa
769	129	Kaizen y mejora continua	Tecnica
770	129	Trabajo en equipo	Blanda
771	129	Calibracion de instrumentos	Tecnica
772	129	Metrologia dimensional	Tecnica
773	129	Manejo de PLC	Tecnica
774	129	Control Estadistico de Proceso (SPC)	Tecnica
775	129	Inyeccion de plastico	Operativa
776	129	Manejo de materiales peligrosos	Operativa
777	130	Lectura e interpretacion de planos	Tecnica
778	130	Mantenimiento productivo total (TPM)	Tecnica
779	130	Kaizen y mejora continua	Tecnica
780	130	Programacion CNC	Tecnica
781	131	Programacion CNC	Tecnica
782	131	Analisis de causa raiz (8D)	Tecnica
783	131	Manejo de materiales peligrosos	Operativa
784	131	Manejo de PLC	Tecnica
785	131	Metrologia dimensional	Tecnica
786	131	Soldadura MIG/MAG	Operativa
787	131	Inyeccion de plastico	Operativa
788	132	Control de documentos	Normativa
789	132	Analisis de causa raiz (8D)	Tecnica
790	132	PPAP y APQP	Normativa
791	132	Control Estadistico de Proceso (SPC)	Tecnica
792	132	Lectura e interpretacion de planos	Tecnica
793	132	Core Tools automotrices	Normativa
794	132	Inyeccion de plastico	Operativa
795	132	AMEF / FMEA	Normativa
796	133	Core Tools automotrices	Normativa
797	133	Seguridad industrial y EPP	Normativa
798	133	AMEF / FMEA	Normativa
799	133	Control Estadistico de Proceso (SPC)	Tecnica
800	133	Comunicacion efectiva	Blanda
801	133	Sistema de gestion ISO 9001	Normativa
802	134	Metrologia dimensional	Tecnica
803	134	Plan de control	Normativa
804	134	Auditoria IATF 16949	Normativa
805	134	PPAP y APQP	Normativa
806	134	Trabajo en equipo	Blanda
807	134	Control Estadistico de Proceso (SPC)	Tecnica
808	134	Manejo de PLC	Tecnica
809	135	Mantenimiento productivo total (TPM)	Tecnica
810	135	Manejo de PLC	Tecnica
811	135	Programacion CNC	Tecnica
812	135	Gestion de proveedores	Administrativa
813	135	Kaizen y mejora continua	Tecnica
814	135	Control de documentos	Normativa
815	136	Metrologia dimensional	Tecnica
816	136	Lectura e interpretacion de planos	Tecnica
817	136	Programacion CNC	Tecnica
818	136	Seguridad industrial y EPP	Normativa
819	136	Inyeccion de plastico	Operativa
820	136	Soldadura MIG/MAG	Operativa
821	137	Trabajo en equipo	Blanda
822	137	Analisis de causa raiz (8D)	Tecnica
823	137	Manejo de montacargas	Operativa
824	137	Kaizen y mejora continua	Tecnica
825	138	Gestion de proveedores	Administrativa
826	138	Manejo de montacargas	Operativa
827	138	Soldadura MIG/MAG	Operativa
828	138	Auditoria IATF 16949	Normativa
829	139	Auditoria IATF 16949	Normativa
830	139	Manufactura esbelta (Lean)	Tecnica
831	139	PPAP y APQP	Normativa
832	139	Sistema de gestion ISO 9001	Normativa
833	139	Plan de control	Normativa
834	139	Programacion CNC	Tecnica
835	139	Soldadura MIG/MAG	Operativa
836	140	Gestion de proveedores	Administrativa
837	140	Manejo de montacargas	Operativa
838	140	Comunicacion efectiva	Blanda
839	140	Manejo de materiales peligrosos	Operativa
840	140	AMEF / FMEA	Normativa
841	140	Mantenimiento productivo total (TPM)	Tecnica
842	140	Manufactura esbelta (Lean)	Tecnica
843	140	Trabajo en equipo	Blanda
844	141	Manejo de materiales peligrosos	Operativa
845	141	Analisis de causa raiz (8D)	Tecnica
846	141	Manufactura esbelta (Lean)	Tecnica
847	141	Calibracion de instrumentos	Tecnica
848	142	Kaizen y mejora continua	Tecnica
849	142	Control de documentos	Normativa
850	142	Gestion de proveedores	Administrativa
851	142	Inyeccion de plastico	Operativa
852	142	Manufactura esbelta (Lean)	Tecnica
853	142	Seguridad industrial y EPP	Normativa
854	142	AMEF / FMEA	Normativa
855	143	Soldadura MIG/MAG	Operativa
856	143	Manejo de PLC	Tecnica
857	143	Inyeccion de plastico	Operativa
858	143	Comunicacion efectiva	Blanda
859	143	Metrologia dimensional	Tecnica
860	144	Mantenimiento productivo total (TPM)	Tecnica
861	144	Sistema de gestion ISO 9001	Normativa
862	144	Control Estadistico de Proceso (SPC)	Tecnica
863	144	Comunicacion efectiva	Blanda
864	144	Manufactura esbelta (Lean)	Tecnica
865	144	Calibracion de instrumentos	Tecnica
866	144	Plan de control	Normativa
867	145	Manejo de montacargas	Operativa
868	145	Gestion de proveedores	Administrativa
869	145	Programacion CNC	Tecnica
870	145	Inyeccion de plastico	Operativa
871	145	PPAP y APQP	Normativa
872	146	Inyeccion de plastico	Operativa
873	146	Plan de control	Normativa
874	146	Gestion de proveedores	Administrativa
875	146	Calibracion de instrumentos	Tecnica
876	146	Mantenimiento productivo total (TPM)	Tecnica
877	147	PPAP y APQP	Normativa
878	147	Lectura e interpretacion de planos	Tecnica
879	147	Auditoria IATF 16949	Normativa
880	147	Kaizen y mejora continua	Tecnica
881	147	Control Estadistico de Proceso (SPC)	Tecnica
882	148	Manejo de montacargas	Operativa
883	148	Trabajo en equipo	Blanda
884	148	Soldadura MIG/MAG	Operativa
885	148	Manejo de materiales peligrosos	Operativa
886	148	PPAP y APQP	Normativa
887	148	Auditoria IATF 16949	Normativa
888	148	Calibracion de instrumentos	Tecnica
889	149	Inyeccion de plastico	Operativa
890	149	Manufactura esbelta (Lean)	Tecnica
891	149	Trabajo en equipo	Blanda
892	149	Plan de control	Normativa
893	149	Programacion CNC	Tecnica
894	149	Auditoria IATF 16949	Normativa
895	149	Mantenimiento productivo total (TPM)	Tecnica
896	150	Manejo de montacargas	Operativa
897	150	Plan de control	Normativa
898	150	Soldadura MIG/MAG	Operativa
899	150	Inyeccion de plastico	Operativa
900	150	Auditoria IATF 16949	Normativa
901	150	Manejo de materiales peligrosos	Operativa
\.


--
-- Data for Name: cursos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cursos (id_curso, id_competencia, nombre_curso, horas) FROM stdin;
1	1	Curso: Control Estadistico de Proceso (SPC)	8
2	2	Curso: Programacion CNC	8
3	4	Curso: Sistema de gestion ISO 9001	24
4	5	Curso: Plan de control	16
5	10	Curso: Lectura e interpretacion de planos	24
6	11	Curso: Metrologia dimensional	4
7	12	Curso: Manejo de montacargas	24
8	13	Curso: Programacion CNC	4
9	16	Curso: Core Tools automotrices	24
10	17	Curso: Kaizen y mejora continua	8
11	18	Curso: Manejo de materiales peligrosos	4
12	19	Curso: Comunicacion efectiva	8
13	20	Curso: Auditoria IATF 16949	4
14	21	Curso: PPAP y APQP	40
15	23	Curso: Manejo de PLC	24
16	24	Curso: Sistema de gestion ISO 9001	40
17	26	Curso: Mantenimiento productivo total (TPM)	4
18	27	Curso: Manejo de materiales peligrosos	40
19	28	Curso: Manejo de montacargas	24
20	29	Curso: Inyeccion de plastico	16
21	32	Curso: Soldadura MIG/MAG	4
22	33	Curso: Manejo de PLC	8
23	34	Curso: Core Tools automotrices	8
24	35	Curso: Control de documentos	40
25	37	Curso: Sistema de gestion ISO 9001	4
26	38	Curso: Soldadura MIG/MAG	4
27	41	Curso: Plan de control	16
28	42	Curso: Gestion de proveedores	16
29	43	Curso: AMEF / FMEA	8
30	45	Curso: Inyeccion de plastico	40
31	46	Curso: Metrologia dimensional	16
32	48	Curso: Mantenimiento productivo total (TPM)	16
33	51	Curso: Plan de control	8
34	52	Curso: Soldadura MIG/MAG	8
35	53	Curso: Control de documentos	16
36	54	Curso: Calibracion de instrumentos	24
37	55	Curso: Comunicacion efectiva	8
38	57	Curso: Control Estadistico de Proceso (SPC)	40
39	58	Curso: Lectura e interpretacion de planos	4
40	59	Curso: AMEF / FMEA	40
41	60	Curso: Trabajo en equipo	24
42	67	Curso: Trabajo en equipo	8
43	69	Curso: PPAP y APQP	40
44	71	Curso: Gestion de proveedores	4
45	72	Curso: Core Tools automotrices	8
46	73	Curso: Manufactura esbelta (Lean)	16
47	75	Curso: Lectura e interpretacion de planos	16
48	76	Curso: Trabajo en equipo	4
49	78	Curso: Sistema de gestion ISO 9001	16
50	79	Curso: Kaizen y mejora continua	16
51	83	Curso: Core Tools automotrices	24
52	84	Curso: Kaizen y mejora continua	16
53	85	Curso: Control Estadistico de Proceso (SPC)	8
54	86	Curso: Gestion de proveedores	40
55	87	Curso: Seguridad industrial y EPP	4
56	89	Curso: Auditoria IATF 16949	4
57	90	Curso: Core Tools automotrices	4
58	92	Curso: Programacion CNC	16
59	95	Curso: Manejo de PLC	24
60	96	Curso: Soldadura MIG/MAG	4
61	97	Curso: Plan de control	8
62	100	Curso: Analisis de causa raiz (8D)	40
63	103	Curso: Trabajo en equipo	4
64	104	Curso: Control Estadistico de Proceso (SPC)	4
65	108	Curso: PPAP y APQP	40
66	111	Curso: AMEF / FMEA	24
67	113	Curso: Manejo de materiales peligrosos	40
68	114	Curso: Auditoria IATF 16949	40
69	115	Curso: Seguridad industrial y EPP	8
70	116	Curso: Manejo de montacargas	40
71	118	Curso: Lectura e interpretacion de planos	24
72	122	Curso: Kaizen y mejora continua	8
73	126	Curso: Plan de control	24
74	129	Curso: Programacion CNC	8
75	130	Curso: Calibracion de instrumentos	8
76	131	Curso: Plan de control	24
77	133	Curso: Core Tools automotrices	8
78	134	Curso: Kaizen y mejora continua	16
79	135	Curso: Sistema de gestion ISO 9001	8
80	137	Curso: Core Tools automotrices	4
81	139	Curso: Control Estadistico de Proceso (SPC)	16
82	140	Curso: Metrologia dimensional	4
83	142	Curso: Comunicacion efectiva	40
84	143	Curso: Analisis de causa raiz (8D)	8
85	145	Curso: Trabajo en equipo	24
86	147	Curso: Inyeccion de plastico	24
87	148	Curso: Manufactura esbelta (Lean)	16
88	149	Curso: Mantenimiento productivo total (TPM)	16
89	150	Curso: Gestion de proveedores	4
90	151	Curso: Metrologia dimensional	40
91	152	Curso: Inyeccion de plastico	8
92	154	Curso: Control de documentos	40
93	155	Curso: Calibracion de instrumentos	4
94	158	Curso: Manufactura esbelta (Lean)	4
95	159	Curso: Programacion CNC	8
96	160	Curso: Metrologia dimensional	40
97	163	Curso: Control Estadistico de Proceso (SPC)	24
98	164	Curso: AMEF / FMEA	4
99	165	Curso: Control de documentos	8
100	166	Curso: Manejo de materiales peligrosos	16
101	167	Curso: Programacion CNC	16
102	168	Curso: Gestion de proveedores	8
103	169	Curso: Auditoria IATF 16949	16
104	170	Curso: Manejo de montacargas	4
105	172	Curso: Manejo de PLC	16
106	173	Curso: Calibracion de instrumentos	8
107	174	Curso: AMEF / FMEA	24
108	175	Curso: Inyeccion de plastico	8
109	180	Curso: Gestion de proveedores	16
110	181	Curso: Kaizen y mejora continua	4
111	183	Curso: Manufactura esbelta (Lean)	16
112	184	Curso: Lectura e interpretacion de planos	4
113	186	Curso: Seguridad industrial y EPP	24
114	187	Curso: Analisis de causa raiz (8D)	24
115	188	Curso: Control Estadistico de Proceso (SPC)	24
116	189	Curso: Programacion CNC	40
117	190	Curso: Kaizen y mejora continua	4
118	193	Curso: Manejo de montacargas	4
119	195	Curso: Analisis de causa raiz (8D)	24
120	196	Curso: Gestion de proveedores	4
121	198	Curso: Mantenimiento productivo total (TPM)	40
122	200	Curso: Control Estadistico de Proceso (SPC)	16
123	201	Curso: Control Estadistico de Proceso (SPC)	24
124	204	Curso: Control de documentos	4
125	207	Curso: Inyeccion de plastico	40
126	208	Curso: Sistema de gestion ISO 9001	4
127	209	Curso: Core Tools automotrices	24
128	210	Curso: Core Tools automotrices	16
129	211	Curso: Analisis de causa raiz (8D)	4
130	214	Curso: PPAP y APQP	24
131	215	Curso: Lectura e interpretacion de planos	40
132	216	Curso: Programacion CNC	8
133	217	Curso: Manejo de montacargas	8
134	219	Curso: Calibracion de instrumentos	16
135	220	Curso: Trabajo en equipo	8
136	221	Curso: Seguridad industrial y EPP	4
137	222	Curso: PPAP y APQP	8
138	223	Curso: Kaizen y mejora continua	24
139	225	Curso: Manufactura esbelta (Lean)	16
140	229	Curso: Comunicacion efectiva	4
141	231	Curso: Manejo de montacargas	40
142	232	Curso: Trabajo en equipo	8
143	234	Curso: Manejo de montacargas	16
144	235	Curso: Programacion CNC	16
145	238	Curso: Soldadura MIG/MAG	40
146	240	Curso: Plan de control	40
147	242	Curso: Core Tools automotrices	4
148	245	Curso: Programacion CNC	40
149	246	Curso: Lectura e interpretacion de planos	40
150	249	Curso: Manejo de materiales peligrosos	40
151	252	Curso: Control de documentos	24
152	253	Curso: Manejo de montacargas	24
153	254	Curso: Programacion CNC	8
154	255	Curso: Soldadura MIG/MAG	24
155	257	Curso: Programacion CNC	16
156	260	Curso: Inyeccion de plastico	4
157	261	Curso: Plan de control	40
158	262	Curso: Core Tools automotrices	4
159	264	Curso: Trabajo en equipo	8
160	265	Curso: Inyeccion de plastico	16
161	266	Curso: Mantenimiento productivo total (TPM)	8
162	269	Curso: AMEF / FMEA	24
163	272	Curso: Control de documentos	16
164	273	Curso: Gestion de proveedores	40
165	274	Curso: Manejo de PLC	4
166	275	Curso: Control Estadistico de Proceso (SPC)	16
167	276	Curso: Analisis de causa raiz (8D)	24
168	277	Curso: Metrologia dimensional	4
169	278	Curso: Seguridad industrial y EPP	24
170	279	Curso: Auditoria IATF 16949	24
171	280	Curso: Manejo de montacargas	40
172	282	Curso: Core Tools automotrices	16
173	284	Curso: Lectura e interpretacion de planos	40
174	285	Curso: Control de documentos	24
175	287	Curso: Manufactura esbelta (Lean)	40
176	288	Curso: Gestion de proveedores	8
177	289	Curso: Sistema de gestion ISO 9001	24
178	290	Curso: Soldadura MIG/MAG	8
179	291	Curso: Comunicacion efectiva	40
180	293	Curso: Manejo de montacargas	4
181	294	Curso: Analisis de causa raiz (8D)	16
182	296	Curso: Kaizen y mejora continua	4
183	297	Curso: Auditoria IATF 16949	16
184	299	Curso: Calibracion de instrumentos	4
185	300	Curso: Plan de control	16
186	303	Curso: Metrologia dimensional	16
187	304	Curso: Mantenimiento productivo total (TPM)	8
188	305	Curso: Soldadura MIG/MAG	24
189	309	Curso: Core Tools automotrices	24
190	310	Curso: Control Estadistico de Proceso (SPC)	8
191	311	Curso: Inyeccion de plastico	16
192	312	Curso: Gestion de proveedores	8
193	315	Curso: Calibracion de instrumentos	4
194	316	Curso: Seguridad industrial y EPP	8
195	318	Curso: Inyeccion de plastico	24
196	319	Curso: Auditoria IATF 16949	24
197	323	Curso: Soldadura MIG/MAG	16
198	324	Curso: Control de documentos	8
199	325	Curso: Inyeccion de plastico	24
200	326	Curso: Seguridad industrial y EPP	40
201	327	Curso: PPAP y APQP	16
202	328	Curso: Gestion de proveedores	8
203	329	Curso: Programacion CNC	8
204	336	Curso: Analisis de causa raiz (8D)	16
205	338	Curso: Manejo de PLC	8
206	339	Curso: Calibracion de instrumentos	24
207	340	Curso: Lectura e interpretacion de planos	4
208	342	Curso: Gestion de proveedores	40
209	343	Curso: Comunicacion efectiva	8
210	345	Curso: Manejo de montacargas	8
211	346	Curso: Analisis de causa raiz (8D)	40
212	347	Curso: Plan de control	8
213	348	Curso: Inyeccion de plastico	8
214	349	Curso: Programacion CNC	8
215	350	Curso: AMEF / FMEA	24
216	352	Curso: Inyeccion de plastico	8
217	356	Curso: Seguridad industrial y EPP	24
218	357	Curso: Trabajo en equipo	24
219	358	Curso: Manejo de materiales peligrosos	40
220	359	Curso: Manejo de PLC	40
221	361	Curso: Manejo de PLC	4
222	362	Curso: Plan de control	24
223	363	Curso: Manufactura esbelta (Lean)	8
224	364	Curso: Trabajo en equipo	40
225	365	Curso: Analisis de causa raiz (8D)	40
226	366	Curso: Control Estadistico de Proceso (SPC)	4
227	367	Curso: Metrologia dimensional	24
228	369	Curso: Sistema de gestion ISO 9001	4
229	371	Curso: Mantenimiento productivo total (TPM)	4
230	372	Curso: Manufactura esbelta (Lean)	24
231	373	Curso: Comunicacion efectiva	40
232	375	Curso: Core Tools automotrices	4
233	377	Curso: Trabajo en equipo	40
234	378	Curso: Gestion de proveedores	4
235	379	Curso: AMEF / FMEA	4
236	381	Curso: Programacion CNC	8
237	382	Curso: Kaizen y mejora continua	40
238	383	Curso: Trabajo en equipo	8
239	384	Curso: Analisis de causa raiz (8D)	4
240	385	Curso: Lectura e interpretacion de planos	24
241	386	Curso: Calibracion de instrumentos	40
242	387	Curso: Control Estadistico de Proceso (SPC)	8
243	388	Curso: Sistema de gestion ISO 9001	4
244	389	Curso: Inyeccion de plastico	8
245	390	Curso: Manufactura esbelta (Lean)	8
246	391	Curso: Manejo de PLC	40
247	393	Curso: Manejo de materiales peligrosos	4
248	394	Curso: Seguridad industrial y EPP	16
249	395	Curso: AMEF / FMEA	40
250	396	Curso: Soldadura MIG/MAG	8
251	398	Curso: Manufactura esbelta (Lean)	8
252	400	Curso: Control de documentos	4
253	401	Curso: AMEF / FMEA	40
254	403	Curso: Core Tools automotrices	16
255	404	Curso: Comunicacion efectiva	8
256	406	Curso: Auditoria IATF 16949	16
257	407	Curso: Programacion CNC	16
258	408	Curso: Kaizen y mejora continua	16
259	411	Curso: Control Estadistico de Proceso (SPC)	4
260	412	Curso: Trabajo en equipo	16
261	414	Curso: Metrologia dimensional	16
262	415	Curso: Auditoria IATF 16949	24
263	417	Curso: Control de documentos	16
264	418	Curso: Kaizen y mejora continua	24
265	419	Curso: Inyeccion de plastico	8
266	421	Curso: Core Tools automotrices	24
267	422	Curso: Analisis de causa raiz (8D)	16
268	425	Curso: Inyeccion de plastico	24
269	426	Curso: Gestion de proveedores	24
270	427	Curso: Mantenimiento productivo total (TPM)	16
271	428	Curso: Seguridad industrial y EPP	24
272	432	Curso: AMEF / FMEA	24
273	433	Curso: Programacion CNC	40
274	435	Curso: Trabajo en equipo	40
275	436	Curso: Inyeccion de plastico	4
276	438	Curso: Core Tools automotrices	24
277	440	Curso: Manufactura esbelta (Lean)	8
278	441	Curso: Comunicacion efectiva	8
279	442	Curso: Manejo de PLC	24
280	443	Curso: Trabajo en equipo	40
281	444	Curso: Sistema de gestion ISO 9001	16
282	445	Curso: Plan de control	16
283	446	Curso: Lectura e interpretacion de planos	16
284	447	Curso: Manufactura esbelta (Lean)	24
285	449	Curso: Comunicacion efectiva	4
286	451	Curso: Seguridad industrial y EPP	8
287	452	Curso: Manejo de materiales peligrosos	24
288	453	Curso: Inyeccion de plastico	40
289	456	Curso: Inyeccion de plastico	8
290	457	Curso: PPAP y APQP	16
291	458	Curso: AMEF / FMEA	40
292	459	Curso: Lectura e interpretacion de planos	16
293	461	Curso: Seguridad industrial y EPP	24
294	462	Curso: Trabajo en equipo	8
295	463	Curso: Manejo de PLC	8
296	464	Curso: Metrologia dimensional	24
297	467	Curso: Plan de control	40
298	472	Curso: Lectura e interpretacion de planos	8
299	475	Curso: Sistema de gestion ISO 9001	4
300	476	Curso: Inyeccion de plastico	40
301	477	Curso: Manejo de PLC	8
302	478	Curso: Core Tools automotrices	24
303	480	Curso: AMEF / FMEA	40
304	481	Curso: Metrologia dimensional	4
305	483	Curso: Gestion de proveedores	8
306	485	Curso: Mantenimiento productivo total (TPM)	24
307	486	Curso: Control Estadistico de Proceso (SPC)	8
308	488	Curso: Manejo de montacargas	40
309	490	Curso: AMEF / FMEA	16
310	491	Curso: Manejo de montacargas	40
311	492	Curso: Comunicacion efectiva	24
312	494	Curso: Programacion CNC	8
313	498	Curso: Metrologia dimensional	40
314	500	Curso: PPAP y APQP	16
315	506	Curso: Seguridad industrial y EPP	8
316	507	Curso: Gestion de proveedores	4
317	508	Curso: Lectura e interpretacion de planos	24
318	509	Curso: Metrologia dimensional	4
319	513	Curso: Trabajo en equipo	16
320	514	Curso: Control de documentos	40
321	515	Curso: Sistema de gestion ISO 9001	40
322	516	Curso: AMEF / FMEA	24
323	517	Curso: Soldadura MIG/MAG	24
324	518	Curso: Manejo de materiales peligrosos	16
325	519	Curso: Manufactura esbelta (Lean)	16
326	521	Curso: Manejo de montacargas	24
327	522	Curso: Seguridad industrial y EPP	4
328	523	Curso: Analisis de causa raiz (8D)	4
329	524	Curso: Auditoria IATF 16949	4
330	528	Curso: Sistema de gestion ISO 9001	16
331	530	Curso: Mantenimiento productivo total (TPM)	4
332	532	Curso: Manejo de montacargas	40
333	533	Curso: Mantenimiento productivo total (TPM)	40
334	534	Curso: Plan de control	40
335	536	Curso: Calibracion de instrumentos	4
336	540	Curso: Mantenimiento productivo total (TPM)	4
337	543	Curso: Manufactura esbelta (Lean)	16
338	544	Curso: Kaizen y mejora continua	24
339	545	Curso: PPAP y APQP	16
340	549	Curso: Control de documentos	4
341	551	Curso: Control de documentos	4
342	554	Curso: Metrologia dimensional	8
343	556	Curso: Lectura e interpretacion de planos	16
344	557	Curso: Lectura e interpretacion de planos	4
345	558	Curso: Sistema de gestion ISO 9001	24
346	559	Curso: Kaizen y mejora continua	16
347	560	Curso: Comunicacion efectiva	24
348	561	Curso: Gestion de proveedores	4
349	562	Curso: AMEF / FMEA	16
350	567	Curso: AMEF / FMEA	8
351	569	Curso: Core Tools automotrices	16
352	570	Curso: Mantenimiento productivo total (TPM)	8
353	571	Curso: Comunicacion efectiva	4
354	572	Curso: Manejo de materiales peligrosos	24
355	574	Curso: Lectura e interpretacion de planos	8
356	577	Curso: Manejo de materiales peligrosos	16
357	578	Curso: Trabajo en equipo	16
358	580	Curso: Gestion de proveedores	24
359	582	Curso: Sistema de gestion ISO 9001	8
360	584	Curso: Manejo de PLC	24
361	585	Curso: Lectura e interpretacion de planos	4
362	586	Curso: Core Tools automotrices	16
363	587	Curso: Manufactura esbelta (Lean)	40
364	588	Curso: Programacion CNC	24
365	589	Curso: Manejo de PLC	24
366	590	Curso: Lectura e interpretacion de planos	40
367	591	Curso: Plan de control	40
368	593	Curso: Analisis de causa raiz (8D)	8
369	595	Curso: Plan de control	8
370	596	Curso: Control Estadistico de Proceso (SPC)	40
371	597	Curso: Soldadura MIG/MAG	4
372	598	Curso: Manufactura esbelta (Lean)	8
373	604	Curso: Seguridad industrial y EPP	24
374	605	Curso: Sistema de gestion ISO 9001	4
375	606	Curso: Calibracion de instrumentos	16
376	607	Curso: Soldadura MIG/MAG	24
377	608	Curso: AMEF / FMEA	16
378	609	Curso: Auditoria IATF 16949	16
379	613	Curso: Soldadura MIG/MAG	24
380	614	Curso: Core Tools automotrices	4
381	615	Curso: Seguridad industrial y EPP	4
382	617	Curso: AMEF / FMEA	16
383	618	Curso: Plan de control	24
384	619	Curso: Manejo de PLC	8
385	620	Curso: Core Tools automotrices	4
386	621	Curso: Calibracion de instrumentos	24
387	622	Curso: Programacion CNC	8
388	624	Curso: Control Estadistico de Proceso (SPC)	4
389	625	Curso: Sistema de gestion ISO 9001	24
390	627	Curso: Programacion CNC	8
391	629	Curso: Auditoria IATF 16949	4
392	631	Curso: Kaizen y mejora continua	8
393	632	Curso: Control Estadistico de Proceso (SPC)	24
394	633	Curso: Sistema de gestion ISO 9001	24
395	636	Curso: Comunicacion efectiva	16
396	637	Curso: Inyeccion de plastico	40
397	639	Curso: Trabajo en equipo	24
398	640	Curso: Soldadura MIG/MAG	8
399	641	Curso: Seguridad industrial y EPP	8
400	642	Curso: Programacion CNC	24
401	644	Curso: Core Tools automotrices	24
402	645	Curso: Seguridad industrial y EPP	40
403	646	Curso: Metrologia dimensional	4
404	647	Curso: Calibracion de instrumentos	16
405	648	Curso: Mantenimiento productivo total (TPM)	8
406	649	Curso: Manufactura esbelta (Lean)	40
407	650	Curso: Metrologia dimensional	16
408	652	Curso: Inyeccion de plastico	24
409	653	Curso: Control Estadistico de Proceso (SPC)	8
410	654	Curso: Auditoria IATF 16949	16
411	655	Curso: Control Estadistico de Proceso (SPC)	8
412	656	Curso: Manufactura esbelta (Lean)	24
413	658	Curso: Manejo de materiales peligrosos	16
414	660	Curso: Lectura e interpretacion de planos	8
415	662	Curso: Plan de control	24
416	663	Curso: Core Tools automotrices	40
417	665	Curso: AMEF / FMEA	40
418	667	Curso: Metrologia dimensional	40
419	668	Curso: Control Estadistico de Proceso (SPC)	4
420	670	Curso: Analisis de causa raiz (8D)	24
421	671	Curso: AMEF / FMEA	40
422	672	Curso: Trabajo en equipo	4
423	673	Curso: Seguridad industrial y EPP	40
424	674	Curso: Control de documentos	16
425	675	Curso: Auditoria IATF 16949	4
426	678	Curso: Gestion de proveedores	40
427	679	Curso: Manejo de PLC	24
428	680	Curso: Manejo de montacargas	40
429	681	Curso: Manejo de materiales peligrosos	24
430	683	Curso: Soldadura MIG/MAG	40
431	684	Curso: Core Tools automotrices	4
432	685	Curso: Core Tools automotrices	40
433	690	Curso: Gestion de proveedores	4
434	692	Curso: Plan de control	24
435	693	Curso: Control Estadistico de Proceso (SPC)	8
436	694	Curso: Analisis de causa raiz (8D)	8
437	696	Curso: Programacion CNC	24
438	697	Curso: Comunicacion efectiva	16
439	699	Curso: Manejo de PLC	24
440	700	Curso: Control de documentos	4
441	701	Curso: Kaizen y mejora continua	24
442	702	Curso: Core Tools automotrices	24
443	703	Curso: Inyeccion de plastico	16
444	704	Curso: Seguridad industrial y EPP	24
445	708	Curso: Manejo de montacargas	8
446	710	Curso: Control de documentos	8
447	711	Curso: Comunicacion efectiva	24
448	712	Curso: Auditoria IATF 16949	8
449	713	Curso: Manejo de materiales peligrosos	4
450	715	Curso: AMEF / FMEA	40
451	716	Curso: Manejo de PLC	4
452	717	Curso: Auditoria IATF 16949	8
453	718	Curso: Manejo de PLC	24
454	722	Curso: AMEF / FMEA	4
455	723	Curso: Kaizen y mejora continua	8
456	725	Curso: Plan de control	16
457	726	Curso: PPAP y APQP	8
458	727	Curso: Seguridad industrial y EPP	4
459	728	Curso: Mantenimiento productivo total (TPM)	16
460	729	Curso: Kaizen y mejora continua	4
461	730	Curso: Trabajo en equipo	16
462	731	Curso: Sistema de gestion ISO 9001	24
463	732	Curso: Calibracion de instrumentos	4
464	733	Curso: Inyeccion de plastico	4
465	734	Curso: Manejo de montacargas	4
466	735	Curso: Programacion CNC	40
467	737	Curso: Trabajo en equipo	16
468	738	Curso: Analisis de causa raiz (8D)	4
469	739	Curso: Core Tools automotrices	8
470	741	Curso: Seguridad industrial y EPP	40
471	742	Curso: Manejo de PLC	8
472	744	Curso: Programacion CNC	4
473	745	Curso: Inyeccion de plastico	16
474	746	Curso: Plan de control	24
475	747	Curso: Sistema de gestion ISO 9001	4
476	748	Curso: Lectura e interpretacion de planos	24
477	749	Curso: Trabajo en equipo	24
478	751	Curso: Manufactura esbelta (Lean)	16
479	752	Curso: Control Estadistico de Proceso (SPC)	24
480	753	Curso: Control de documentos	4
481	755	Curso: Lectura e interpretacion de planos	16
482	757	Curso: Inyeccion de plastico	24
483	760	Curso: Manejo de PLC	24
484	761	Curso: Core Tools automotrices	24
485	762	Curso: Programacion CNC	4
486	763	Curso: Mantenimiento productivo total (TPM)	4
487	764	Curso: Control de documentos	8
488	765	Curso: Soldadura MIG/MAG	40
489	766	Curso: Sistema de gestion ISO 9001	8
490	767	Curso: Plan de control	16
491	768	Curso: Inyeccion de plastico	4
492	769	Curso: Kaizen y mejora continua	40
493	770	Curso: Trabajo en equipo	40
494	771	Curso: Calibracion de instrumentos	16
495	772	Curso: Metrologia dimensional	40
496	773	Curso: Manejo de PLC	40
497	775	Curso: Inyeccion de plastico	8
498	779	Curso: Kaizen y mejora continua	40
499	782	Curso: Analisis de causa raiz (8D)	8
500	783	Curso: Manejo de materiales peligrosos	4
501	784	Curso: Manejo de PLC	16
502	785	Curso: Metrologia dimensional	8
503	786	Curso: Soldadura MIG/MAG	16
504	788	Curso: Control de documentos	8
505	789	Curso: Analisis de causa raiz (8D)	8
506	790	Curso: PPAP y APQP	40
507	791	Curso: Control Estadistico de Proceso (SPC)	16
508	793	Curso: Core Tools automotrices	16
509	794	Curso: Inyeccion de plastico	4
510	796	Curso: Core Tools automotrices	40
511	797	Curso: Seguridad industrial y EPP	8
512	798	Curso: AMEF / FMEA	24
513	799	Curso: Control Estadistico de Proceso (SPC)	4
514	802	Curso: Metrologia dimensional	40
515	803	Curso: Plan de control	16
516	804	Curso: Auditoria IATF 16949	24
517	805	Curso: PPAP y APQP	40
518	807	Curso: Control Estadistico de Proceso (SPC)	24
519	809	Curso: Mantenimiento productivo total (TPM)	8
520	811	Curso: Programacion CNC	8
521	812	Curso: Gestion de proveedores	16
522	814	Curso: Control de documentos	4
523	815	Curso: Metrologia dimensional	40
524	816	Curso: Lectura e interpretacion de planos	16
525	817	Curso: Programacion CNC	16
526	818	Curso: Seguridad industrial y EPP	4
527	819	Curso: Inyeccion de plastico	24
528	820	Curso: Soldadura MIG/MAG	16
529	821	Curso: Trabajo en equipo	16
530	822	Curso: Analisis de causa raiz (8D)	4
531	823	Curso: Manejo de montacargas	4
532	825	Curso: Gestion de proveedores	16
533	826	Curso: Manejo de montacargas	40
534	827	Curso: Soldadura MIG/MAG	16
535	828	Curso: Auditoria IATF 16949	4
536	829	Curso: Auditoria IATF 16949	8
537	831	Curso: PPAP y APQP	4
538	834	Curso: Programacion CNC	16
539	836	Curso: Gestion de proveedores	8
540	837	Curso: Manejo de montacargas	4
541	838	Curso: Comunicacion efectiva	40
542	839	Curso: Manejo de materiales peligrosos	16
543	842	Curso: Manufactura esbelta (Lean)	40
544	844	Curso: Manejo de materiales peligrosos	16
545	845	Curso: Analisis de causa raiz (8D)	40
546	846	Curso: Manufactura esbelta (Lean)	24
547	848	Curso: Kaizen y mejora continua	8
548	849	Curso: Control de documentos	16
549	850	Curso: Gestion de proveedores	8
550	851	Curso: Inyeccion de plastico	16
551	853	Curso: Seguridad industrial y EPP	24
552	854	Curso: AMEF / FMEA	8
553	855	Curso: Soldadura MIG/MAG	16
554	857	Curso: Inyeccion de plastico	4
555	858	Curso: Comunicacion efectiva	4
556	860	Curso: Mantenimiento productivo total (TPM)	40
557	861	Curso: Sistema de gestion ISO 9001	8
558	862	Curso: Control Estadistico de Proceso (SPC)	8
559	865	Curso: Calibracion de instrumentos	16
560	866	Curso: Plan de control	24
561	869	Curso: Programacion CNC	24
562	870	Curso: Inyeccion de plastico	16
563	871	Curso: PPAP y APQP	16
564	872	Curso: Inyeccion de plastico	4
565	874	Curso: Gestion de proveedores	24
566	876	Curso: Mantenimiento productivo total (TPM)	4
567	877	Curso: PPAP y APQP	24
568	883	Curso: Trabajo en equipo	8
569	885	Curso: Manejo de materiales peligrosos	16
570	886	Curso: PPAP y APQP	16
571	887	Curso: Auditoria IATF 16949	24
572	890	Curso: Manufactura esbelta (Lean)	4
573	891	Curso: Trabajo en equipo	40
574	895	Curso: Mantenimiento productivo total (TPM)	4
575	896	Curso: Manejo de montacargas	40
576	897	Curso: Plan de control	40
577	898	Curso: Soldadura MIG/MAG	24
578	899	Curso: Inyeccion de plastico	24
579	900	Curso: Auditoria IATF 16949	24
580	901	Curso: Manejo de materiales peligrosos	24
\.


--
-- Data for Name: cursos_participantes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cursos_participantes (id, id_curso_programado, no_reloj, asistio) FROM stdin;
1	16	10212	t
2	1044	10441	t
3	1024	10083	t
4	859	10225	t
5	68	10180	t
6	943	10187	t
7	890	10045	t
8	331	10126	t
9	746	10343	t
10	1012	10301	t
11	714	10339	t
12	738	10314	t
13	294	10584	f
14	603	10376	f
15	513	10173	t
16	191	10326	t
17	1139	10282	t
18	32	10096	t
19	554	10175	t
20	276	10233	t
21	798	10253	t
22	571	10141	t
23	262	10549	f
24	982	10051	f
25	264	10474	t
26	915	10267	t
27	623	10572	t
28	740	10471	t
29	876	10382	t
30	315	10220	t
31	656	10071	f
32	287	10564	t
33	375	10536	t
34	728	10220	t
35	274	10361	f
36	715	10051	t
37	422	10281	f
38	291	10175	t
39	364	10146	t
40	330	10145	t
41	1110	10254	t
42	879	10066	f
43	912	10517	t
44	247	10419	t
45	420	10165	t
46	229	10044	t
47	1130	10132	t
48	106	10570	t
49	247	10578	f
50	1034	10285	t
51	570	10504	t
52	531	10461	t
53	163	10574	t
54	232	10015	f
55	1034	10404	f
56	200	10016	t
57	195	10145	t
58	305	10086	t
59	1106	10486	t
60	98	10079	t
61	898	10498	t
62	599	10103	t
63	234	10548	t
64	776	10286	t
65	817	10170	t
66	246	10217	t
67	1109	10087	t
68	457	10036	t
69	483	10096	t
70	996	10237	t
71	215	10168	t
72	1024	10287	f
73	735	10255	t
74	643	10027	t
75	825	10039	t
76	273	10584	t
77	561	10230	t
78	1000	10557	t
79	1130	10326	f
80	934	10332	f
81	792	10583	t
82	882	10220	t
83	7	10513	t
84	859	10371	t
85	753	10476	t
86	498	10436	t
87	750	10443	t
88	260	10083	f
89	384	10417	f
90	1079	10204	t
91	984	10534	t
92	1088	10203	t
93	728	10229	t
94	477	10395	t
95	990	10440	t
96	156	10587	t
97	616	10563	t
98	1091	10179	t
99	829	10423	t
100	131	10491	f
101	103	10438	t
102	590	10559	t
103	108	10307	t
104	176	10490	t
105	691	10339	f
106	63	10420	t
107	353	10001	t
108	610	10196	t
109	607	10434	f
110	912	10182	t
111	458	10235	t
112	48	10125	t
113	1129	10310	t
114	996	10330	t
115	758	10214	t
116	90	10372	t
117	75	10583	f
118	1110	10529	t
119	1159	10255	t
120	131	10530	t
121	68	10338	f
122	534	10012	t
123	366	10030	t
124	522	10331	t
125	866	10256	f
126	679	10093	t
127	307	10245	t
128	704	10457	t
129	201	10360	t
130	654	10525	t
131	26	10511	t
132	450	10424	f
133	379	10279	t
134	366	10074	t
135	266	10162	t
136	470	10534	t
137	603	10539	t
138	873	10452	t
139	825	10287	t
140	467	10417	t
141	812	10150	t
142	531	10206	t
143	297	10161	f
144	357	10381	t
145	267	10180	t
146	585	10069	t
147	317	10570	t
148	598	10497	t
149	849	10105	t
150	335	10048	f
151	1127	10408	t
152	812	10557	t
153	514	10435	t
154	354	10566	t
155	724	10022	t
156	406	10599	t
157	410	10082	t
158	708	10547	t
159	692	10523	t
160	127	10414	t
161	668	10469	t
162	845	10526	f
163	450	10091	f
164	811	10386	f
165	220	10075	t
166	104	10140	t
167	1137	10580	t
168	1155	10288	t
169	195	10104	f
170	520	10346	f
171	227	10505	t
172	579	10319	t
173	40	10035	t
174	837	10206	t
175	255	10343	t
176	531	10389	t
177	1013	10161	t
178	749	10480	t
179	333	10236	t
180	200	10375	t
181	732	10437	t
182	565	10316	f
183	142	10212	f
184	1117	10283	t
185	471	10259	t
186	608	10595	t
187	1140	10346	t
188	1137	10444	t
189	633	10187	t
190	962	10257	t
191	971	10591	t
192	281	10470	f
193	708	10136	f
194	700	10243	t
195	333	10373	t
196	467	10559	t
197	665	10215	t
198	639	10505	t
199	136	10083	t
200	468	10241	t
201	1000	10368	t
202	874	10192	t
203	728	10309	t
204	810	10424	t
205	1001	10045	t
206	1078	10371	f
207	548	10229	t
208	512	10407	t
209	967	10212	f
210	1024	10213	t
211	173	10497	t
212	1033	10094	f
213	622	10501	t
214	966	10419	f
215	893	10464	t
216	624	10300	t
217	35	10340	t
218	34	10242	t
219	241	10288	t
220	115	10260	t
221	1102	10225	t
222	1100	10195	t
223	1118	10434	t
224	285	10561	t
225	732	10022	t
226	821	10500	t
227	458	10281	t
228	1159	10529	t
229	344	10271	t
230	219	10318	t
231	210	10478	f
232	916	10329	t
233	120	10599	t
234	255	10599	t
235	818	10234	t
236	324	10407	t
237	676	10071	f
238	307	10119	t
239	1029	10298	t
240	227	10408	f
241	976	10376	t
242	500	10067	t
243	958	10227	t
244	928	10435	t
245	294	10340	t
246	853	10212	t
247	1035	10502	t
248	994	10496	t
249	350	10355	t
250	355	10052	t
251	1050	10169	f
252	12	10010	t
253	374	10019	f
254	250	10208	t
255	114	10570	t
256	550	10417	t
257	910	10566	t
258	685	10099	t
259	903	10383	t
260	678	10326	t
261	956	10272	t
262	431	10522	t
263	252	10217	t
264	263	10382	t
265	520	10260	f
266	682	10007	f
267	559	10380	f
268	234	10077	t
269	1021	10400	t
270	764	10341	t
271	47	10234	t
272	621	10094	t
273	566	10416	t
274	650	10513	t
275	122	10112	t
276	382	10238	t
277	1064	10277	t
278	1156	10217	t
279	901	10198	f
280	134	10195	t
281	1043	10360	t
282	461	10580	t
283	794	10426	f
284	279	10398	t
285	507	10236	t
286	226	10564	t
287	1017	10516	t
288	1152	10161	t
289	291	10353	f
290	201	10474	t
291	977	10270	t
292	246	10554	t
293	1111	10312	t
294	737	10137	f
295	787	10541	f
296	131	10561	f
297	857	10553	t
298	91	10290	t
299	410	10120	t
300	787	10211	f
301	10	10243	f
302	703	10578	t
303	660	10361	t
304	1077	10431	t
305	149	10365	t
306	754	10474	t
307	837	10088	t
308	680	10376	t
309	718	10201	t
310	551	10574	t
311	829	10542	t
312	1138	10028	t
313	1030	10237	t
314	198	10051	t
315	1031	10159	f
316	1050	10028	t
317	1044	10270	t
318	559	10447	t
319	430	10034	t
320	1072	10125	t
321	751	10047	t
322	323	10531	t
323	859	10401	t
324	618	10583	t
325	892	10115	t
326	573	10488	t
327	523	10527	t
328	630	10534	t
329	848	10365	t
330	42	10470	t
331	919	10048	t
332	857	10165	t
333	309	10240	t
334	785	10284	t
335	654	10183	t
336	246	10025	t
337	619	10490	f
338	25	10062	t
339	1056	10479	f
340	493	10554	t
341	289	10176	t
342	791	10449	t
343	29	10422	t
344	451	10162	t
345	974	10195	f
346	789	10557	t
347	627	10338	t
348	744	10124	t
349	935	10110	t
350	728	10286	t
351	948	10084	t
352	154	10342	t
353	706	10205	t
354	845	10465	t
355	815	10066	f
356	1022	10289	t
357	371	10451	t
358	705	10201	t
359	1013	10555	t
360	988	10502	t
361	1043	10311	t
362	1094	10542	t
363	368	10470	t
364	998	10198	t
365	1071	10460	f
366	137	10022	t
367	682	10393	t
368	161	10060	t
369	612	10406	t
370	1011	10375	t
371	814	10346	t
372	833	10417	f
373	848	10592	t
374	1098	10235	t
375	1021	10093	t
376	592	10318	t
377	751	10325	t
378	27	10569	t
379	597	10054	t
380	864	10294	t
381	902	10495	t
382	747	10108	t
383	239	10399	t
384	664	10071	t
385	307	10047	t
386	549	10061	t
387	968	10037	t
388	351	10127	t
389	991	10260	t
390	835	10552	t
391	416	10574	t
392	121	10584	t
393	95	10103	f
394	677	10289	f
395	650	10253	t
396	481	10502	f
397	384	10225	f
398	1015	10260	t
399	899	10091	t
400	1112	10270	t
401	418	10412	f
402	32	10585	t
403	14	10457	t
404	357	10331	t
405	486	10596	t
406	581	10322	t
407	494	10241	t
408	501	10056	t
409	156	10482	t
410	344	10253	t
411	58	10359	t
412	772	10214	f
413	300	10576	t
414	1047	10523	f
415	939	10590	f
416	602	10191	t
417	1075	10226	t
418	926	10416	t
419	254	10146	t
420	576	10068	t
421	208	10329	t
422	714	10451	t
423	654	10398	f
424	120	10075	t
425	618	10025	t
426	703	10492	t
427	1155	10080	t
428	653	10151	t
429	844	10470	t
430	1156	10426	t
431	467	10042	t
432	240	10507	t
433	159	10097	f
434	111	10406	f
435	225	10081	t
436	145	10090	t
437	468	10333	t
438	1116	10158	t
439	779	10252	t
440	187	10394	t
441	8	10500	t
442	934	10244	t
443	1158	10449	t
444	1040	10022	t
445	697	10127	t
446	926	10161	t
447	586	10454	t
448	794	10271	t
449	582	10163	t
450	635	10133	t
451	60	10080	t
452	864	10390	t
453	766	10467	f
454	85	10461	t
455	233	10406	f
456	333	10340	t
457	569	10557	t
458	953	10436	t
459	968	10320	t
460	129	10137	f
461	575	10518	t
462	595	10581	t
463	22	10057	t
464	1023	10548	f
465	144	10273	t
466	1104	10396	t
467	558	10388	f
468	1104	10022	t
469	831	10477	t
470	222	10295	f
471	282	10036	t
472	538	10205	t
473	1058	10330	t
474	411	10474	t
475	45	10343	t
476	1093	10518	t
477	473	10538	f
478	1036	10280	t
479	85	10369	t
480	176	10597	f
481	7	10569	f
482	164	10090	t
483	428	10220	t
484	731	10110	t
485	943	10208	t
486	410	10050	t
487	655	10392	f
488	570	10532	t
489	616	10518	t
490	1124	10557	t
491	12	10139	t
492	1093	10077	t
493	52	10559	t
494	510	10402	t
495	959	10318	t
496	260	10270	t
497	1019	10472	t
498	1149	10385	t
499	482	10446	t
500	1092	10196	t
501	157	10536	t
502	598	10581	t
503	857	10187	t
504	677	10426	t
505	779	10045	f
506	475	10316	t
507	1033	10059	t
508	398	10466	t
509	712	10318	t
510	298	10171	t
511	186	10389	t
512	719	10505	t
513	280	10192	t
514	708	10325	t
515	661	10479	t
516	684	10234	f
517	86	10456	t
518	612	10107	t
519	675	10051	t
520	713	10374	t
521	566	10012	t
522	564	10324	t
523	1130	10032	t
524	852	10385	t
525	1059	10408	t
526	1155	10328	f
527	722	10315	t
528	1100	10224	t
529	348	10357	t
530	39	10153	t
531	477	10093	t
532	66	10002	t
533	598	10072	t
534	547	10234	t
535	1086	10428	t
536	370	10575	t
537	1055	10038	t
538	365	10438	f
539	647	10544	f
540	880	10554	f
541	858	10466	t
542	1104	10516	t
543	1162	10573	t
544	547	10253	t
545	656	10546	t
546	482	10169	t
547	1086	10581	t
548	1060	10432	t
549	914	10163	f
550	802	10116	t
551	61	10496	t
552	1149	10129	t
553	472	10025	t
554	752	10294	f
555	246	10483	f
556	403	10339	t
557	27	10190	t
558	791	10507	t
559	786	10302	t
560	711	10343	t
561	102	10113	t
562	150	10000	t
563	307	10013	t
564	85	10538	f
565	666	10067	f
566	767	10150	t
567	583	10086	t
568	1140	10041	t
569	81	10356	f
570	328	10510	t
571	259	10136	t
572	120	10591	t
573	558	10314	f
574	945	10245	t
575	1084	10129	t
576	725	10002	t
577	51	10547	t
578	958	10249	t
579	135	10229	t
580	1007	10278	t
581	1028	10073	f
582	272	10545	t
583	857	10236	t
584	405	10564	t
585	1004	10356	t
586	1117	10196	t
587	324	10315	f
588	104	10161	f
589	1162	10102	t
590	160	10540	f
591	636	10480	t
592	269	10179	t
593	970	10525	t
594	924	10228	t
595	68	10436	t
596	644	10064	f
597	792	10047	t
598	353	10234	t
599	297	10561	t
600	1003	10482	t
601	236	10489	t
602	753	10346	t
603	629	10396	t
604	90	10561	t
605	289	10424	t
606	1111	10176	t
607	476	10464	t
608	265	10240	t
609	35	10456	t
610	20	10291	f
611	860	10030	t
612	498	10030	f
613	99	10541	t
614	1020	10016	t
615	191	10260	t
616	55	10552	t
617	966	10516	f
618	325	10289	t
619	1006	10409	t
620	583	10594	t
621	977	10495	t
622	578	10554	t
623	544	10405	t
624	1147	10373	t
625	1031	10245	t
626	97	10050	t
627	414	10533	t
628	330	10239	t
629	518	10287	f
630	659	10561	t
631	808	10507	t
632	1119	10429	t
633	408	10157	t
634	853	10137	f
635	1111	10001	f
636	218	10030	t
637	823	10180	t
638	972	10200	t
639	1157	10149	t
640	295	10080	t
641	748	10454	t
642	672	10321	t
643	839	10511	t
644	702	10516	t
645	746	10245	t
646	641	10000	t
647	1062	10376	t
648	25	10094	t
649	92	10263	t
650	461	10362	t
651	390	10251	t
652	642	10358	f
653	781	10003	t
654	1152	10143	t
655	940	10528	t
656	819	10225	t
657	1137	10415	t
658	31	10201	t
659	139	10593	t
660	509	10078	t
661	1007	10514	t
662	1042	10151	t
663	847	10332	t
664	1059	10138	t
665	592	10437	t
666	1030	10043	t
667	1155	10125	t
668	906	10585	t
669	524	10502	f
670	507	10099	t
671	724	10063	t
672	165	10341	t
673	276	10279	t
674	863	10019	t
675	92	10000	t
676	597	10140	t
677	1143	10307	t
678	960	10169	t
679	700	10151	f
680	706	10270	f
681	338	10337	f
682	404	10228	t
683	487	10219	t
684	533	10267	t
685	229	10464	t
686	986	10137	t
687	890	10069	t
688	680	10247	t
689	311	10136	f
690	83	10064	t
691	61	10046	t
692	692	10235	t
693	1043	10154	t
694	441	10134	t
695	727	10137	f
696	130	10201	t
697	1159	10126	t
698	424	10124	t
699	932	10288	t
700	809	10412	t
701	8	10227	f
702	898	10353	t
703	992	10040	t
704	1131	10065	t
705	539	10446	t
706	407	10156	t
707	248	10481	t
708	327	10238	t
709	469	10035	t
710	626	10443	t
711	1154	10280	t
712	266	10498	t
713	345	10107	t
714	8	10110	f
715	1088	10494	t
716	1032	10080	t
717	810	10430	t
718	727	10558	t
719	1030	10248	t
720	1001	10299	t
721	783	10127	t
722	554	10312	t
723	1016	10351	t
724	439	10358	t
725	934	10537	f
726	324	10241	t
727	584	10141	t
728	156	10512	t
729	1111	10370	t
730	175	10124	t
731	752	10095	f
732	630	10027	t
733	190	10493	t
734	1052	10453	t
735	156	10253	t
736	296	10526	t
737	767	10032	t
738	1148	10286	t
739	182	10514	t
740	1022	10242	t
741	1077	10071	t
742	769	10401	t
743	451	10026	t
744	641	10297	t
745	476	10104	t
746	1020	10077	t
747	722	10069	t
748	1097	10246	t
749	832	10301	f
750	289	10570	t
751	392	10132	f
752	360	10320	t
753	1056	10287	t
754	692	10473	t
755	840	10158	t
756	240	10226	t
757	380	10278	t
758	1046	10266	f
759	702	10467	t
760	160	10358	t
761	631	10469	t
762	432	10485	t
763	1105	10480	t
764	956	10393	t
765	393	10526	f
766	31	10134	t
767	789	10597	t
768	798	10107	t
769	254	10059	f
770	729	10294	t
771	728	10506	f
772	333	10119	t
773	280	10000	f
774	232	10587	t
775	301	10248	f
776	250	10599	t
777	560	10303	t
778	1068	10042	f
779	50	10387	t
780	803	10335	t
781	263	10268	t
782	694	10396	t
783	1160	10375	t
784	215	10586	t
785	540	10001	f
786	835	10256	t
787	469	10228	t
788	867	10005	t
789	54	10409	t
790	176	10051	f
791	633	10182	t
792	920	10257	t
793	941	10216	t
794	761	10454	t
795	584	10483	t
796	406	10188	f
797	188	10193	t
798	480	10164	t
799	900	10043	f
800	629	10271	t
801	128	10430	t
802	1134	10379	t
803	660	10106	t
804	451	10296	t
805	31	10118	t
806	696	10271	f
807	355	10130	f
808	642	10132	t
809	550	10538	t
810	1021	10032	t
811	360	10413	t
812	1092	10586	t
813	821	10023	f
814	554	10158	f
815	1048	10400	t
816	458	10486	t
817	434	10081	t
818	792	10122	f
819	677	10054	t
820	405	10199	t
821	802	10088	t
822	522	10012	t
823	365	10553	t
824	860	10320	t
825	589	10040	t
826	225	10192	t
827	783	10036	t
828	988	10532	f
829	453	10028	t
830	755	10308	t
831	526	10185	t
832	429	10577	t
833	1121	10404	t
834	871	10509	t
835	495	10304	t
836	102	10182	t
837	291	10387	t
838	400	10423	t
839	131	10250	t
840	1135	10364	t
841	812	10110	t
842	494	10383	f
843	885	10490	t
844	304	10273	t
845	942	10470	t
846	313	10457	t
847	13	10101	t
848	468	10164	t
849	506	10506	t
850	885	10160	t
851	401	10472	t
852	379	10139	f
853	43	10149	t
854	436	10363	t
855	858	10155	t
856	863	10019	t
857	396	10117	t
858	568	10580	t
859	244	10276	t
860	375	10167	t
861	5	10564	t
862	829	10460	t
863	307	10312	t
864	780	10159	t
865	764	10187	t
866	462	10023	t
867	766	10314	f
868	34	10491	f
869	422	10412	t
870	501	10078	t
871	155	10535	t
872	653	10386	t
873	528	10365	t
874	136	10177	t
875	190	10501	t
876	400	10249	t
877	464	10572	t
878	118	10186	t
879	417	10393	t
880	91	10254	t
881	841	10033	f
882	156	10372	f
883	901	10396	f
884	873	10597	t
885	122	10514	t
886	842	10104	t
887	594	10337	t
888	146	10178	t
889	224	10532	f
890	1114	10038	t
891	4	10370	t
892	600	10340	t
893	174	10039	t
894	154	10010	t
895	738	10029	t
896	894	10013	t
897	583	10167	t
898	1049	10215	t
899	752	10405	t
900	91	10362	t
901	230	10372	t
902	405	10506	t
903	29	10149	t
904	512	10354	t
905	568	10548	f
906	516	10133	t
907	299	10036	t
908	412	10384	t
909	440	10440	t
910	861	10094	t
911	271	10126	t
912	932	10024	t
913	375	10550	t
914	407	10466	t
915	105	10127	t
916	448	10163	t
917	771	10012	t
918	61	10116	f
919	148	10095	f
920	1094	10230	t
921	593	10548	t
922	584	10069	t
923	560	10024	t
924	970	10551	t
925	779	10191	t
926	168	10169	t
927	276	10028	t
928	662	10131	t
929	284	10590	f
930	249	10386	t
931	1134	10530	t
932	762	10326	t
933	1131	10247	t
934	291	10011	t
935	139	10263	t
936	935	10461	t
937	730	10210	t
938	683	10413	t
939	667	10474	t
940	95	10566	t
941	796	10233	t
942	815	10095	t
943	1102	10204	f
944	1071	10280	t
945	822	10437	t
946	187	10011	t
947	744	10176	t
948	146	10004	t
949	637	10508	t
950	960	10410	t
951	479	10176	t
952	1086	10220	t
953	966	10098	t
954	513	10253	t
955	312	10028	t
956	1038	10237	t
957	204	10593	t
958	698	10596	t
959	1018	10536	t
960	16	10291	f
961	304	10254	f
962	796	10340	t
963	564	10034	t
964	144	10441	t
965	691	10493	f
966	1130	10336	t
967	580	10283	t
968	1062	10183	t
969	397	10435	t
970	903	10389	t
971	343	10061	t
972	437	10517	t
973	620	10422	t
974	387	10058	t
975	1119	10079	t
976	1118	10319	f
977	536	10026	f
978	60	10048	t
979	962	10501	f
980	291	10340	t
981	229	10177	t
982	438	10348	t
983	890	10131	t
984	117	10214	t
985	750	10351	t
986	1110	10040	t
987	1158	10121	t
988	462	10014	t
989	165	10576	t
990	577	10486	f
991	185	10088	t
992	989	10498	t
993	229	10307	f
994	25	10384	t
995	428	10163	t
996	165	10212	t
997	1061	10587	t
998	1135	10535	f
999	905	10416	t
1000	671	10049	t
1001	10	10038	t
1002	227	10593	t
1003	849	10215	t
1004	1035	10155	t
1005	1016	10198	t
1006	520	10201	t
1007	216	10275	t
1008	1159	10310	f
1009	309	10163	f
1010	783	10572	t
1011	722	10422	f
1012	182	10584	t
1013	94	10490	t
1014	749	10219	t
1015	984	10301	t
1016	144	10457	t
1017	1139	10527	t
1018	707	10578	t
1019	714	10129	t
1020	753	10321	t
1021	1031	10295	t
1022	597	10264	t
1023	79	10287	t
1024	910	10495	t
1025	798	10350	t
1026	129	10402	f
1027	1083	10295	t
1028	799	10244	t
1029	789	10196	t
1030	962	10471	t
1031	877	10386	t
1032	671	10296	t
1033	1165	10263	t
1034	665	10004	t
1035	964	10528	t
1036	845	10400	f
1037	831	10077	f
1038	208	10154	t
1039	554	10226	t
1040	912	10494	t
1041	999	10030	t
1042	138	10331	t
1043	84	10011	t
1044	885	10360	t
1045	594	10356	f
1046	611	10137	t
1047	44	10505	t
1048	699	10369	t
1049	696	10579	t
1050	135	10573	t
1051	1144	10226	f
1052	415	10322	t
1053	1076	10150	t
1054	952	10105	t
1055	637	10028	t
1056	279	10044	t
1057	913	10541	t
1058	367	10557	t
1059	1167	10021	t
1060	768	10180	f
1061	318	10481	t
1062	706	10495	f
1063	363	10553	t
1064	901	10280	t
1065	297	10113	t
1066	679	10450	t
1067	152	10191	t
1068	391	10068	f
1069	1015	10557	f
1070	719	10064	f
1071	272	10439	t
1072	1020	10405	f
1073	766	10419	t
1074	858	10365	t
1075	1032	10441	f
1076	1036	10140	f
1077	785	10128	t
1078	332	10483	t
1079	1077	10132	f
1080	262	10121	t
1081	260	10014	t
1082	179	10532	f
1083	798	10354	t
1084	567	10594	f
1085	613	10018	f
1086	238	10388	t
1087	772	10479	t
1088	1079	10082	t
1089	142	10155	t
1090	1161	10249	t
1091	249	10036	t
1092	658	10192	t
1093	611	10034	t
1094	195	10376	t
1095	366	10143	t
1096	864	10587	t
1097	923	10532	t
1098	922	10236	t
1099	179	10087	t
1100	39	10593	f
1101	996	10187	t
1102	1143	10185	t
1103	93	10570	t
1104	851	10263	t
1105	283	10151	t
1106	758	10152	t
1107	927	10064	t
1108	1043	10461	t
1109	969	10539	t
1110	328	10263	t
1111	914	10530	t
1112	867	10142	t
1113	22	10415	t
1114	374	10067	t
1115	885	10514	t
1116	880	10066	t
1117	954	10185	t
1118	576	10142	t
1119	1132	10074	f
1120	304	10158	f
1121	820	10430	t
1122	666	10052	t
1123	465	10027	t
1124	1146	10587	t
1125	686	10179	t
1126	463	10392	t
1127	257	10501	t
1128	1133	10044	t
1129	135	10059	t
1130	820	10342	t
1131	667	10527	t
1132	704	10302	t
1133	28	10376	t
1134	128	10446	t
1135	1049	10228	t
1136	52	10029	t
1137	483	10299	t
1138	675	10529	t
1139	71	10548	t
1140	1110	10262	t
1141	724	10148	t
1142	422	10186	t
1143	773	10355	t
1144	952	10015	f
1145	484	10058	t
1146	973	10245	t
1147	1115	10595	t
1148	946	10349	t
1149	647	10419	t
1150	773	10215	t
1151	927	10265	t
1152	536	10360	t
1153	849	10473	t
1154	118	10409	t
1155	76	10407	t
1156	361	10289	t
1157	1128	10230	t
1158	991	10143	t
1159	29	10517	t
1160	385	10260	t
1161	651	10184	f
1162	34	10154	t
1163	8	10149	t
1164	1113	10165	t
1165	623	10172	f
1166	900	10163	t
1167	726	10083	t
1168	808	10526	t
1169	356	10362	t
1170	1048	10256	f
1171	223	10388	t
1172	25	10181	t
1173	759	10482	t
1174	698	10266	t
1175	205	10044	t
1176	526	10101	t
1177	313	10023	t
1178	1073	10546	t
1179	430	10210	t
1180	517	10065	t
1181	56	10277	t
1182	339	10186	t
1183	187	10590	f
1184	623	10011	t
1185	67	10556	f
1186	492	10034	t
1187	720	10271	t
1188	358	10494	t
1189	14	10527	t
1190	801	10465	t
1191	168	10455	t
1192	968	10202	t
1193	1149	10559	t
1194	241	10306	t
1195	349	10558	f
1196	795	10121	t
1197	991	10195	t
1198	1100	10068	f
1199	998	10022	t
1200	118	10326	f
1201	871	10487	t
1202	563	10534	t
1203	899	10229	f
1204	1158	10019	t
1205	782	10081	t
1206	230	10311	t
1207	157	10159	f
1208	892	10506	t
1209	95	10350	t
1210	1130	10192	t
1211	860	10089	t
1212	369	10065	t
1213	77	10219	f
1214	642	10441	t
1215	266	10243	t
1216	22	10381	t
1217	303	10497	t
1218	457	10410	t
1219	1003	10244	t
1220	439	10228	t
1221	29	10242	t
1222	602	10211	t
1223	37	10469	t
1224	710	10572	t
1225	680	10317	t
1226	1119	10419	t
1227	8	10544	t
1228	70	10573	f
1229	473	10034	t
1230	845	10535	t
1231	826	10440	f
1232	330	10050	t
1233	117	10281	t
1234	773	10073	t
1235	928	10445	t
1236	625	10162	t
1237	274	10014	t
1238	846	10175	t
1239	992	10217	t
1240	1060	10137	t
1241	878	10394	t
1242	670	10072	t
1243	439	10535	t
1244	756	10270	t
1245	172	10183	t
1246	1107	10178	t
1247	663	10506	t
1248	898	10477	t
1249	369	10369	t
1250	989	10039	t
1251	115	10312	f
1252	325	10174	f
1253	291	10255	t
1254	350	10568	t
1255	117	10528	t
1256	1056	10321	t
1257	695	10273	t
1258	185	10381	t
1259	952	10565	t
1260	715	10244	t
1261	1146	10480	t
1262	631	10292	f
1263	532	10390	f
1264	635	10243	t
1265	190	10350	t
1266	840	10172	t
1267	669	10253	t
1268	131	10303	t
1269	389	10026	t
1270	491	10564	t
1271	932	10186	t
1272	178	10506	t
1273	782	10105	t
1274	512	10431	t
1275	347	10497	t
1276	658	10093	t
1277	321	10325	f
1278	361	10584	f
1279	66	10597	f
1280	919	10255	t
1281	494	10467	f
1282	274	10173	t
1283	272	10409	t
1284	439	10240	t
1285	1167	10326	t
1286	780	10510	t
1287	4	10109	t
1288	146	10108	f
1289	737	10144	t
1290	1014	10103	t
1291	369	10396	t
1292	836	10114	t
1293	877	10330	t
1294	1133	10050	f
1295	983	10541	t
1296	890	10241	t
1297	996	10145	t
1298	32	10564	t
1299	210	10539	t
1300	501	10247	t
1301	448	10330	t
1302	851	10317	t
1303	596	10184	t
1304	396	10465	t
1305	227	10429	t
1306	247	10277	t
1307	127	10385	t
1308	222	10395	t
1309	378	10332	t
1310	146	10281	f
1311	9	10350	t
1312	623	10535	t
1313	893	10112	t
1314	42	10584	t
1315	409	10172	t
1316	897	10254	f
1317	705	10503	t
1318	665	10187	t
1319	563	10569	t
1320	954	10373	t
1321	409	10438	t
1322	31	10345	t
1323	571	10584	t
1324	581	10420	t
1325	851	10048	t
1326	406	10224	t
1327	129	10282	t
1328	277	10046	t
1329	368	10172	t
1330	1047	10571	t
1331	942	10138	t
1332	239	10288	t
1333	96	10496	t
1334	1067	10324	t
1335	479	10321	t
1336	282	10523	f
1337	146	10449	t
1338	1063	10089	f
1339	100	10554	t
1340	217	10540	t
1341	903	10099	t
1342	1117	10051	f
1343	724	10122	t
1344	1082	10164	t
1345	682	10578	t
1346	671	10249	t
1347	183	10131	t
1348	905	10153	t
1349	148	10451	t
1350	696	10054	f
1351	217	10452	t
1352	894	10061	t
1353	335	10143	t
1354	468	10151	t
1355	918	10230	t
1356	54	10550	t
1357	624	10150	t
1358	1164	10596	t
1359	829	10278	f
1360	162	10315	f
1361	585	10316	t
1362	911	10477	t
1363	1138	10455	t
1364	1127	10175	t
1365	1038	10168	t
1366	677	10199	t
1367	726	10314	t
1368	590	10180	t
1369	569	10236	f
1370	331	10345	f
1371	498	10297	t
1372	462	10201	t
1373	572	10077	t
1374	506	10566	t
1375	1134	10099	t
1376	874	10191	t
1377	66	10522	t
1378	653	10082	t
1379	129	10427	t
1380	1007	10016	t
1381	380	10155	t
1382	1117	10448	t
1383	138	10050	t
1384	366	10013	f
1385	207	10413	t
1386	1037	10546	t
1387	21	10109	t
1388	506	10592	f
1389	29	10138	t
1390	712	10124	t
1391	1113	10154	t
1392	262	10073	t
1393	167	10346	t
1394	344	10066	t
1395	229	10554	t
1396	342	10300	t
1397	356	10563	t
1398	576	10056	t
1399	1038	10258	t
1400	184	10540	t
1401	1007	10475	f
1402	355	10249	t
1403	325	10392	t
1404	1161	10157	t
1405	323	10526	t
1406	768	10041	t
1407	427	10236	f
1408	914	10300	t
1409	1127	10300	t
1410	410	10049	f
1411	163	10420	t
1412	742	10455	t
1413	706	10472	f
1414	980	10536	t
1415	1005	10370	t
1416	854	10338	t
1417	237	10026	t
1418	939	10560	t
1419	1111	10594	t
1420	908	10018	f
1421	88	10066	t
1422	722	10335	t
1423	79	10567	t
1424	420	10449	t
1425	939	10582	t
1426	788	10471	t
1427	308	10199	t
1428	457	10565	f
1429	942	10291	f
1430	75	10141	t
1431	46	10283	t
1432	1033	10513	t
1433	644	10139	t
1434	162	10043	t
1435	74	10019	t
1436	400	10577	f
1437	282	10279	t
1438	741	10291	t
1439	574	10521	f
1440	57	10007	t
1441	148	10036	t
1442	1122	10073	t
1443	89	10542	t
1444	854	10232	t
1445	1123	10310	t
1446	725	10063	t
1447	38	10295	t
1448	514	10306	t
1449	328	10003	t
1450	500	10235	t
1451	18	10003	t
1452	452	10206	t
1453	199	10094	t
1454	347	10155	t
1455	513	10193	f
1456	953	10258	t
1457	197	10155	f
1458	680	10066	t
1459	832	10508	t
1460	18	10249	t
1461	1008	10067	t
1462	112	10470	t
1463	487	10538	t
1464	552	10145	t
1465	572	10385	t
1466	403	10291	t
1467	402	10542	t
1468	1111	10026	t
1469	183	10291	t
1470	461	10114	t
1471	1158	10519	t
1472	1098	10080	t
1473	998	10521	t
1474	460	10329	t
1475	537	10012	t
1476	727	10011	t
1477	788	10297	t
1478	301	10071	f
1479	45	10008	t
\.


--
-- Data for Name: cursos_programados; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cursos_programados (id_curso_programado, id_curso, id_plan_maestro, anio_fiscal, semana, fecha_inicio, fecha_fin, estatus) FROM stdin;
1	1	1	2024	13	2024-03-25	2024-03-29	Completado
2	2	1	2024	1	2024-01-01	2024-01-05	Cancelado
3	3	1	2024	9	2024-02-26	2024-02-29	Programado
4	3	1	2024	46	2024-11-11	2024-11-12	Programado
5	3	1	2024	50	2024-12-09	2024-12-11	Completado
6	4	3	2026	18	2026-04-30	2026-05-02	Completado
7	4	3	2026	46	2026-11-12	2026-11-13	En curso
8	4	3	2026	49	2026-12-03	2026-12-06	Cancelado
9	5	4	2024	23	2024-06-03	2024-06-08	Completado
10	5	4	2024	29	2024-07-15	2024-07-19	Completado
11	6	4	2024	15	2024-04-08	2024-04-13	Completado
12	6	4	2024	41	2024-10-07	2024-10-12	Programado
13	6	4	2024	9	2024-02-26	2024-03-02	Completado
14	7	5	2025	7	2025-02-12	2025-02-15	Completado
15	7	5	2025	23	2025-06-04	2025-06-05	Completado
16	7	5	2025	6	2025-02-05	2025-02-08	Completado
17	8	5	2025	13	2025-03-26	2025-03-27	Completado
18	8	5	2025	36	2025-09-03	2025-09-07	Completado
19	9	8	2025	40	2025-10-01	2025-10-03	Completado
20	9	8	2025	41	2025-10-08	2025-10-09	Programado
21	10	9	2026	50	2026-12-10	2026-12-11	Programado
22	11	8	2025	33	2025-08-13	2025-08-15	Completado
23	12	8	2025	37	2025-09-10	2025-09-14	Completado
24	12	8	2025	48	2025-11-26	2025-12-01	Completado
25	12	8	2025	19	2025-05-07	2025-05-12	Completado
26	13	7	2024	28	2024-07-08	2024-07-10	Completado
27	14	7	2024	2	2024-01-08	2024-01-10	Completado
28	14	7	2024	22	2024-05-27	2024-05-29	Programado
29	14	7	2024	16	2024-04-15	2024-04-19	Completado
30	15	10	2024	27	2024-07-01	2024-07-05	Completado
31	16	12	2026	43	2026-10-22	2026-10-26	Cancelado
32	16	12	2026	6	2026-02-05	2026-02-08	Programado
33	16	12	2026	44	2026-10-29	2026-11-01	Completado
34	17	10	2024	40	2024-09-30	2024-10-03	Completado
35	17	10	2024	27	2024-07-01	2024-07-04	Completado
36	18	15	2026	26	2026-06-25	2026-06-27	Programado
37	18	15	2026	25	2026-06-18	2026-06-23	En curso
38	18	15	2026	32	2026-08-06	2026-08-07	En curso
39	19	14	2025	21	2025-05-21	2025-05-23	Completado
40	19	14	2025	49	2025-12-03	2025-12-07	Completado
41	20	14	2025	6	2025-02-05	2025-02-06	Completado
42	20	14	2025	41	2025-10-08	2025-10-13	Completado
43	20	14	2025	5	2025-01-29	2025-01-31	Completado
44	21	13	2024	20	2024-05-13	2024-05-17	Completado
45	22	17	2025	49	2025-12-03	2025-12-06	Completado
46	22	17	2025	26	2025-06-25	2025-06-30	Programado
47	23	16	2024	46	2024-11-11	2024-11-13	Completado
48	23	16	2024	49	2024-12-02	2024-12-07	Completado
49	23	16	2024	48	2024-11-25	2024-11-30	Cancelado
50	24	17	2025	49	2025-12-03	2025-12-04	Completado
51	24	17	2025	36	2025-09-03	2025-09-05	Programado
52	25	16	2024	50	2024-12-09	2024-12-11	Completado
53	25	16	2024	51	2024-12-16	2024-12-21	Completado
54	25	16	2024	42	2024-10-14	2024-10-15	Completado
55	26	16	2024	12	2024-03-18	2024-03-19	Programado
56	26	16	2024	6	2024-02-05	2024-02-07	Completado
57	27	19	2024	33	2024-08-12	2024-08-16	Cancelado
58	27	19	2024	24	2024-06-10	2024-06-15	Completado
59	27	19	2024	47	2024-11-18	2024-11-19	Completado
60	28	21	2026	7	2026-02-12	2026-02-17	En curso
61	28	21	2026	14	2026-04-02	2026-04-06	En curso
62	28	21	2026	40	2026-10-01	2026-10-05	Programado
63	29	21	2026	6	2026-02-05	2026-02-08	Completado
64	30	21	2026	52	2026-12-24	2026-12-28	Completado
65	30	21	2026	23	2026-06-04	2026-06-05	Cancelado
66	31	23	2025	52	2025-12-24	2025-12-28	Completado
67	31	23	2025	12	2025-03-19	2025-03-23	Completado
68	31	23	2025	7	2025-02-12	2025-02-16	Completado
69	32	22	2024	31	2024-07-29	2024-07-31	Completado
70	32	22	2024	18	2024-04-29	2024-05-02	Completado
71	33	23	2025	47	2025-11-19	2025-11-24	Completado
72	33	23	2025	39	2025-09-24	2025-09-25	Completado
73	34	27	2026	9	2026-02-26	2026-02-28	Completado
74	35	25	2024	18	2024-04-29	2024-05-03	Completado
75	35	25	2024	36	2024-09-02	2024-09-04	Completado
76	36	27	2026	24	2026-06-11	2026-06-12	En curso
77	36	27	2026	42	2026-10-15	2026-10-20	Programado
78	37	27	2026	7	2026-02-12	2026-02-13	Completado
79	37	27	2026	33	2026-08-13	2026-08-17	Completado
80	37	27	2026	6	2026-02-05	2026-02-07	Cancelado
81	38	25	2024	10	2024-03-04	2024-03-08	Completado
82	39	27	2026	38	2026-09-17	2026-09-21	En curso
83	39	27	2026	28	2026-07-09	2026-07-14	Completado
84	39	27	2026	45	2026-11-05	2026-11-09	Cancelado
85	40	30	2026	23	2026-06-04	2026-06-07	Completado
86	40	30	2026	20	2026-05-14	2026-05-18	Completado
87	41	28	2024	52	2024-12-23	2024-12-25	Completado
88	41	28	2024	3	2024-01-15	2024-01-16	Completado
89	42	32	2025	3	2025-01-15	2025-01-17	Completado
90	42	32	2025	35	2025-08-27	2025-08-30	Completado
91	42	32	2025	32	2025-08-06	2025-08-10	Completado
92	43	33	2026	2	2026-01-08	2026-01-12	Completado
93	44	36	2026	19	2026-05-07	2026-05-11	Programado
94	44	36	2026	32	2026-08-06	2026-08-07	Cancelado
95	45	34	2024	40	2024-09-30	2024-10-03	Completado
96	46	34	2024	21	2024-05-20	2024-05-23	Completado
97	46	34	2024	46	2024-11-11	2024-11-13	Completado
98	47	35	2025	4	2025-01-22	2025-01-25	Completado
99	47	35	2025	32	2025-08-06	2025-08-11	Completado
100	48	34	2024	35	2024-08-26	2024-08-31	Completado
101	48	34	2024	36	2024-09-02	2024-09-05	Completado
102	48	34	2024	27	2024-07-01	2024-07-04	Completado
103	49	37	2024	1	2024-01-01	2024-01-03	Completado
104	49	37	2024	41	2024-10-07	2024-10-11	Completado
105	50	39	2026	20	2026-05-14	2026-05-19	En curso
106	51	40	2024	4	2024-01-22	2024-01-26	Completado
107	52	42	2026	33	2026-08-13	2026-08-15	Programado
108	52	42	2026	3	2026-01-15	2026-01-17	Completado
109	53	40	2024	4	2024-01-22	2024-01-25	Completado
110	53	40	2024	22	2024-05-27	2024-05-28	Completado
111	54	42	2026	43	2026-10-22	2026-10-24	Cancelado
112	54	42	2026	21	2026-05-21	2026-05-23	Programado
113	54	42	2026	47	2026-11-19	2026-11-23	Programado
114	55	43	2024	4	2024-01-22	2024-01-25	Completado
115	56	43	2024	28	2024-07-08	2024-07-09	Completado
116	56	43	2024	18	2024-04-29	2024-05-03	Completado
117	56	43	2024	47	2024-11-18	2024-11-23	Completado
118	57	44	2025	47	2025-11-19	2025-11-24	Completado
119	57	44	2025	34	2025-08-20	2025-08-24	Completado
120	58	48	2026	43	2026-10-22	2026-10-27	En curso
121	58	48	2026	9	2026-02-26	2026-03-01	En curso
122	58	48	2026	18	2026-04-30	2026-05-04	Programado
123	59	48	2026	35	2026-08-27	2026-08-30	En curso
124	59	48	2026	41	2026-10-08	2026-10-11	Completado
125	59	48	2026	30	2026-07-23	2026-07-25	En curso
126	60	47	2025	23	2025-06-04	2025-06-05	Completado
127	61	50	2025	47	2025-11-19	2025-11-21	Completado
128	61	50	2025	46	2025-11-12	2025-11-14	Completado
129	62	49	2024	10	2024-03-04	2024-03-09	Completado
130	62	49	2024	47	2024-11-18	2024-11-19	Completado
131	62	49	2024	28	2024-07-08	2024-07-09	Completado
132	63	51	2026	51	2026-12-17	2026-12-19	En curso
133	63	51	2026	43	2026-10-22	2026-10-25	Cancelado
134	63	51	2026	1	2026-01-01	2026-01-02	Programado
135	64	54	2026	44	2026-10-29	2026-11-01	En curso
136	64	54	2026	37	2026-09-10	2026-09-13	Programado
137	64	54	2026	37	2026-09-10	2026-09-11	Programado
138	65	2	2025	46	2025-11-12	2025-11-13	Completado
139	65	2	2025	32	2025-08-06	2025-08-08	Completado
140	65	2	2025	52	2025-12-24	2025-12-27	Completado
141	66	3	2026	43	2026-10-22	2026-10-23	Completado
142	66	3	2026	20	2026-05-14	2026-05-19	En curso
143	67	4	2024	18	2024-04-29	2024-05-04	Completado
144	68	4	2024	9	2024-02-26	2024-03-01	Completado
145	68	4	2024	17	2024-04-22	2024-04-25	Programado
146	68	4	2024	50	2024-12-09	2024-12-13	Completado
147	69	6	2026	41	2026-10-08	2026-10-13	En curso
148	69	6	2026	48	2026-11-26	2026-12-01	Completado
149	70	5	2025	25	2025-06-18	2025-06-19	Completado
150	71	6	2026	16	2026-04-16	2026-04-19	Programado
151	71	6	2026	51	2026-12-17	2026-12-21	Programado
152	71	6	2026	36	2026-09-03	2026-09-05	Programado
153	72	8	2025	26	2025-06-25	2025-06-30	Completado
154	73	10	2024	1	2024-01-01	2024-01-02	Completado
155	73	10	2024	39	2024-09-23	2024-09-24	Completado
156	73	10	2024	35	2024-08-26	2024-08-29	Completado
157	74	10	2024	31	2024-07-29	2024-08-03	Completado
158	75	13	2024	1	2024-01-01	2024-01-02	Completado
159	75	13	2024	9	2024-02-26	2024-02-28	Completado
160	76	14	2025	12	2025-03-19	2025-03-24	Completado
161	76	14	2025	3	2025-01-15	2025-01-18	Completado
162	77	15	2026	7	2026-02-12	2026-02-14	Completado
163	77	15	2026	1	2026-01-01	2026-01-03	Completado
164	77	15	2026	50	2026-12-10	2026-12-15	En curso
165	78	13	2024	41	2024-10-07	2024-10-08	Completado
166	79	16	2024	23	2024-06-03	2024-06-07	Completado
167	79	16	2024	37	2024-09-09	2024-09-14	Programado
168	80	18	2026	22	2026-05-28	2026-05-31	En curso
169	80	18	2026	1	2026-01-01	2026-01-04	Completado
170	81	16	2024	21	2024-05-20	2024-05-25	Completado
171	81	16	2024	15	2024-04-08	2024-04-13	Completado
172	81	16	2024	1	2024-01-01	2024-01-02	Completado
173	82	20	2025	19	2025-05-07	2025-05-08	Completado
174	82	20	2025	4	2025-01-22	2025-01-23	Completado
175	83	21	2026	36	2026-09-03	2026-09-05	Cancelado
176	83	21	2026	8	2026-02-19	2026-02-20	En curso
177	83	21	2026	43	2026-10-22	2026-10-26	Programado
178	84	19	2024	48	2024-11-25	2024-11-30	Completado
179	85	24	2026	37	2026-09-10	2026-09-13	Programado
180	86	22	2024	4	2024-01-22	2024-01-24	Completado
181	86	22	2024	13	2024-03-25	2024-03-27	Cancelado
182	87	23	2025	27	2025-07-02	2025-07-04	Cancelado
183	88	25	2024	22	2024-05-27	2024-06-01	Completado
184	88	25	2024	28	2024-07-08	2024-07-09	Completado
185	89	25	2024	50	2024-12-09	2024-12-14	Programado
186	89	25	2024	39	2024-09-23	2024-09-26	Completado
187	90	25	2024	48	2024-11-25	2024-11-30	Completado
188	90	25	2024	12	2024-03-18	2024-03-19	Completado
189	91	26	2025	32	2025-08-06	2025-08-08	Completado
190	91	26	2025	36	2025-09-03	2025-09-05	Completado
191	92	27	2026	51	2026-12-17	2026-12-20	Cancelado
192	93	26	2025	44	2025-10-29	2025-10-30	Completado
193	94	30	2026	13	2026-03-26	2026-03-29	En curso
194	94	30	2026	43	2026-10-22	2026-10-24	En curso
195	95	28	2024	10	2024-03-04	2024-03-06	Completado
196	96	30	2026	24	2026-06-11	2026-06-15	Completado
197	97	33	2026	15	2026-04-09	2026-04-13	En curso
198	97	33	2026	45	2026-11-05	2026-11-09	En curso
199	97	33	2026	38	2026-09-17	2026-09-20	Completado
200	98	33	2026	18	2026-04-30	2026-05-01	En curso
201	98	33	2026	18	2026-04-30	2026-05-02	Programado
202	99	31	2024	49	2024-12-02	2024-12-07	Completado
203	99	31	2024	8	2024-02-19	2024-02-22	Completado
204	99	31	2024	6	2024-02-05	2024-02-10	Completado
205	100	34	2024	31	2024-07-29	2024-08-01	Completado
206	101	34	2024	24	2024-06-10	2024-06-15	Programado
207	101	34	2024	15	2024-04-08	2024-04-10	Completado
208	101	34	2024	21	2024-05-20	2024-05-24	Completado
209	102	34	2024	27	2024-07-01	2024-07-03	Completado
210	103	35	2025	21	2025-05-21	2025-05-24	Completado
211	103	35	2025	16	2025-04-16	2025-04-20	Completado
212	104	34	2024	47	2024-11-18	2024-11-20	Completado
213	105	36	2026	49	2026-12-03	2026-12-08	Programado
214	105	36	2026	27	2026-07-02	2026-07-06	Programado
215	106	38	2025	17	2025-04-23	2025-04-28	Completado
216	106	38	2025	40	2025-10-01	2025-10-06	Completado
217	107	37	2024	19	2024-05-06	2024-05-08	Programado
218	107	37	2024	29	2024-07-15	2024-07-19	Completado
219	108	37	2024	22	2024-05-27	2024-05-29	Completado
220	108	37	2024	11	2024-03-11	2024-03-12	Completado
221	109	42	2026	4	2026-01-22	2026-01-26	En curso
222	110	42	2026	42	2026-10-15	2026-10-17	En curso
223	110	42	2026	27	2026-07-02	2026-07-05	En curso
224	111	42	2026	32	2026-08-06	2026-08-09	Completado
225	111	42	2026	11	2026-03-12	2026-03-16	Completado
226	111	42	2026	33	2026-08-13	2026-08-18	Completado
227	112	40	2024	4	2024-01-22	2024-01-26	Completado
228	112	40	2024	16	2024-04-15	2024-04-19	Completado
229	112	40	2024	48	2024-11-25	2024-11-26	Completado
230	113	43	2024	38	2024-09-16	2024-09-19	Completado
231	114	45	2026	40	2026-10-01	2026-10-06	Completado
232	115	45	2026	49	2026-12-03	2026-12-05	Completado
233	115	45	2026	40	2026-10-01	2026-10-04	Programado
234	116	45	2026	52	2026-12-24	2026-12-25	En curso
235	117	45	2026	38	2026-09-17	2026-09-18	En curso
236	118	46	2024	22	2024-05-27	2024-05-31	Completado
237	118	46	2024	20	2024-05-13	2024-05-18	Completado
238	119	47	2025	33	2025-08-13	2025-08-18	Completado
239	119	47	2025	24	2025-06-11	2025-06-14	Completado
240	119	47	2025	49	2025-12-03	2025-12-07	Completado
241	120	48	2026	51	2026-12-17	2026-12-18	Programado
242	120	48	2026	33	2026-08-13	2026-08-17	Programado
243	121	46	2024	21	2024-05-20	2024-05-22	Completado
244	121	46	2024	18	2024-04-29	2024-05-03	Cancelado
245	122	46	2024	13	2024-03-25	2024-03-27	Programado
246	122	46	2024	2	2024-01-08	2024-01-11	Completado
247	122	46	2024	32	2024-08-05	2024-08-07	Completado
248	123	50	2025	5	2025-01-29	2025-01-31	Completado
249	124	51	2026	43	2026-10-22	2026-10-26	Cancelado
250	124	51	2026	38	2026-09-17	2026-09-20	Programado
251	124	51	2026	39	2026-09-24	2026-09-25	Programado
252	125	52	2024	41	2024-10-07	2024-10-09	Completado
253	125	52	2024	4	2024-01-22	2024-01-26	Completado
254	125	52	2024	9	2024-02-26	2024-02-28	Completado
255	126	53	2025	5	2025-01-29	2025-02-02	Completado
256	126	53	2025	19	2025-05-07	2025-05-08	Completado
257	126	53	2025	29	2025-07-16	2025-07-19	Completado
258	127	52	2024	20	2024-05-13	2024-05-17	Completado
259	127	52	2024	33	2024-08-12	2024-08-17	Completado
260	127	52	2024	21	2024-05-20	2024-05-23	Completado
261	128	3	2026	12	2026-03-19	2026-03-20	En curso
262	128	3	2026	29	2026-07-16	2026-07-18	Programado
263	129	1	2024	39	2024-09-23	2024-09-25	Completado
264	129	1	2024	27	2024-07-01	2024-07-05	Completado
265	130	3	2026	45	2026-11-05	2026-11-08	Cancelado
266	130	3	2026	49	2026-12-03	2026-12-08	En curso
267	131	4	2024	26	2024-06-24	2024-06-25	Completado
268	131	4	2024	39	2024-09-23	2024-09-28	Completado
269	132	6	2026	29	2026-07-16	2026-07-19	Completado
270	132	6	2026	27	2026-07-02	2026-07-06	Cancelado
271	132	6	2026	8	2026-02-19	2026-02-20	Completado
272	133	5	2025	25	2025-06-18	2025-06-20	Programado
273	133	5	2025	50	2025-12-10	2025-12-13	Completado
274	134	4	2024	52	2024-12-23	2024-12-26	Completado
275	134	4	2024	46	2024-11-11	2024-11-15	Programado
276	134	4	2024	45	2024-11-04	2024-11-09	Completado
277	135	8	2025	17	2025-04-23	2025-04-24	Cancelado
278	136	8	2025	16	2025-04-16	2025-04-20	Completado
279	137	8	2025	19	2025-05-07	2025-05-08	Completado
280	137	8	2025	2	2025-01-08	2025-01-09	Completado
281	138	7	2024	42	2024-10-14	2024-10-18	Completado
282	139	8	2025	13	2025-03-26	2025-03-28	Programado
283	139	8	2025	25	2025-06-18	2025-06-19	Completado
284	139	8	2025	5	2025-01-29	2025-01-30	Completado
285	140	11	2025	11	2025-03-12	2025-03-17	Completado
286	141	11	2025	12	2025-03-19	2025-03-22	Completado
287	141	11	2025	28	2025-07-09	2025-07-12	Completado
288	141	11	2025	15	2025-04-09	2025-04-14	Completado
289	142	13	2024	38	2024-09-16	2024-09-18	Completado
290	143	15	2026	36	2026-09-03	2026-09-04	Programado
291	144	13	2024	6	2024-02-05	2024-02-09	Completado
292	144	13	2024	2	2024-01-08	2024-01-13	Completado
293	144	13	2024	3	2024-01-15	2024-01-20	Completado
294	145	15	2026	52	2026-12-24	2026-12-25	Programado
295	145	15	2026	49	2026-12-03	2026-12-06	En curso
296	145	15	2026	12	2026-03-19	2026-03-22	En curso
297	146	18	2026	41	2026-10-08	2026-10-10	Cancelado
298	147	17	2025	32	2025-08-06	2025-08-10	Completado
299	148	16	2024	50	2024-12-09	2024-12-11	Completado
300	149	17	2025	30	2025-07-23	2025-07-27	Completado
301	150	21	2026	44	2026-10-29	2026-10-31	En curso
302	150	21	2026	29	2026-07-16	2026-07-20	Programado
303	151	20	2025	3	2025-01-15	2025-01-18	Completado
304	151	20	2025	32	2025-08-06	2025-08-08	Completado
305	152	23	2025	43	2025-10-22	2025-10-27	Completado
306	152	23	2025	6	2025-02-05	2025-02-08	Completado
307	153	22	2024	23	2024-06-03	2024-06-05	Completado
308	154	24	2026	2	2026-01-08	2026-01-10	Programado
309	155	26	2025	6	2025-02-05	2025-02-08	Completado
310	155	26	2025	46	2025-11-12	2025-11-15	Completado
311	155	26	2025	5	2025-01-29	2025-02-02	Completado
312	156	27	2026	24	2026-06-11	2026-06-15	Programado
313	156	27	2026	25	2026-06-18	2026-06-20	Completado
314	157	27	2026	2	2026-01-08	2026-01-13	Completado
315	158	27	2026	31	2026-07-30	2026-08-02	Completado
316	158	27	2026	52	2026-12-24	2026-12-27	Programado
317	159	27	2026	37	2026-09-10	2026-09-13	Completado
318	160	28	2024	49	2024-12-02	2024-12-07	Completado
319	160	28	2024	33	2024-08-12	2024-08-17	Completado
320	160	28	2024	43	2024-10-21	2024-10-23	Programado
321	161	29	2025	22	2025-05-28	2025-05-31	Completado
322	161	29	2025	49	2025-12-03	2025-12-05	Completado
323	161	29	2025	47	2025-11-19	2025-11-21	Completado
324	162	30	2026	6	2026-02-05	2026-02-07	Completado
325	162	30	2026	21	2026-05-21	2026-05-23	Completado
326	162	30	2026	1	2026-01-01	2026-01-04	Cancelado
327	163	33	2026	12	2026-03-19	2026-03-20	Completado
328	163	33	2026	12	2026-03-19	2026-03-24	En curso
329	163	33	2026	47	2026-11-19	2026-11-20	Completado
330	164	33	2026	34	2026-08-20	2026-08-23	Completado
331	164	33	2026	18	2026-04-30	2026-05-04	Programado
332	165	31	2024	14	2024-04-01	2024-04-02	Programado
333	165	31	2024	18	2024-04-29	2024-04-30	Completado
334	166	31	2024	49	2024-12-02	2024-12-07	Completado
335	167	32	2025	44	2025-10-29	2025-10-31	Completado
336	168	35	2025	49	2025-12-03	2025-12-08	Completado
337	168	35	2025	18	2025-04-30	2025-05-05	Completado
338	169	34	2024	34	2024-08-19	2024-08-21	Completado
339	169	34	2024	51	2024-12-16	2024-12-19	Completado
340	170	35	2025	29	2025-07-16	2025-07-20	Completado
341	170	35	2025	1	2025-01-01	2025-01-04	Completado
342	171	35	2025	9	2025-02-26	2025-02-27	Completado
343	171	35	2025	40	2025-10-01	2025-10-03	Programado
344	172	36	2026	10	2026-03-05	2026-03-10	Cancelado
345	172	36	2026	33	2026-08-13	2026-08-16	Completado
346	172	36	2026	43	2026-10-22	2026-10-23	Completado
347	173	34	2024	30	2024-07-22	2024-07-23	Completado
348	174	37	2024	45	2024-11-04	2024-11-05	Completado
349	174	37	2024	2	2024-01-08	2024-01-11	Completado
350	175	37	2024	35	2024-08-26	2024-08-30	Completado
351	175	37	2024	38	2024-09-16	2024-09-17	Completado
352	176	39	2026	17	2026-04-23	2026-04-24	En curso
353	177	41	2025	8	2025-02-19	2025-02-22	Completado
354	177	41	2025	36	2025-09-03	2025-09-08	Completado
355	178	40	2024	31	2024-07-29	2024-07-30	Completado
356	178	40	2024	7	2024-02-12	2024-02-17	Programado
357	179	41	2025	49	2025-12-03	2025-12-05	Completado
358	180	40	2024	39	2024-09-23	2024-09-28	Completado
359	181	40	2024	6	2024-02-05	2024-02-10	Completado
360	181	40	2024	39	2024-09-23	2024-09-25	Programado
361	182	43	2024	23	2024-06-03	2024-06-04	Completado
362	182	43	2024	18	2024-04-29	2024-05-03	Completado
363	183	44	2025	43	2025-10-22	2025-10-27	Cancelado
364	184	43	2024	27	2024-07-01	2024-07-05	Completado
365	185	43	2024	8	2024-02-19	2024-02-22	Completado
366	186	48	2026	25	2026-06-18	2026-06-22	Programado
367	186	48	2026	6	2026-02-05	2026-02-08	Completado
368	186	48	2026	27	2026-07-02	2026-07-06	En curso
369	187	47	2025	30	2025-07-23	2025-07-28	Completado
370	187	47	2025	12	2025-03-19	2025-03-24	Cancelado
371	188	48	2026	50	2026-12-10	2026-12-11	Programado
372	188	48	2026	5	2026-01-29	2026-01-31	Completado
373	189	46	2024	51	2024-12-16	2024-12-20	Completado
374	190	47	2025	2	2025-01-08	2025-01-11	Completado
375	190	47	2025	48	2025-11-26	2025-11-27	Completado
376	190	47	2025	51	2025-12-17	2025-12-20	Completado
377	191	50	2025	49	2025-12-03	2025-12-07	Completado
378	191	50	2025	6	2025-02-05	2025-02-10	Completado
379	192	51	2026	50	2026-12-10	2026-12-14	Completado
380	192	51	2026	30	2026-07-23	2026-07-26	Programado
381	193	50	2025	46	2025-11-12	2025-11-17	Completado
382	194	52	2024	29	2024-07-15	2024-07-17	Completado
383	194	52	2024	1	2024-01-01	2024-01-04	Completado
384	195	54	2026	19	2026-05-07	2026-05-10	Completado
385	195	54	2026	14	2026-04-02	2026-04-06	Completado
386	196	53	2025	4	2025-01-22	2025-01-24	Programado
387	196	53	2025	25	2025-06-18	2025-06-21	Completado
388	196	53	2025	48	2025-11-26	2025-11-28	Completado
389	197	2	2025	12	2025-03-19	2025-03-24	Completado
390	197	2	2025	47	2025-11-19	2025-11-24	Completado
391	198	2	2025	14	2025-04-02	2025-04-03	Completado
392	198	2	2025	32	2025-08-06	2025-08-11	Cancelado
393	199	5	2025	12	2025-03-19	2025-03-23	Cancelado
394	200	4	2024	41	2024-10-07	2024-10-09	Completado
395	200	4	2024	18	2024-04-29	2024-05-04	Completado
396	201	6	2026	36	2026-09-03	2026-09-04	En curso
397	202	6	2026	25	2026-06-18	2026-06-21	En curso
398	202	6	2026	36	2026-09-03	2026-09-08	En curso
399	203	9	2026	44	2026-10-29	2026-11-01	Programado
400	203	9	2026	52	2026-12-24	2026-12-25	En curso
401	204	12	2026	40	2026-10-01	2026-10-05	En curso
402	204	12	2026	12	2026-03-19	2026-03-22	Completado
403	205	14	2025	19	2025-05-07	2025-05-10	Completado
404	206	15	2026	42	2026-10-15	2026-10-17	Programado
405	206	15	2026	4	2026-01-22	2026-01-24	Programado
406	207	14	2025	48	2025-11-26	2025-11-28	Completado
407	208	13	2024	30	2024-07-22	2024-07-23	Completado
408	208	13	2024	47	2024-11-18	2024-11-22	Completado
409	208	13	2024	30	2024-07-22	2024-07-24	Completado
410	209	18	2026	40	2026-10-01	2026-10-03	Completado
411	210	17	2025	28	2025-07-09	2025-07-14	Cancelado
412	211	17	2025	51	2025-12-17	2025-12-20	Completado
413	211	17	2025	24	2025-06-11	2025-06-14	Completado
414	211	17	2025	20	2025-05-14	2025-05-16	Cancelado
415	212	17	2025	3	2025-01-15	2025-01-20	Programado
416	213	20	2025	35	2025-08-27	2025-08-31	Completado
417	214	20	2025	34	2025-08-20	2025-08-21	Completado
418	214	20	2025	49	2025-12-03	2025-12-06	Completado
419	215	20	2025	47	2025-11-19	2025-11-20	Programado
420	215	20	2025	27	2025-07-02	2025-07-06	Completado
421	216	23	2025	33	2025-08-13	2025-08-15	Completado
422	216	23	2025	44	2025-10-29	2025-10-31	Completado
423	217	24	2026	5	2026-01-29	2026-02-02	Completado
424	218	24	2026	24	2026-06-11	2026-06-15	Completado
425	218	24	2026	48	2026-11-26	2026-11-30	Completado
426	219	23	2025	21	2025-05-21	2025-05-24	Completado
427	220	24	2026	17	2026-04-23	2026-04-26	Completado
428	220	24	2026	16	2026-04-16	2026-04-17	Cancelado
429	220	24	2026	31	2026-07-30	2026-08-04	En curso
430	221	27	2026	26	2026-06-25	2026-06-28	En curso
431	222	26	2025	51	2025-12-17	2025-12-22	Completado
432	222	26	2025	10	2025-03-05	2025-03-10	Completado
433	223	27	2026	10	2026-03-05	2026-03-06	En curso
434	223	27	2026	16	2026-04-16	2026-04-17	Completado
435	223	27	2026	43	2026-10-22	2026-10-23	Completado
436	224	25	2024	30	2024-07-22	2024-07-23	Completado
437	224	25	2024	4	2024-01-22	2024-01-26	Completado
438	225	27	2026	10	2026-03-05	2026-03-07	Cancelado
439	225	27	2026	35	2026-08-27	2026-08-28	Completado
440	225	27	2026	52	2026-12-24	2026-12-28	Programado
441	226	26	2025	34	2025-08-20	2025-08-25	Completado
442	226	26	2025	2	2025-01-08	2025-01-09	Completado
443	227	30	2026	39	2026-09-24	2026-09-29	Programado
444	227	30	2026	49	2026-12-03	2026-12-08	En curso
445	227	30	2026	44	2026-10-29	2026-10-30	Programado
446	228	30	2026	17	2026-04-23	2026-04-25	Completado
447	228	30	2026	21	2026-05-21	2026-05-22	Completado
448	228	30	2026	35	2026-08-27	2026-08-28	Programado
449	229	28	2024	51	2024-12-16	2024-12-18	Completado
450	229	28	2024	38	2024-09-16	2024-09-21	Completado
451	229	28	2024	18	2024-04-29	2024-05-03	Completado
452	230	28	2024	40	2024-09-30	2024-10-03	Completado
453	230	28	2024	29	2024-07-15	2024-07-17	Programado
454	231	28	2024	13	2024-03-25	2024-03-30	Completado
455	231	28	2024	36	2024-09-02	2024-09-03	Completado
456	232	33	2026	28	2026-07-09	2026-07-14	Programado
457	233	32	2025	45	2025-11-05	2025-11-06	Completado
458	234	31	2024	44	2024-10-28	2024-11-02	Completado
459	234	31	2024	27	2024-07-01	2024-07-03	Completado
460	234	31	2024	30	2024-07-22	2024-07-23	Completado
461	235	31	2024	25	2024-06-17	2024-06-20	Cancelado
462	235	31	2024	46	2024-11-11	2024-11-16	Completado
463	236	33	2026	38	2026-09-17	2026-09-20	Completado
464	236	33	2026	24	2026-06-11	2026-06-12	Completado
465	236	33	2026	5	2026-01-29	2026-01-30	Completado
466	237	34	2024	52	2024-12-23	2024-12-28	Completado
467	238	35	2025	37	2025-09-10	2025-09-13	Completado
468	238	35	2025	5	2025-01-29	2025-01-30	Programado
469	238	35	2025	40	2025-10-01	2025-10-04	Completado
470	239	34	2024	22	2024-05-27	2024-05-28	Completado
471	239	34	2024	11	2024-03-11	2024-03-14	Completado
472	240	35	2025	8	2025-02-19	2025-02-23	Programado
473	240	35	2025	9	2025-02-26	2025-03-03	Programado
474	241	34	2024	50	2024-12-09	2024-12-13	Completado
475	241	34	2024	35	2024-08-26	2024-08-29	Completado
476	241	34	2024	8	2024-02-19	2024-02-22	Completado
477	242	36	2026	18	2026-04-30	2026-05-02	Completado
478	242	36	2026	6	2026-02-05	2026-02-07	Completado
479	242	36	2026	48	2026-11-26	2026-11-30	Cancelado
480	243	39	2026	39	2026-09-24	2026-09-25	Programado
481	244	38	2025	25	2025-06-18	2025-06-19	Completado
482	244	38	2025	7	2025-02-12	2025-02-16	Completado
483	245	39	2026	43	2026-10-22	2026-10-23	En curso
484	245	39	2026	9	2026-02-26	2026-03-02	Completado
485	246	38	2025	3	2025-01-15	2025-01-18	Completado
486	246	38	2025	51	2025-12-17	2025-12-21	Completado
487	246	38	2025	2	2025-01-08	2025-01-12	Completado
488	247	39	2026	31	2026-07-30	2026-08-03	Programado
489	247	39	2026	47	2026-11-19	2026-11-20	Completado
490	248	37	2024	43	2024-10-21	2024-10-22	Completado
491	248	37	2024	9	2024-02-26	2024-03-02	Completado
492	248	37	2024	31	2024-07-29	2024-08-01	Completado
493	249	39	2026	46	2026-11-12	2026-11-17	Completado
494	249	39	2026	17	2026-04-23	2026-04-27	Cancelado
495	249	39	2026	32	2026-08-06	2026-08-11	En curso
496	250	40	2024	23	2024-06-03	2024-06-06	Completado
497	251	41	2025	39	2025-09-24	2025-09-26	Completado
498	251	41	2025	52	2025-12-24	2025-12-29	Completado
499	252	40	2024	24	2024-06-10	2024-06-12	Completado
500	252	40	2024	31	2024-07-29	2024-07-31	Completado
501	253	40	2024	5	2024-01-29	2024-02-01	Completado
502	253	40	2024	50	2024-12-09	2024-12-14	Completado
503	254	42	2026	51	2026-12-17	2026-12-20	En curso
504	254	42	2026	51	2026-12-17	2026-12-19	En curso
505	254	42	2026	23	2026-06-04	2026-06-08	Completado
506	255	43	2024	51	2024-12-16	2024-12-20	Completado
507	255	43	2024	41	2024-10-07	2024-10-10	Completado
508	256	43	2024	44	2024-10-28	2024-10-31	Completado
509	257	43	2024	29	2024-07-15	2024-07-20	Completado
510	258	44	2025	25	2025-06-18	2025-06-20	Completado
511	259	46	2024	46	2024-11-11	2024-11-12	Completado
512	259	46	2024	42	2024-10-14	2024-10-19	Completado
513	259	46	2024	16	2024-04-15	2024-04-19	Programado
514	260	46	2024	16	2024-04-15	2024-04-17	Completado
515	260	46	2024	26	2024-06-24	2024-06-27	Completado
516	260	46	2024	8	2024-02-19	2024-02-24	Programado
517	261	46	2024	9	2024-02-26	2024-02-28	Cancelado
518	262	47	2025	33	2025-08-13	2025-08-14	Completado
519	263	50	2025	5	2025-01-29	2025-02-02	Completado
520	263	50	2025	28	2025-07-09	2025-07-11	Completado
521	264	50	2025	15	2025-04-09	2025-04-14	Completado
522	264	50	2025	5	2025-01-29	2025-02-01	Programado
523	265	49	2024	41	2024-10-07	2024-10-12	Programado
524	265	49	2024	22	2024-05-27	2024-05-28	Completado
525	266	50	2025	25	2025-06-18	2025-06-20	Completado
526	266	50	2025	29	2025-07-16	2025-07-18	Completado
527	267	51	2026	41	2026-10-08	2026-10-12	En curso
528	267	51	2026	45	2026-11-05	2026-11-10	Completado
529	267	51	2026	13	2026-03-26	2026-03-28	Programado
530	268	52	2024	19	2024-05-06	2024-05-10	Completado
531	268	52	2024	30	2024-07-22	2024-07-23	Completado
532	268	52	2024	6	2024-02-05	2024-02-07	Completado
533	269	53	2025	31	2025-07-30	2025-08-02	Completado
534	270	52	2024	5	2024-01-29	2024-01-31	Completado
535	270	52	2024	15	2024-04-08	2024-04-11	Completado
536	270	52	2024	1	2024-01-01	2024-01-04	Completado
537	271	53	2025	5	2025-01-29	2025-02-01	Completado
538	271	53	2025	49	2025-12-03	2025-12-08	Completado
539	271	53	2025	16	2025-04-16	2025-04-20	Completado
540	272	2	2025	41	2025-10-08	2025-10-09	Completado
541	273	2	2025	41	2025-10-08	2025-10-10	Completado
542	273	2	2025	7	2025-02-12	2025-02-17	Programado
543	274	1	2024	47	2024-11-18	2024-11-21	Completado
544	274	1	2024	16	2024-04-15	2024-04-16	Completado
545	275	3	2026	33	2026-08-13	2026-08-15	Completado
546	275	3	2026	23	2026-06-04	2026-06-05	En curso
547	275	3	2026	33	2026-08-13	2026-08-18	Cancelado
548	276	6	2026	40	2026-10-01	2026-10-06	Completado
549	276	6	2026	11	2026-03-12	2026-03-15	Programado
550	277	6	2026	18	2026-04-30	2026-05-05	Completado
551	278	8	2025	32	2025-08-06	2025-08-11	Completado
552	278	8	2025	52	2025-12-24	2025-12-27	Completado
553	278	8	2025	46	2025-11-12	2025-11-17	Completado
554	279	9	2026	39	2026-09-24	2026-09-29	Programado
555	280	7	2024	35	2024-08-26	2024-08-31	Completado
556	281	8	2025	7	2025-02-12	2025-02-16	Completado
557	281	8	2025	44	2025-10-29	2025-11-01	Cancelado
558	281	8	2025	3	2025-01-15	2025-01-18	Completado
559	282	7	2024	50	2024-12-09	2024-12-14	Completado
560	283	7	2024	37	2024-09-09	2024-09-12	Completado
561	283	7	2024	44	2024-10-28	2024-10-29	Completado
562	284	12	2026	45	2026-11-05	2026-11-10	Completado
563	284	12	2026	15	2026-04-09	2026-04-14	Programado
564	284	12	2026	27	2026-07-02	2026-07-04	En curso
565	285	12	2026	31	2026-07-30	2026-08-04	En curso
566	286	10	2024	30	2024-07-22	2024-07-27	Completado
567	286	10	2024	35	2024-08-26	2024-08-30	Completado
568	286	10	2024	1	2024-01-01	2024-01-04	Completado
569	287	12	2026	46	2026-11-12	2026-11-16	En curso
570	287	12	2026	40	2026-10-01	2026-10-02	Programado
571	287	12	2026	30	2026-07-23	2026-07-25	Completado
572	288	10	2024	13	2024-03-25	2024-03-30	Completado
573	288	10	2024	6	2024-02-05	2024-02-07	Completado
574	289	13	2024	30	2024-07-22	2024-07-25	Completado
575	289	13	2024	34	2024-08-19	2024-08-23	Completado
576	290	14	2025	18	2025-04-30	2025-05-05	Completado
577	290	14	2025	14	2025-04-02	2025-04-06	Cancelado
578	291	13	2024	20	2024-05-13	2024-05-16	Completado
579	292	16	2024	48	2024-11-25	2024-11-30	Completado
580	292	16	2024	35	2024-08-26	2024-08-27	Completado
581	292	16	2024	24	2024-06-10	2024-06-12	Completado
582	293	17	2025	28	2025-07-09	2025-07-12	Completado
583	293	17	2025	14	2025-04-02	2025-04-07	Completado
584	293	17	2025	46	2025-11-12	2025-11-17	Completado
585	294	16	2024	38	2024-09-16	2024-09-20	Programado
586	294	16	2024	11	2024-03-11	2024-03-12	Completado
587	295	20	2025	48	2025-11-26	2025-11-27	Completado
588	295	20	2025	10	2025-03-05	2025-03-07	Completado
589	296	20	2025	12	2025-03-19	2025-03-21	Completado
590	296	20	2025	10	2025-03-05	2025-03-10	Completado
591	297	20	2025	52	2025-12-24	2025-12-28	Completado
592	297	20	2025	26	2025-06-25	2025-06-30	Completado
593	297	20	2025	45	2025-11-05	2025-11-09	Completado
594	298	23	2025	34	2025-08-20	2025-08-23	Completado
595	299	27	2026	37	2026-09-10	2026-09-15	En curso
596	299	27	2026	26	2026-06-25	2026-06-30	Programado
597	300	26	2025	33	2025-08-13	2025-08-15	Completado
598	300	26	2025	12	2025-03-19	2025-03-24	Completado
599	301	27	2026	43	2026-10-22	2026-10-24	En curso
600	301	27	2026	52	2026-12-24	2026-12-26	Cancelado
601	302	27	2026	15	2026-04-09	2026-04-11	En curso
602	302	27	2026	5	2026-01-29	2026-02-01	Programado
603	302	27	2026	49	2026-12-03	2026-12-08	Completado
604	303	26	2025	43	2025-10-22	2025-10-25	Completado
605	303	26	2025	44	2025-10-29	2025-11-01	Completado
606	304	26	2025	28	2025-07-09	2025-07-13	Completado
607	305	28	2024	5	2024-01-29	2024-02-03	Completado
608	306	29	2025	2	2025-01-08	2025-01-13	Completado
609	306	29	2025	14	2025-04-02	2025-04-06	Completado
610	307	30	2026	36	2026-09-03	2026-09-06	Programado
611	308	30	2026	51	2026-12-17	2026-12-19	Completado
612	308	30	2026	51	2026-12-17	2026-12-19	Completado
613	309	33	2026	49	2026-12-03	2026-12-05	En curso
614	309	33	2026	2	2026-01-08	2026-01-09	Completado
615	310	32	2025	45	2025-11-05	2025-11-10	Completado
616	310	32	2025	3	2025-01-15	2025-01-19	Completado
617	310	32	2025	43	2025-10-22	2025-10-25	Completado
618	311	31	2024	25	2024-06-17	2024-06-19	Completado
619	312	36	2026	45	2026-11-05	2026-11-09	En curso
620	312	36	2026	42	2026-10-15	2026-10-16	Cancelado
621	313	36	2026	3	2026-01-15	2026-01-17	Programado
622	314	39	2026	20	2026-05-14	2026-05-15	Completado
623	315	41	2025	24	2025-06-11	2025-06-13	Completado
624	316	42	2026	50	2026-12-10	2026-12-13	Programado
625	317	42	2026	35	2026-08-27	2026-09-01	En curso
626	318	40	2024	41	2024-10-07	2024-10-08	Completado
627	318	40	2024	39	2024-09-23	2024-09-25	Completado
628	319	45	2026	25	2026-06-18	2026-06-20	Completado
629	319	45	2026	37	2026-09-10	2026-09-11	Completado
630	320	45	2026	48	2026-11-26	2026-11-30	Completado
631	320	45	2026	18	2026-04-30	2026-05-01	Cancelado
632	320	45	2026	20	2026-05-14	2026-05-17	Programado
633	321	44	2025	24	2025-06-11	2025-06-12	Completado
634	321	44	2025	34	2025-08-20	2025-08-24	Completado
635	321	44	2025	28	2025-07-09	2025-07-11	Completado
636	322	44	2025	48	2025-11-26	2025-11-30	Completado
637	323	47	2025	35	2025-08-27	2025-08-29	Completado
638	323	47	2025	18	2025-04-30	2025-05-03	Completado
639	324	47	2025	4	2025-01-22	2025-01-24	Completado
640	324	47	2025	31	2025-07-30	2025-07-31	Completado
641	324	47	2025	32	2025-08-06	2025-08-08	Completado
642	325	48	2026	52	2026-12-24	2026-12-29	En curso
643	325	48	2026	18	2026-04-30	2026-05-05	Completado
644	326	46	2024	1	2024-01-01	2024-01-04	Completado
645	326	46	2024	33	2024-08-12	2024-08-15	Completado
646	327	48	2026	47	2026-11-19	2026-11-22	En curso
647	327	48	2026	29	2026-07-16	2026-07-18	Programado
648	327	48	2026	7	2026-02-12	2026-02-16	En curso
649	328	46	2024	29	2024-07-15	2024-07-18	Completado
650	328	46	2024	39	2024-09-23	2024-09-28	Completado
651	328	46	2024	15	2024-04-08	2024-04-12	Completado
652	329	49	2024	6	2024-02-05	2024-02-10	Completado
653	329	49	2024	1	2024-01-01	2024-01-05	Completado
654	330	49	2024	15	2024-04-08	2024-04-10	Completado
655	331	49	2024	24	2024-06-10	2024-06-11	Completado
656	331	49	2024	15	2024-04-08	2024-04-10	Completado
657	331	49	2024	10	2024-03-04	2024-03-05	Completado
658	332	54	2026	29	2026-07-16	2026-07-21	En curso
659	333	52	2024	39	2024-09-23	2024-09-27	Completado
660	334	54	2026	26	2026-06-25	2026-06-29	En curso
661	334	54	2026	49	2026-12-03	2026-12-06	Programado
662	335	53	2025	18	2025-04-30	2025-05-04	Completado
663	336	2	2025	9	2025-02-26	2025-02-27	Completado
664	336	2	2025	28	2025-07-09	2025-07-14	Completado
665	337	2	2025	20	2025-05-14	2025-05-15	Completado
666	337	2	2025	38	2025-09-17	2025-09-19	Completado
667	338	1	2024	25	2024-06-17	2024-06-22	Completado
668	338	1	2024	32	2024-08-05	2024-08-06	Completado
669	339	4	2024	44	2024-10-28	2024-10-31	Completado
670	340	6	2026	39	2026-09-24	2026-09-26	Cancelado
671	340	6	2026	16	2026-04-16	2026-04-18	Completado
672	341	9	2026	1	2026-01-01	2026-01-04	Programado
673	342	8	2025	3	2025-01-15	2025-01-18	Cancelado
674	343	7	2024	45	2024-11-04	2024-11-09	Completado
675	343	7	2024	38	2024-09-16	2024-09-17	Completado
676	343	7	2024	10	2024-03-04	2024-03-05	Completado
677	344	11	2025	36	2025-09-03	2025-09-05	Programado
678	345	11	2025	18	2025-04-30	2025-05-04	Completado
679	345	11	2025	31	2025-07-30	2025-08-04	Completado
680	346	10	2024	23	2024-06-03	2024-06-07	Completado
681	346	10	2024	31	2024-07-29	2024-08-02	Programado
682	347	11	2025	43	2025-10-22	2025-10-23	Completado
683	347	11	2025	31	2025-07-30	2025-07-31	Cancelado
684	348	10	2024	52	2024-12-23	2024-12-24	Completado
685	348	10	2024	36	2024-09-02	2024-09-06	Completado
686	348	10	2024	18	2024-04-29	2024-05-03	Completado
687	349	11	2025	18	2025-04-30	2025-05-03	Completado
688	349	11	2025	52	2025-12-24	2025-12-26	Completado
689	350	15	2026	12	2026-03-19	2026-03-22	Completado
690	350	15	2026	10	2026-03-05	2026-03-10	Completado
691	350	15	2026	8	2026-02-19	2026-02-22	En curso
692	351	18	2026	52	2026-12-24	2026-12-25	En curso
693	351	18	2026	51	2026-12-17	2026-12-19	Completado
694	351	18	2026	25	2026-06-18	2026-06-23	Cancelado
695	352	18	2026	17	2026-04-23	2026-04-25	Programado
696	352	18	2026	47	2026-11-19	2026-11-24	Programado
697	353	18	2026	10	2026-03-05	2026-03-08	En curso
698	354	18	2026	38	2026-09-17	2026-09-18	Cancelado
699	355	16	2024	23	2024-06-03	2024-06-08	Completado
700	356	19	2024	19	2024-05-06	2024-05-10	Completado
701	356	19	2024	27	2024-07-01	2024-07-04	Cancelado
702	356	19	2024	36	2024-09-02	2024-09-07	Completado
703	357	21	2026	4	2026-01-22	2026-01-26	En curso
704	358	19	2024	2	2024-01-08	2024-01-11	Completado
705	358	19	2024	17	2024-04-22	2024-04-27	Completado
706	359	23	2025	24	2025-06-11	2025-06-12	Completado
707	359	23	2025	31	2025-07-30	2025-08-03	Completado
708	360	23	2025	47	2025-11-19	2025-11-23	Completado
709	360	23	2025	51	2025-12-17	2025-12-19	Completado
710	360	23	2025	8	2025-02-19	2025-02-24	Completado
711	361	23	2025	50	2025-12-10	2025-12-13	Completado
712	361	23	2025	16	2025-04-16	2025-04-20	Completado
713	362	23	2025	21	2025-05-21	2025-05-22	Completado
714	362	23	2025	31	2025-07-30	2025-08-01	Completado
715	362	23	2025	50	2025-12-10	2025-12-12	Completado
716	363	23	2025	36	2025-09-03	2025-09-06	Completado
717	363	23	2025	43	2025-10-22	2025-10-26	Completado
718	364	23	2025	18	2025-04-30	2025-05-05	Completado
719	365	26	2025	39	2025-09-24	2025-09-29	Completado
720	365	26	2025	20	2025-05-14	2025-05-18	Completado
721	365	26	2025	6	2025-02-05	2025-02-09	Completado
722	366	27	2026	32	2026-08-06	2026-08-07	Completado
723	366	27	2026	27	2026-07-02	2026-07-04	Programado
724	366	27	2026	30	2026-07-23	2026-07-24	Completado
725	367	27	2026	18	2026-04-30	2026-05-02	Programado
726	367	27	2026	49	2026-12-03	2026-12-08	Programado
727	367	27	2026	28	2026-07-09	2026-07-13	En curso
728	368	26	2025	6	2025-02-05	2025-02-10	Completado
729	368	26	2025	51	2025-12-17	2025-12-22	Completado
730	368	26	2025	45	2025-11-05	2025-11-07	Completado
731	369	30	2026	45	2026-11-05	2026-11-09	Programado
732	369	30	2026	47	2026-11-19	2026-11-22	Completado
733	369	30	2026	1	2026-01-01	2026-01-02	Completado
734	370	30	2026	8	2026-02-19	2026-02-22	Cancelado
735	370	30	2026	46	2026-11-12	2026-11-17	Completado
736	371	29	2025	42	2025-10-15	2025-10-19	Programado
737	371	29	2025	51	2025-12-17	2025-12-21	Completado
738	371	29	2025	26	2025-06-25	2025-06-30	Completado
739	372	29	2025	15	2025-04-09	2025-04-13	Completado
740	373	32	2025	36	2025-09-03	2025-09-04	Completado
741	374	31	2024	10	2024-03-04	2024-03-09	Programado
742	374	31	2024	40	2024-09-30	2024-10-01	Completado
743	375	31	2024	35	2024-08-26	2024-08-28	Completado
744	375	31	2024	24	2024-06-10	2024-06-13	Completado
745	375	31	2024	19	2024-05-06	2024-05-11	Completado
746	376	31	2024	19	2024-05-06	2024-05-11	Completado
747	376	31	2024	45	2024-11-04	2024-11-09	Completado
748	376	31	2024	6	2024-02-05	2024-02-09	Completado
749	377	33	2026	32	2026-08-06	2026-08-10	Cancelado
750	377	33	2026	15	2026-04-09	2026-04-14	Cancelado
751	378	34	2024	50	2024-12-09	2024-12-14	Programado
752	378	34	2024	29	2024-07-15	2024-07-20	Completado
753	379	34	2024	51	2024-12-16	2024-12-17	Completado
754	379	34	2024	21	2024-05-20	2024-05-22	Completado
755	379	34	2024	49	2024-12-02	2024-12-04	Completado
756	380	34	2024	34	2024-08-19	2024-08-22	Completado
757	380	34	2024	12	2024-03-18	2024-03-20	Completado
758	381	37	2024	49	2024-12-02	2024-12-05	Completado
759	382	37	2024	9	2024-02-26	2024-02-27	Completado
760	383	39	2026	45	2026-11-05	2026-11-06	Completado
761	384	41	2025	18	2025-04-30	2025-05-05	Completado
762	385	40	2024	10	2024-03-04	2024-03-07	Completado
763	385	40	2024	24	2024-06-10	2024-06-13	Completado
764	385	40	2024	17	2024-04-22	2024-04-27	Completado
765	386	40	2024	33	2024-08-12	2024-08-13	Completado
766	386	40	2024	25	2024-06-17	2024-06-18	Programado
767	387	40	2024	46	2024-11-11	2024-11-15	Completado
768	387	40	2024	1	2024-01-01	2024-01-06	Completado
769	388	42	2026	17	2026-04-23	2026-04-26	Programado
770	388	42	2026	38	2026-09-17	2026-09-19	En curso
771	388	42	2026	15	2026-04-09	2026-04-14	En curso
772	389	40	2024	20	2024-05-13	2024-05-17	Completado
773	390	44	2025	42	2025-10-15	2025-10-17	Completado
774	390	44	2025	26	2025-06-25	2025-06-27	Completado
775	391	44	2025	46	2025-11-12	2025-11-14	Programado
776	392	43	2024	13	2024-03-25	2024-03-29	Completado
777	393	48	2026	41	2026-10-08	2026-10-11	Completado
778	394	48	2026	6	2026-02-05	2026-02-08	Programado
779	394	48	2026	3	2026-01-15	2026-01-18	En curso
780	394	48	2026	10	2026-03-05	2026-03-09	Completado
781	395	48	2026	18	2026-04-30	2026-05-01	Programado
782	395	48	2026	33	2026-08-13	2026-08-16	Completado
783	395	48	2026	34	2026-08-20	2026-08-23	Programado
784	396	49	2024	23	2024-06-03	2024-06-04	Completado
785	397	51	2026	7	2026-02-12	2026-02-13	Cancelado
786	397	51	2026	32	2026-08-06	2026-08-07	Completado
787	397	51	2026	50	2026-12-10	2026-12-13	Completado
788	398	49	2024	2	2024-01-08	2024-01-11	Completado
789	398	49	2024	21	2024-05-20	2024-05-24	Completado
790	398	49	2024	3	2024-01-15	2024-01-19	Completado
791	399	50	2025	7	2025-02-12	2025-02-16	Completado
792	399	50	2025	36	2025-09-03	2025-09-04	Programado
793	399	50	2025	11	2025-03-12	2025-03-13	Completado
794	400	51	2026	11	2026-03-12	2026-03-13	Completado
795	400	51	2026	51	2026-12-17	2026-12-22	Programado
796	401	52	2024	39	2024-09-23	2024-09-26	Completado
797	401	52	2024	40	2024-09-30	2024-10-02	Completado
798	402	53	2025	43	2025-10-22	2025-10-26	Completado
799	402	53	2025	17	2025-04-23	2025-04-26	Completado
800	403	54	2026	10	2026-03-05	2026-03-10	Programado
801	404	54	2026	17	2026-04-23	2026-04-26	Programado
802	404	54	2026	43	2026-10-22	2026-10-26	Programado
803	404	54	2026	36	2026-09-03	2026-09-06	Completado
804	405	3	2026	21	2026-05-21	2026-05-23	Cancelado
805	405	3	2026	29	2026-07-16	2026-07-17	En curso
806	405	3	2026	7	2026-02-12	2026-02-15	Programado
807	406	2	2025	22	2025-05-28	2025-05-30	Completado
808	407	2	2025	51	2025-12-17	2025-12-21	Completado
809	407	2	2025	39	2025-09-24	2025-09-27	Completado
810	407	2	2025	31	2025-07-30	2025-08-02	Completado
811	408	1	2024	48	2024-11-25	2024-11-27	Programado
812	409	1	2024	13	2024-03-25	2024-03-28	Completado
813	410	4	2024	41	2024-10-07	2024-10-08	Completado
814	410	4	2024	49	2024-12-02	2024-12-07	Completado
815	410	4	2024	10	2024-03-04	2024-03-05	Completado
816	411	4	2024	3	2024-01-15	2024-01-16	Completado
817	412	5	2025	45	2025-11-05	2025-11-08	Completado
818	412	5	2025	52	2025-12-24	2025-12-26	Completado
819	413	6	2026	23	2026-06-04	2026-06-05	Completado
820	413	6	2026	23	2026-06-04	2026-06-05	Programado
821	413	6	2026	26	2026-06-25	2026-06-27	Programado
822	414	9	2026	52	2026-12-24	2026-12-29	Cancelado
823	415	7	2024	31	2024-07-29	2024-08-02	Completado
824	416	9	2026	30	2026-07-23	2026-07-28	Completado
825	416	9	2026	38	2026-09-17	2026-09-18	En curso
826	417	10	2024	2	2024-01-08	2024-01-11	Programado
827	417	10	2024	46	2024-11-11	2024-11-13	Completado
828	417	10	2024	38	2024-09-16	2024-09-20	Completado
829	418	12	2026	40	2026-10-01	2026-10-06	Completado
830	418	12	2026	37	2026-09-10	2026-09-11	Completado
831	419	11	2025	9	2025-02-26	2025-03-03	Completado
832	419	11	2025	48	2025-11-26	2025-11-28	Completado
833	419	11	2025	43	2025-10-22	2025-10-27	Completado
834	420	14	2025	41	2025-10-08	2025-10-11	Completado
835	421	15	2026	45	2026-11-05	2026-11-06	Programado
836	421	15	2026	39	2026-09-24	2026-09-29	En curso
837	421	15	2026	33	2026-08-13	2026-08-16	Completado
838	422	15	2026	3	2026-01-15	2026-01-17	Programado
839	422	15	2026	5	2026-01-29	2026-02-01	Cancelado
840	423	14	2025	1	2025-01-01	2025-01-04	Completado
841	423	14	2025	22	2025-05-28	2025-05-31	Programado
842	423	14	2025	32	2025-08-06	2025-08-07	Completado
843	424	13	2024	10	2024-03-04	2024-03-07	Completado
844	425	15	2026	3	2026-01-15	2026-01-17	Completado
845	425	15	2026	11	2026-03-12	2026-03-16	Completado
846	426	17	2025	39	2025-09-24	2025-09-27	Completado
847	426	17	2025	38	2025-09-17	2025-09-19	Completado
848	426	17	2025	43	2025-10-22	2025-10-26	Programado
849	427	17	2025	15	2025-04-09	2025-04-14	Completado
850	427	17	2025	34	2025-08-20	2025-08-23	Completado
851	428	18	2026	9	2026-02-26	2026-03-02	Programado
852	428	18	2026	50	2026-12-10	2026-12-12	Completado
853	428	18	2026	50	2026-12-10	2026-12-12	Completado
854	429	17	2025	39	2025-09-24	2025-09-29	Completado
855	429	17	2025	8	2025-02-19	2025-02-22	Programado
856	430	16	2024	26	2024-06-24	2024-06-28	Cancelado
857	430	16	2024	6	2024-02-05	2024-02-08	Completado
858	431	16	2024	22	2024-05-27	2024-05-31	Completado
859	431	16	2024	44	2024-10-28	2024-10-31	Programado
860	431	16	2024	36	2024-09-02	2024-09-06	Completado
861	432	21	2026	20	2026-05-14	2026-05-16	En curso
862	433	22	2024	2	2024-01-08	2024-01-11	Completado
863	434	23	2025	24	2025-06-11	2025-06-14	Completado
864	435	23	2025	14	2025-04-02	2025-04-03	Completado
865	436	25	2024	5	2024-01-29	2024-02-02	Programado
866	436	25	2024	24	2024-06-10	2024-06-13	Completado
867	437	26	2025	24	2025-06-11	2025-06-12	Completado
868	437	26	2025	28	2025-07-09	2025-07-14	Completado
869	437	26	2025	31	2025-07-30	2025-08-03	Completado
870	438	25	2024	33	2024-08-12	2024-08-14	Completado
871	439	25	2024	47	2024-11-18	2024-11-19	Completado
872	439	25	2024	34	2024-08-19	2024-08-24	Cancelado
873	439	25	2024	39	2024-09-23	2024-09-26	Programado
874	440	25	2024	19	2024-05-06	2024-05-09	Completado
875	440	25	2024	21	2024-05-20	2024-05-25	Completado
876	440	25	2024	3	2024-01-15	2024-01-18	Completado
877	441	30	2026	41	2026-10-08	2026-10-13	En curso
878	441	30	2026	1	2026-01-01	2026-01-04	Programado
879	441	30	2026	4	2026-01-22	2026-01-25	Completado
880	442	30	2026	5	2026-01-29	2026-02-02	En curso
881	442	30	2026	43	2026-10-22	2026-10-27	En curso
882	442	30	2026	9	2026-02-26	2026-03-03	Completado
883	443	29	2025	29	2025-07-16	2025-07-17	Completado
884	443	29	2025	15	2025-04-09	2025-04-12	Completado
885	444	28	2024	48	2024-11-25	2024-11-30	Completado
886	444	28	2024	36	2024-09-02	2024-09-05	Completado
887	445	33	2026	45	2026-11-05	2026-11-10	Programado
888	445	33	2026	12	2026-03-19	2026-03-24	En curso
889	446	32	2025	10	2025-03-05	2025-03-10	Cancelado
890	446	32	2025	50	2025-12-10	2025-12-13	Programado
891	446	32	2025	17	2025-04-23	2025-04-26	Completado
892	447	35	2025	36	2025-09-03	2025-09-06	Completado
893	447	35	2025	45	2025-11-05	2025-11-10	Completado
894	448	34	2024	30	2024-07-22	2024-07-27	Completado
895	448	34	2024	41	2024-10-07	2024-10-12	Completado
896	448	34	2024	42	2024-10-14	2024-10-19	Completado
897	449	36	2026	40	2026-10-01	2026-10-04	Completado
898	449	36	2026	25	2026-06-18	2026-06-23	Completado
899	450	34	2024	27	2024-07-01	2024-07-05	Completado
900	451	36	2026	1	2026-01-01	2026-01-05	En curso
901	451	36	2026	12	2026-03-19	2026-03-22	Programado
902	452	37	2024	38	2024-09-16	2024-09-17	Completado
903	452	37	2024	16	2024-04-15	2024-04-20	Completado
904	453	37	2024	25	2024-06-17	2024-06-19	Completado
905	454	38	2025	52	2025-12-24	2025-12-25	Completado
906	454	38	2025	23	2025-06-04	2025-06-06	Completado
907	454	38	2025	10	2025-03-05	2025-03-09	Completado
908	455	38	2025	39	2025-09-24	2025-09-25	Completado
909	455	38	2025	42	2025-10-15	2025-10-17	Completado
910	455	38	2025	23	2025-06-04	2025-06-08	Completado
911	456	40	2024	48	2024-11-25	2024-11-29	Completado
912	457	42	2026	37	2026-09-10	2026-09-13	Completado
913	457	42	2026	48	2026-11-26	2026-11-30	Programado
914	457	42	2026	2	2026-01-08	2026-01-13	Programado
915	458	40	2024	52	2024-12-23	2024-12-24	Completado
916	459	42	2026	39	2026-09-24	2026-09-25	En curso
917	460	41	2025	48	2025-11-26	2025-11-30	Completado
918	460	41	2025	51	2025-12-17	2025-12-19	Completado
919	460	41	2025	4	2025-01-22	2025-01-26	Completado
920	461	42	2026	39	2026-09-24	2026-09-25	Completado
921	462	40	2024	45	2024-11-04	2024-11-08	Cancelado
922	463	45	2026	28	2026-07-09	2026-07-10	En curso
923	463	45	2026	50	2026-12-10	2026-12-12	Completado
924	463	45	2026	1	2026-01-01	2026-01-05	Completado
925	464	45	2026	11	2026-03-12	2026-03-16	En curso
926	464	45	2026	25	2026-06-18	2026-06-23	En curso
927	464	45	2026	4	2026-01-22	2026-01-27	Completado
928	465	45	2026	52	2026-12-24	2026-12-29	Programado
929	465	45	2026	20	2026-05-14	2026-05-18	Cancelado
930	465	45	2026	18	2026-04-30	2026-05-05	Programado
931	466	44	2025	26	2025-06-25	2025-06-28	Completado
932	467	44	2025	40	2025-10-01	2025-10-06	Completado
933	467	44	2025	49	2025-12-03	2025-12-05	Completado
934	467	44	2025	25	2025-06-18	2025-06-19	Completado
935	468	45	2026	19	2026-05-07	2026-05-08	Programado
936	469	45	2026	51	2026-12-17	2026-12-22	Programado
937	469	45	2026	32	2026-08-06	2026-08-07	Programado
938	470	48	2026	51	2026-12-17	2026-12-20	Completado
939	470	48	2026	24	2026-06-11	2026-06-15	Completado
940	470	48	2026	35	2026-08-27	2026-08-31	En curso
941	471	48	2026	8	2026-02-19	2026-02-24	Programado
942	471	48	2026	41	2026-10-08	2026-10-11	Completado
943	471	48	2026	7	2026-02-12	2026-02-14	Completado
944	472	47	2025	12	2025-03-19	2025-03-24	Completado
945	472	47	2025	7	2025-02-12	2025-02-13	Completado
946	472	47	2025	1	2025-01-01	2025-01-06	Completado
947	473	47	2025	1	2025-01-01	2025-01-06	Completado
948	473	47	2025	48	2025-11-26	2025-11-30	Completado
949	473	47	2025	11	2025-03-12	2025-03-17	Completado
950	474	49	2024	39	2024-09-23	2024-09-24	Completado
951	474	49	2024	1	2024-01-01	2024-01-02	Completado
952	474	49	2024	22	2024-05-27	2024-05-29	Completado
953	475	51	2026	37	2026-09-10	2026-09-15	Programado
954	475	51	2026	6	2026-02-05	2026-02-08	Completado
955	476	51	2026	49	2026-12-03	2026-12-06	En curso
956	476	51	2026	4	2026-01-22	2026-01-25	Programado
957	477	51	2026	33	2026-08-13	2026-08-16	Programado
958	477	51	2026	52	2026-12-24	2026-12-25	Completado
959	478	49	2024	48	2024-11-25	2024-11-27	Completado
960	478	49	2024	37	2024-09-09	2024-09-11	Programado
961	479	49	2024	24	2024-06-10	2024-06-13	Completado
962	479	49	2024	46	2024-11-11	2024-11-15	Completado
963	480	52	2024	23	2024-06-03	2024-06-04	Completado
964	481	52	2024	31	2024-07-29	2024-07-31	Completado
965	481	52	2024	9	2024-02-26	2024-02-29	Completado
966	481	52	2024	21	2024-05-20	2024-05-22	Completado
967	482	2	2025	40	2025-10-01	2025-10-02	Completado
968	482	2	2025	41	2025-10-08	2025-10-12	Completado
969	483	1	2024	43	2024-10-21	2024-10-23	Completado
970	483	1	2024	9	2024-02-26	2024-02-29	Completado
971	484	2	2025	52	2025-12-24	2025-12-29	Completado
972	484	2	2025	34	2025-08-20	2025-08-21	Completado
973	485	1	2024	33	2024-08-12	2024-08-15	Completado
974	485	1	2024	6	2024-02-05	2024-02-07	Completado
975	486	4	2024	51	2024-12-16	2024-12-17	Completado
976	486	4	2024	35	2024-08-26	2024-08-29	Completado
977	486	4	2024	4	2024-01-22	2024-01-26	Completado
978	487	6	2026	1	2026-01-01	2026-01-02	Completado
979	488	6	2026	52	2026-12-24	2026-12-27	En curso
980	489	5	2025	16	2025-04-16	2025-04-19	Programado
981	490	4	2024	44	2024-10-28	2024-10-29	Completado
982	490	4	2024	44	2024-10-28	2024-10-30	Completado
983	491	6	2026	52	2026-12-24	2026-12-28	Completado
984	491	6	2026	29	2026-07-16	2026-07-20	Completado
985	492	8	2025	48	2025-11-26	2025-11-27	Completado
986	492	8	2025	4	2025-01-22	2025-01-23	Completado
987	492	8	2025	25	2025-06-18	2025-06-23	Completado
988	493	7	2024	40	2024-09-30	2024-10-03	Completado
989	493	7	2024	5	2024-01-29	2024-01-30	Completado
990	494	7	2024	48	2024-11-25	2024-11-30	Completado
991	494	7	2024	48	2024-11-25	2024-11-30	Completado
992	495	8	2025	7	2025-02-12	2025-02-16	Completado
993	495	8	2025	50	2025-12-10	2025-12-12	Completado
994	495	8	2025	19	2025-05-07	2025-05-08	Completado
995	496	8	2025	24	2025-06-11	2025-06-16	Programado
996	496	8	2025	26	2025-06-25	2025-06-30	Completado
997	496	8	2025	12	2025-03-19	2025-03-20	Completado
998	497	9	2026	31	2026-07-30	2026-08-01	Programado
999	497	9	2026	34	2026-08-20	2026-08-25	Cancelado
1000	498	11	2025	16	2025-04-16	2025-04-18	Completado
1001	499	14	2025	3	2025-01-15	2025-01-17	Completado
1002	499	14	2025	2	2025-01-08	2025-01-13	Programado
1003	499	14	2025	29	2025-07-16	2025-07-17	Completado
1004	500	14	2025	7	2025-02-12	2025-02-16	Programado
1005	500	14	2025	18	2025-04-30	2025-05-03	Completado
1006	500	14	2025	17	2025-04-23	2025-04-26	Completado
1007	501	14	2025	6	2025-02-05	2025-02-06	Completado
1008	501	14	2025	23	2025-06-04	2025-06-07	Completado
1009	502	13	2024	45	2024-11-04	2024-11-09	Completado
1010	502	13	2024	35	2024-08-26	2024-08-31	Completado
1011	502	13	2024	16	2024-04-15	2024-04-18	Completado
1012	503	13	2024	14	2024-04-01	2024-04-03	Completado
1013	504	18	2026	15	2026-04-09	2026-04-10	Cancelado
1014	505	16	2024	19	2024-05-06	2024-05-08	Cancelado
1015	505	16	2024	21	2024-05-20	2024-05-23	Completado
1016	505	16	2024	45	2024-11-04	2024-11-06	Programado
1017	506	17	2025	4	2025-01-22	2025-01-24	Completado
1018	506	17	2025	43	2025-10-22	2025-10-27	Completado
1019	507	18	2026	7	2026-02-12	2026-02-15	Completado
1020	508	16	2024	36	2024-09-02	2024-09-05	Completado
1021	509	18	2026	30	2026-07-23	2026-07-26	Programado
1022	509	18	2026	8	2026-02-19	2026-02-23	Programado
1023	510	20	2025	10	2025-03-05	2025-03-08	Completado
1024	510	20	2025	49	2025-12-03	2025-12-07	Completado
1025	510	20	2025	45	2025-11-05	2025-11-09	Cancelado
1026	511	20	2025	44	2025-10-29	2025-11-03	Completado
1027	511	20	2025	13	2025-03-26	2025-03-31	Completado
1028	512	20	2025	10	2025-03-05	2025-03-10	Completado
1029	513	20	2025	31	2025-07-30	2025-08-04	Completado
1030	513	20	2025	15	2025-04-09	2025-04-14	Completado
1031	513	20	2025	12	2025-03-19	2025-03-24	Completado
1032	514	22	2024	29	2024-07-15	2024-07-17	Completado
1033	514	22	2024	49	2024-12-02	2024-12-07	Completado
1034	515	24	2026	34	2026-08-20	2026-08-24	Completado
1035	515	24	2026	36	2026-09-03	2026-09-07	Programado
1036	515	24	2026	7	2026-02-12	2026-02-15	Completado
1037	516	22	2024	3	2024-01-15	2024-01-17	Completado
1038	517	22	2024	34	2024-08-19	2024-08-24	Completado
1039	518	24	2026	49	2026-12-03	2026-12-07	Completado
1040	518	24	2026	42	2026-10-15	2026-10-16	Cancelado
1041	518	24	2026	38	2026-09-17	2026-09-22	Programado
1042	519	27	2026	43	2026-10-22	2026-10-24	Completado
1043	520	25	2024	4	2024-01-22	2024-01-24	Completado
1044	520	25	2024	22	2024-05-27	2024-05-31	Completado
1045	520	25	2024	51	2024-12-16	2024-12-17	Completado
1046	521	26	2025	35	2025-08-27	2025-09-01	Completado
1047	521	26	2025	35	2025-08-27	2025-08-31	Completado
1048	521	26	2025	34	2025-08-20	2025-08-24	Completado
1049	522	27	2026	13	2026-03-26	2026-03-27	En curso
1050	523	29	2025	15	2025-04-09	2025-04-11	Completado
1051	524	30	2026	51	2026-12-17	2026-12-19	Programado
1052	524	30	2026	9	2026-02-26	2026-02-28	Completado
1053	524	30	2026	17	2026-04-23	2026-04-28	En curso
1054	525	29	2025	3	2025-01-15	2025-01-20	Completado
1055	526	30	2026	2	2026-01-08	2026-01-13	Completado
1056	526	30	2026	39	2026-09-24	2026-09-26	Completado
1057	526	30	2026	23	2026-06-04	2026-06-06	Programado
1058	527	30	2026	50	2026-12-10	2026-12-14	Programado
1059	527	30	2026	8	2026-02-19	2026-02-24	En curso
1060	528	29	2025	51	2025-12-17	2025-12-20	Completado
1061	528	29	2025	8	2025-02-19	2025-02-24	Completado
1062	528	29	2025	3	2025-01-15	2025-01-16	Completado
1063	529	31	2024	29	2024-07-15	2024-07-16	Completado
1064	529	31	2024	48	2024-11-25	2024-11-28	Completado
1065	529	31	2024	15	2024-04-08	2024-04-12	Completado
1066	530	33	2026	24	2026-06-11	2026-06-14	Programado
1067	530	33	2026	41	2026-10-08	2026-10-09	Programado
1068	530	33	2026	47	2026-11-19	2026-11-20	Programado
1069	531	32	2025	21	2025-05-21	2025-05-26	Completado
1070	532	36	2026	30	2026-07-23	2026-07-28	Programado
1071	532	36	2026	31	2026-07-30	2026-08-01	Programado
1072	533	35	2025	22	2025-05-28	2025-06-01	Completado
1073	534	36	2026	42	2026-10-15	2026-10-20	Completado
1074	535	35	2025	24	2025-06-11	2025-06-13	Completado
1075	535	35	2025	8	2025-02-19	2025-02-23	Completado
1076	535	35	2025	16	2025-04-16	2025-04-17	Completado
1077	536	37	2024	46	2024-11-11	2024-11-13	Cancelado
1078	536	37	2024	27	2024-07-01	2024-07-02	Completado
1079	536	37	2024	12	2024-03-18	2024-03-23	Completado
1080	537	38	2025	30	2025-07-23	2025-07-28	Completado
1081	537	38	2025	24	2025-06-11	2025-06-14	Completado
1082	537	38	2025	35	2025-08-27	2025-09-01	Completado
1083	538	39	2026	31	2026-07-30	2026-07-31	Programado
1084	538	39	2026	51	2026-12-17	2026-12-22	Completado
1085	539	41	2025	5	2025-01-29	2025-01-30	Completado
1086	539	41	2025	7	2025-02-12	2025-02-15	Programado
1087	540	42	2026	12	2026-03-19	2026-03-22	Programado
1088	540	42	2026	43	2026-10-22	2026-10-25	En curso
1089	540	42	2026	33	2026-08-13	2026-08-18	Completado
1090	541	42	2026	16	2026-04-16	2026-04-18	Completado
1091	542	41	2025	19	2025-05-07	2025-05-08	Completado
1092	542	41	2025	19	2025-05-07	2025-05-10	Completado
1093	543	41	2025	7	2025-02-12	2025-02-14	Completado
1094	543	41	2025	10	2025-03-05	2025-03-06	Completado
1095	543	41	2025	31	2025-07-30	2025-07-31	Completado
1096	544	45	2026	27	2026-07-02	2026-07-05	Completado
1097	544	45	2026	22	2026-05-28	2026-05-29	Completado
1098	544	45	2026	15	2026-04-09	2026-04-10	Cancelado
1099	545	45	2026	42	2026-10-15	2026-10-16	Completado
1100	545	45	2026	13	2026-03-26	2026-03-28	Cancelado
1101	545	45	2026	51	2026-12-17	2026-12-20	Completado
1102	546	43	2024	2	2024-01-08	2024-01-13	Completado
1103	546	43	2024	52	2024-12-23	2024-12-27	Cancelado
1104	546	43	2024	5	2024-01-29	2024-02-03	Completado
1105	547	48	2026	15	2026-04-09	2026-04-14	En curso
1106	547	48	2026	52	2026-12-24	2026-12-26	Completado
1107	548	48	2026	37	2026-09-10	2026-09-14	En curso
1108	548	48	2026	27	2026-07-02	2026-07-04	Completado
1109	548	48	2026	11	2026-03-12	2026-03-15	Cancelado
1110	549	47	2025	16	2025-04-16	2025-04-20	Completado
1111	549	47	2025	10	2025-03-05	2025-03-09	Completado
1112	550	48	2026	43	2026-10-22	2026-10-25	Programado
1113	551	48	2026	12	2026-03-19	2026-03-20	En curso
1114	551	48	2026	4	2026-01-22	2026-01-23	Programado
1115	552	47	2025	13	2025-03-26	2025-03-28	Completado
1116	553	51	2026	4	2026-01-22	2026-01-27	En curso
1117	554	51	2026	15	2026-04-09	2026-04-13	Programado
1118	554	51	2026	28	2026-07-09	2026-07-12	Completado
1119	555	49	2024	43	2024-10-21	2024-10-22	Completado
1120	556	54	2026	20	2026-05-14	2026-05-18	Completado
1121	556	54	2026	10	2026-03-05	2026-03-09	Completado
1122	557	52	2024	37	2024-09-09	2024-09-12	Completado
1123	557	52	2024	13	2024-03-25	2024-03-29	Completado
1124	558	54	2026	52	2026-12-24	2026-12-28	Programado
1125	558	54	2026	40	2026-10-01	2026-10-02	Completado
1126	558	54	2026	51	2026-12-17	2026-12-19	Completado
1127	559	54	2026	36	2026-09-03	2026-09-07	Completado
1128	560	53	2025	8	2025-02-19	2025-02-24	Completado
1129	561	1	2024	27	2024-07-01	2024-07-04	Completado
1130	561	1	2024	32	2024-08-05	2024-08-10	Completado
1131	562	2	2025	50	2025-12-10	2025-12-12	Completado
1132	562	2	2025	52	2025-12-24	2025-12-28	Cancelado
1133	562	2	2025	46	2025-11-12	2025-11-13	Programado
1134	563	2	2025	32	2025-08-06	2025-08-10	Completado
1135	563	2	2025	34	2025-08-20	2025-08-22	Completado
1136	564	6	2026	43	2026-10-22	2026-10-27	En curso
1137	564	6	2026	40	2026-10-01	2026-10-04	En curso
1138	565	6	2026	30	2026-07-23	2026-07-28	Completado
1139	566	6	2026	48	2026-11-26	2026-12-01	En curso
1140	566	6	2026	45	2026-11-05	2026-11-07	Cancelado
1141	567	9	2026	40	2026-10-01	2026-10-02	En curso
1142	568	11	2025	37	2025-09-10	2025-09-15	Completado
1143	568	11	2025	37	2025-09-10	2025-09-12	Completado
1144	569	10	2024	8	2024-02-19	2024-02-20	Completado
1145	569	10	2024	12	2024-03-18	2024-03-23	Completado
1146	569	10	2024	28	2024-07-08	2024-07-13	Completado
1147	570	10	2024	14	2024-04-01	2024-04-06	Completado
1148	571	12	2026	42	2026-10-15	2026-10-17	Cancelado
1149	571	12	2026	23	2026-06-04	2026-06-06	Completado
1150	572	14	2025	6	2025-02-05	2025-02-08	Completado
1151	573	15	2026	52	2026-12-24	2026-12-29	Programado
1152	573	15	2026	40	2026-10-01	2026-10-03	Programado
1153	573	15	2026	12	2026-03-19	2026-03-24	Programado
1154	574	15	2026	29	2026-07-16	2026-07-19	Completado
1155	574	15	2026	40	2026-10-01	2026-10-04	Completado
1156	575	17	2025	35	2025-08-27	2025-08-29	Completado
1157	575	17	2025	20	2025-05-14	2025-05-18	Completado
1158	576	17	2025	4	2025-01-22	2025-01-25	Completado
1159	577	17	2025	27	2025-07-02	2025-07-04	Completado
1160	577	17	2025	13	2025-03-26	2025-03-28	Completado
1161	578	16	2024	52	2024-12-23	2024-12-27	Completado
1162	578	16	2024	12	2024-03-18	2024-03-21	Completado
1163	578	16	2024	41	2024-10-07	2024-10-10	Programado
1164	579	17	2025	43	2025-10-22	2025-10-23	Completado
1165	580	16	2024	13	2024-03-25	2024-03-30	Completado
1166	580	16	2024	45	2024-11-04	2024-11-09	Completado
1167	580	16	2024	1	2024-01-01	2024-01-03	Programado
\.


--
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.departamentos (id_departamento, departamento) FROM stdin;
1	Produccion
2	Calidad
3	Ingenieria
4	Mantenimiento
5	Logistica
6	Recursos Humanos
7	Seguridad e Higiene
8	Compras
9	Almacen
10	Control de Produccion
11	Metrologia
12	Herramentales
13	Inyeccion
14	Ensamble
15	Pintura
16	Sistemas
17	Finanzas
18	Entrenamiento
\.


--
-- Data for Name: descripciones_puesto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.descripciones_puesto (id_descripcion_puesto, clave_planta, clave_puesto, clave_area, id_departamento, revision, elaborado_por, objetivo, fecha_creacion, fecha_envio, fecha_aprobacion, autorizada) FROM stdin;
1	1	1	2	1	4	MNJ Produccion	Asegurar la operacion de Operador de Produccion	2025-09-14	2025-09-28	2025-10-07	t
2	3	2	3	2	3	MNJ Calidad	Asegurar la operacion de Inspector de Calidad	2024-12-21	2024-12-29	\N	f
3	3	3	8	3	2	MNJ Ingenieria	Asegurar la operacion de Ingeniero de Procesos	2025-01-26	2025-02-09	2025-02-15	t
4	3	4	9	4	1	MNJ Mantenimiento	Asegurar la operacion de Tecnico de Mantenimiento	2025-09-23	2025-09-29	\N	f
5	3	5	12	5	0	MNJ Logistica	Asegurar la operacion de Auxiliar de Logistica	2024-10-25	2024-11-04	2024-11-12	t
6	2	6	15	6	1	MNJ Recursos Humanos	Asegurar la operacion de Analista de RH	2025-07-21	2025-08-01	2025-08-02	t
7	1	7	18	7	2	MNJ Seguridad e Higiene	Asegurar la operacion de Supervisor de Linea	2024-03-20	2024-03-31	\N	f
8	1	8	19	8	3	MNJ Compras	Asegurar la operacion de Comprador	2025-07-10	2025-07-16	\N	f
9	1	9	25	9	0	MNJ Almacen	Asegurar la operacion de Almacenista	2024-05-16	2024-05-27	2024-06-02	t
10	2	10	26	10	1	MNJ Control de Produccion	Asegurar la operacion de Planeador	2024-10-14	2024-10-29	2024-11-01	t
11	1	11	31	11	3	MNJ Metrologia	Asegurar la operacion de Metrologo	2024-12-01	2024-12-04	\N	f
12	1	12	33	12	1	MNJ Herramentales	Asegurar la operacion de Diseñador de Herramentales	2025-05-01	2025-05-04	\N	f
13	2	13	37	13	3	MNJ Inyeccion	Asegurar la operacion de Operador de Inyeccion	2024-07-14	2024-07-28	\N	f
14	1	14	39	14	3	MNJ Ensamble	Asegurar la operacion de Ensamblador	2024-07-19	2024-07-27	2024-08-04	t
15	1	15	43	15	1	MNJ Pintura	Asegurar la operacion de Pintor Industrial	2024-04-18	2024-05-02	2024-05-09	t
16	2	16	49	16	4	MNJ Sistemas	Asegurar la operacion de Analista de Sistemas	2025-04-13	2025-04-16	2025-04-17	t
17	2	17	50	17	2	MNJ Finanzas	Asegurar la operacion de Contador	2025-08-27	2025-08-28	\N	f
18	2	18	55	18	2	MNJ Entrenamiento	Asegurar la operacion de Coordinador de Entrenamiento	2024-09-24	2024-10-03	2024-10-11	t
19	1	19	2	1	4	MNJ Produccion	Asegurar la operacion de Lider de Celula	2025-09-14	2025-09-22	2025-09-29	t
20	3	20	4	2	0	MNJ Calidad	Asegurar la operacion de Auditor Interno	2024-08-02	2024-08-15	2024-08-19	t
21	2	21	5	3	4	MNJ Ingenieria	Asegurar la operacion de Operador de Produccion Tecnico N1	2025-09-26	2025-10-06	\N	f
22	3	22	10	4	3	MNJ Mantenimiento	Asegurar la operacion de Inspector de Calidad Gerencial N1	2023-12-25	2023-12-31	\N	f
23	1	23	11	5	2	MNJ Logistica	Asegurar la operacion de Ingeniero de Procesos Supervision N1	2024-11-25	2024-12-10	\N	f
24	2	24	15	6	0	MNJ Recursos Humanos	Asegurar la operacion de Tecnico de Mantenimiento Gerencial N1	2024-07-22	2024-07-30	2024-08-01	t
25	2	25	16	7	3	MNJ Seguridad e Higiene	Asegurar la operacion de Auxiliar de Logistica Supervision N1	2025-01-20	2025-01-27	\N	f
26	2	26	20	8	4	MNJ Compras	Asegurar la operacion de Analista de RH Administrativo N1	2024-12-11	2024-12-12	\N	f
27	1	27	25	9	3	MNJ Almacen	Asegurar la operacion de Supervisor de Linea Tecnico N1	2025-05-20	2025-05-21	2025-05-25	t
28	3	28	28	10	1	MNJ Control de Produccion	Asegurar la operacion de Comprador Administrativo N1	2025-09-09	2025-09-16	2025-09-16	t
29	2	29	32	11	3	MNJ Metrologia	Asegurar la operacion de Almacenista Supervision N1	2025-06-11	2025-06-18	2025-06-21	t
30	1	30	34	12	2	MNJ Herramentales	Asegurar la operacion de Planeador Supervision N1	2025-03-16	2025-03-25	2025-04-04	t
31	1	31	36	13	1	MNJ Inyeccion	Asegurar la operacion de Metrologo Gerencial N1	2025-02-21	2025-03-01	2025-03-08	t
32	3	32	41	14	3	MNJ Ensamble	Asegurar la operacion de Diseñador de Herramentales Supervision N1	2024-02-02	2024-02-05	2024-02-07	t
33	1	33	44	15	2	MNJ Pintura	Asegurar la operacion de Operador de Inyeccion Supervision N1	2025-08-05	2025-08-09	2025-08-19	t
34	2	34	49	16	2	MNJ Sistemas	Asegurar la operacion de Ensamblador Gerencial N1	2023-12-28	2024-01-01	\N	f
35	3	35	51	17	0	MNJ Finanzas	Asegurar la operacion de Pintor Industrial Operativo N1	2024-06-18	2024-07-01	2024-07-03	t
36	2	36	52	18	1	MNJ Entrenamiento	Asegurar la operacion de Analista de Sistemas Administrativo N1	2025-09-01	2025-09-03	2025-09-13	t
37	3	37	1	1	0	MNJ Produccion	Asegurar la operacion de Contador Administrativo N1	2025-11-06	2025-11-12	2025-11-15	t
38	2	38	3	2	3	MNJ Calidad	Asegurar la operacion de Coordinador de Entrenamiento Supervision N1	2024-05-15	2024-05-24	\N	f
39	2	39	6	3	1	MNJ Ingenieria	Asegurar la operacion de Lider de Celula Operativo N1	2025-07-09	2025-07-15	\N	f
40	3	40	9	4	0	MNJ Mantenimiento	Asegurar la operacion de Auditor Interno Supervision N1	2024-12-28	2025-01-09	2025-01-12	t
41	2	41	11	5	0	MNJ Logistica	Asegurar la operacion de Operador de Produccion Gerencial N2	2024-09-30	2024-10-09	2024-10-13	t
42	2	42	13	6	0	MNJ Recursos Humanos	Asegurar la operacion de Inspector de Calidad Administrativo N2	2024-06-22	2024-06-23	2024-06-29	t
43	3	43	17	7	2	MNJ Seguridad e Higiene	Asegurar la operacion de Ingeniero de Procesos Supervision N2	2024-09-08	2024-09-14	2024-09-16	t
44	2	44	19	8	3	MNJ Compras	Asegurar la operacion de Tecnico de Mantenimiento Tecnico N2	2024-09-06	2024-09-17	\N	f
45	1	45	22	9	3	MNJ Almacen	Asegurar la operacion de Auxiliar de Logistica Supervision N2	2025-08-16	2025-08-24	2025-08-31	t
46	3	46	28	10	2	MNJ Control de Produccion	Asegurar la operacion de Analista de RH Supervision N2	2025-08-06	2025-08-19	2025-08-24	t
47	2	47	29	11	4	MNJ Metrologia	Asegurar la operacion de Supervisor de Linea Operativo N2	2025-06-15	2025-06-22	2025-06-24	t
48	3	48	34	12	3	MNJ Herramentales	Asegurar la operacion de Comprador Administrativo N2	2024-12-12	2024-12-16	2024-12-24	t
49	2	49	37	13	0	MNJ Inyeccion	Asegurar la operacion de Almacenista Supervision N2	2025-07-02	2025-07-16	\N	f
50	3	50	40	14	4	MNJ Ensamble	Asegurar la operacion de Planeador Administrativo N2	2024-07-06	2024-07-21	2024-07-23	t
51	2	51	44	15	0	MNJ Pintura	Asegurar la operacion de Metrologo Operativo N2	2025-06-10	2025-06-13	\N	f
52	3	52	47	16	0	MNJ Sistemas	Asegurar la operacion de Diseñador de Herramentales Tecnico N2	2025-03-01	2025-03-06	2025-03-13	t
53	1	53	50	17	3	MNJ Finanzas	Asegurar la operacion de Operador de Inyeccion Supervision N2	2025-07-11	2025-07-14	2025-07-19	t
54	1	54	55	18	2	MNJ Entrenamiento	Asegurar la operacion de Ensamblador Tecnico N2	2025-11-06	2025-11-10	2025-11-15	t
55	1	55	1	1	4	MNJ Produccion	Asegurar la operacion de Pintor Industrial Supervision N2	2025-06-17	2025-06-18	\N	f
56	2	56	3	2	4	MNJ Calidad	Asegurar la operacion de Analista de Sistemas Operativo N2	2025-03-17	2025-03-21	2025-03-22	t
57	1	57	8	3	0	MNJ Ingenieria	Asegurar la operacion de Contador Operativo N2	2025-10-07	2025-10-12	2025-10-16	t
58	1	58	10	4	0	MNJ Mantenimiento	Asegurar la operacion de Coordinador de Entrenamiento Operativo N2	2024-05-07	2024-05-17	2024-05-24	t
59	3	59	12	5	2	MNJ Logistica	Asegurar la operacion de Lider de Celula Supervision N2	2025-09-24	2025-10-04	\N	f
60	3	60	13	6	4	MNJ Recursos Humanos	Asegurar la operacion de Auditor Interno Gerencial N2	2025-03-26	2025-04-07	2025-04-16	t
61	1	61	18	7	3	MNJ Seguridad e Higiene	Asegurar la operacion de Operador de Produccion Gerencial N3	2024-07-24	2024-07-31	2024-08-07	t
62	2	62	20	8	3	MNJ Compras	Asegurar la operacion de Inspector de Calidad Operativo N3	2025-09-13	2025-09-26	2025-09-27	t
63	3	63	25	9	3	MNJ Almacen	Asegurar la operacion de Ingeniero de Procesos Gerencial N3	2024-01-05	2024-01-08	2024-01-16	t
64	2	64	26	10	3	MNJ Control de Produccion	Asegurar la operacion de Tecnico de Mantenimiento Tecnico N3	2025-09-24	2025-09-27	2025-10-02	t
65	3	65	32	11	2	MNJ Metrologia	Asegurar la operacion de Auxiliar de Logistica Tecnico N3	2025-10-28	2025-10-31	2025-11-09	t
66	3	66	34	12	1	MNJ Herramentales	Asegurar la operacion de Analista de RH Operativo N3	2025-07-13	2025-07-25	2025-07-30	t
67	2	67	37	13	1	MNJ Inyeccion	Asegurar la operacion de Supervisor de Linea Gerencial N3	2025-02-18	2025-02-27	\N	f
68	1	68	39	14	4	MNJ Ensamble	Asegurar la operacion de Comprador Operativo N3	2025-10-09	2025-10-21	\N	f
69	2	69	43	15	3	MNJ Pintura	Asegurar la operacion de Almacenista Gerencial N3	2025-10-19	2025-10-21	2025-10-22	t
70	1	70	48	16	3	MNJ Sistemas	Asegurar la operacion de Planeador Administrativo N3	2024-01-30	2024-02-02	2024-02-08	t
71	3	71	50	17	0	MNJ Finanzas	Asegurar la operacion de Metrologo Administrativo N3	2024-03-09	2024-03-10	2024-03-16	t
72	1	72	52	18	4	MNJ Entrenamiento	Asegurar la operacion de Diseñador de Herramentales Tecnico N3	2025-03-01	2025-03-03	2025-03-13	t
73	2	73	1	1	3	MNJ Produccion	Asegurar la operacion de Operador de Inyeccion Operativo N3	2024-12-24	2025-01-02	2025-01-04	t
74	3	74	3	2	1	MNJ Calidad	Asegurar la operacion de Ensamblador Administrativo N3	2025-02-28	2025-03-14	2025-03-22	t
75	2	75	7	3	3	MNJ Ingenieria	Asegurar la operacion de Pintor Industrial Gerencial N3	2025-06-21	2025-07-05	2025-07-15	t
76	1	76	10	4	2	MNJ Mantenimiento	Asegurar la operacion de Analista de Sistemas Gerencial N3	2024-10-18	2024-10-28	2024-10-31	t
77	3	77	11	5	0	MNJ Logistica	Asegurar la operacion de Contador Supervision N3	2024-11-26	2024-12-10	2024-12-16	t
78	3	78	13	6	2	MNJ Recursos Humanos	Asegurar la operacion de Coordinador de Entrenamiento Tecnico N3	2024-02-06	2024-02-21	2024-03-01	t
79	3	79	18	7	2	MNJ Seguridad e Higiene	Asegurar la operacion de Lider de Celula Gerencial N3	2024-06-24	2024-06-26	2024-06-27	t
80	2	80	20	8	1	MNJ Compras	Asegurar la operacion de Auditor Interno Tecnico N3	2024-09-21	2024-09-24	\N	f
81	2	81	23	9	1	MNJ Almacen	Asegurar la operacion de Operador de Produccion Supervision N4	2024-07-24	2024-07-29	2024-07-29	t
82	2	82	28	10	4	MNJ Control de Produccion	Asegurar la operacion de Inspector de Calidad Gerencial N4	2024-01-07	2024-01-12	2024-01-16	t
83	2	83	31	11	0	MNJ Metrologia	Asegurar la operacion de Ingeniero de Procesos Tecnico N4	2025-07-23	2025-08-02	2025-08-07	t
84	1	84	34	12	1	MNJ Herramentales	Asegurar la operacion de Tecnico de Mantenimiento Gerencial N4	2024-03-19	2024-03-20	2024-03-23	t
85	3	85	38	13	1	MNJ Inyeccion	Asegurar la operacion de Auxiliar de Logistica Gerencial N4	2024-02-06	2024-02-20	\N	f
86	2	86	39	14	4	MNJ Ensamble	Asegurar la operacion de Analista de RH Administrativo N4	2025-05-17	2025-05-28	2025-06-03	t
87	3	87	44	15	3	MNJ Pintura	Asegurar la operacion de Supervisor de Linea Operativo N4	2024-07-25	2024-08-05	2024-08-08	t
88	1	88	46	16	2	MNJ Sistemas	Asegurar la operacion de Comprador Supervision N4	2025-07-17	2025-07-29	\N	f
89	2	89	50	17	3	MNJ Finanzas	Asegurar la operacion de Almacenista Tecnico N4	2024-07-03	2024-07-18	\N	f
90	3	90	55	18	2	MNJ Entrenamiento	Asegurar la operacion de Planeador Tecnico N4	2024-02-02	2024-02-13	2024-02-22	t
91	1	91	1	1	4	MNJ Produccion	Asegurar la operacion de Metrologo Gerencial N4	2024-12-12	2024-12-27	2025-01-02	t
92	2	92	4	2	2	MNJ Calidad	Asegurar la operacion de Diseñador de Herramentales Administrativo N4	2024-04-24	2024-04-28	2024-05-05	t
93	2	93	8	3	1	MNJ Ingenieria	Asegurar la operacion de Operador de Inyeccion Gerencial N4	2024-05-02	2024-05-15	\N	f
94	1	94	10	4	4	MNJ Mantenimiento	Asegurar la operacion de Ensamblador Supervision N4	2025-01-31	2025-02-02	\N	f
95	1	95	11	5	1	MNJ Logistica	Asegurar la operacion de Pintor Industrial Supervision N4	2025-07-19	2025-07-28	\N	f
96	1	96	13	6	1	MNJ Recursos Humanos	Asegurar la operacion de Analista de Sistemas Tecnico N4	2025-01-27	2025-01-28	2025-02-01	t
97	2	97	18	7	2	MNJ Seguridad e Higiene	Asegurar la operacion de Contador Gerencial N4	2024-02-12	2024-02-23	2024-02-29	t
98	1	98	20	8	1	MNJ Compras	Asegurar la operacion de Coordinador de Entrenamiento Tecnico N4	2023-12-14	2023-12-20	2023-12-23	t
99	2	99	23	9	2	MNJ Almacen	Asegurar la operacion de Lider de Celula Supervision N4	2024-07-24	2024-08-01	2024-08-05	t
100	2	100	27	10	4	MNJ Control de Produccion	Asegurar la operacion de Auditor Interno Operativo N4	2024-06-17	2024-06-29	2024-06-29	t
101	3	101	32	11	0	MNJ Metrologia	Asegurar la operacion de Operador de Produccion Operativo N5	2025-05-30	2025-06-07	2025-06-09	t
102	2	102	35	12	4	MNJ Herramentales	Asegurar la operacion de Inspector de Calidad Supervision N5	2025-01-15	2025-01-26	\N	f
103	1	103	36	13	3	MNJ Inyeccion	Asegurar la operacion de Ingeniero de Procesos Operativo N5	2024-11-01	2024-11-10	\N	f
104	2	104	40	14	4	MNJ Ensamble	Asegurar la operacion de Tecnico de Mantenimiento Operativo N5	2025-06-27	2025-07-08	\N	f
105	3	105	44	15	3	MNJ Pintura	Asegurar la operacion de Auxiliar de Logistica Administrativo N5	2025-01-25	2025-02-08	\N	f
106	3	106	47	16	1	MNJ Sistemas	Asegurar la operacion de Analista de RH Administrativo N5	2025-08-02	2025-08-13	2025-08-14	t
107	3	107	51	17	4	MNJ Finanzas	Asegurar la operacion de Supervisor de Linea Operativo N5	2024-03-26	2024-03-30	\N	f
108	3	108	52	18	2	MNJ Entrenamiento	Asegurar la operacion de Comprador Operativo N5	2025-10-09	2025-10-12	\N	f
109	3	109	1	1	0	MNJ Produccion	Asegurar la operacion de Almacenista Gerencial N5	2025-01-10	2025-01-16	2025-01-17	t
110	3	110	4	2	2	MNJ Calidad	Asegurar la operacion de Planeador Supervision N5	2024-10-08	2024-10-18	\N	f
111	3	111	8	3	0	MNJ Ingenieria	Asegurar la operacion de Metrologo Administrativo N5	2025-10-13	2025-10-16	2025-10-17	t
112	3	112	10	4	3	MNJ Mantenimiento	Asegurar la operacion de Diseñador de Herramentales Administrativo N5	2024-01-22	2024-01-27	2024-02-05	t
113	2	113	11	5	4	MNJ Logistica	Asegurar la operacion de Operador de Inyeccion Supervision N5	2024-12-24	2024-12-31	2025-01-05	t
114	2	114	14	6	2	MNJ Recursos Humanos	Asegurar la operacion de Ensamblador Administrativo N5	2024-12-31	2025-01-03	2025-01-08	t
115	2	115	18	7	1	MNJ Seguridad e Higiene	Asegurar la operacion de Pintor Industrial Operativo N5	2024-09-14	2024-09-26	2024-10-01	t
116	2	116	20	8	3	MNJ Compras	Asegurar la operacion de Analista de Sistemas Supervision N5	2024-06-27	2024-06-29	2024-07-03	t
117	3	117	24	9	4	MNJ Almacen	Asegurar la operacion de Contador Supervision N5	2025-03-16	2025-03-17	\N	f
118	1	118	28	10	1	MNJ Control de Produccion	Asegurar la operacion de Coordinador de Entrenamiento Gerencial N5	2024-03-10	2024-03-17	2024-03-18	t
119	2	119	29	11	0	MNJ Metrologia	Asegurar la operacion de Lider de Celula Gerencial N5	2025-04-17	2025-04-19	2025-04-25	t
120	1	120	35	12	0	MNJ Herramentales	Asegurar la operacion de Auditor Interno Tecnico N5	2024-09-08	2024-09-18	2024-09-26	t
121	2	121	38	13	1	MNJ Inyeccion	Asegurar la operacion de Operador de Produccion Tecnico N6	2024-09-18	2024-09-23	2024-09-24	t
122	1	122	39	14	2	MNJ Ensamble	Asegurar la operacion de Inspector de Calidad Gerencial N6	2025-08-11	2025-08-16	2025-08-16	t
123	1	123	42	15	4	MNJ Pintura	Asegurar la operacion de Ingeniero de Procesos Gerencial N6	2025-09-08	2025-09-14	2025-09-23	t
124	1	124	48	16	2	MNJ Sistemas	Asegurar la operacion de Tecnico de Mantenimiento Tecnico N6	2025-02-04	2025-02-14	\N	f
125	3	125	50	17	3	MNJ Finanzas	Asegurar la operacion de Auxiliar de Logistica Supervision N6	2024-12-18	2024-12-21	2024-12-26	t
126	2	126	54	18	2	MNJ Entrenamiento	Asegurar la operacion de Analista de RH Gerencial N6	2025-02-10	2025-02-21	2025-02-26	t
127	2	127	2	1	1	MNJ Produccion	Asegurar la operacion de Supervisor de Linea Administrativo N6	2024-09-08	2024-09-21	2024-09-24	t
128	1	128	4	2	2	MNJ Calidad	Asegurar la operacion de Comprador Supervision N6	2024-05-18	2024-05-31	2024-06-03	t
129	1	129	5	3	2	MNJ Ingenieria	Asegurar la operacion de Almacenista Gerencial N6	2024-11-23	2024-11-29	2024-12-06	t
130	1	130	9	4	3	MNJ Mantenimiento	Asegurar la operacion de Planeador Tecnico N6	2025-04-11	2025-04-18	\N	f
131	2	131	11	5	0	MNJ Logistica	Asegurar la operacion de Metrologo Operativo N6	2025-02-21	2025-02-23	2025-03-04	t
132	1	132	13	6	2	MNJ Recursos Humanos	Asegurar la operacion de Diseñador de Herramentales Gerencial N6	2024-06-29	2024-07-10	\N	f
133	2	133	18	7	2	MNJ Seguridad e Higiene	Asegurar la operacion de Operador de Inyeccion Supervision N6	2025-02-19	2025-02-21	2025-03-03	t
134	2	134	20	8	4	MNJ Compras	Asegurar la operacion de Ensamblador Operativo N6	2024-07-13	2024-07-27	2024-07-27	t
135	2	135	23	9	0	MNJ Almacen	Asegurar la operacion de Pintor Industrial Tecnico N6	2023-12-29	2023-12-30	2024-01-01	t
136	1	136	27	10	2	MNJ Control de Produccion	Asegurar la operacion de Analista de Sistemas Tecnico N6	2025-07-05	2025-07-12	2025-07-12	t
137	2	137	29	11	1	MNJ Metrologia	Asegurar la operacion de Contador Operativo N6	2025-09-13	2025-09-24	\N	f
138	2	138	33	12	1	MNJ Herramentales	Asegurar la operacion de Coordinador de Entrenamiento Gerencial N6	2025-01-12	2025-01-17	2025-01-18	t
139	1	139	38	13	1	MNJ Inyeccion	Asegurar la operacion de Lider de Celula Operativo N6	2024-12-11	2024-12-19	2024-12-23	t
140	1	140	41	14	4	MNJ Ensamble	Asegurar la operacion de Auditor Interno Supervision N6	2025-04-10	2025-04-19	2025-04-28	t
141	3	141	45	15	1	MNJ Pintura	Asegurar la operacion de Operador de Produccion Tecnico N7	2024-05-03	2024-05-09	2024-05-10	t
142	3	142	47	16	4	MNJ Sistemas	Asegurar la operacion de Inspector de Calidad Supervision N7	2025-06-05	2025-06-06	2025-06-10	t
143	2	143	51	17	2	MNJ Finanzas	Asegurar la operacion de Ingeniero de Procesos Operativo N7	2024-02-19	2024-02-28	2024-02-28	t
144	1	144	53	18	0	MNJ Entrenamiento	Asegurar la operacion de Tecnico de Mantenimiento Tecnico N7	2024-10-17	2024-10-23	2024-10-30	t
145	3	145	1	1	0	MNJ Produccion	Asegurar la operacion de Auxiliar de Logistica Gerencial N7	2025-02-13	2025-02-25	2025-03-04	t
146	1	146	3	2	0	MNJ Calidad	Asegurar la operacion de Analista de RH Tecnico N7	2024-07-14	2024-07-28	\N	f
147	1	147	5	3	1	MNJ Ingenieria	Asegurar la operacion de Supervisor de Linea Gerencial N7	2025-08-26	2025-09-07	2025-09-13	t
148	2	148	10	4	4	MNJ Mantenimiento	Asegurar la operacion de Comprador Tecnico N7	2025-03-25	2025-03-29	\N	f
149	1	149	12	5	2	MNJ Logistica	Asegurar la operacion de Almacenista Tecnico N7	2025-05-26	2025-06-03	2025-06-08	t
150	3	150	14	6	0	MNJ Recursos Humanos	Asegurar la operacion de Planeador Tecnico N7	2025-07-10	2025-07-19	2025-07-25	t
\.


--
-- Data for Name: diagnosticos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.diagnosticos (id_diagnostico, no_reloj, id_descripcion_puesto, id_competencia, competente, prioridad, ruta_evidencia, fecha_registro, fecha_vencimiento) FROM stdin;
1	10000	100	595	f	Media	\N	2024-02-08	2025-02-07
2	10000	100	596	t	Media	/evidencias/10000_596.pdf	2024-08-12	2025-08-12
3	10000	100	597	t	Media	/evidencias/10000_597.pdf	2025-12-27	2026-12-27
4	10000	100	598	f	Media	\N	2024-11-29	2025-11-29
5	10000	100	598	t	Media	/evidencias/10000_598.pdf	2025-05-01	2026-05-01
6	10000	100	599	t	Alta	/evidencias/10000_599.pdf	2023-10-04	2025-10-03
7	10000	100	599	f	Baja	\N	2025-08-09	2027-08-09
8	10000	100	600	t	Media	/evidencias/10000_600.pdf	2024-09-22	2025-09-22
9	10000	100	600	f	Alta	\N	2024-02-13	2026-02-12
10	10000	100	601	t	Alta	/evidencias/10000_601.pdf	2025-09-19	2027-09-19
11	10000	100	601	t	Baja	/evidencias/10000_601.pdf	2025-05-26	2026-05-26
12	10000	100	602	t	Baja	/evidencias/10000_602.pdf	2025-09-07	2027-09-07
13	10001	89	524	t	Baja	/evidencias/10001_524.pdf	2024-03-04	2026-03-04
14	10001	89	524	t	Baja	/evidencias/10001_524.pdf	2023-12-11	2025-12-10
15	10001	89	525	t	Alta	/evidencias/10001_525.pdf	2024-03-04	2025-03-04
16	10001	89	525	f	Media	\N	2024-02-17	2025-02-16
17	10001	89	526	t	Media	/evidencias/10001_526.pdf	2023-10-15	2025-10-14
18	10001	89	527	f	Alta	\N	2026-02-19	2028-02-19
19	10001	89	528	f	Media	\N	2024-04-14	2025-04-14
20	10001	89	528	t	Alta	/evidencias/10001_528.pdf	2023-11-29	2024-11-28
21	10001	89	529	t	Baja	/evidencias/10001_529.pdf	2024-03-23	2026-03-23
22	10001	89	530	t	Media	/evidencias/10001_530.pdf	2025-08-10	2026-08-10
23	10001	89	530	t	Alta	/evidencias/10001_530.pdf	2023-10-12	2025-10-11
24	10002	84	494	t	Media	/evidencias/10002_494.pdf	2025-08-15	2027-08-15
25	10002	84	495	f	Baja	\N	2024-04-14	2026-04-14
26	10002	84	495	t	Media	/evidencias/10002_495.pdf	2024-02-09	2026-02-08
27	10002	84	496	t	Media	/evidencias/10002_496.pdf	2023-11-08	2025-11-07
28	10002	84	496	f	Alta	\N	2023-07-05	2025-07-04
29	10002	84	497	t	Alta	/evidencias/10002_497.pdf	2025-05-26	2026-05-26
30	10002	84	497	t	Baja	/evidencias/10002_497.pdf	2024-08-15	2026-08-15
31	10002	84	498	t	Alta	/evidencias/10002_498.pdf	2024-05-27	2026-05-27
32	10002	84	498	t	Media	/evidencias/10002_498.pdf	2024-11-13	2025-11-13
33	10003	25	140	f	Baja	\N	2025-03-08	2026-03-08
34	10003	25	141	t	Alta	/evidencias/10003_141.pdf	2025-06-27	2027-06-27
35	10003	25	141	f	Baja	\N	2026-02-17	2027-02-17
36	10003	25	142	t	Baja	/evidencias/10003_142.pdf	2025-11-22	2026-11-22
37	10003	25	143	t	Media	/evidencias/10003_143.pdf	2023-12-02	2024-12-01
38	10003	25	144	f	Media	\N	2025-07-26	2026-07-26
39	10003	25	144	t	Baja	/evidencias/10003_144.pdf	2025-09-08	2027-09-08
40	10004	140	836	f	Alta	\N	2023-10-06	2024-10-05
41	10004	140	836	t	Alta	/evidencias/10004_836.pdf	2024-05-24	2026-05-24
42	10004	140	837	t	Alta	/evidencias/10004_837.pdf	2024-01-08	2026-01-07
43	10004	140	837	t	Media	/evidencias/10004_837.pdf	2024-03-31	2025-03-31
44	10004	140	838	f	Baja	\N	2025-04-14	2026-04-14
45	10004	140	839	t	Baja	/evidencias/10004_839.pdf	2026-01-17	2028-01-17
46	10004	140	840	t	Baja	/evidencias/10004_840.pdf	2024-01-22	2026-01-21
47	10004	140	841	t	Media	/evidencias/10004_841.pdf	2023-12-21	2025-12-20
48	10004	140	842	t	Baja	/evidencias/10004_842.pdf	2025-01-26	2027-01-26
49	10004	140	842	t	Media	/evidencias/10004_842.pdf	2024-10-24	2025-10-24
50	10004	140	843	t	Alta	/evidencias/10004_843.pdf	2024-03-13	2026-03-13
51	10005	147	877	t	Alta	/evidencias/10005_877.pdf	2023-08-09	2024-08-08
52	10005	147	877	t	Alta	/evidencias/10005_877.pdf	2025-04-24	2027-04-24
53	10005	147	878	t	Media	/evidencias/10005_878.pdf	2024-08-20	2026-08-20
54	10005	147	879	t	Alta	/evidencias/10005_879.pdf	2026-02-10	2027-02-10
55	10005	147	880	t	Alta	/evidencias/10005_880.pdf	2024-12-07	2026-12-07
56	10005	147	880	t	Media	/evidencias/10005_880.pdf	2025-03-19	2026-03-19
57	10005	147	881	f	Media	\N	2024-11-15	2025-11-15
58	10006	55	321	t	Media	/evidencias/10006_321.pdf	2024-05-08	2026-05-08
59	10006	55	322	t	Media	/evidencias/10006_322.pdf	2026-03-17	2027-03-17
60	10006	55	323	t	Alta	/evidencias/10006_323.pdf	2024-12-20	2026-12-20
61	10006	55	323	t	Media	/evidencias/10006_323.pdf	2023-12-03	2025-12-02
62	10006	55	324	t	Baja	/evidencias/10006_324.pdf	2024-12-26	2026-12-26
63	10006	55	324	t	Alta	/evidencias/10006_324.pdf	2026-02-09	2027-02-09
64	10007	25	140	t	Baja	/evidencias/10007_140.pdf	2024-03-27	2025-03-27
65	10007	25	141	t	Alta	/evidencias/10007_141.pdf	2024-05-18	2025-05-18
66	10007	25	141	t	Media	/evidencias/10007_141.pdf	2023-10-28	2024-10-27
67	10007	25	142	t	Media	/evidencias/10007_142.pdf	2024-08-19	2026-08-19
68	10007	25	142	f	Media	\N	2024-10-02	2026-10-02
69	10007	25	143	f	Alta	\N	2023-08-15	2025-08-14
70	10007	25	143	t	Media	/evidencias/10007_143.pdf	2025-09-22	2027-09-22
71	10007	25	144	t	Baja	/evidencias/10007_144.pdf	2025-12-19	2027-12-19
72	10008	48	277	t	Media	/evidencias/10008_277.pdf	2023-06-22	2025-06-21
73	10008	48	278	t	Alta	/evidencias/10008_278.pdf	2023-09-30	2025-09-29
74	10008	48	279	t	Baja	/evidencias/10008_279.pdf	2024-11-15	2026-11-15
75	10008	48	280	t	Media	/evidencias/10008_280.pdf	2026-04-25	2027-04-25
76	10008	48	281	t	Media	/evidencias/10008_281.pdf	2026-04-15	2028-04-14
77	10008	48	282	t	Alta	/evidencias/10008_282.pdf	2025-06-25	2026-06-25
78	10008	48	282	t	Baja	/evidencias/10008_282.pdf	2026-03-15	2027-03-15
79	10008	48	283	f	Alta	\N	2024-06-07	2026-06-07
80	10008	48	284	t	Media	/evidencias/10008_284.pdf	2025-02-04	2026-02-04
81	10010	107	637	t	Media	/evidencias/10010_637.pdf	2024-09-04	2026-09-04
82	10010	107	637	t	Media	/evidencias/10010_637.pdf	2024-10-28	2026-10-28
83	10010	107	638	t	Alta	/evidencias/10010_638.pdf	2023-06-10	2025-06-09
84	10010	107	638	t	Baja	/evidencias/10010_638.pdf	2024-06-06	2025-06-06
85	10010	107	639	f	Media	\N	2026-03-05	2028-03-04
86	10010	107	639	t	Baja	/evidencias/10010_639.pdf	2024-01-28	2025-01-27
87	10010	107	640	f	Alta	\N	2023-11-29	2024-11-28
88	10010	107	640	t	Media	/evidencias/10010_640.pdf	2025-03-03	2026-03-03
89	10010	107	641	t	Media	/evidencias/10010_641.pdf	2024-04-12	2026-04-12
90	10010	107	641	t	Baja	/evidencias/10010_641.pdf	2024-01-22	2025-01-21
91	10010	107	642	t	Media	/evidencias/10010_642.pdf	2026-01-06	2028-01-06
92	10010	107	643	t	Alta	/evidencias/10010_643.pdf	2025-06-16	2027-06-16
93	10011	144	860	f	Media	\N	2025-01-14	2027-01-14
94	10011	144	861	t	Baja	/evidencias/10011_861.pdf	2024-12-22	2026-12-22
95	10011	144	861	t	Media	/evidencias/10011_861.pdf	2026-01-28	2027-01-28
96	10011	144	862	t	Alta	/evidencias/10011_862.pdf	2025-03-01	2027-03-01
97	10011	144	862	f	Alta	\N	2024-01-28	2026-01-27
98	10011	144	863	t	Media	/evidencias/10011_863.pdf	2024-03-26	2026-03-26
99	10011	144	864	f	Baja	\N	2025-11-20	2027-11-20
100	10011	144	864	t	Media	/evidencias/10011_864.pdf	2023-11-08	2025-11-07
101	10011	144	865	f	Media	\N	2023-08-19	2024-08-18
102	10011	144	866	f	Alta	\N	2024-02-11	2026-02-10
103	10011	144	866	t	Alta	/evidencias/10011_866.pdf	2023-07-23	2025-07-22
104	10012	10	59	t	Alta	/evidencias/10012_59.pdf	2023-09-04	2024-09-03
105	10012	10	60	t	Alta	/evidencias/10012_60.pdf	2025-09-03	2027-09-03
106	10012	10	61	f	Media	\N	2026-04-16	2027-04-16
107	10012	10	62	t	Media	/evidencias/10012_62.pdf	2023-07-08	2024-07-07
108	10012	10	62	t	Media	/evidencias/10012_62.pdf	2023-11-02	2024-11-01
109	10012	10	63	t	Baja	/evidencias/10012_63.pdf	2024-07-07	2026-07-07
110	10012	10	63	t	Baja	/evidencias/10012_63.pdf	2025-01-01	2026-01-01
111	10012	10	64	f	Alta	\N	2024-09-29	2026-09-29
112	10012	10	64	f	Media	\N	2024-03-14	2025-03-14
113	10012	10	65	f	Alta	\N	2025-08-31	2027-08-31
114	10012	10	65	t	Media	/evidencias/10012_65.pdf	2025-03-28	2026-03-28
115	10012	10	66	f	Baja	\N	2023-08-19	2024-08-18
116	10013	31	173	t	Alta	/evidencias/10013_173.pdf	2023-10-20	2025-10-19
117	10013	31	173	t	Media	/evidencias/10013_173.pdf	2024-10-07	2026-10-07
118	10013	31	174	f	Media	\N	2024-10-26	2025-10-26
119	10013	31	174	f	Media	\N	2026-03-17	2028-03-16
120	10013	31	175	t	Baja	/evidencias/10013_175.pdf	2024-10-31	2025-10-31
121	10013	31	175	t	Media	/evidencias/10013_175.pdf	2025-10-25	2026-10-25
122	10013	31	176	t	Media	/evidencias/10013_176.pdf	2024-10-01	2026-10-01
123	10013	31	177	f	Media	\N	2026-02-06	2027-02-06
124	10013	31	177	t	Baja	/evidencias/10013_177.pdf	2024-10-19	2026-10-19
125	10014	15	87	t	Media	/evidencias/10014_87.pdf	2025-05-02	2026-05-02
126	10014	15	87	f	Media	\N	2025-09-12	2027-09-12
127	10014	15	88	t	Media	/evidencias/10014_88.pdf	2024-10-29	2025-10-29
128	10014	15	88	f	Media	\N	2024-04-06	2026-04-06
129	10014	15	89	t	Media	/evidencias/10014_89.pdf	2023-07-24	2025-07-23
130	10014	15	90	f	Alta	\N	2025-12-27	2026-12-27
131	10014	15	91	t	Alta	/evidencias/10014_91.pdf	2024-06-10	2025-06-10
132	10014	15	91	t	Media	/evidencias/10014_91.pdf	2025-06-25	2026-06-25
133	10015	77	454	t	Media	/evidencias/10015_454.pdf	2023-11-08	2025-11-07
134	10015	77	455	f	Media	\N	2024-05-14	2025-05-14
135	10015	77	455	t	Media	/evidencias/10015_455.pdf	2025-07-15	2027-07-15
136	10015	77	456	f	Baja	\N	2023-12-20	2025-12-19
137	10015	77	457	t	Baja	/evidencias/10015_457.pdf	2025-01-30	2027-01-30
138	10015	77	457	t	Media	/evidencias/10015_457.pdf	2025-05-14	2027-05-14
139	10015	77	458	t	Baja	/evidencias/10015_458.pdf	2023-11-09	2025-11-08
140	10016	144	860	t	Baja	/evidencias/10016_860.pdf	2025-06-25	2026-06-25
141	10016	144	861	t	Media	/evidencias/10016_861.pdf	2024-12-25	2026-12-25
142	10016	144	861	t	Baja	/evidencias/10016_861.pdf	2025-03-06	2027-03-06
143	10016	144	862	f	Alta	\N	2023-06-08	2025-06-07
144	10016	144	863	t	Alta	/evidencias/10016_863.pdf	2025-07-31	2026-07-31
145	10016	144	864	t	Baja	/evidencias/10016_864.pdf	2025-12-10	2027-12-10
146	10016	144	864	t	Media	/evidencias/10016_864.pdf	2025-04-04	2027-04-04
147	10016	144	865	f	Alta	\N	2023-11-03	2025-11-02
148	10016	144	866	f	Alta	\N	2025-08-22	2027-08-22
149	10016	144	866	t	Media	/evidencias/10016_866.pdf	2024-07-17	2025-07-17
150	10018	33	185	t	Alta	/evidencias/10018_185.pdf	2023-09-13	2024-09-12
151	10018	33	185	t	Media	/evidencias/10018_185.pdf	2025-03-18	2026-03-18
152	10018	33	186	t	Baja	/evidencias/10018_186.pdf	2025-07-26	2027-07-26
153	10018	33	186	t	Alta	/evidencias/10018_186.pdf	2023-10-05	2025-10-04
154	10018	33	187	f	Baja	\N	2025-11-26	2027-11-26
155	10018	33	188	t	Media	/evidencias/10018_188.pdf	2024-11-01	2025-11-01
156	10018	33	189	t	Media	/evidencias/10018_189.pdf	2025-01-11	2027-01-11
157	10018	33	190	f	Media	\N	2024-11-22	2026-11-22
158	10018	33	190	t	Alta	/evidencias/10018_190.pdf	2025-07-13	2027-07-13
159	10018	33	191	t	Alta	/evidencias/10018_191.pdf	2026-01-28	2028-01-28
160	10018	33	191	t	Alta	/evidencias/10018_191.pdf	2025-03-18	2026-03-18
161	10018	33	192	t	Baja	/evidencias/10018_192.pdf	2023-10-15	2024-10-14
162	10019	57	329	f	Baja	\N	2024-12-11	2025-12-11
163	10019	57	329	t	Baja	/evidencias/10019_329.pdf	2025-07-15	2026-07-15
164	10019	57	330	f	Baja	\N	2024-11-29	2026-11-29
165	10019	57	330	t	Baja	/evidencias/10019_330.pdf	2025-09-27	2027-09-27
166	10019	57	331	f	Media	\N	2024-09-12	2025-09-12
167	10019	57	331	t	Media	/evidencias/10019_331.pdf	2024-03-25	2026-03-25
168	10019	57	332	t	Baja	/evidencias/10019_332.pdf	2025-09-03	2026-09-03
169	10019	57	332	t	Media	/evidencias/10019_332.pdf	2024-02-11	2026-02-10
170	10019	57	333	f	Media	\N	2024-01-07	2025-01-06
171	10019	57	333	f	Media	\N	2024-02-26	2025-02-25
172	10021	123	732	t	Alta	/evidencias/10021_732.pdf	2025-04-21	2027-04-21
173	10021	123	733	t	Media	/evidencias/10021_733.pdf	2024-09-26	2026-09-26
174	10021	123	734	t	Media	/evidencias/10021_734.pdf	2025-06-27	2027-06-27
175	10021	123	734	t	Media	/evidencias/10021_734.pdf	2025-12-22	2027-12-22
176	10021	123	735	f	Media	\N	2025-12-05	2026-12-05
177	10021	123	736	t	Baja	/evidencias/10021_736.pdf	2025-04-15	2026-04-15
178	10021	123	737	t	Alta	/evidencias/10021_737.pdf	2025-11-25	2026-11-25
179	10021	123	738	t	Media	/evidencias/10021_738.pdf	2023-08-25	2024-08-24
180	10021	123	739	t	Media	/evidencias/10021_739.pdf	2023-08-25	2024-08-24
181	10021	123	739	t	Baja	/evidencias/10021_739.pdf	2024-12-09	2026-12-09
182	10022	142	848	f	Baja	\N	2024-06-07	2025-06-07
183	10022	142	848	f	Baja	\N	2024-01-10	2026-01-09
184	10022	142	849	f	Baja	\N	2026-02-19	2028-02-19
185	10022	142	849	f	Baja	\N	2024-06-10	2025-06-10
186	10022	142	850	t	Alta	/evidencias/10022_850.pdf	2026-02-07	2028-02-07
187	10022	142	851	t	Baja	/evidencias/10022_851.pdf	2025-12-04	2026-12-04
188	10022	142	851	t	Alta	/evidencias/10022_851.pdf	2024-03-25	2025-03-25
189	10022	142	852	f	Media	\N	2026-05-05	2027-05-05
190	10022	142	853	f	Alta	\N	2023-12-22	2024-12-21
191	10022	142	854	t	Alta	/evidencias/10022_854.pdf	2024-04-27	2025-04-27
192	10023	82	482	f	Baja	\N	2023-07-19	2024-07-18
193	10023	82	483	t	Media	/evidencias/10023_483.pdf	2023-06-07	2024-06-06
194	10023	82	484	t	Alta	/evidencias/10023_484.pdf	2025-11-18	2026-11-18
195	10023	82	484	t	Alta	/evidencias/10023_484.pdf	2025-11-20	2027-11-20
196	10023	82	485	f	Media	\N	2025-04-09	2027-04-09
197	10023	82	485	t	Alta	/evidencias/10023_485.pdf	2025-01-16	2027-01-16
198	10023	82	486	t	Baja	/evidencias/10023_486.pdf	2023-07-19	2025-07-18
199	10023	82	486	t	Alta	/evidencias/10023_486.pdf	2023-09-08	2024-09-07
699	10077	69	408	f	Alta	\N	2024-08-17	2026-08-17
200	10023	82	487	t	Media	/evidencias/10023_487.pdf	2025-08-08	2027-08-08
201	10023	82	488	f	Baja	\N	2026-04-01	2028-03-31
202	10023	82	488	t	Baja	/evidencias/10023_488.pdf	2026-05-13	2028-05-12
203	10024	131	781	t	Media	/evidencias/10024_781.pdf	2025-05-31	2026-05-31
204	10024	131	782	f	Media	\N	2025-08-27	2027-08-27
205	10024	131	783	t	Baja	/evidencias/10024_783.pdf	2024-01-05	2026-01-04
206	10024	131	784	f	Baja	\N	2025-10-19	2027-10-19
207	10024	131	785	t	Media	/evidencias/10024_785.pdf	2026-05-16	2028-05-15
208	10024	131	785	t	Alta	/evidencias/10024_785.pdf	2023-07-21	2025-07-20
209	10024	131	786	t	Media	/evidencias/10024_786.pdf	2024-10-25	2025-10-25
210	10024	131	787	t	Media	/evidencias/10024_787.pdf	2025-05-04	2026-05-04
211	10024	131	787	t	Baja	/evidencias/10024_787.pdf	2026-04-24	2028-04-23
212	10025	88	517	t	Media	/evidencias/10025_517.pdf	2023-08-20	2024-08-19
213	10025	88	517	f	Media	\N	2025-04-08	2027-04-08
214	10025	88	518	t	Media	/evidencias/10025_518.pdf	2025-09-25	2026-09-25
215	10025	88	519	f	Baja	\N	2026-01-28	2028-01-28
216	10025	88	519	t	Baja	/evidencias/10025_519.pdf	2023-09-23	2024-09-22
217	10025	88	520	f	Alta	\N	2024-10-19	2026-10-19
218	10025	88	521	t	Media	/evidencias/10025_521.pdf	2025-03-08	2027-03-08
219	10025	88	522	t	Media	/evidencias/10025_522.pdf	2024-12-22	2026-12-22
220	10025	88	523	t	Alta	/evidencias/10025_523.pdf	2025-09-06	2026-09-06
221	10026	149	889	t	Media	/evidencias/10026_889.pdf	2025-08-06	2026-08-06
222	10026	149	889	t	Baja	/evidencias/10026_889.pdf	2024-12-16	2025-12-16
223	10026	149	890	f	Baja	\N	2025-05-19	2027-05-19
224	10026	149	891	f	Media	\N	2024-12-30	2026-12-30
225	10026	149	891	f	Media	\N	2024-07-27	2025-07-27
226	10026	149	892	t	Alta	/evidencias/10026_892.pdf	2026-01-09	2028-01-09
227	10026	149	892	f	Alta	\N	2025-07-31	2026-07-31
228	10026	149	893	t	Baja	/evidencias/10026_893.pdf	2024-02-24	2025-02-23
229	10026	149	893	t	Alta	/evidencias/10026_893.pdf	2025-03-26	2026-03-26
230	10026	149	894	t	Media	/evidencias/10026_894.pdf	2025-09-12	2027-09-12
231	10026	149	894	t	Baja	/evidencias/10026_894.pdf	2026-02-11	2027-02-11
232	10026	149	895	f	Baja	\N	2024-08-08	2026-08-08
233	10026	149	895	t	Alta	/evidencias/10026_895.pdf	2025-01-20	2027-01-20
234	10027	91	538	t	Media	/evidencias/10027_538.pdf	2024-03-31	2025-03-31
235	10027	91	538	f	Media	\N	2023-11-02	2024-11-01
236	10027	91	539	t	Media	/evidencias/10027_539.pdf	2026-03-02	2028-03-01
237	10027	91	540	t	Media	/evidencias/10027_540.pdf	2023-08-02	2024-08-01
238	10027	91	540	t	Media	/evidencias/10027_540.pdf	2026-04-01	2028-03-31
239	10027	91	541	f	Alta	\N	2025-02-09	2026-02-09
240	10027	91	541	t	Alta	/evidencias/10027_541.pdf	2025-09-12	2027-09-12
241	10027	91	542	t	Alta	/evidencias/10027_542.pdf	2024-06-21	2025-06-21
242	10027	91	542	t	Media	/evidencias/10027_542.pdf	2025-05-26	2027-05-26
243	10027	91	543	t	Media	/evidencias/10027_543.pdf	2025-01-12	2027-01-12
244	10027	91	543	t	Media	/evidencias/10027_543.pdf	2024-07-12	2025-07-12
245	10027	91	544	t	Media	/evidencias/10027_544.pdf	2024-09-15	2025-09-15
246	10027	91	544	f	Alta	\N	2024-03-05	2025-03-05
247	10028	68	396	t	Alta	/evidencias/10028_396.pdf	2025-06-17	2027-06-17
248	10028	68	397	f	Media	\N	2026-03-12	2027-03-12
249	10028	68	398	f	Media	\N	2025-12-13	2026-12-13
250	10028	68	399	t	Baja	/evidencias/10028_399.pdf	2025-01-21	2026-01-21
251	10028	68	399	t	Baja	/evidencias/10028_399.pdf	2024-07-19	2025-07-19
252	10028	68	400	t	Alta	/evidencias/10028_400.pdf	2025-01-24	2027-01-24
253	10028	68	400	f	Media	\N	2023-08-05	2024-08-04
254	10028	68	401	t	Alta	/evidencias/10028_401.pdf	2026-02-07	2028-02-07
255	10028	68	402	f	Media	\N	2024-12-17	2025-12-17
256	10028	68	402	f	Media	\N	2023-09-25	2024-09-24
257	10028	68	403	t	Alta	/evidencias/10028_403.pdf	2024-07-27	2025-07-27
258	10028	68	403	f	Alta	\N	2024-04-28	2026-04-28
259	10029	150	896	t	Baja	/evidencias/10029_896.pdf	2025-04-08	2027-04-08
260	10029	150	897	f	Alta	\N	2023-09-12	2025-09-11
261	10029	150	898	t	Media	/evidencias/10029_898.pdf	2024-05-30	2025-05-30
262	10029	150	899	f	Alta	\N	2024-02-11	2026-02-10
263	10029	150	900	t	Media	/evidencias/10029_900.pdf	2025-04-07	2027-04-07
264	10029	150	900	t	Baja	/evidencias/10029_900.pdf	2025-01-06	2026-01-06
265	10029	150	901	t	Alta	/evidencias/10029_901.pdf	2025-07-28	2026-07-28
266	10029	150	901	t	Alta	/evidencias/10029_901.pdf	2023-08-15	2025-08-14
267	10030	41	232	t	Alta	/evidencias/10030_232.pdf	2024-09-27	2026-09-27
268	10030	41	232	f	Baja	\N	2024-10-20	2026-10-20
269	10030	41	233	f	Baja	\N	2024-05-21	2025-05-21
270	10030	41	234	f	Baja	\N	2026-04-05	2028-04-04
271	10030	41	235	f	Alta	\N	2024-03-29	2025-03-29
272	10030	41	235	t	Media	/evidencias/10030_235.pdf	2026-04-13	2027-04-13
273	10030	41	236	t	Alta	/evidencias/10030_236.pdf	2025-07-28	2026-07-28
274	10030	41	236	t	Media	/evidencias/10030_236.pdf	2024-08-18	2025-08-18
275	10030	41	237	t	Alta	/evidencias/10030_237.pdf	2024-01-30	2026-01-29
276	10030	41	237	t	Alta	/evidencias/10030_237.pdf	2023-09-23	2024-09-22
277	10030	41	238	f	Alta	\N	2023-07-02	2025-07-01
278	10030	41	238	t	Media	/evidencias/10030_238.pdf	2024-05-15	2025-05-15
279	10031	11	67	t	Media	/evidencias/10031_67.pdf	2025-09-24	2026-09-24
280	10031	11	67	t	Baja	/evidencias/10031_67.pdf	2024-06-13	2026-06-13
281	10031	11	68	t	Baja	/evidencias/10031_68.pdf	2023-10-21	2025-10-20
282	10031	11	69	t	Media	/evidencias/10031_69.pdf	2024-12-12	2025-12-12
283	10031	11	70	t	Baja	/evidencias/10031_70.pdf	2024-05-14	2025-05-14
284	10031	11	70	t	Media	/evidencias/10031_70.pdf	2025-02-23	2026-02-23
285	10032	100	595	t	Baja	/evidencias/10032_595.pdf	2024-11-03	2026-11-03
286	10032	100	595	t	Media	/evidencias/10032_595.pdf	2026-01-31	2027-01-31
287	10032	100	596	f	Media	\N	2025-11-13	2026-11-13
288	10032	100	596	f	Alta	\N	2026-04-14	2028-04-13
289	10032	100	597	t	Media	/evidencias/10032_597.pdf	2023-06-14	2025-06-13
290	10032	100	598	t	Alta	/evidencias/10032_598.pdf	2025-12-16	2027-12-16
291	10032	100	599	t	Media	/evidencias/10032_599.pdf	2025-01-01	2026-01-01
292	10032	100	600	t	Media	/evidencias/10032_600.pdf	2025-10-10	2026-10-10
293	10032	100	600	t	Alta	/evidencias/10032_600.pdf	2024-09-16	2025-09-16
294	10032	100	601	f	Baja	\N	2025-07-01	2026-07-01
295	10032	100	602	t	Alta	/evidencias/10032_602.pdf	2025-10-31	2026-10-31
296	10032	100	602	t	Alta	/evidencias/10032_602.pdf	2025-09-30	2027-09-30
297	10033	92	545	t	Baja	/evidencias/10033_545.pdf	2025-05-02	2026-05-02
298	10033	92	545	t	Media	/evidencias/10033_545.pdf	2025-06-16	2026-06-16
299	10033	92	546	f	Baja	\N	2024-07-12	2026-07-12
300	10033	92	547	t	Baja	/evidencias/10033_547.pdf	2023-11-02	2024-11-01
301	10033	92	547	t	Alta	/evidencias/10033_547.pdf	2026-03-17	2027-03-17
302	10033	92	548	t	Baja	/evidencias/10033_548.pdf	2023-07-28	2024-07-27
303	10033	92	548	t	Alta	/evidencias/10033_548.pdf	2023-10-03	2025-10-02
304	10033	92	549	t	Baja	/evidencias/10033_549.pdf	2023-11-18	2024-11-17
305	10033	92	549	t	Alta	/evidencias/10033_549.pdf	2025-04-11	2027-04-11
306	10034	42	239	t	Baja	/evidencias/10034_239.pdf	2024-01-11	2026-01-10
307	10034	42	240	f	Baja	\N	2025-11-12	2027-11-12
308	10034	42	241	f	Baja	\N	2025-04-26	2026-04-26
309	10034	42	241	t	Baja	/evidencias/10034_241.pdf	2025-10-17	2026-10-17
310	10034	42	242	t	Media	/evidencias/10034_242.pdf	2025-12-19	2026-12-19
311	10034	42	242	f	Media	\N	2024-05-11	2025-05-11
312	10034	42	243	t	Alta	/evidencias/10034_243.pdf	2023-10-28	2025-10-27
313	10034	42	244	t	Baja	/evidencias/10034_244.pdf	2025-06-21	2027-06-21
314	10034	42	244	f	Baja	\N	2023-11-04	2024-11-03
315	10034	42	245	f	Media	\N	2025-06-06	2027-06-06
316	10034	42	245	t	Alta	/evidencias/10034_245.pdf	2023-10-30	2025-10-29
317	10034	42	246	t	Alta	/evidencias/10034_246.pdf	2024-07-16	2025-07-16
318	10035	17	97	t	Alta	/evidencias/10035_97.pdf	2026-05-06	2027-05-06
319	10035	17	98	t	Baja	/evidencias/10035_98.pdf	2025-07-09	2026-07-09
320	10035	17	98	t	Media	/evidencias/10035_98.pdf	2026-05-31	2027-05-31
321	10035	17	99	t	Alta	/evidencias/10035_99.pdf	2023-08-23	2025-08-22
322	10035	17	100	f	Alta	\N	2025-10-26	2026-10-26
323	10035	17	101	t	Baja	/evidencias/10035_101.pdf	2026-01-27	2028-01-27
324	10035	17	102	t	Baja	/evidencias/10035_102.pdf	2024-11-23	2026-11-23
325	10035	17	102	t	Alta	/evidencias/10035_102.pdf	2024-09-15	2026-09-15
326	10035	17	103	f	Alta	\N	2026-02-10	2028-02-10
327	10036	33	185	f	Baja	\N	2026-04-15	2027-04-15
328	10036	33	185	f	Baja	\N	2024-05-22	2026-05-22
329	10036	33	186	f	Media	\N	2024-03-04	2026-03-04
330	10036	33	186	t	Baja	/evidencias/10036_186.pdf	2023-08-01	2024-07-31
331	10036	33	187	f	Baja	\N	2024-07-04	2026-07-04
332	10036	33	187	t	Baja	/evidencias/10036_187.pdf	2025-02-20	2027-02-20
333	10036	33	188	t	Alta	/evidencias/10036_188.pdf	2024-02-14	2026-02-13
334	10036	33	188	f	Baja	\N	2024-01-30	2025-01-29
335	10036	33	189	t	Media	/evidencias/10036_189.pdf	2026-03-18	2027-03-18
336	10036	33	190	f	Baja	\N	2026-03-08	2027-03-08
337	10036	33	191	t	Baja	/evidencias/10036_191.pdf	2023-06-11	2025-06-10
338	10036	33	191	t	Media	/evidencias/10036_191.pdf	2025-09-29	2027-09-29
339	10036	33	192	t	Baja	/evidencias/10036_192.pdf	2024-11-08	2026-11-08
340	10036	33	192	t	Baja	/evidencias/10036_192.pdf	2025-09-01	2026-09-01
341	10037	78	459	t	Media	/evidencias/10037_459.pdf	2024-06-20	2025-06-20
342	10037	78	460	f	Media	\N	2026-02-09	2027-02-09
343	10037	78	461	t	Media	/evidencias/10037_461.pdf	2025-08-17	2027-08-17
344	10037	78	462	t	Baja	/evidencias/10037_462.pdf	2024-01-22	2026-01-21
345	10038	64	367	t	Media	/evidencias/10038_367.pdf	2025-12-31	2027-12-31
346	10038	64	367	t	Alta	/evidencias/10038_367.pdf	2025-11-06	2026-11-06
347	10038	64	368	t	Alta	/evidencias/10038_368.pdf	2026-02-24	2028-02-24
348	10038	64	368	t	Baja	/evidencias/10038_368.pdf	2024-08-05	2025-08-05
349	10038	64	369	t	Baja	/evidencias/10038_369.pdf	2026-04-25	2028-04-24
350	10038	64	369	t	Alta	/evidencias/10038_369.pdf	2024-11-03	2025-11-03
351	10038	64	370	f	Alta	\N	2025-11-13	2027-11-13
352	10038	64	371	t	Media	/evidencias/10038_371.pdf	2026-02-26	2027-02-26
353	10038	64	372	f	Baja	\N	2025-02-14	2026-02-14
354	10038	64	372	f	Alta	\N	2025-04-06	2027-04-06
355	10038	64	373	t	Media	/evidencias/10038_373.pdf	2023-11-11	2025-11-10
356	10038	64	373	t	Media	/evidencias/10038_373.pdf	2023-07-30	2024-07-29
357	10039	127	757	t	Baja	/evidencias/10039_757.pdf	2025-03-29	2026-03-29
358	10039	127	757	f	Baja	\N	2025-12-14	2027-12-14
359	10039	127	758	f	Baja	\N	2025-08-16	2026-08-16
360	10039	127	759	t	Media	/evidencias/10039_759.pdf	2024-07-06	2025-07-06
361	10039	127	760	t	Baja	/evidencias/10039_760.pdf	2025-05-17	2026-05-17
362	10039	127	760	t	Baja	/evidencias/10039_760.pdf	2024-10-10	2025-10-10
363	10039	127	761	f	Media	\N	2023-08-10	2025-08-09
364	10039	127	762	t	Media	/evidencias/10039_762.pdf	2024-12-23	2026-12-23
365	10040	144	860	t	Alta	/evidencias/10040_860.pdf	2023-12-10	2024-12-09
366	10040	144	861	f	Media	\N	2026-01-28	2028-01-28
367	10040	144	861	t	Media	/evidencias/10040_861.pdf	2023-10-30	2024-10-29
368	10040	144	862	t	Alta	/evidencias/10040_862.pdf	2024-05-19	2026-05-19
369	10040	144	863	f	Media	\N	2025-09-30	2027-09-30
370	10040	144	864	t	Alta	/evidencias/10040_864.pdf	2024-04-03	2026-04-03
371	10040	144	864	t	Alta	/evidencias/10040_864.pdf	2023-11-27	2024-11-26
372	10040	144	865	f	Media	\N	2024-01-20	2025-01-19
373	10040	144	865	t	Alta	/evidencias/10040_865.pdf	2025-01-08	2027-01-08
374	10040	144	866	t	Alta	/evidencias/10040_866.pdf	2024-12-18	2025-12-18
375	10041	119	706	t	Media	/evidencias/10041_706.pdf	2023-06-02	2025-06-01
376	10041	119	707	f	Baja	\N	2024-09-13	2025-09-13
377	10041	119	707	f	Alta	\N	2025-05-13	2026-05-13
378	10041	119	708	t	Media	/evidencias/10041_708.pdf	2025-09-21	2026-09-21
379	10041	119	709	t	Media	/evidencias/10041_709.pdf	2024-05-07	2025-05-07
380	10041	119	710	t	Baja	/evidencias/10041_710.pdf	2024-02-12	2026-02-11
381	10042	98	582	t	Alta	/evidencias/10042_582.pdf	2025-08-07	2027-08-07
382	10042	98	583	t	Media	/evidencias/10042_583.pdf	2025-06-07	2026-06-07
383	10042	98	584	f	Media	\N	2026-04-15	2028-04-14
384	10042	98	585	f	Alta	\N	2025-06-08	2027-06-08
385	10042	98	586	t	Baja	/evidencias/10042_586.pdf	2023-11-29	2025-11-28
386	10042	98	587	t	Baja	/evidencias/10042_587.pdf	2026-03-09	2028-03-08
387	10042	98	588	t	Media	/evidencias/10042_588.pdf	2023-08-11	2024-08-10
388	10043	69	404	f	Baja	\N	2025-07-22	2027-07-22
389	10043	69	405	t	Media	/evidencias/10043_405.pdf	2024-07-20	2025-07-20
390	10043	69	405	t	Baja	/evidencias/10043_405.pdf	2025-02-09	2026-02-09
391	10043	69	406	f	Media	\N	2025-08-30	2027-08-30
392	10043	69	406	t	Baja	/evidencias/10043_406.pdf	2023-09-08	2025-09-07
393	10043	69	407	t	Media	/evidencias/10043_407.pdf	2024-09-03	2026-09-03
394	10043	69	407	t	Media	/evidencias/10043_407.pdf	2026-01-25	2028-01-25
395	10043	69	408	t	Baja	/evidencias/10043_408.pdf	2023-06-03	2025-06-02
396	10043	69	408	f	Media	\N	2024-07-09	2025-07-09
397	10043	69	409	t	Baja	/evidencias/10043_409.pdf	2025-03-28	2026-03-28
398	10043	69	409	t	Baja	/evidencias/10043_409.pdf	2025-10-23	2027-10-23
399	10044	69	404	t	Media	/evidencias/10044_404.pdf	2026-02-10	2027-02-10
700	10077	69	409	f	Media	\N	2024-06-16	2025-06-16
400	10044	69	404	t	Baja	/evidencias/10044_404.pdf	2024-11-09	2026-11-09
401	10044	69	405	t	Media	/evidencias/10044_405.pdf	2025-12-24	2026-12-24
402	10044	69	405	f	Media	\N	2025-09-13	2026-09-13
403	10044	69	406	t	Alta	/evidencias/10044_406.pdf	2025-10-30	2027-10-30
404	10044	69	407	t	Alta	/evidencias/10044_407.pdf	2023-06-07	2024-06-06
405	10044	69	408	f	Alta	\N	2025-08-09	2026-08-09
406	10044	69	409	f	Baja	\N	2025-02-15	2027-02-15
407	10044	69	409	f	Alta	\N	2024-03-26	2026-03-26
408	10045	118	701	f	Baja	\N	2023-06-14	2025-06-13
409	10045	118	702	f	Media	\N	2026-01-06	2027-01-06
410	10045	118	703	t	Baja	/evidencias/10045_703.pdf	2025-05-21	2027-05-21
411	10045	118	703	t	Media	/evidencias/10045_703.pdf	2024-05-22	2026-05-22
412	10045	118	704	f	Media	\N	2025-08-11	2027-08-11
413	10045	118	705	t	Media	/evidencias/10045_705.pdf	2023-09-29	2025-09-28
414	10046	105	626	f	Media	\N	2025-04-18	2026-04-18
415	10046	105	626	t	Media	/evidencias/10046_626.pdf	2026-01-11	2027-01-11
416	10046	105	627	f	Baja	\N	2024-07-10	2026-07-10
417	10046	105	628	t	Baja	/evidencias/10046_628.pdf	2026-01-02	2028-01-02
418	10046	105	628	t	Media	/evidencias/10046_628.pdf	2024-08-08	2026-08-08
419	10046	105	629	t	Alta	/evidencias/10046_629.pdf	2024-05-03	2025-05-03
420	10046	105	629	t	Baja	/evidencias/10046_629.pdf	2024-10-30	2025-10-30
421	10046	105	630	t	Alta	/evidencias/10046_630.pdf	2024-03-05	2026-03-05
422	10046	105	630	t	Baja	/evidencias/10046_630.pdf	2024-08-10	2026-08-10
423	10046	105	631	t	Baja	/evidencias/10046_631.pdf	2024-12-08	2026-12-08
424	10047	140	836	f	Baja	\N	2025-07-14	2027-07-14
425	10047	140	837	t	Media	/evidencias/10047_837.pdf	2025-05-25	2027-05-25
426	10047	140	838	t	Alta	/evidencias/10047_838.pdf	2023-10-03	2025-10-02
427	10047	140	839	t	Media	/evidencias/10047_839.pdf	2024-01-07	2026-01-06
428	10047	140	839	t	Media	/evidencias/10047_839.pdf	2025-10-14	2026-10-14
429	10047	140	840	f	Media	\N	2024-07-29	2026-07-29
430	10047	140	840	t	Baja	/evidencias/10047_840.pdf	2026-01-11	2028-01-11
431	10047	140	841	f	Alta	\N	2026-02-09	2028-02-09
432	10047	140	842	t	Baja	/evidencias/10047_842.pdf	2023-06-07	2025-06-06
433	10047	140	843	t	Baja	/evidencias/10047_843.pdf	2024-06-25	2025-06-25
434	10047	140	843	t	Alta	/evidencias/10047_843.pdf	2023-11-02	2025-11-01
435	10048	45	257	t	Media	/evidencias/10048_257.pdf	2024-09-30	2025-09-30
436	10048	45	258	t	Media	/evidencias/10048_258.pdf	2026-02-03	2027-02-03
437	10048	45	259	t	Media	/evidencias/10048_259.pdf	2025-03-12	2026-03-12
438	10048	45	260	f	Alta	\N	2025-01-05	2027-01-05
439	10048	45	260	t	Media	/evidencias/10048_260.pdf	2025-09-24	2026-09-24
440	10048	45	261	t	Alta	/evidencias/10048_261.pdf	2024-07-13	2026-07-13
441	10048	45	262	f	Media	\N	2024-12-20	2025-12-20
442	10048	45	262	f	Media	\N	2023-08-18	2024-08-17
443	10048	45	263	t	Alta	/evidencias/10048_263.pdf	2023-10-10	2024-10-09
444	10048	45	264	t	Media	/evidencias/10048_264.pdf	2026-05-14	2027-05-14
445	10048	45	264	f	Alta	\N	2025-08-14	2026-08-14
446	10049	107	637	f	Media	\N	2025-01-19	2027-01-19
447	10049	107	637	t	Baja	/evidencias/10049_637.pdf	2026-05-19	2028-05-18
448	10049	107	638	t	Baja	/evidencias/10049_638.pdf	2023-06-25	2024-06-24
449	10049	107	639	f	Alta	\N	2024-01-31	2025-01-30
450	10049	107	640	t	Alta	/evidencias/10049_640.pdf	2023-11-07	2025-11-06
451	10049	107	641	t	Alta	/evidencias/10049_641.pdf	2025-07-22	2027-07-22
452	10049	107	642	t	Alta	/evidencias/10049_642.pdf	2026-03-29	2027-03-29
453	10049	107	643	t	Alta	/evidencias/10049_643.pdf	2023-09-03	2024-09-02
454	10049	107	643	t	Media	/evidencias/10049_643.pdf	2024-10-26	2025-10-26
455	10050	31	173	t	Media	/evidencias/10050_173.pdf	2023-11-07	2024-11-06
456	10050	31	173	t	Alta	/evidencias/10050_173.pdf	2023-09-06	2024-09-05
457	10050	31	174	t	Media	/evidencias/10050_174.pdf	2024-04-10	2026-04-10
458	10050	31	174	t	Baja	/evidencias/10050_174.pdf	2025-10-27	2026-10-27
459	10050	31	175	f	Baja	\N	2025-01-21	2026-01-21
460	10050	31	175	f	Media	\N	2024-03-28	2025-03-28
461	10050	31	176	f	Baja	\N	2025-04-03	2027-04-03
462	10050	31	176	f	Alta	\N	2025-07-27	2027-07-27
463	10050	31	177	t	Baja	/evidencias/10050_177.pdf	2024-05-04	2025-05-04
464	10050	31	177	f	Media	\N	2025-09-28	2027-09-28
465	10051	71	417	f	Alta	\N	2025-01-05	2027-01-05
466	10051	71	418	t	Alta	/evidencias/10051_418.pdf	2024-06-29	2025-06-29
467	10051	71	419	f	Media	\N	2025-10-29	2027-10-29
468	10051	71	420	f	Baja	\N	2025-04-08	2026-04-08
469	10051	71	420	t	Baja	/evidencias/10051_420.pdf	2023-08-31	2025-08-30
470	10051	71	421	t	Media	/evidencias/10051_421.pdf	2025-04-08	2027-04-08
471	10051	71	421	t	Alta	/evidencias/10051_421.pdf	2024-05-10	2026-05-10
472	10051	71	422	t	Media	/evidencias/10051_422.pdf	2023-06-19	2025-06-18
473	10051	71	422	f	Media	\N	2024-05-29	2026-05-29
474	10051	71	423	f	Media	\N	2025-09-01	2026-09-01
475	10051	71	423	f	Alta	\N	2024-12-20	2026-12-20
476	10051	71	424	t	Media	/evidencias/10051_424.pdf	2023-11-27	2024-11-26
477	10052	40	226	t	Baja	/evidencias/10052_226.pdf	2023-07-24	2025-07-23
478	10052	40	226	t	Alta	/evidencias/10052_226.pdf	2024-04-17	2025-04-17
479	10052	40	227	t	Media	/evidencias/10052_227.pdf	2023-07-16	2025-07-15
480	10052	40	228	t	Alta	/evidencias/10052_228.pdf	2024-08-05	2025-08-05
481	10052	40	229	f	Alta	\N	2025-10-08	2027-10-08
482	10052	40	230	t	Media	/evidencias/10052_230.pdf	2024-10-17	2026-10-17
483	10052	40	231	t	Media	/evidencias/10052_231.pdf	2023-06-10	2024-06-09
484	10052	40	231	f	Media	\N	2025-10-28	2027-10-28
485	10053	80	469	t	Media	/evidencias/10053_469.pdf	2024-05-29	2025-05-29
486	10053	80	470	t	Baja	/evidencias/10053_470.pdf	2025-01-21	2027-01-21
487	10053	80	470	t	Baja	/evidencias/10053_470.pdf	2025-07-05	2027-07-05
488	10053	80	471	t	Media	/evidencias/10053_471.pdf	2024-10-23	2025-10-23
489	10053	80	472	t	Media	/evidencias/10053_472.pdf	2025-01-15	2027-01-15
490	10053	80	472	t	Media	/evidencias/10053_472.pdf	2024-09-18	2026-09-18
491	10053	80	473	t	Media	/evidencias/10053_473.pdf	2024-06-17	2025-06-17
492	10053	80	474	t	Media	/evidencias/10053_474.pdf	2025-08-08	2026-08-08
493	10053	80	474	t	Baja	/evidencias/10053_474.pdf	2023-07-19	2025-07-18
494	10054	28	156	f	Media	\N	2025-08-06	2027-08-06
495	10054	28	157	t	Media	/evidencias/10054_157.pdf	2025-02-28	2027-02-28
496	10054	28	157	t	Alta	/evidencias/10054_157.pdf	2023-07-31	2024-07-30
497	10054	28	158	t	Media	/evidencias/10054_158.pdf	2023-12-27	2024-12-26
498	10054	28	158	f	Media	\N	2024-02-10	2025-02-09
499	10054	28	159	t	Media	/evidencias/10054_159.pdf	2024-05-18	2026-05-18
500	10054	28	160	t	Alta	/evidencias/10054_160.pdf	2024-02-20	2026-02-19
501	10054	28	161	f	Baja	\N	2025-04-01	2026-04-01
502	10055	60	343	t	Media	/evidencias/10055_343.pdf	2026-02-07	2028-02-07
503	10055	60	344	t	Media	/evidencias/10055_344.pdf	2025-12-03	2026-12-03
504	10055	60	344	t	Baja	/evidencias/10055_344.pdf	2025-05-23	2026-05-23
505	10055	60	345	t	Media	/evidencias/10055_345.pdf	2024-04-16	2025-04-16
506	10055	60	346	t	Media	/evidencias/10055_346.pdf	2024-12-02	2026-12-02
507	10055	60	346	t	Media	/evidencias/10055_346.pdf	2025-03-23	2027-03-23
508	10055	60	347	t	Media	/evidencias/10055_347.pdf	2023-11-12	2025-11-11
509	10056	123	732	t	Alta	/evidencias/10056_732.pdf	2024-12-16	2025-12-16
510	10056	123	733	t	Alta	/evidencias/10056_733.pdf	2025-07-27	2026-07-27
511	10056	123	733	f	Media	\N	2025-09-18	2026-09-18
512	10056	123	734	t	Alta	/evidencias/10056_734.pdf	2023-11-03	2024-11-02
513	10056	123	734	t	Media	/evidencias/10056_734.pdf	2023-06-24	2025-06-23
514	10056	123	735	t	Media	/evidencias/10056_735.pdf	2024-08-16	2026-08-16
515	10056	123	736	t	Media	/evidencias/10056_736.pdf	2025-08-19	2027-08-19
516	10056	123	737	f	Media	\N	2025-09-30	2026-09-30
517	10056	123	738	t	Alta	/evidencias/10056_738.pdf	2023-09-13	2024-09-12
518	10056	123	738	t	Media	/evidencias/10056_738.pdf	2026-03-23	2027-03-23
519	10056	123	739	t	Media	/evidencias/10056_739.pdf	2025-08-30	2027-08-30
520	10057	6	33	t	Media	/evidencias/10057_33.pdf	2024-06-12	2026-06-12
521	10057	6	33	f	Media	\N	2024-03-11	2026-03-11
522	10057	6	34	t	Baja	/evidencias/10057_34.pdf	2025-05-22	2027-05-22
523	10057	6	34	t	Media	/evidencias/10057_34.pdf	2024-08-24	2026-08-24
524	10057	6	35	t	Alta	/evidencias/10057_35.pdf	2024-11-05	2026-11-05
525	10057	6	36	t	Baja	/evidencias/10057_36.pdf	2023-11-21	2025-11-20
526	10057	6	37	t	Baja	/evidencias/10057_37.pdf	2024-08-31	2025-08-31
527	10057	6	38	t	Media	/evidencias/10057_38.pdf	2025-12-10	2027-12-10
528	10057	6	38	t	Media	/evidencias/10057_38.pdf	2024-02-09	2026-02-08
529	10057	6	39	t	Media	/evidencias/10057_39.pdf	2026-04-24	2028-04-23
530	10058	103	615	t	Media	/evidencias/10058_615.pdf	2023-12-07	2025-12-06
531	10058	103	616	t	Alta	/evidencias/10058_616.pdf	2023-07-17	2024-07-16
532	10058	103	616	t	Alta	/evidencias/10058_616.pdf	2025-05-20	2026-05-20
533	10058	103	617	f	Media	\N	2023-07-11	2024-07-10
534	10058	103	618	f	Media	\N	2024-12-15	2026-12-15
535	10059	131	781	t	Alta	/evidencias/10059_781.pdf	2024-02-28	2026-02-27
536	10059	131	782	f	Baja	\N	2024-09-21	2026-09-21
537	10059	131	783	t	Media	/evidencias/10059_783.pdf	2023-11-12	2025-11-11
538	10059	131	784	f	Baja	\N	2025-03-06	2027-03-06
539	10059	131	785	t	Media	/evidencias/10059_785.pdf	2025-12-08	2027-12-08
540	10059	131	785	t	Media	/evidencias/10059_785.pdf	2024-02-14	2026-02-13
541	10059	131	786	t	Baja	/evidencias/10059_786.pdf	2024-06-16	2026-06-16
542	10059	131	787	f	Alta	\N	2026-01-31	2028-01-31
543	10059	131	787	t	Baja	/evidencias/10059_787.pdf	2023-11-24	2025-11-23
544	10060	84	494	t	Alta	/evidencias/10060_494.pdf	2023-12-20	2024-12-19
545	10060	84	495	t	Baja	/evidencias/10060_495.pdf	2025-08-28	2027-08-28
546	10060	84	495	t	Media	/evidencias/10060_495.pdf	2026-05-28	2027-05-28
547	10060	84	496	t	Alta	/evidencias/10060_496.pdf	2025-12-17	2027-12-17
548	10060	84	496	t	Media	/evidencias/10060_496.pdf	2023-08-17	2024-08-16
549	10060	84	497	f	Media	\N	2024-06-20	2025-06-20
550	10060	84	497	t	Alta	/evidencias/10060_497.pdf	2026-05-09	2027-05-09
551	10060	84	498	t	Media	/evidencias/10060_498.pdf	2023-11-01	2024-10-31
552	10060	84	498	t	Media	/evidencias/10060_498.pdf	2023-11-28	2024-11-27
553	10061	45	257	f	Media	\N	2025-04-28	2027-04-28
554	10061	45	258	t	Baja	/evidencias/10061_258.pdf	2024-06-04	2025-06-04
555	10061	45	259	t	Alta	/evidencias/10061_259.pdf	2024-11-30	2025-11-30
556	10061	45	260	t	Alta	/evidencias/10061_260.pdf	2024-11-23	2026-11-23
557	10061	45	261	t	Media	/evidencias/10061_261.pdf	2025-10-22	2026-10-22
558	10061	45	261	t	Baja	/evidencias/10061_261.pdf	2024-02-28	2026-02-27
559	10061	45	262	f	Media	\N	2025-09-27	2027-09-27
560	10061	45	263	t	Alta	/evidencias/10061_263.pdf	2024-01-01	2025-12-31
561	10061	45	264	f	Baja	\N	2024-03-27	2026-03-27
562	10061	45	264	t	Alta	/evidencias/10061_264.pdf	2025-04-01	2027-04-01
563	10062	55	321	t	Media	/evidencias/10062_321.pdf	2026-04-23	2027-04-23
564	10062	55	321	f	Alta	\N	2023-10-10	2024-10-09
565	10062	55	322	t	Baja	/evidencias/10062_322.pdf	2025-01-08	2027-01-08
566	10062	55	323	t	Media	/evidencias/10062_323.pdf	2024-11-18	2025-11-18
567	10062	55	324	t	Media	/evidencias/10062_324.pdf	2024-05-13	2025-05-13
568	10062	55	324	t	Baja	/evidencias/10062_324.pdf	2023-10-14	2024-10-13
569	10063	33	185	t	Media	/evidencias/10063_185.pdf	2025-09-22	2027-09-22
570	10063	33	186	t	Media	/evidencias/10063_186.pdf	2023-10-30	2024-10-29
571	10063	33	187	t	Media	/evidencias/10063_187.pdf	2026-05-12	2028-05-11
572	10063	33	187	t	Baja	/evidencias/10063_187.pdf	2023-07-18	2024-07-17
573	10063	33	188	f	Media	\N	2024-03-11	2025-03-11
574	10063	33	189	t	Media	/evidencias/10063_189.pdf	2025-12-20	2027-12-20
575	10063	33	190	t	Alta	/evidencias/10063_190.pdf	2024-10-15	2026-10-15
576	10063	33	191	t	Alta	/evidencias/10063_191.pdf	2026-01-26	2027-01-26
577	10063	33	191	f	Baja	\N	2023-07-18	2025-07-17
578	10063	33	192	t	Media	/evidencias/10063_192.pdf	2026-01-14	2028-01-14
579	10064	94	557	t	Media	/evidencias/10064_557.pdf	2025-12-27	2026-12-27
580	10064	94	558	t	Media	/evidencias/10064_558.pdf	2026-02-19	2027-02-19
581	10064	94	558	t	Media	/evidencias/10064_558.pdf	2023-09-01	2025-08-31
582	10064	94	559	t	Alta	/evidencias/10064_559.pdf	2023-09-23	2025-09-22
583	10064	94	560	t	Alta	/evidencias/10064_560.pdf	2024-12-04	2025-12-04
584	10064	94	560	t	Baja	/evidencias/10064_560.pdf	2024-10-22	2026-10-22
585	10064	94	561	f	Baja	\N	2025-05-11	2026-05-11
586	10064	94	561	f	Media	\N	2024-08-07	2026-08-07
587	10064	94	562	t	Media	/evidencias/10064_562.pdf	2024-10-24	2026-10-24
588	10064	94	562	f	Alta	\N	2023-08-03	2025-08-02
589	10064	94	563	t	Alta	/evidencias/10064_563.pdf	2024-11-27	2026-11-27
590	10064	94	563	f	Alta	\N	2026-05-02	2027-05-02
591	10065	40	226	t	Alta	/evidencias/10065_226.pdf	2024-02-10	2026-02-09
592	10065	40	227	t	Media	/evidencias/10065_227.pdf	2025-03-24	2027-03-24
593	10065	40	228	t	Media	/evidencias/10065_228.pdf	2024-10-04	2026-10-04
594	10065	40	228	t	Media	/evidencias/10065_228.pdf	2023-06-24	2024-06-23
595	10065	40	229	f	Media	\N	2023-11-12	2024-11-11
596	10065	40	229	f	Baja	\N	2025-04-22	2027-04-22
597	10065	40	230	t	Alta	/evidencias/10065_230.pdf	2025-12-19	2026-12-19
598	10065	40	231	t	Media	/evidencias/10065_231.pdf	2025-08-31	2027-08-31
599	10065	40	231	f	Media	\N	2024-08-10	2026-08-10
600	10066	72	425	f	Media	\N	2023-08-08	2024-08-07
601	10066	72	425	f	Media	\N	2025-12-10	2026-12-10
602	10066	72	426	t	Media	/evidencias/10066_426.pdf	2025-04-02	2026-04-02
603	10066	72	426	t	Media	/evidencias/10066_426.pdf	2024-12-24	2025-12-24
604	10066	72	427	f	Baja	\N	2025-05-02	2026-05-02
605	10066	72	428	t	Baja	/evidencias/10066_428.pdf	2024-03-24	2025-03-24
606	10066	72	428	f	Alta	\N	2025-12-20	2026-12-20
607	10066	72	429	t	Alta	/evidencias/10066_429.pdf	2024-09-14	2025-09-14
608	10066	72	429	f	Media	\N	2024-02-16	2025-02-15
609	10066	72	430	t	Alta	/evidencias/10066_430.pdf	2024-11-09	2026-11-09
610	10066	72	430	t	Media	/evidencias/10066_430.pdf	2024-10-11	2025-10-11
611	10066	72	431	t	Media	/evidencias/10066_431.pdf	2023-06-20	2024-06-19
612	10066	72	431	f	Alta	\N	2025-10-03	2027-10-03
613	10067	118	701	t	Baja	/evidencias/10067_701.pdf	2024-12-09	2026-12-09
614	10067	118	702	f	Media	\N	2026-01-17	2027-01-17
615	10067	118	703	t	Alta	/evidencias/10067_703.pdf	2025-06-13	2026-06-13
616	10067	118	703	f	Media	\N	2024-04-04	2025-04-04
617	10067	118	704	t	Media	/evidencias/10067_704.pdf	2025-07-23	2027-07-23
618	10067	118	705	f	Media	\N	2025-02-06	2027-02-06
619	10067	118	705	f	Media	\N	2025-12-27	2026-12-27
620	10068	126	753	f	Alta	\N	2025-03-20	2026-03-20
621	10068	126	753	t	Media	/evidencias/10068_753.pdf	2026-05-30	2028-05-29
622	10068	126	754	f	Alta	\N	2025-02-20	2027-02-20
623	10068	126	754	t	Alta	/evidencias/10068_754.pdf	2023-11-21	2024-11-20
624	10068	126	755	t	Media	/evidencias/10068_755.pdf	2024-10-10	2025-10-10
625	10068	126	755	t	Baja	/evidencias/10068_755.pdf	2025-04-13	2027-04-13
626	10068	126	756	f	Baja	\N	2024-09-14	2026-09-14
627	10068	126	756	t	Media	/evidencias/10068_756.pdf	2023-10-31	2025-10-30
628	10069	120	711	t	Alta	/evidencias/10069_711.pdf	2024-05-25	2026-05-25
629	10069	120	712	t	Baja	/evidencias/10069_712.pdf	2023-10-11	2024-10-10
630	10069	120	712	f	Media	\N	2024-03-22	2025-03-22
631	10069	120	713	f	Media	\N	2024-09-09	2026-09-09
632	10069	120	713	t	Baja	/evidencias/10069_713.pdf	2024-05-05	2025-05-05
633	10069	120	714	t	Media	/evidencias/10069_714.pdf	2025-01-08	2027-01-08
634	10069	120	714	f	Media	\N	2025-12-16	2026-12-16
635	10069	120	715	t	Alta	/evidencias/10069_715.pdf	2023-10-10	2025-10-09
636	10069	120	715	f	Media	\N	2024-07-20	2026-07-20
637	10069	120	716	t	Alta	/evidencias/10069_716.pdf	2026-02-28	2027-02-28
638	10069	120	716	t	Alta	/evidencias/10069_716.pdf	2024-04-16	2026-04-16
639	10070	11	67	t	Media	/evidencias/10070_67.pdf	2024-02-01	2025-01-31
640	10070	11	68	t	Alta	/evidencias/10070_68.pdf	2024-07-01	2026-07-01
641	10070	11	68	t	Alta	/evidencias/10070_68.pdf	2024-04-01	2026-04-01
642	10070	11	69	t	Baja	/evidencias/10070_69.pdf	2024-07-08	2026-07-08
643	10070	11	70	t	Media	/evidencias/10070_70.pdf	2024-05-08	2026-05-08
644	10070	11	70	t	Media	/evidencias/10070_70.pdf	2026-01-15	2027-01-15
645	10071	66	382	f	Media	\N	2026-01-11	2027-01-11
646	10071	66	383	t	Media	/evidencias/10071_383.pdf	2024-07-22	2025-07-22
647	10071	66	383	f	Media	\N	2025-11-23	2026-11-23
648	10071	66	384	t	Alta	/evidencias/10071_384.pdf	2024-11-28	2025-11-28
649	10071	66	384	f	Alta	\N	2024-03-23	2025-03-23
650	10071	66	385	f	Alta	\N	2025-10-31	2027-10-31
651	10071	66	386	f	Media	\N	2024-08-03	2025-08-03
652	10071	66	386	t	Baja	/evidencias/10071_386.pdf	2024-06-14	2026-06-14
653	10071	66	387	t	Media	/evidencias/10071_387.pdf	2024-04-28	2026-04-28
654	10071	66	387	t	Media	/evidencias/10071_387.pdf	2026-04-16	2028-04-15
655	10072	109	648	t	Media	/evidencias/10072_648.pdf	2024-12-18	2025-12-18
656	10072	109	649	t	Media	/evidencias/10072_649.pdf	2023-12-30	2025-12-29
657	10072	109	649	f	Media	\N	2025-11-14	2027-11-14
658	10072	109	650	t	Alta	/evidencias/10072_650.pdf	2026-05-19	2028-05-18
659	10072	109	651	t	Alta	/evidencias/10072_651.pdf	2026-03-14	2027-03-14
660	10072	109	652	t	Media	/evidencias/10072_652.pdf	2023-06-06	2024-06-05
661	10072	109	652	t	Baja	/evidencias/10072_652.pdf	2025-12-10	2026-12-10
662	10072	109	653	f	Alta	\N	2024-02-23	2025-02-22
663	10073	55	321	f	Alta	\N	2024-06-11	2025-06-11
664	10073	55	322	f	Media	\N	2024-06-03	2026-06-03
665	10073	55	322	t	Alta	/evidencias/10073_322.pdf	2024-01-09	2025-01-08
666	10073	55	323	f	Alta	\N	2023-08-14	2025-08-13
667	10073	55	323	t	Media	/evidencias/10073_323.pdf	2023-09-17	2025-09-16
668	10073	55	324	f	Alta	\N	2025-03-27	2027-03-27
669	10073	55	324	t	Media	/evidencias/10073_324.pdf	2025-07-21	2026-07-21
670	10074	54	316	t	Alta	/evidencias/10074_316.pdf	2025-04-24	2027-04-24
671	10074	54	316	t	Baja	/evidencias/10074_316.pdf	2025-12-07	2026-12-07
672	10074	54	317	t	Media	/evidencias/10074_317.pdf	2024-10-23	2026-10-23
673	10074	54	318	f	Baja	\N	2025-10-05	2027-10-05
674	10074	54	318	t	Alta	/evidencias/10074_318.pdf	2025-03-17	2026-03-17
675	10074	54	319	t	Alta	/evidencias/10074_319.pdf	2023-08-15	2025-08-14
676	10074	54	319	t	Baja	/evidencias/10074_319.pdf	2024-05-27	2026-05-27
677	10074	54	320	f	Alta	\N	2024-03-12	2025-03-12
678	10074	54	320	t	Media	/evidencias/10074_320.pdf	2024-11-15	2025-11-15
679	10075	51	295	t	Media	/evidencias/10075_295.pdf	2024-02-04	2025-02-03
680	10075	51	295	f	Alta	\N	2023-07-10	2024-07-09
681	10075	51	296	t	Baja	/evidencias/10075_296.pdf	2026-04-04	2028-04-03
682	10075	51	296	f	Alta	\N	2025-09-02	2027-09-02
683	10075	51	297	t	Alta	/evidencias/10075_297.pdf	2025-09-13	2026-09-13
684	10075	51	298	t	Baja	/evidencias/10075_298.pdf	2024-03-29	2025-03-29
685	10075	51	299	t	Media	/evidencias/10075_299.pdf	2024-08-26	2026-08-26
686	10075	51	299	t	Baja	/evidencias/10075_299.pdf	2024-09-05	2025-09-05
687	10075	51	300	t	Baja	/evidencias/10075_300.pdf	2024-09-09	2026-09-09
688	10075	51	300	t	Media	/evidencias/10075_300.pdf	2025-06-04	2026-06-04
689	10075	51	301	t	Alta	/evidencias/10075_301.pdf	2025-02-13	2026-02-13
690	10075	51	301	t	Media	/evidencias/10075_301.pdf	2026-05-30	2028-05-29
691	10075	51	302	t	Alta	/evidencias/10075_302.pdf	2025-12-18	2027-12-18
692	10077	69	404	t	Media	/evidencias/10077_404.pdf	2024-10-23	2025-10-23
693	10077	69	405	t	Baja	/evidencias/10077_405.pdf	2024-12-12	2025-12-12
694	10077	69	405	f	Baja	\N	2024-02-13	2025-02-12
695	10077	69	406	t	Baja	/evidencias/10077_406.pdf	2026-04-26	2027-04-26
696	10077	69	406	f	Media	\N	2025-02-05	2026-02-05
697	10077	69	407	t	Media	/evidencias/10077_407.pdf	2025-02-05	2026-02-05
698	10077	69	407	t	Alta	/evidencias/10077_407.pdf	2024-09-20	2025-09-20
701	10077	69	409	f	Media	\N	2024-11-04	2026-11-04
702	10078	70	410	t	Media	/evidencias/10078_410.pdf	2026-01-08	2027-01-08
703	10078	70	410	t	Baja	/evidencias/10078_410.pdf	2024-05-08	2026-05-08
704	10078	70	411	f	Media	\N	2023-10-28	2024-10-27
705	10078	70	412	t	Media	/evidencias/10078_412.pdf	2024-11-20	2025-11-20
706	10078	70	413	t	Baja	/evidencias/10078_413.pdf	2025-03-08	2026-03-08
707	10078	70	414	t	Baja	/evidencias/10078_414.pdf	2023-12-03	2024-12-02
708	10078	70	415	t	Media	/evidencias/10078_415.pdf	2025-05-24	2027-05-24
709	10078	70	415	t	Media	/evidencias/10078_415.pdf	2024-09-13	2025-09-13
710	10078	70	416	f	Media	\N	2025-07-25	2026-07-25
711	10078	70	416	t	Baja	/evidencias/10078_416.pdf	2024-08-20	2026-08-20
712	10079	117	694	t	Alta	/evidencias/10079_694.pdf	2024-01-05	2026-01-04
713	10079	117	694	t	Media	/evidencias/10079_694.pdf	2024-09-06	2026-09-06
714	10079	117	695	t	Media	/evidencias/10079_695.pdf	2026-02-02	2028-02-02
715	10079	117	695	t	Baja	/evidencias/10079_695.pdf	2024-06-11	2026-06-11
716	10079	117	696	t	Media	/evidencias/10079_696.pdf	2025-01-18	2026-01-18
717	10079	117	696	f	Alta	\N	2025-08-21	2027-08-21
718	10079	117	697	t	Media	/evidencias/10079_697.pdf	2025-09-03	2026-09-03
719	10079	117	698	t	Media	/evidencias/10079_698.pdf	2025-12-12	2026-12-12
720	10079	117	698	t	Alta	/evidencias/10079_698.pdf	2024-02-22	2025-02-21
721	10079	117	699	t	Alta	/evidencias/10079_699.pdf	2024-08-23	2026-08-23
722	10079	117	700	f	Media	\N	2024-04-28	2025-04-28
723	10079	117	700	t	Media	/evidencias/10079_700.pdf	2024-10-11	2026-10-11
724	10080	144	860	f	Media	\N	2024-12-12	2026-12-12
725	10080	144	860	t	Media	/evidencias/10080_860.pdf	2025-10-20	2027-10-20
726	10080	144	861	f	Baja	\N	2024-01-14	2025-01-13
727	10080	144	861	t	Alta	/evidencias/10080_861.pdf	2026-03-15	2027-03-15
728	10080	144	862	t	Media	/evidencias/10080_862.pdf	2026-04-29	2028-04-28
729	10080	144	862	f	Alta	\N	2024-12-03	2026-12-03
730	10080	144	863	t	Media	/evidencias/10080_863.pdf	2026-05-24	2028-05-23
731	10080	144	864	t	Baja	/evidencias/10080_864.pdf	2024-02-16	2025-02-15
732	10080	144	864	f	Media	\N	2023-11-05	2025-11-04
733	10080	144	865	f	Media	\N	2025-08-12	2026-08-12
734	10080	144	866	t	Media	/evidencias/10080_866.pdf	2024-12-26	2025-12-26
735	10080	144	866	t	Media	/evidencias/10080_866.pdf	2024-12-27	2026-12-27
736	10081	135	809	t	Media	/evidencias/10081_809.pdf	2024-02-19	2025-02-18
737	10081	135	810	t	Alta	/evidencias/10081_810.pdf	2023-09-17	2024-09-16
738	10081	135	811	f	Alta	\N	2025-03-06	2026-03-06
739	10081	135	811	t	Alta	/evidencias/10081_811.pdf	2024-12-18	2026-12-18
740	10081	135	812	t	Alta	/evidencias/10081_812.pdf	2026-03-11	2028-03-10
741	10081	135	812	t	Alta	/evidencias/10081_812.pdf	2024-11-21	2026-11-21
742	10081	135	813	f	Media	\N	2025-07-23	2027-07-23
743	10081	135	814	f	Baja	\N	2023-09-30	2025-09-29
744	10082	136	815	t	Media	/evidencias/10082_815.pdf	2025-09-28	2027-09-28
745	10082	136	815	t	Baja	/evidencias/10082_815.pdf	2024-10-17	2026-10-17
746	10082	136	816	t	Baja	/evidencias/10082_816.pdf	2025-10-28	2027-10-28
747	10082	136	817	t	Baja	/evidencias/10082_817.pdf	2026-01-26	2028-01-26
748	10082	136	818	t	Alta	/evidencias/10082_818.pdf	2024-08-21	2026-08-21
749	10082	136	819	f	Baja	\N	2025-09-22	2026-09-22
750	10082	136	819	f	Alta	\N	2025-04-07	2027-04-07
751	10082	136	820	f	Alta	\N	2024-09-10	2026-09-10
752	10082	136	820	t	Media	/evidencias/10082_820.pdf	2024-05-20	2025-05-20
753	10083	123	732	t	Alta	/evidencias/10083_732.pdf	2024-07-10	2026-07-10
754	10083	123	732	f	Baja	\N	2025-08-23	2026-08-23
755	10083	123	733	t	Baja	/evidencias/10083_733.pdf	2026-01-24	2027-01-24
756	10083	123	733	f	Media	\N	2024-06-01	2026-06-01
757	10083	123	734	t	Media	/evidencias/10083_734.pdf	2026-05-23	2027-05-23
758	10083	123	735	t	Media	/evidencias/10083_735.pdf	2025-10-03	2027-10-03
759	10083	123	736	t	Media	/evidencias/10083_736.pdf	2026-04-29	2028-04-28
760	10083	123	737	f	Alta	\N	2025-01-28	2026-01-28
761	10083	123	737	t	Alta	/evidencias/10083_737.pdf	2024-10-21	2025-10-21
762	10083	123	738	t	Media	/evidencias/10083_738.pdf	2026-03-12	2028-03-11
763	10083	123	739	t	Media	/evidencias/10083_739.pdf	2023-11-19	2025-11-18
764	10083	123	739	f	Alta	\N	2025-09-23	2027-09-23
765	10084	44	253	t	Media	/evidencias/10084_253.pdf	2026-05-15	2028-05-14
766	10084	44	253	t	Media	/evidencias/10084_253.pdf	2023-06-07	2024-06-06
767	10084	44	254	f	Media	\N	2025-12-11	2027-12-11
768	10084	44	255	t	Media	/evidencias/10084_255.pdf	2024-07-04	2025-07-04
769	10084	44	256	t	Media	/evidencias/10084_256.pdf	2025-02-08	2026-02-08
770	10085	31	173	t	Media	/evidencias/10085_173.pdf	2024-12-18	2025-12-18
771	10085	31	173	t	Alta	/evidencias/10085_173.pdf	2025-05-03	2027-05-03
772	10085	31	174	t	Media	/evidencias/10085_174.pdf	2025-08-19	2026-08-19
773	10085	31	175	t	Baja	/evidencias/10085_175.pdf	2025-03-11	2027-03-11
774	10085	31	175	t	Media	/evidencias/10085_175.pdf	2024-06-05	2025-06-05
775	10085	31	176	t	Media	/evidencias/10085_176.pdf	2024-02-09	2026-02-08
776	10085	31	177	t	Media	/evidencias/10085_177.pdf	2024-10-14	2025-10-14
777	10085	31	177	t	Media	/evidencias/10085_177.pdf	2023-12-17	2024-12-16
778	10086	120	711	t	Alta	/evidencias/10086_711.pdf	2025-02-07	2026-02-07
779	10086	120	711	t	Media	/evidencias/10086_711.pdf	2024-07-26	2025-07-26
780	10086	120	712	t	Media	/evidencias/10086_712.pdf	2025-09-20	2026-09-20
781	10086	120	713	f	Alta	\N	2023-06-29	2024-06-28
782	10086	120	713	t	Baja	/evidencias/10086_713.pdf	2025-12-14	2027-12-14
783	10086	120	714	t	Alta	/evidencias/10086_714.pdf	2026-01-28	2027-01-28
784	10086	120	715	f	Alta	\N	2026-03-26	2027-03-26
785	10086	120	716	t	Media	/evidencias/10086_716.pdf	2024-10-17	2026-10-17
786	10087	108	644	t	Baja	/evidencias/10087_644.pdf	2024-08-26	2026-08-26
787	10087	108	644	t	Baja	/evidencias/10087_644.pdf	2024-07-27	2026-07-27
788	10087	108	645	t	Media	/evidencias/10087_645.pdf	2025-05-12	2026-05-12
789	10087	108	645	t	Baja	/evidencias/10087_645.pdf	2023-08-15	2025-08-14
790	10087	108	646	f	Baja	\N	2023-09-04	2024-09-03
791	10087	108	647	f	Baja	\N	2024-05-18	2026-05-18
792	10087	108	647	t	Media	/evidencias/10087_647.pdf	2024-07-02	2025-07-02
793	10088	122	724	t	Media	/evidencias/10088_724.pdf	2024-04-04	2025-04-04
794	10088	122	724	t	Baja	/evidencias/10088_724.pdf	2024-09-09	2025-09-09
795	10088	122	725	f	Media	\N	2023-11-10	2024-11-09
796	10088	122	726	t	Media	/evidencias/10088_726.pdf	2023-10-20	2025-10-19
797	10088	122	726	t	Media	/evidencias/10088_726.pdf	2025-11-23	2027-11-23
798	10088	122	727	t	Media	/evidencias/10088_727.pdf	2024-02-27	2025-02-26
799	10088	122	728	f	Media	\N	2025-05-01	2026-05-01
800	10088	122	729	f	Baja	\N	2023-08-30	2024-08-29
801	10088	122	730	t	Baja	/evidencias/10088_730.pdf	2023-06-09	2024-06-08
802	10088	122	730	t	Alta	/evidencias/10088_730.pdf	2025-04-28	2027-04-28
803	10088	122	731	t	Media	/evidencias/10088_731.pdf	2024-10-04	2026-10-04
804	10089	99	589	t	Media	/evidencias/10089_589.pdf	2024-11-23	2026-11-23
805	10089	99	590	t	Alta	/evidencias/10089_590.pdf	2023-12-06	2025-12-05
806	10089	99	591	t	Alta	/evidencias/10089_591.pdf	2024-02-04	2026-02-03
807	10089	99	592	t	Media	/evidencias/10089_592.pdf	2025-04-09	2026-04-09
808	10089	99	592	t	Baja	/evidencias/10089_592.pdf	2025-01-09	2026-01-09
809	10089	99	593	t	Alta	/evidencias/10089_593.pdf	2025-07-04	2026-07-04
810	10089	99	594	f	Alta	\N	2025-04-29	2026-04-29
811	10089	99	594	f	Alta	\N	2024-03-22	2025-03-22
812	10090	81	475	t	Media	/evidencias/10090_475.pdf	2025-02-05	2026-02-05
813	10090	81	476	t	Media	/evidencias/10090_476.pdf	2023-10-16	2025-10-15
814	10090	81	477	t	Media	/evidencias/10090_477.pdf	2026-03-23	2027-03-23
815	10090	81	478	t	Media	/evidencias/10090_478.pdf	2026-02-15	2027-02-15
816	10090	81	479	t	Media	/evidencias/10090_479.pdf	2025-09-11	2027-09-11
817	10090	81	479	t	Media	/evidencias/10090_479.pdf	2023-08-27	2025-08-26
818	10090	81	480	t	Alta	/evidencias/10090_480.pdf	2026-05-10	2027-05-10
819	10090	81	481	f	Media	\N	2026-03-05	2028-03-04
820	10090	81	481	f	Media	\N	2025-08-04	2026-08-04
821	10091	43	247	t	Alta	/evidencias/10091_247.pdf	2025-04-16	2027-04-16
822	10091	43	247	t	Baja	/evidencias/10091_247.pdf	2023-11-29	2024-11-28
823	10091	43	248	t	Alta	/evidencias/10091_248.pdf	2025-11-04	2027-11-04
824	10091	43	248	t	Baja	/evidencias/10091_248.pdf	2024-01-08	2025-01-07
825	10091	43	249	t	Alta	/evidencias/10091_249.pdf	2025-02-28	2026-02-28
826	10091	43	249	f	Media	\N	2025-08-16	2027-08-16
827	10091	43	250	t	Media	/evidencias/10091_250.pdf	2024-11-06	2025-11-06
828	10091	43	251	t	Media	/evidencias/10091_251.pdf	2024-10-07	2025-10-07
829	10091	43	251	f	Media	\N	2024-01-15	2026-01-14
830	10091	43	252	t	Baja	/evidencias/10091_252.pdf	2024-03-12	2026-03-12
831	10092	44	253	t	Media	/evidencias/10092_253.pdf	2025-09-05	2027-09-05
832	10092	44	254	t	Media	/evidencias/10092_254.pdf	2024-12-10	2026-12-10
833	10092	44	254	t	Alta	/evidencias/10092_254.pdf	2023-08-29	2024-08-28
834	10092	44	255	t	Media	/evidencias/10092_255.pdf	2024-09-20	2026-09-20
835	10092	44	255	t	Media	/evidencias/10092_255.pdf	2024-01-02	2025-01-01
836	10092	44	256	t	Media	/evidencias/10092_256.pdf	2025-12-12	2026-12-12
837	10093	63	360	t	Alta	/evidencias/10093_360.pdf	2025-05-12	2027-05-12
838	10093	63	360	t	Alta	/evidencias/10093_360.pdf	2023-12-15	2024-12-14
839	10093	63	361	t	Baja	/evidencias/10093_361.pdf	2025-07-12	2027-07-12
840	10093	63	361	t	Media	/evidencias/10093_361.pdf	2025-07-19	2026-07-19
841	10093	63	362	f	Media	\N	2025-04-12	2027-04-12
842	10093	63	363	f	Media	\N	2024-01-18	2025-01-17
843	10093	63	363	t	Baja	/evidencias/10093_363.pdf	2025-05-27	2026-05-27
844	10093	63	364	f	Alta	\N	2024-08-21	2025-08-21
845	10093	63	365	t	Alta	/evidencias/10093_365.pdf	2023-12-19	2025-12-18
846	10093	63	365	f	Media	\N	2024-06-09	2025-06-09
847	10093	63	366	t	Media	/evidencias/10093_366.pdf	2023-09-22	2024-09-21
848	10094	22	125	f	Alta	\N	2023-07-29	2024-07-28
849	10094	22	125	t	Media	/evidencias/10094_125.pdf	2025-10-21	2026-10-21
850	10094	22	126	f	Media	\N	2023-06-03	2024-06-02
851	10094	22	126	t	Baja	/evidencias/10094_126.pdf	2025-04-15	2027-04-15
852	10094	22	127	f	Media	\N	2026-04-23	2028-04-22
853	10094	22	128	f	Baja	\N	2024-03-04	2026-03-04
854	10094	22	129	f	Media	\N	2024-01-19	2025-01-18
855	10094	22	129	t	Media	/evidencias/10094_129.pdf	2025-07-20	2027-07-20
856	10095	30	166	f	Media	\N	2026-05-12	2027-05-12
857	10095	30	167	t	Media	/evidencias/10095_167.pdf	2026-04-05	2028-04-04
858	10095	30	167	f	Alta	\N	2025-09-28	2027-09-28
859	10095	30	168	f	Baja	\N	2024-11-18	2025-11-18
860	10095	30	168	t	Media	/evidencias/10095_168.pdf	2024-06-18	2025-06-18
861	10095	30	169	t	Alta	/evidencias/10095_169.pdf	2025-01-25	2026-01-25
862	10095	30	170	t	Baja	/evidencias/10095_170.pdf	2023-12-13	2024-12-12
863	10095	30	170	t	Media	/evidencias/10095_170.pdf	2023-07-30	2024-07-29
864	10095	30	171	t	Baja	/evidencias/10095_171.pdf	2023-06-16	2024-06-15
865	10095	30	172	t	Media	/evidencias/10095_172.pdf	2025-03-07	2026-03-07
866	10095	30	172	t	Media	/evidencias/10095_172.pdf	2025-12-21	2026-12-21
867	10096	120	711	t	Baja	/evidencias/10096_711.pdf	2024-03-14	2026-03-14
868	10096	120	712	t	Media	/evidencias/10096_712.pdf	2024-08-01	2026-08-01
869	10096	120	712	f	Alta	\N	2024-05-26	2026-05-26
870	10096	120	713	t	Media	/evidencias/10096_713.pdf	2025-07-18	2027-07-18
871	10096	120	714	t	Media	/evidencias/10096_714.pdf	2025-11-17	2026-11-17
872	10096	120	714	f	Media	\N	2025-10-01	2027-10-01
873	10096	120	715	t	Alta	/evidencias/10096_715.pdf	2025-12-28	2026-12-28
874	10096	120	716	t	Media	/evidencias/10096_716.pdf	2023-09-30	2025-09-29
875	10096	120	716	t	Baja	/evidencias/10096_716.pdf	2026-04-02	2027-04-02
876	10097	13	77	t	Alta	/evidencias/10097_77.pdf	2024-06-17	2026-06-17
877	10097	13	78	t	Baja	/evidencias/10097_78.pdf	2025-11-18	2026-11-18
878	10097	13	79	t	Media	/evidencias/10097_79.pdf	2025-01-07	2026-01-07
879	10097	13	80	f	Media	\N	2025-10-07	2027-10-07
880	10098	74	437	t	Baja	/evidencias/10098_437.pdf	2025-06-12	2027-06-12
881	10098	74	438	f	Baja	\N	2024-05-27	2026-05-27
882	10098	74	438	t	Alta	/evidencias/10098_438.pdf	2025-02-21	2026-02-21
883	10098	74	439	t	Alta	/evidencias/10098_439.pdf	2025-11-05	2027-11-05
884	10098	74	440	t	Alta	/evidencias/10098_440.pdf	2024-12-04	2025-12-04
885	10098	74	440	t	Media	/evidencias/10098_440.pdf	2024-02-21	2025-02-20
886	10099	133	796	f	Media	\N	2025-12-06	2027-12-06
887	10099	133	796	t	Media	/evidencias/10099_796.pdf	2024-05-29	2025-05-29
888	10099	133	797	t	Baja	/evidencias/10099_797.pdf	2024-02-18	2025-02-17
889	10099	133	797	f	Baja	\N	2026-05-12	2027-05-12
890	10099	133	798	f	Baja	\N	2025-09-18	2027-09-18
891	10099	133	798	t	Alta	/evidencias/10099_798.pdf	2025-04-05	2026-04-05
892	10099	133	799	t	Media	/evidencias/10099_799.pdf	2024-11-21	2025-11-21
893	10099	133	799	t	Alta	/evidencias/10099_799.pdf	2023-10-10	2024-10-09
894	10099	133	800	f	Alta	\N	2024-01-10	2026-01-09
895	10099	133	800	t	Media	/evidencias/10099_800.pdf	2023-11-26	2025-11-25
896	10099	133	801	t	Alta	/evidencias/10099_801.pdf	2024-07-19	2026-07-19
897	10099	133	801	t	Alta	/evidencias/10099_801.pdf	2024-03-11	2025-03-11
898	10101	143	855	t	Media	/evidencias/10101_855.pdf	2024-03-18	2025-03-18
899	10101	143	855	t	Alta	/evidencias/10101_855.pdf	2025-08-04	2026-08-04
900	10101	143	856	t	Alta	/evidencias/10101_856.pdf	2026-03-16	2027-03-16
901	10101	143	856	f	Media	\N	2023-07-07	2024-07-06
902	10101	143	857	f	Media	\N	2025-09-15	2026-09-15
903	10101	143	858	t	Alta	/evidencias/10101_858.pdf	2025-10-20	2026-10-20
904	10101	143	859	t	Media	/evidencias/10101_859.pdf	2023-06-10	2024-06-09
905	10101	143	859	t	Media	/evidencias/10101_859.pdf	2023-11-05	2024-11-04
906	10102	144	860	t	Media	/evidencias/10102_860.pdf	2024-12-19	2026-12-19
907	10102	144	860	t	Alta	/evidencias/10102_860.pdf	2024-04-22	2026-04-22
908	10102	144	861	t	Baja	/evidencias/10102_861.pdf	2025-12-01	2027-12-01
909	10102	144	861	t	Media	/evidencias/10102_861.pdf	2024-10-14	2026-10-14
910	10102	144	862	t	Media	/evidencias/10102_862.pdf	2024-09-01	2025-09-01
911	10102	144	862	t	Alta	/evidencias/10102_862.pdf	2024-12-04	2026-12-04
912	10102	144	863	t	Baja	/evidencias/10102_863.pdf	2025-12-18	2027-12-18
913	10102	144	863	t	Baja	/evidencias/10102_863.pdf	2023-07-20	2025-07-19
914	10102	144	864	t	Media	/evidencias/10102_864.pdf	2024-02-21	2025-02-20
915	10102	144	864	f	Baja	\N	2023-06-19	2025-06-18
916	10102	144	865	t	Media	/evidencias/10102_865.pdf	2025-05-25	2027-05-25
917	10102	144	866	t	Alta	/evidencias/10102_866.pdf	2025-11-15	2026-11-15
918	10103	44	253	t	Baja	/evidencias/10103_253.pdf	2023-10-10	2024-10-09
919	10103	44	253	f	Media	\N	2026-02-18	2027-02-18
920	10103	44	254	t	Alta	/evidencias/10103_254.pdf	2023-11-17	2024-11-16
921	10103	44	254	f	Media	\N	2023-07-27	2025-07-26
922	10103	44	255	t	Alta	/evidencias/10103_255.pdf	2025-01-22	2027-01-22
923	10103	44	255	t	Alta	/evidencias/10103_255.pdf	2024-09-18	2026-09-18
924	10103	44	256	t	Baja	/evidencias/10103_256.pdf	2025-02-19	2026-02-19
925	10103	44	256	f	Alta	\N	2024-06-21	2026-06-21
926	10104	146	872	f	Alta	\N	2025-08-29	2026-08-29
927	10104	146	873	t	Media	/evidencias/10104_873.pdf	2026-03-26	2028-03-25
928	10104	146	874	f	Alta	\N	2025-05-09	2026-05-09
929	10104	146	875	f	Baja	\N	2025-04-26	2026-04-26
930	10104	146	875	t	Alta	/evidencias/10104_875.pdf	2024-01-19	2025-01-18
931	10104	146	876	t	Baja	/evidencias/10104_876.pdf	2025-04-02	2027-04-02
932	10104	146	876	t	Media	/evidencias/10104_876.pdf	2025-12-18	2026-12-18
933	10105	30	166	t	Media	/evidencias/10105_166.pdf	2026-04-24	2027-04-24
934	10105	30	167	f	Alta	\N	2024-07-01	2025-07-01
935	10105	30	167	t	Alta	/evidencias/10105_167.pdf	2023-08-09	2025-08-08
936	10105	30	168	t	Alta	/evidencias/10105_168.pdf	2025-03-20	2026-03-20
937	10105	30	169	f	Alta	\N	2023-10-10	2025-10-09
938	10105	30	169	t	Media	/evidencias/10105_169.pdf	2023-08-28	2025-08-27
939	10105	30	170	f	Media	\N	2025-11-14	2026-11-14
940	10105	30	170	t	Media	/evidencias/10105_170.pdf	2026-02-10	2027-02-10
941	10105	30	171	t	Alta	/evidencias/10105_171.pdf	2023-07-13	2024-07-12
942	10105	30	172	t	Media	/evidencias/10105_172.pdf	2026-03-16	2028-03-15
943	10106	146	872	t	Alta	/evidencias/10106_872.pdf	2024-09-08	2025-09-08
944	10106	146	873	t	Media	/evidencias/10106_873.pdf	2025-11-21	2027-11-21
945	10106	146	874	t	Media	/evidencias/10106_874.pdf	2025-07-11	2026-07-11
946	10106	146	875	t	Media	/evidencias/10106_875.pdf	2025-03-08	2026-03-08
947	10106	146	876	f	Baja	\N	2025-12-31	2027-12-31
948	10106	146	876	t	Alta	/evidencias/10106_876.pdf	2024-10-21	2026-10-21
949	10107	65	374	t	Media	/evidencias/10107_374.pdf	2025-06-12	2027-06-12
950	10107	65	375	f	Baja	\N	2024-12-13	2026-12-13
951	10107	65	375	t	Alta	/evidencias/10107_375.pdf	2026-03-07	2028-03-06
952	10107	65	376	t	Baja	/evidencias/10107_376.pdf	2025-05-08	2026-05-08
953	10107	65	376	t	Media	/evidencias/10107_376.pdf	2024-07-27	2026-07-27
954	10107	65	377	t	Alta	/evidencias/10107_377.pdf	2024-10-09	2026-10-09
955	10107	65	377	f	Baja	\N	2023-11-16	2024-11-15
956	10107	65	378	t	Alta	/evidencias/10107_378.pdf	2026-01-31	2027-01-31
957	10107	65	378	t	Baja	/evidencias/10107_378.pdf	2025-01-27	2026-01-27
958	10107	65	379	t	Media	/evidencias/10107_379.pdf	2026-01-10	2028-01-10
959	10107	65	380	t	Media	/evidencias/10107_380.pdf	2024-07-27	2025-07-27
960	10107	65	380	t	Media	/evidencias/10107_380.pdf	2023-12-21	2024-12-20
961	10107	65	381	f	Baja	\N	2026-03-16	2028-03-15
962	10108	146	872	t	Alta	/evidencias/10108_872.pdf	2025-09-09	2026-09-09
963	10108	146	873	t	Alta	/evidencias/10108_873.pdf	2024-10-12	2025-10-12
964	10108	146	873	t	Baja	/evidencias/10108_873.pdf	2024-04-10	2026-04-10
965	10108	146	874	f	Alta	\N	2024-12-18	2026-12-18
966	10108	146	875	f	Media	\N	2024-11-16	2026-11-16
967	10108	146	875	t	Alta	/evidencias/10108_875.pdf	2025-02-21	2027-02-21
968	10108	146	876	t	Media	/evidencias/10108_876.pdf	2025-11-18	2026-11-18
969	10108	146	876	t	Alta	/evidencias/10108_876.pdf	2023-12-16	2024-12-15
970	10109	45	257	t	Alta	/evidencias/10109_257.pdf	2024-01-29	2025-01-28
971	10109	45	258	f	Media	\N	2025-06-01	2026-06-01
972	10109	45	259	t	Media	/evidencias/10109_259.pdf	2025-03-26	2027-03-26
973	10109	45	260	t	Media	/evidencias/10109_260.pdf	2026-04-06	2028-04-05
974	10109	45	261	t	Alta	/evidencias/10109_261.pdf	2023-07-13	2024-07-12
975	10109	45	262	t	Alta	/evidencias/10109_262.pdf	2024-08-16	2026-08-16
976	10109	45	263	f	Media	\N	2026-02-26	2028-02-26
977	10109	45	264	t	Media	/evidencias/10109_264.pdf	2023-12-25	2024-12-24
978	10109	45	264	t	Media	/evidencias/10109_264.pdf	2024-09-02	2025-09-02
979	10110	129	769	f	Media	\N	2023-08-07	2025-08-06
980	10110	129	770	f	Media	\N	2025-10-28	2027-10-28
981	10110	129	771	t	Media	/evidencias/10110_771.pdf	2025-06-12	2026-06-12
982	10110	129	771	t	Media	/evidencias/10110_771.pdf	2025-10-02	2026-10-02
983	10110	129	772	t	Alta	/evidencias/10110_772.pdf	2026-02-19	2027-02-19
984	10110	129	772	f	Baja	\N	2024-11-13	2026-11-13
985	10110	129	773	t	Media	/evidencias/10110_773.pdf	2025-09-09	2027-09-09
986	10110	129	773	t	Alta	/evidencias/10110_773.pdf	2023-09-30	2024-09-29
987	10110	129	774	f	Media	\N	2024-04-25	2025-04-25
988	10110	129	775	t	Alta	/evidencias/10110_775.pdf	2024-06-28	2025-06-28
989	10110	129	776	t	Alta	/evidencias/10110_776.pdf	2023-06-03	2024-06-02
990	10110	129	776	t	Media	/evidencias/10110_776.pdf	2026-04-20	2028-04-19
991	10111	38	215	t	Alta	/evidencias/10111_215.pdf	2026-01-29	2027-01-29
992	10111	38	215	t	Baja	/evidencias/10111_215.pdf	2024-01-12	2026-01-11
993	10111	38	216	t	Media	/evidencias/10111_216.pdf	2024-07-23	2025-07-23
994	10111	38	217	t	Alta	/evidencias/10111_217.pdf	2024-08-19	2025-08-19
995	10111	38	218	t	Alta	/evidencias/10111_218.pdf	2025-03-26	2026-03-26
996	10111	38	218	t	Media	/evidencias/10111_218.pdf	2023-09-01	2024-08-31
997	10111	38	219	t	Media	/evidencias/10111_219.pdf	2025-07-18	2026-07-18
998	10112	98	582	t	Baja	/evidencias/10112_582.pdf	2026-05-28	2027-05-28
999	10112	98	583	t	Baja	/evidencias/10112_583.pdf	2025-01-29	2026-01-29
1000	10112	98	584	t	Media	/evidencias/10112_584.pdf	2023-12-14	2024-12-13
1001	10112	98	585	f	Media	\N	2025-02-06	2026-02-06
1002	10112	98	585	t	Media	/evidencias/10112_585.pdf	2024-10-02	2026-10-02
1003	10112	98	586	t	Media	/evidencias/10112_586.pdf	2026-04-10	2027-04-10
1004	10112	98	587	f	Media	\N	2026-02-16	2028-02-16
1005	10112	98	588	t	Media	/evidencias/10112_588.pdf	2023-11-06	2024-11-05
1006	10112	98	588	t	Media	/evidencias/10112_588.pdf	2024-09-01	2025-09-01
1007	10113	84	494	t	Alta	/evidencias/10113_494.pdf	2025-12-26	2027-12-26
1008	10113	84	495	t	Media	/evidencias/10113_495.pdf	2024-08-11	2025-08-11
1009	10113	84	496	t	Media	/evidencias/10113_496.pdf	2024-07-02	2026-07-02
1010	10113	84	496	t	Media	/evidencias/10113_496.pdf	2026-01-16	2027-01-16
1011	10113	84	497	f	Baja	\N	2024-11-02	2026-11-02
1012	10113	84	497	t	Media	/evidencias/10113_497.pdf	2026-03-31	2027-03-31
1013	10113	84	498	f	Media	\N	2024-09-25	2026-09-25
1014	10113	84	498	t	Media	/evidencias/10113_498.pdf	2024-02-29	2025-02-28
1015	10114	77	454	f	Media	\N	2024-06-04	2026-06-04
1016	10114	77	455	t	Alta	/evidencias/10114_455.pdf	2024-09-06	2026-09-06
1017	10114	77	456	t	Media	/evidencias/10114_456.pdf	2025-07-18	2026-07-18
1018	10114	77	457	t	Alta	/evidencias/10114_457.pdf	2024-12-22	2026-12-22
1019	10114	77	458	t	Media	/evidencias/10114_458.pdf	2024-07-26	2026-07-26
1020	10114	77	458	f	Media	\N	2024-12-29	2025-12-29
1021	10115	44	253	f	Media	\N	2023-11-20	2025-11-19
1022	10115	44	253	t	Baja	/evidencias/10115_253.pdf	2024-06-02	2026-06-02
1023	10115	44	254	t	Alta	/evidencias/10115_254.pdf	2026-03-19	2028-03-18
1024	10115	44	255	t	Media	/evidencias/10115_255.pdf	2024-10-23	2026-10-23
1025	10115	44	256	t	Baja	/evidencias/10115_256.pdf	2024-04-14	2025-04-14
1026	10116	76	447	t	Alta	/evidencias/10116_447.pdf	2023-12-25	2024-12-24
1027	10116	76	447	t	Media	/evidencias/10116_447.pdf	2025-04-29	2027-04-29
1028	10116	76	448	f	Media	\N	2025-06-22	2027-06-22
1029	10116	76	449	t	Alta	/evidencias/10116_449.pdf	2024-12-12	2026-12-12
1030	10116	76	449	t	Alta	/evidencias/10116_449.pdf	2024-01-24	2025-01-23
1031	10116	76	450	t	Baja	/evidencias/10116_450.pdf	2024-06-12	2025-06-12
1032	10116	76	450	t	Alta	/evidencias/10116_450.pdf	2024-08-23	2025-08-23
1033	10116	76	451	t	Alta	/evidencias/10116_451.pdf	2026-03-30	2028-03-29
1034	10116	76	451	t	Alta	/evidencias/10116_451.pdf	2025-11-26	2027-11-26
1035	10116	76	452	f	Baja	\N	2026-05-05	2027-05-05
1036	10116	76	453	t	Baja	/evidencias/10116_453.pdf	2024-06-28	2026-06-28
1037	10117	99	589	t	Baja	/evidencias/10117_589.pdf	2025-10-15	2027-10-15
1038	10117	99	589	t	Media	/evidencias/10117_589.pdf	2023-12-24	2024-12-23
1039	10117	99	590	f	Baja	\N	2023-09-28	2025-09-27
1040	10117	99	590	t	Baja	/evidencias/10117_590.pdf	2023-09-01	2024-08-31
1041	10117	99	591	t	Baja	/evidencias/10117_591.pdf	2023-12-17	2024-12-16
1042	10117	99	591	t	Baja	/evidencias/10117_591.pdf	2024-11-11	2026-11-11
1043	10117	99	592	t	Media	/evidencias/10117_592.pdf	2023-08-04	2024-08-03
1044	10117	99	592	t	Alta	/evidencias/10117_592.pdf	2024-04-25	2025-04-25
1045	10117	99	593	t	Media	/evidencias/10117_593.pdf	2023-07-30	2025-07-29
1046	10117	99	594	t	Media	/evidencias/10117_594.pdf	2025-03-07	2026-03-07
1047	10118	141	844	t	Media	/evidencias/10118_844.pdf	2024-12-03	2026-12-03
1048	10118	141	844	t	Media	/evidencias/10118_844.pdf	2023-09-26	2024-09-25
1049	10118	141	845	f	Baja	\N	2025-10-07	2027-10-07
1050	10118	141	846	t	Media	/evidencias/10118_846.pdf	2024-07-09	2026-07-09
1051	10118	141	847	t	Alta	/evidencias/10118_847.pdf	2023-08-08	2024-08-07
1052	10119	63	360	t	Baja	/evidencias/10119_360.pdf	2023-12-04	2025-12-03
1053	10119	63	361	t	Alta	/evidencias/10119_361.pdf	2025-02-20	2026-02-20
1054	10119	63	361	f	Media	\N	2025-07-15	2026-07-15
1055	10119	63	362	f	Baja	\N	2025-11-15	2026-11-15
1056	10119	63	362	t	Media	/evidencias/10119_362.pdf	2025-09-21	2026-09-21
1057	10119	63	363	t	Alta	/evidencias/10119_363.pdf	2024-11-10	2026-11-10
1058	10119	63	363	t	Media	/evidencias/10119_363.pdf	2025-01-03	2027-01-03
1059	10119	63	364	t	Baja	/evidencias/10119_364.pdf	2024-12-20	2025-12-20
1060	10119	63	364	t	Baja	/evidencias/10119_364.pdf	2025-08-19	2026-08-19
1061	10119	63	365	t	Baja	/evidencias/10119_365.pdf	2025-08-16	2026-08-16
1062	10119	63	365	t	Media	/evidencias/10119_365.pdf	2023-07-09	2024-07-08
1063	10119	63	366	t	Alta	/evidencias/10119_366.pdf	2026-04-16	2027-04-16
1064	10120	44	253	t	Alta	/evidencias/10120_253.pdf	2025-10-11	2027-10-11
1065	10120	44	253	f	Media	\N	2025-09-12	2026-09-12
1066	10120	44	254	t	Baja	/evidencias/10120_254.pdf	2025-04-21	2027-04-21
1067	10120	44	254	t	Baja	/evidencias/10120_254.pdf	2024-08-07	2025-08-07
1068	10120	44	255	t	Media	/evidencias/10120_255.pdf	2025-09-20	2026-09-20
1069	10120	44	256	t	Media	/evidencias/10120_256.pdf	2025-04-03	2026-04-03
1070	10120	44	256	t	Baja	/evidencias/10120_256.pdf	2025-10-19	2026-10-19
1071	10121	128	763	f	Baja	\N	2023-06-13	2024-06-12
1072	10121	128	764	f	Alta	\N	2024-10-22	2026-10-22
1073	10121	128	764	f	Media	\N	2023-10-12	2024-10-11
1074	10121	128	765	t	Baja	/evidencias/10121_765.pdf	2024-02-08	2025-02-07
1075	10121	128	765	t	Media	/evidencias/10121_765.pdf	2024-11-26	2025-11-26
1076	10121	128	766	t	Alta	/evidencias/10121_766.pdf	2025-01-10	2027-01-10
1077	10121	128	767	t	Media	/evidencias/10121_767.pdf	2025-08-31	2027-08-31
1078	10121	128	768	t	Media	/evidencias/10121_768.pdf	2023-09-20	2024-09-19
1079	10121	128	768	t	Media	/evidencias/10121_768.pdf	2023-06-14	2025-06-13
1080	10122	77	454	t	Baja	/evidencias/10122_454.pdf	2024-08-24	2026-08-24
1081	10122	77	454	t	Media	/evidencias/10122_454.pdf	2024-07-29	2026-07-29
1082	10122	77	455	f	Alta	\N	2024-08-22	2025-08-22
1083	10122	77	455	t	Media	/evidencias/10122_455.pdf	2025-03-25	2027-03-25
1084	10122	77	456	t	Alta	/evidencias/10122_456.pdf	2024-08-08	2025-08-08
1085	10122	77	457	f	Alta	\N	2026-05-02	2028-05-01
1086	10122	77	458	t	Media	/evidencias/10122_458.pdf	2024-04-30	2025-04-30
1087	10122	77	458	t	Media	/evidencias/10122_458.pdf	2024-04-17	2026-04-17
1088	10124	110	654	f	Media	\N	2026-05-27	2027-05-27
1089	10124	110	654	t	Media	/evidencias/10124_654.pdf	2025-12-10	2027-12-10
1090	10124	110	655	f	Baja	\N	2023-09-18	2025-09-17
1091	10124	110	655	t	Media	/evidencias/10124_655.pdf	2024-07-20	2026-07-20
1092	10124	110	656	f	Alta	\N	2025-06-26	2026-06-26
3388	10393	49	286	f	Alta	\N	2025-02-05	2027-02-05
1093	10124	110	657	t	Baja	/evidencias/10124_657.pdf	2024-08-29	2026-08-29
1094	10124	110	657	t	Alta	/evidencias/10124_657.pdf	2024-09-06	2026-09-06
1095	10124	110	658	f	Baja	\N	2025-04-02	2027-04-02
1096	10124	110	658	t	Alta	/evidencias/10124_658.pdf	2024-07-05	2026-07-05
1097	10125	8	46	f	Media	\N	2023-11-06	2025-11-05
1098	10125	8	46	t	Media	/evidencias/10125_46.pdf	2023-11-16	2024-11-15
1099	10125	8	47	f	Baja	\N	2025-05-28	2026-05-28
1100	10125	8	48	t	Alta	/evidencias/10125_48.pdf	2023-10-25	2025-10-24
1101	10125	8	48	t	Alta	/evidencias/10125_48.pdf	2024-11-06	2025-11-06
1102	10125	8	49	t	Media	/evidencias/10125_49.pdf	2025-11-07	2027-11-07
1103	10125	8	49	t	Media	/evidencias/10125_49.pdf	2025-10-03	2027-10-03
1104	10125	8	50	t	Media	/evidencias/10125_50.pdf	2023-11-12	2024-11-11
1105	10125	8	50	f	Alta	\N	2023-08-19	2024-08-18
1106	10125	8	51	t	Alta	/evidencias/10125_51.pdf	2024-07-29	2025-07-29
1107	10126	41	232	t	Alta	/evidencias/10126_232.pdf	2024-02-17	2026-02-16
1108	10126	41	233	t	Media	/evidencias/10126_233.pdf	2025-09-19	2027-09-19
1109	10126	41	233	f	Alta	\N	2025-03-30	2026-03-30
1110	10126	41	234	t	Alta	/evidencias/10126_234.pdf	2024-10-22	2026-10-22
1111	10126	41	234	t	Alta	/evidencias/10126_234.pdf	2025-12-27	2027-12-27
1112	10126	41	235	f	Alta	\N	2024-12-02	2026-12-02
1113	10126	41	236	t	Media	/evidencias/10126_236.pdf	2024-06-26	2025-06-26
1114	10126	41	237	t	Media	/evidencias/10126_237.pdf	2025-02-22	2026-02-22
1115	10126	41	238	f	Media	\N	2023-10-29	2025-10-28
1116	10126	41	238	t	Media	/evidencias/10126_238.pdf	2026-03-22	2027-03-22
1117	10127	30	166	t	Media	/evidencias/10127_166.pdf	2024-08-08	2026-08-08
1118	10127	30	167	f	Alta	\N	2024-09-12	2025-09-12
1119	10127	30	168	t	Media	/evidencias/10127_168.pdf	2024-02-25	2026-02-24
1120	10127	30	169	f	Media	\N	2026-05-07	2027-05-07
1121	10127	30	169	t	Baja	/evidencias/10127_169.pdf	2023-08-23	2024-08-22
1122	10127	30	170	t	Media	/evidencias/10127_170.pdf	2025-12-06	2027-12-06
1123	10127	30	171	f	Baja	\N	2024-06-07	2025-06-07
1124	10127	30	172	f	Baja	\N	2023-10-25	2025-10-24
1125	10128	26	145	t	Media	/evidencias/10128_145.pdf	2025-07-19	2026-07-19
1126	10128	26	145	t	Alta	/evidencias/10128_145.pdf	2026-05-23	2028-05-22
1127	10128	26	146	t	Media	/evidencias/10128_146.pdf	2025-12-04	2026-12-04
1128	10128	26	147	t	Alta	/evidencias/10128_147.pdf	2026-05-09	2028-05-08
1129	10128	26	148	t	Media	/evidencias/10128_148.pdf	2025-04-03	2027-04-03
1130	10128	26	148	f	Baja	\N	2025-08-17	2026-08-17
1131	10129	88	517	t	Media	/evidencias/10129_517.pdf	2024-07-18	2025-07-18
1132	10129	88	518	t	Media	/evidencias/10129_518.pdf	2023-06-07	2024-06-06
1133	10129	88	519	t	Baja	/evidencias/10129_519.pdf	2025-07-27	2027-07-27
1134	10129	88	519	t	Alta	/evidencias/10129_519.pdf	2026-04-03	2027-04-03
1135	10129	88	520	t	Media	/evidencias/10129_520.pdf	2025-10-07	2026-10-07
1136	10129	88	520	f	Alta	\N	2026-02-18	2027-02-18
1137	10129	88	521	t	Alta	/evidencias/10129_521.pdf	2026-01-03	2028-01-03
1138	10129	88	521	f	Media	\N	2025-08-17	2026-08-17
1139	10129	88	522	t	Media	/evidencias/10129_522.pdf	2026-02-10	2027-02-10
1140	10129	88	522	t	Alta	/evidencias/10129_522.pdf	2026-03-11	2028-03-10
1141	10129	88	523	f	Alta	\N	2024-06-27	2026-06-27
1142	10130	142	848	t	Alta	/evidencias/10130_848.pdf	2025-05-03	2026-05-03
1143	10130	142	848	t	Alta	/evidencias/10130_848.pdf	2025-02-25	2027-02-25
1144	10130	142	849	t	Media	/evidencias/10130_849.pdf	2025-08-09	2027-08-09
1145	10130	142	849	t	Media	/evidencias/10130_849.pdf	2024-01-14	2025-01-13
1146	10130	142	850	t	Media	/evidencias/10130_850.pdf	2025-04-05	2026-04-05
1147	10130	142	850	t	Media	/evidencias/10130_850.pdf	2025-02-12	2026-02-12
1148	10130	142	851	t	Media	/evidencias/10130_851.pdf	2026-04-21	2028-04-20
1149	10130	142	852	f	Media	\N	2024-05-01	2026-05-01
1150	10130	142	852	t	Media	/evidencias/10130_852.pdf	2025-05-20	2027-05-20
1151	10130	142	853	t	Alta	/evidencias/10130_853.pdf	2023-06-11	2024-06-10
1152	10130	142	854	t	Media	/evidencias/10130_854.pdf	2025-02-23	2027-02-23
1153	10130	142	854	t	Media	/evidencias/10130_854.pdf	2024-04-29	2025-04-29
1154	10131	39	220	t	Alta	/evidencias/10131_220.pdf	2024-04-16	2025-04-16
1155	10131	39	221	f	Media	\N	2024-09-11	2026-09-11
1156	10131	39	222	t	Media	/evidencias/10131_222.pdf	2024-02-16	2026-02-15
1157	10131	39	222	t	Media	/evidencias/10131_222.pdf	2024-12-08	2026-12-08
1158	10131	39	223	f	Alta	\N	2025-09-29	2026-09-29
1159	10131	39	224	f	Baja	\N	2024-02-16	2025-02-15
1160	10131	39	225	t	Alta	/evidencias/10131_225.pdf	2024-11-30	2026-11-30
1161	10131	39	225	t	Media	/evidencias/10131_225.pdf	2023-09-30	2024-09-29
1162	10132	24	135	t	Media	/evidencias/10132_135.pdf	2025-10-07	2026-10-07
1163	10132	24	136	f	Media	\N	2023-08-26	2024-08-25
1164	10132	24	136	f	Baja	\N	2023-11-15	2025-11-14
1165	10132	24	137	f	Baja	\N	2025-09-19	2026-09-19
1166	10132	24	138	t	Alta	/evidencias/10132_138.pdf	2025-08-20	2026-08-20
1167	10132	24	138	t	Media	/evidencias/10132_138.pdf	2025-08-22	2026-08-22
1168	10132	24	139	f	Baja	\N	2023-09-17	2024-09-16
1169	10133	115	685	f	Alta	\N	2026-04-15	2027-04-15
1170	10133	115	686	t	Media	/evidencias/10133_686.pdf	2024-02-03	2026-02-02
1171	10133	115	687	t	Alta	/evidencias/10133_687.pdf	2025-04-26	2027-04-26
1172	10133	115	687	t	Media	/evidencias/10133_687.pdf	2023-06-04	2025-06-03
1173	10133	115	688	t	Media	/evidencias/10133_688.pdf	2024-01-28	2025-01-27
1174	10133	115	689	f	Baja	\N	2023-11-10	2024-11-09
1175	10134	18	104	t	Media	/evidencias/10134_104.pdf	2023-08-27	2025-08-26
1176	10134	18	105	f	Media	\N	2023-12-29	2024-12-28
1177	10134	18	105	t	Alta	/evidencias/10134_105.pdf	2023-10-21	2025-10-20
1178	10134	18	106	t	Baja	/evidencias/10134_106.pdf	2026-05-30	2027-05-30
1179	10134	18	106	f	Baja	\N	2025-07-14	2026-07-14
1180	10134	18	107	t	Media	/evidencias/10134_107.pdf	2023-09-13	2024-09-12
1181	10135	44	253	t	Alta	/evidencias/10135_253.pdf	2023-08-22	2025-08-21
1182	10135	44	254	t	Baja	/evidencias/10135_254.pdf	2025-09-25	2027-09-25
1183	10135	44	255	t	Baja	/evidencias/10135_255.pdf	2023-07-16	2024-07-15
1184	10135	44	255	t	Media	/evidencias/10135_255.pdf	2023-12-21	2024-12-20
1185	10135	44	256	t	Media	/evidencias/10135_256.pdf	2024-08-27	2026-08-27
1186	10136	27	149	f	Baja	\N	2024-05-08	2026-05-08
1187	10136	27	149	t	Media	/evidencias/10136_149.pdf	2026-02-23	2027-02-23
1188	10136	27	150	t	Media	/evidencias/10136_150.pdf	2025-10-16	2026-10-16
1189	10136	27	150	t	Media	/evidencias/10136_150.pdf	2024-12-10	2025-12-10
1190	10136	27	151	t	Media	/evidencias/10136_151.pdf	2024-03-16	2026-03-16
3389	10393	49	287	f	Media	\N	2023-08-05	2025-08-04
1191	10136	27	152	t	Alta	/evidencias/10136_152.pdf	2023-10-21	2024-10-20
1192	10136	27	152	f	Alta	\N	2026-01-22	2028-01-22
1193	10136	27	153	t	Alta	/evidencias/10136_153.pdf	2025-02-01	2027-02-01
1194	10136	27	154	t	Baja	/evidencias/10136_154.pdf	2025-02-13	2027-02-13
1195	10136	27	154	f	Baja	\N	2025-03-02	2027-03-02
1196	10136	27	155	t	Alta	/evidencias/10136_155.pdf	2023-10-27	2024-10-26
1197	10136	27	155	t	Alta	/evidencias/10136_155.pdf	2023-12-16	2025-12-15
1198	10137	68	396	f	Baja	\N	2025-12-22	2027-12-22
1199	10137	68	397	f	Alta	\N	2023-11-17	2024-11-16
1200	10137	68	397	f	Alta	\N	2024-07-13	2025-07-13
1201	10137	68	398	f	Baja	\N	2025-06-03	2026-06-03
1202	10137	68	398	f	Baja	\N	2024-02-13	2026-02-12
1203	10137	68	399	t	Alta	/evidencias/10137_399.pdf	2025-09-10	2026-09-10
1204	10137	68	400	t	Baja	/evidencias/10137_400.pdf	2025-02-07	2026-02-07
1205	10137	68	400	t	Media	/evidencias/10137_400.pdf	2023-06-19	2024-06-18
1206	10137	68	401	t	Alta	/evidencias/10137_401.pdf	2025-10-04	2027-10-04
1207	10137	68	401	f	Baja	\N	2026-01-12	2027-01-12
1208	10137	68	402	t	Alta	/evidencias/10137_402.pdf	2025-05-13	2026-05-13
1209	10137	68	402	f	Media	\N	2025-05-27	2026-05-27
1210	10137	68	403	t	Alta	/evidencias/10137_403.pdf	2025-12-10	2026-12-10
1211	10138	135	809	t	Baja	/evidencias/10138_809.pdf	2023-06-18	2025-06-17
1212	10138	135	810	t	Baja	/evidencias/10138_810.pdf	2025-09-03	2026-09-03
1213	10138	135	811	t	Media	/evidencias/10138_811.pdf	2025-03-01	2027-03-01
1214	10138	135	812	t	Media	/evidencias/10138_812.pdf	2025-06-27	2027-06-27
1215	10138	135	812	t	Alta	/evidencias/10138_812.pdf	2024-04-08	2026-04-08
1216	10138	135	813	f	Media	\N	2023-11-27	2024-11-26
1217	10138	135	813	f	Media	\N	2024-06-07	2025-06-07
1218	10138	135	814	f	Alta	\N	2024-10-24	2025-10-24
1219	10139	135	809	t	Alta	/evidencias/10139_809.pdf	2025-01-04	2027-01-04
1220	10139	135	809	t	Media	/evidencias/10139_809.pdf	2025-04-16	2027-04-16
1221	10139	135	810	f	Media	\N	2025-03-17	2027-03-17
1222	10139	135	810	t	Baja	/evidencias/10139_810.pdf	2026-01-05	2028-01-05
1223	10139	135	811	t	Alta	/evidencias/10139_811.pdf	2025-10-05	2027-10-05
1224	10139	135	812	f	Media	\N	2024-05-01	2026-05-01
1225	10139	135	813	t	Media	/evidencias/10139_813.pdf	2026-02-10	2028-02-10
1226	10139	135	813	t	Alta	/evidencias/10139_813.pdf	2026-04-12	2028-04-11
1227	10139	135	814	f	Media	\N	2025-06-30	2026-06-30
1228	10140	114	678	t	Media	/evidencias/10140_678.pdf	2023-08-08	2025-08-07
1229	10140	114	679	f	Media	\N	2025-02-12	2026-02-12
1230	10140	114	679	t	Alta	/evidencias/10140_679.pdf	2023-09-23	2024-09-22
1231	10140	114	680	t	Media	/evidencias/10140_680.pdf	2024-06-01	2025-06-01
1232	10140	114	680	t	Media	/evidencias/10140_680.pdf	2024-07-31	2025-07-31
1233	10140	114	681	t	Media	/evidencias/10140_681.pdf	2026-05-16	2027-05-16
1234	10140	114	682	t	Baja	/evidencias/10140_682.pdf	2024-04-19	2026-04-19
1235	10140	114	683	f	Baja	\N	2026-03-25	2027-03-25
1236	10140	114	683	f	Alta	\N	2026-04-23	2027-04-23
1237	10140	114	684	t	Media	/evidencias/10140_684.pdf	2026-03-01	2027-03-01
1238	10141	64	367	t	Media	/evidencias/10141_367.pdf	2024-06-29	2026-06-29
1239	10141	64	368	t	Baja	/evidencias/10141_368.pdf	2025-02-22	2027-02-22
1240	10141	64	369	t	Alta	/evidencias/10141_369.pdf	2025-05-17	2026-05-17
1241	10141	64	369	t	Media	/evidencias/10141_369.pdf	2025-01-30	2026-01-30
1242	10141	64	370	t	Alta	/evidencias/10141_370.pdf	2025-06-07	2027-06-07
1243	10141	64	371	f	Alta	\N	2023-07-25	2025-07-24
1244	10141	64	372	f	Media	\N	2024-09-30	2026-09-30
1245	10141	64	372	f	Alta	\N	2025-09-28	2027-09-28
1246	10141	64	373	t	Baja	/evidencias/10141_373.pdf	2024-08-17	2025-08-17
1247	10142	32	178	t	Baja	/evidencias/10142_178.pdf	2024-06-27	2026-06-27
1248	10142	32	179	t	Media	/evidencias/10142_179.pdf	2023-11-28	2024-11-27
1249	10142	32	180	t	Media	/evidencias/10142_180.pdf	2024-02-10	2026-02-09
1250	10142	32	181	f	Alta	\N	2024-07-18	2026-07-18
1251	10142	32	182	t	Media	/evidencias/10142_182.pdf	2024-06-10	2025-06-10
1252	10142	32	182	f	Media	\N	2023-08-03	2024-08-02
1253	10142	32	183	t	Alta	/evidencias/10142_183.pdf	2024-08-16	2025-08-16
1254	10142	32	184	t	Media	/evidencias/10142_184.pdf	2024-11-23	2025-11-23
1255	10143	97	577	t	Baja	/evidencias/10143_577.pdf	2024-05-21	2026-05-21
1256	10143	97	577	f	Baja	\N	2024-06-10	2025-06-10
1257	10143	97	578	f	Media	\N	2024-12-03	2025-12-03
1258	10143	97	578	f	Media	\N	2024-04-20	2026-04-20
1259	10143	97	579	t	Media	/evidencias/10143_579.pdf	2025-04-28	2027-04-28
1260	10143	97	579	t	Baja	/evidencias/10143_579.pdf	2025-08-01	2026-08-01
1261	10143	97	580	t	Media	/evidencias/10143_580.pdf	2023-07-10	2025-07-09
1262	10143	97	580	t	Alta	/evidencias/10143_580.pdf	2024-02-07	2025-02-06
1263	10143	97	581	t	Baja	/evidencias/10143_581.pdf	2023-06-11	2025-06-10
1264	10143	97	581	f	Media	\N	2025-09-25	2027-09-25
1265	10144	146	872	t	Baja	/evidencias/10144_872.pdf	2025-01-10	2027-01-10
1266	10144	146	872	t	Alta	/evidencias/10144_872.pdf	2024-06-15	2025-06-15
1267	10144	146	873	t	Alta	/evidencias/10144_873.pdf	2026-04-19	2027-04-19
1268	10144	146	874	t	Media	/evidencias/10144_874.pdf	2024-08-05	2026-08-05
1269	10144	146	874	f	Baja	\N	2024-10-10	2026-10-10
1270	10144	146	875	t	Media	/evidencias/10144_875.pdf	2025-04-16	2026-04-16
1271	10144	146	876	t	Baja	/evidencias/10144_876.pdf	2026-01-15	2028-01-15
1272	10144	146	876	t	Baja	/evidencias/10144_876.pdf	2024-04-09	2026-04-09
1273	10145	123	732	t	Baja	/evidencias/10145_732.pdf	2025-06-24	2027-06-24
1274	10145	123	733	t	Baja	/evidencias/10145_733.pdf	2023-07-26	2024-07-25
1275	10145	123	733	f	Alta	\N	2024-05-30	2026-05-30
1276	10145	123	734	t	Alta	/evidencias/10145_734.pdf	2025-12-20	2027-12-20
1277	10145	123	734	f	Alta	\N	2025-06-24	2027-06-24
1278	10145	123	735	t	Alta	/evidencias/10145_735.pdf	2026-05-29	2028-05-28
1279	10145	123	736	t	Baja	/evidencias/10145_736.pdf	2024-10-18	2025-10-18
1280	10145	123	737	t	Media	/evidencias/10145_737.pdf	2026-01-14	2028-01-14
1281	10145	123	737	t	Alta	/evidencias/10145_737.pdf	2026-03-04	2027-03-04
1282	10145	123	738	f	Baja	\N	2023-10-23	2024-10-22
1283	10145	123	738	t	Alta	/evidencias/10145_738.pdf	2025-01-13	2027-01-13
1284	10145	123	739	f	Baja	\N	2024-11-07	2026-11-07
1285	10146	76	447	t	Baja	/evidencias/10146_447.pdf	2024-09-17	2025-09-17
1286	10146	76	448	t	Baja	/evidencias/10146_448.pdf	2023-12-27	2024-12-26
1287	10146	76	448	t	Alta	/evidencias/10146_448.pdf	2025-04-27	2026-04-27
1288	10146	76	449	t	Media	/evidencias/10146_449.pdf	2023-10-26	2024-10-25
1289	10146	76	449	t	Media	/evidencias/10146_449.pdf	2024-11-22	2025-11-22
1290	10146	76	450	f	Media	\N	2023-11-30	2025-11-29
1291	10146	76	450	f	Media	\N	2024-05-12	2025-05-12
1292	10146	76	451	t	Media	/evidencias/10146_451.pdf	2025-12-30	2027-12-30
1293	10146	76	451	t	Alta	/evidencias/10146_451.pdf	2025-10-22	2026-10-22
1294	10146	76	452	t	Media	/evidencias/10146_452.pdf	2024-03-10	2025-03-10
1295	10146	76	453	t	Media	/evidencias/10146_453.pdf	2024-06-29	2026-06-29
1296	10147	66	382	t	Media	/evidencias/10147_382.pdf	2024-04-27	2026-04-27
1297	10147	66	383	t	Alta	/evidencias/10147_383.pdf	2024-12-29	2025-12-29
1298	10147	66	384	t	Media	/evidencias/10147_384.pdf	2023-08-03	2025-08-02
1299	10147	66	384	t	Alta	/evidencias/10147_384.pdf	2025-04-28	2026-04-28
1300	10147	66	385	t	Media	/evidencias/10147_385.pdf	2024-03-21	2026-03-21
1301	10147	66	386	t	Media	/evidencias/10147_386.pdf	2024-07-03	2025-07-03
1302	10147	66	386	t	Alta	/evidencias/10147_386.pdf	2024-08-14	2026-08-14
1303	10147	66	387	t	Baja	/evidencias/10147_387.pdf	2025-05-27	2026-05-27
1304	10148	94	557	t	Alta	/evidencias/10148_557.pdf	2026-02-28	2028-02-28
1305	10148	94	558	t	Media	/evidencias/10148_558.pdf	2024-05-02	2026-05-02
1306	10148	94	558	t	Baja	/evidencias/10148_558.pdf	2025-03-17	2027-03-17
1307	10148	94	559	t	Alta	/evidencias/10148_559.pdf	2024-04-14	2025-04-14
1308	10148	94	560	t	Media	/evidencias/10148_560.pdf	2026-03-17	2027-03-17
1309	10148	94	561	t	Media	/evidencias/10148_561.pdf	2025-10-27	2027-10-27
1310	10148	94	562	f	Baja	\N	2024-10-30	2025-10-30
1311	10148	94	562	t	Baja	/evidencias/10148_562.pdf	2025-07-16	2026-07-16
1312	10148	94	563	t	Baja	/evidencias/10148_563.pdf	2023-06-16	2025-06-15
1313	10149	14	81	f	Baja	\N	2023-07-06	2024-07-05
1314	10149	14	82	f	Media	\N	2025-10-18	2026-10-18
1315	10149	14	83	f	Media	\N	2025-08-20	2027-08-20
1316	10149	14	83	t	Media	/evidencias/10149_83.pdf	2024-11-09	2025-11-09
1317	10149	14	84	t	Media	/evidencias/10149_84.pdf	2025-01-22	2026-01-22
1318	10149	14	85	f	Alta	\N	2025-10-07	2026-10-07
1319	10149	14	86	t	Media	/evidencias/10149_86.pdf	2024-11-20	2025-11-20
1320	10150	27	149	f	Media	\N	2023-07-27	2024-07-26
1321	10150	27	150	f	Alta	\N	2024-07-27	2025-07-27
1322	10150	27	151	t	Media	/evidencias/10150_151.pdf	2024-05-30	2026-05-30
1323	10150	27	152	t	Media	/evidencias/10150_152.pdf	2025-05-30	2026-05-30
1324	10150	27	153	t	Media	/evidencias/10150_153.pdf	2024-03-22	2026-03-22
1325	10150	27	154	f	Media	\N	2025-09-08	2026-09-08
1326	10150	27	154	t	Media	/evidencias/10150_154.pdf	2024-11-27	2026-11-27
1327	10150	27	155	f	Baja	\N	2025-12-13	2026-12-13
1328	10151	7	40	f	Media	\N	2026-04-13	2028-04-12
1329	10151	7	40	t	Media	/evidencias/10151_40.pdf	2024-01-15	2025-01-14
1330	10151	7	41	t	Media	/evidencias/10151_41.pdf	2025-04-24	2027-04-24
1331	10151	7	42	f	Media	\N	2026-03-07	2028-03-06
1332	10151	7	42	t	Baja	/evidencias/10151_42.pdf	2024-04-09	2025-04-09
1333	10151	7	43	f	Alta	\N	2025-10-28	2026-10-28
1334	10151	7	43	t	Alta	/evidencias/10151_43.pdf	2026-01-29	2028-01-29
1335	10151	7	44	t	Alta	/evidencias/10151_44.pdf	2026-01-07	2027-01-07
1336	10151	7	44	t	Baja	/evidencias/10151_44.pdf	2025-10-02	2026-10-02
1337	10151	7	45	f	Baja	\N	2025-11-03	2027-11-03
1338	10151	7	45	f	Media	\N	2024-06-07	2025-06-07
1339	10152	49	285	t	Baja	/evidencias/10152_285.pdf	2025-08-09	2027-08-09
1340	10152	49	286	t	Media	/evidencias/10152_286.pdf	2024-04-17	2025-04-17
1341	10152	49	286	t	Alta	/evidencias/10152_286.pdf	2026-05-30	2028-05-29
1342	10152	49	287	t	Alta	/evidencias/10152_287.pdf	2026-04-01	2028-03-31
1343	10152	49	288	f	Media	\N	2024-12-24	2025-12-24
1344	10153	43	247	t	Media	/evidencias/10153_247.pdf	2023-11-02	2024-11-01
1345	10153	43	248	f	Media	\N	2023-06-11	2024-06-10
1346	10153	43	249	t	Baja	/evidencias/10153_249.pdf	2025-12-11	2026-12-11
1347	10153	43	249	t	Baja	/evidencias/10153_249.pdf	2025-05-07	2026-05-07
1348	10153	43	250	t	Alta	/evidencias/10153_250.pdf	2025-11-18	2026-11-18
1349	10153	43	251	t	Alta	/evidencias/10153_251.pdf	2023-09-27	2024-09-26
1350	10153	43	252	f	Baja	\N	2024-02-29	2025-02-28
1351	10154	123	732	f	Alta	\N	2023-12-17	2024-12-16
1352	10154	123	733	t	Alta	/evidencias/10154_733.pdf	2026-05-11	2028-05-10
1353	10154	123	734	t	Media	/evidencias/10154_734.pdf	2025-11-13	2027-11-13
1354	10154	123	734	t	Alta	/evidencias/10154_734.pdf	2024-07-19	2026-07-19
1355	10154	123	735	f	Media	\N	2026-04-05	2027-04-05
1356	10154	123	735	f	Baja	\N	2025-12-14	2026-12-14
1357	10154	123	736	f	Baja	\N	2026-02-02	2028-02-02
1358	10154	123	736	t	Alta	/evidencias/10154_736.pdf	2024-08-24	2025-08-24
1359	10154	123	737	t	Media	/evidencias/10154_737.pdf	2023-08-08	2025-08-07
1360	10154	123	737	t	Baja	/evidencias/10154_737.pdf	2023-12-25	2025-12-24
1361	10154	123	738	t	Baja	/evidencias/10154_738.pdf	2024-03-21	2025-03-21
1362	10154	123	738	t	Alta	/evidencias/10154_738.pdf	2025-06-12	2026-06-12
1363	10154	123	739	t	Media	/evidencias/10154_739.pdf	2024-08-23	2026-08-23
1364	10154	123	739	t	Media	/evidencias/10154_739.pdf	2024-01-19	2026-01-18
1365	10155	33	185	t	Media	/evidencias/10155_185.pdf	2023-09-13	2024-09-12
1366	10155	33	186	t	Baja	/evidencias/10155_186.pdf	2025-02-17	2027-02-17
1367	10155	33	186	f	Alta	\N	2024-10-24	2025-10-24
1368	10155	33	187	t	Baja	/evidencias/10155_187.pdf	2024-11-07	2025-11-07
1369	10155	33	188	t	Media	/evidencias/10155_188.pdf	2023-07-04	2024-07-03
1370	10155	33	189	f	Alta	\N	2026-01-06	2027-01-06
1371	10155	33	189	f	Media	\N	2024-04-03	2025-04-03
1372	10155	33	190	f	Alta	\N	2023-08-04	2025-08-03
1373	10155	33	190	t	Alta	/evidencias/10155_190.pdf	2026-02-05	2028-02-05
1374	10155	33	191	t	Media	/evidencias/10155_191.pdf	2023-08-01	2024-07-31
1375	10155	33	191	f	Media	\N	2025-05-27	2026-05-27
1376	10155	33	192	t	Alta	/evidencias/10155_192.pdf	2024-11-24	2025-11-24
1377	10155	33	192	f	Baja	\N	2025-05-06	2027-05-06
1378	10156	83	489	t	Baja	/evidencias/10156_489.pdf	2024-10-27	2026-10-27
1379	10156	83	489	t	Alta	/evidencias/10156_489.pdf	2026-01-11	2028-01-11
1380	10156	83	490	t	Alta	/evidencias/10156_490.pdf	2025-05-30	2027-05-30
1381	10156	83	491	f	Alta	\N	2023-12-30	2025-12-29
1382	10156	83	492	t	Baja	/evidencias/10156_492.pdf	2026-04-12	2027-04-12
1383	10156	83	492	t	Alta	/evidencias/10156_492.pdf	2025-11-05	2026-11-05
1384	10156	83	493	t	Media	/evidencias/10156_493.pdf	2023-08-24	2024-08-23
1385	10157	20	113	t	Alta	/evidencias/10157_113.pdf	2024-03-01	2025-03-01
1386	10157	20	114	t	Media	/evidencias/10157_114.pdf	2026-04-14	2027-04-14
1387	10157	20	114	f	Alta	\N	2024-07-29	2025-07-29
1388	10157	20	115	t	Baja	/evidencias/10157_115.pdf	2024-03-03	2025-03-03
1389	10157	20	116	t	Media	/evidencias/10157_116.pdf	2024-03-09	2025-03-09
1390	10157	20	117	t	Alta	/evidencias/10157_117.pdf	2024-05-04	2025-05-04
1391	10157	20	118	f	Media	\N	2025-10-13	2026-10-13
1392	10158	71	417	t	Media	/evidencias/10158_417.pdf	2025-01-21	2026-01-21
1393	10158	71	418	t	Alta	/evidencias/10158_418.pdf	2024-04-13	2026-04-13
1394	10158	71	418	t	Alta	/evidencias/10158_418.pdf	2023-10-27	2024-10-26
1395	10158	71	419	f	Media	\N	2026-04-15	2027-04-15
1396	10158	71	420	t	Alta	/evidencias/10158_420.pdf	2026-04-17	2028-04-16
1397	10158	71	421	t	Alta	/evidencias/10158_421.pdf	2024-10-30	2025-10-30
1398	10158	71	422	f	Alta	\N	2023-06-25	2025-06-24
1399	10158	71	422	t	Alta	/evidencias/10158_422.pdf	2025-05-04	2027-05-04
1400	10158	71	423	t	Media	/evidencias/10158_423.pdf	2025-04-26	2026-04-26
1401	10158	71	423	f	Alta	\N	2024-07-07	2025-07-07
1402	10158	71	424	f	Alta	\N	2026-03-16	2028-03-15
1403	10158	71	424	t	Media	/evidencias/10158_424.pdf	2024-04-09	2026-04-09
1404	10159	29	162	f	Alta	\N	2024-06-30	2026-06-30
1405	10159	29	162	t	Baja	/evidencias/10159_162.pdf	2025-06-04	2026-06-04
1406	10159	29	163	f	Alta	\N	2024-08-16	2025-08-16
1407	10159	29	164	t	Alta	/evidencias/10159_164.pdf	2025-08-22	2027-08-22
1408	10159	29	164	f	Media	\N	2023-08-08	2025-08-07
1409	10159	29	165	t	Media	/evidencias/10159_165.pdf	2026-03-01	2028-02-29
1410	10159	29	165	t	Media	/evidencias/10159_165.pdf	2026-04-02	2027-04-02
1411	10160	44	253	f	Alta	\N	2024-10-10	2026-10-10
1412	10160	44	253	t	Alta	/evidencias/10160_253.pdf	2025-07-27	2026-07-27
1413	10160	44	254	t	Alta	/evidencias/10160_254.pdf	2024-03-18	2025-03-18
1414	10160	44	255	t	Alta	/evidencias/10160_255.pdf	2026-01-01	2028-01-01
1415	10160	44	255	t	Alta	/evidencias/10160_255.pdf	2025-04-23	2026-04-23
1416	10160	44	256	t	Alta	/evidencias/10160_256.pdf	2025-01-19	2027-01-19
1417	10160	44	256	t	Baja	/evidencias/10160_256.pdf	2025-04-26	2027-04-26
1418	10161	121	717	f	Media	\N	2023-10-25	2025-10-24
1419	10161	121	718	t	Media	/evidencias/10161_718.pdf	2025-03-13	2026-03-13
1420	10161	121	718	f	Media	\N	2026-01-20	2027-01-20
1421	10161	121	719	f	Baja	\N	2024-08-09	2025-08-09
1422	10161	121	720	f	Media	\N	2024-10-23	2026-10-23
1423	10161	121	720	t	Media	/evidencias/10161_720.pdf	2024-03-03	2025-03-03
1424	10161	121	721	f	Media	\N	2023-11-04	2024-11-03
1425	10161	121	721	t	Media	/evidencias/10161_721.pdf	2026-03-30	2028-03-29
1426	10161	121	722	t	Alta	/evidencias/10161_722.pdf	2024-05-26	2025-05-26
1427	10161	121	722	t	Alta	/evidencias/10161_722.pdf	2026-04-28	2028-04-27
1428	10161	121	723	t	Media	/evidencias/10161_723.pdf	2024-08-10	2025-08-10
1429	10162	35	201	t	Alta	/evidencias/10162_201.pdf	2025-10-20	2027-10-20
1430	10162	35	202	f	Baja	\N	2024-10-08	2026-10-08
1431	10162	35	203	t	Media	/evidencias/10162_203.pdf	2025-02-07	2026-02-07
1432	10162	35	204	f	Alta	\N	2025-01-11	2027-01-11
1433	10162	35	204	f	Baja	\N	2024-08-06	2026-08-06
1434	10162	35	205	t	Media	/evidencias/10162_205.pdf	2023-09-17	2024-09-16
1435	10163	71	417	t	Media	/evidencias/10163_417.pdf	2024-03-11	2026-03-11
1436	10163	71	418	t	Baja	/evidencias/10163_418.pdf	2024-12-17	2025-12-17
1437	10163	71	419	t	Baja	/evidencias/10163_419.pdf	2026-03-03	2028-03-02
1438	10163	71	420	f	Media	\N	2023-06-24	2024-06-23
1439	10163	71	420	f	Alta	\N	2024-07-28	2025-07-28
1440	10163	71	421	f	Media	\N	2023-09-11	2025-09-10
1441	10163	71	421	t	Baja	/evidencias/10163_421.pdf	2024-09-04	2025-09-04
1442	10163	71	422	f	Baja	\N	2024-08-17	2025-08-17
1443	10163	71	422	t	Baja	/evidencias/10163_422.pdf	2025-12-30	2026-12-30
1444	10163	71	423	t	Media	/evidencias/10163_423.pdf	2025-05-25	2026-05-25
1445	10163	71	424	f	Media	\N	2023-08-14	2025-08-13
1446	10163	71	424	f	Media	\N	2026-03-14	2027-03-14
1447	10164	27	149	t	Alta	/evidencias/10164_149.pdf	2026-01-22	2027-01-22
1448	10164	27	149	t	Baja	/evidencias/10164_149.pdf	2024-02-21	2025-02-20
1449	10164	27	150	f	Baja	\N	2025-02-18	2027-02-18
1450	10164	27	151	t	Baja	/evidencias/10164_151.pdf	2023-08-02	2024-08-01
1451	10164	27	151	t	Baja	/evidencias/10164_151.pdf	2024-08-09	2025-08-09
1452	10164	27	152	f	Baja	\N	2025-03-18	2027-03-18
1453	10164	27	153	t	Media	/evidencias/10164_153.pdf	2024-08-25	2026-08-25
1454	10164	27	153	t	Alta	/evidencias/10164_153.pdf	2025-06-16	2026-06-16
1455	10164	27	154	t	Media	/evidencias/10164_154.pdf	2023-08-25	2024-08-24
1456	10164	27	155	f	Alta	\N	2025-04-06	2027-04-06
1457	10164	27	155	t	Media	/evidencias/10164_155.pdf	2025-04-02	2027-04-02
1458	10165	123	732	f	Baja	\N	2024-03-25	2026-03-25
1459	10165	123	732	f	Alta	\N	2023-07-21	2024-07-20
1460	10165	123	733	t	Media	/evidencias/10165_733.pdf	2025-03-25	2026-03-25
1461	10165	123	734	t	Media	/evidencias/10165_734.pdf	2023-08-09	2025-08-08
1462	10165	123	735	t	Baja	/evidencias/10165_735.pdf	2025-04-10	2027-04-10
1463	10165	123	736	t	Baja	/evidencias/10165_736.pdf	2024-10-05	2026-10-05
1464	10165	123	737	f	Baja	\N	2025-09-05	2027-09-05
1465	10165	123	737	t	Alta	/evidencias/10165_737.pdf	2024-12-08	2025-12-08
1466	10165	123	738	t	Alta	/evidencias/10165_738.pdf	2025-04-06	2026-04-06
1467	10165	123	739	t	Media	/evidencias/10165_739.pdf	2024-02-20	2026-02-19
1468	10167	52	303	t	Baja	/evidencias/10167_303.pdf	2025-12-19	2026-12-19
1469	10167	52	303	t	Alta	/evidencias/10167_303.pdf	2025-11-24	2026-11-24
1470	10167	52	304	t	Alta	/evidencias/10167_304.pdf	2025-07-09	2027-07-09
1471	10167	52	305	t	Alta	/evidencias/10167_305.pdf	2025-03-13	2026-03-13
1472	10167	52	306	t	Alta	/evidencias/10167_306.pdf	2024-07-08	2025-07-08
1473	10167	52	307	t	Alta	/evidencias/10167_307.pdf	2023-10-28	2025-10-27
1474	10167	52	307	t	Alta	/evidencias/10167_307.pdf	2023-06-10	2025-06-09
1475	10167	52	308	t	Alta	/evidencias/10167_308.pdf	2025-09-28	2027-09-28
1476	10167	52	309	t	Alta	/evidencias/10167_309.pdf	2024-05-23	2025-05-23
1477	10167	52	310	f	Media	\N	2026-04-17	2028-04-16
1478	10167	52	310	f	Media	\N	2024-05-13	2026-05-13
1479	10168	106	632	f	Media	\N	2025-04-25	2026-04-25
1480	10168	106	632	t	Media	/evidencias/10168_632.pdf	2025-02-11	2026-02-11
1481	10168	106	633	f	Media	\N	2024-04-08	2026-04-08
1482	10168	106	633	t	Baja	/evidencias/10168_633.pdf	2025-03-10	2027-03-10
1483	10168	106	634	t	Baja	/evidencias/10168_634.pdf	2025-05-02	2027-05-02
1484	10168	106	634	t	Alta	/evidencias/10168_634.pdf	2024-03-11	2025-03-11
1485	10168	106	635	t	Alta	/evidencias/10168_635.pdf	2023-08-25	2025-08-24
1486	10168	106	635	t	Baja	/evidencias/10168_635.pdf	2025-01-04	2026-01-04
1487	10168	106	636	t	Alta	/evidencias/10168_636.pdf	2025-05-07	2026-05-07
1488	10168	106	636	t	Media	/evidencias/10168_636.pdf	2023-07-14	2025-07-13
1489	10169	148	882	t	Media	/evidencias/10169_882.pdf	2026-01-31	2028-01-31
1490	10169	148	882	t	Alta	/evidencias/10169_882.pdf	2025-02-24	2027-02-24
1491	10169	148	883	f	Media	\N	2024-08-07	2025-08-07
1492	10169	148	883	t	Media	/evidencias/10169_883.pdf	2025-06-11	2027-06-11
1493	10169	148	884	t	Baja	/evidencias/10169_884.pdf	2024-01-08	2026-01-07
1494	10169	148	885	t	Media	/evidencias/10169_885.pdf	2025-09-18	2026-09-18
1495	10169	148	885	f	Baja	\N	2026-03-20	2028-03-19
1496	10169	148	886	t	Baja	/evidencias/10169_886.pdf	2024-08-24	2025-08-24
1497	10169	148	886	f	Alta	\N	2024-01-04	2025-01-03
1498	10169	148	887	t	Baja	/evidencias/10169_887.pdf	2025-11-27	2026-11-27
1499	10169	148	888	f	Media	\N	2024-05-28	2025-05-28
1500	10169	148	888	t	Alta	/evidencias/10169_888.pdf	2024-04-03	2025-04-03
1501	10170	93	550	t	Alta	/evidencias/10170_550.pdf	2024-07-29	2025-07-29
1502	10170	93	551	f	Alta	\N	2024-05-28	2025-05-28
1503	10170	93	552	t	Media	/evidencias/10170_552.pdf	2025-02-01	2026-02-01
1504	10170	93	552	t	Baja	/evidencias/10170_552.pdf	2025-12-14	2027-12-14
1505	10170	93	553	t	Baja	/evidencias/10170_553.pdf	2025-02-22	2026-02-22
1506	10170	93	554	t	Media	/evidencias/10170_554.pdf	2025-10-14	2027-10-14
1507	10170	93	554	t	Baja	/evidencias/10170_554.pdf	2026-05-07	2027-05-07
1508	10170	93	555	t	Baja	/evidencias/10170_555.pdf	2025-08-05	2026-08-05
1509	10170	93	556	t	Media	/evidencias/10170_556.pdf	2026-03-04	2028-03-03
1510	10170	93	556	t	Media	/evidencias/10170_556.pdf	2025-05-04	2027-05-04
1511	10171	138	825	t	Alta	/evidencias/10171_825.pdf	2025-02-16	2027-02-16
1512	10171	138	825	t	Media	/evidencias/10171_825.pdf	2023-09-06	2025-09-05
1513	10171	138	826	t	Baja	/evidencias/10171_826.pdf	2024-02-09	2025-02-08
1514	10171	138	827	t	Alta	/evidencias/10171_827.pdf	2026-05-20	2028-05-19
1515	10171	138	828	f	Media	\N	2025-11-23	2026-11-23
1516	10171	138	828	t	Baja	/evidencias/10171_828.pdf	2023-12-12	2024-12-11
1517	10172	14	81	t	Media	/evidencias/10172_81.pdf	2025-02-14	2027-02-14
1518	10172	14	81	t	Alta	/evidencias/10172_81.pdf	2025-05-30	2026-05-30
1519	10172	14	82	t	Alta	/evidencias/10172_82.pdf	2025-01-10	2026-01-10
1520	10172	14	82	t	Media	/evidencias/10172_82.pdf	2024-09-29	2025-09-29
1521	10172	14	83	t	Media	/evidencias/10172_83.pdf	2023-07-25	2025-07-24
1522	10172	14	83	f	Media	\N	2025-04-26	2027-04-26
1523	10172	14	84	f	Baja	\N	2023-06-20	2025-06-19
1524	10172	14	84	f	Alta	\N	2025-09-01	2026-09-01
1525	10172	14	85	t	Media	/evidencias/10172_85.pdf	2024-06-02	2026-06-02
1526	10172	14	86	f	Alta	\N	2025-05-03	2027-05-03
1527	10172	14	86	t	Alta	/evidencias/10172_86.pdf	2024-04-04	2025-04-04
1528	10173	104	619	t	Alta	/evidencias/10173_619.pdf	2024-04-17	2025-04-17
1529	10173	104	620	t	Media	/evidencias/10173_620.pdf	2024-08-28	2026-08-28
1530	10173	104	621	t	Alta	/evidencias/10173_621.pdf	2023-08-05	2025-08-04
1531	10173	104	621	t	Media	/evidencias/10173_621.pdf	2025-06-16	2027-06-16
1532	10173	104	622	t	Baja	/evidencias/10173_622.pdf	2026-04-28	2027-04-28
1533	10173	104	622	f	Media	\N	2024-11-03	2025-11-03
1534	10173	104	623	t	Baja	/evidencias/10173_623.pdf	2025-09-08	2026-09-08
1535	10173	104	624	t	Media	/evidencias/10173_624.pdf	2023-06-11	2024-06-10
1536	10173	104	625	f	Media	\N	2024-07-18	2026-07-18
1537	10174	109	648	t	Alta	/evidencias/10174_648.pdf	2025-09-27	2027-09-27
1538	10174	109	648	t	Alta	/evidencias/10174_648.pdf	2024-10-18	2025-10-18
1539	10174	109	649	t	Baja	/evidencias/10174_649.pdf	2026-03-26	2028-03-25
1540	10174	109	650	t	Media	/evidencias/10174_650.pdf	2024-11-21	2026-11-21
1541	10174	109	650	t	Media	/evidencias/10174_650.pdf	2024-09-29	2026-09-29
1542	10174	109	651	t	Alta	/evidencias/10174_651.pdf	2023-07-30	2025-07-29
1543	10174	109	652	t	Baja	/evidencias/10174_652.pdf	2023-06-26	2025-06-25
1544	10174	109	653	f	Media	\N	2024-04-13	2025-04-13
1545	10175	3	14	f	Baja	\N	2025-09-04	2026-09-04
1546	10175	3	14	t	Alta	/evidencias/10175_14.pdf	2025-05-14	2026-05-14
1547	10175	3	15	f	Media	\N	2024-09-27	2026-09-27
1548	10175	3	15	f	Baja	\N	2024-07-27	2026-07-27
1549	10175	3	16	t	Baja	/evidencias/10175_16.pdf	2024-04-04	2025-04-04
1550	10175	3	17	f	Media	\N	2025-03-12	2027-03-12
1551	10175	3	17	t	Media	/evidencias/10175_17.pdf	2025-12-16	2027-12-16
1552	10175	3	18	t	Media	/evidencias/10175_18.pdf	2024-03-27	2026-03-27
1553	10175	3	18	t	Media	/evidencias/10175_18.pdf	2023-11-30	2024-11-29
1554	10175	3	19	t	Media	/evidencias/10175_19.pdf	2024-02-10	2026-02-09
1555	10175	3	19	t	Alta	/evidencias/10175_19.pdf	2025-02-13	2027-02-13
1556	10175	3	20	t	Media	/evidencias/10175_20.pdf	2023-09-19	2024-09-18
1557	10175	3	20	t	Media	/evidencias/10175_20.pdf	2023-06-02	2025-06-01
1558	10175	3	21	t	Alta	/evidencias/10175_21.pdf	2024-11-21	2026-11-21
1559	10175	3	21	t	Media	/evidencias/10175_21.pdf	2025-07-06	2027-07-06
1560	10176	34	193	t	Alta	/evidencias/10176_193.pdf	2024-01-20	2026-01-19
1561	10176	34	194	t	Media	/evidencias/10176_194.pdf	2023-09-02	2024-09-01
1562	10176	34	195	f	Media	\N	2025-12-27	2026-12-27
1563	10176	34	196	t	Alta	/evidencias/10176_196.pdf	2023-09-26	2024-09-25
1564	10176	34	196	f	Baja	\N	2026-05-26	2027-05-26
1565	10176	34	197	t	Alta	/evidencias/10176_197.pdf	2025-05-16	2027-05-16
1566	10176	34	197	t	Media	/evidencias/10176_197.pdf	2026-03-07	2028-03-06
1567	10176	34	198	t	Media	/evidencias/10176_198.pdf	2025-10-29	2027-10-29
1568	10176	34	198	t	Baja	/evidencias/10176_198.pdf	2026-03-31	2028-03-30
1569	10176	34	199	f	Media	\N	2023-10-29	2024-10-28
1570	10176	34	199	f	Alta	\N	2025-03-29	2026-03-29
1571	10176	34	200	t	Media	/evidencias/10176_200.pdf	2023-10-13	2024-10-12
1572	10176	34	200	t	Alta	/evidencias/10176_200.pdf	2026-05-23	2028-05-22
1573	10177	74	437	t	Alta	/evidencias/10177_437.pdf	2025-06-07	2026-06-07
1574	10177	74	438	f	Alta	\N	2025-12-28	2027-12-28
1575	10177	74	439	f	Baja	\N	2023-10-20	2024-10-19
1576	10177	74	439	t	Media	/evidencias/10177_439.pdf	2024-11-11	2026-11-11
1577	10177	74	440	t	Baja	/evidencias/10177_440.pdf	2024-11-27	2026-11-27
1578	10178	95	564	f	Media	\N	2025-05-26	2027-05-26
1579	10178	95	565	t	Baja	/evidencias/10178_565.pdf	2024-04-12	2025-04-12
1580	10178	95	565	f	Media	\N	2025-12-08	2026-12-08
1581	10178	95	566	t	Baja	/evidencias/10178_566.pdf	2026-04-27	2028-04-26
1582	10178	95	567	t	Alta	/evidencias/10178_567.pdf	2023-08-14	2025-08-13
1583	10178	95	567	t	Media	/evidencias/10178_567.pdf	2023-09-02	2024-09-01
1584	10178	95	568	t	Alta	/evidencias/10178_568.pdf	2023-12-13	2024-12-12
1585	10178	95	568	t	Alta	/evidencias/10178_568.pdf	2025-10-09	2026-10-09
1586	10179	68	396	t	Media	/evidencias/10179_396.pdf	2025-06-09	2027-06-09
1587	10179	68	396	f	Media	\N	2026-04-18	2028-04-17
1588	10179	68	397	t	Baja	/evidencias/10179_397.pdf	2024-01-03	2025-01-02
1589	10179	68	397	t	Baja	/evidencias/10179_397.pdf	2026-05-09	2027-05-09
1590	10179	68	398	t	Media	/evidencias/10179_398.pdf	2025-03-28	2026-03-28
1591	10179	68	398	t	Media	/evidencias/10179_398.pdf	2025-02-26	2027-02-26
1592	10179	68	399	f	Baja	\N	2024-02-05	2026-02-04
1593	10179	68	399	t	Alta	/evidencias/10179_399.pdf	2024-05-28	2025-05-28
1594	10179	68	400	t	Media	/evidencias/10179_400.pdf	2026-03-23	2028-03-22
1595	10179	68	400	t	Baja	/evidencias/10179_400.pdf	2023-08-09	2024-08-08
1596	10179	68	401	t	Alta	/evidencias/10179_401.pdf	2023-12-12	2024-12-11
1597	10179	68	402	t	Media	/evidencias/10179_402.pdf	2024-11-14	2026-11-14
1598	10179	68	402	t	Baja	/evidencias/10179_402.pdf	2023-08-25	2025-08-24
1599	10179	68	403	f	Alta	\N	2025-02-06	2026-02-06
1600	10179	68	403	t	Alta	/evidencias/10179_403.pdf	2026-02-10	2027-02-10
1601	10180	69	404	f	Baja	\N	2023-08-25	2024-08-24
1602	10180	69	404	t	Alta	/evidencias/10180_404.pdf	2024-10-14	2025-10-14
1603	10180	69	405	t	Alta	/evidencias/10180_405.pdf	2026-04-03	2027-04-03
1604	10180	69	405	t	Media	/evidencias/10180_405.pdf	2025-01-29	2026-01-29
1605	10180	69	406	f	Alta	\N	2024-02-05	2026-02-04
1606	10180	69	406	f	Media	\N	2025-06-01	2026-06-01
1607	10180	69	407	t	Baja	/evidencias/10180_407.pdf	2024-11-19	2025-11-19
1608	10180	69	407	f	Media	\N	2026-02-01	2027-02-01
1609	10180	69	408	t	Alta	/evidencias/10180_408.pdf	2024-12-07	2026-12-07
1610	10180	69	409	f	Alta	\N	2025-10-02	2027-10-02
1611	10181	80	469	t	Alta	/evidencias/10181_469.pdf	2024-07-31	2026-07-31
1612	10181	80	469	t	Media	/evidencias/10181_469.pdf	2024-12-25	2026-12-25
1613	10181	80	470	t	Media	/evidencias/10181_470.pdf	2025-03-22	2027-03-22
1614	10181	80	470	t	Media	/evidencias/10181_470.pdf	2025-10-23	2027-10-23
1615	10181	80	471	t	Alta	/evidencias/10181_471.pdf	2024-12-18	2026-12-18
1616	10181	80	472	t	Baja	/evidencias/10181_472.pdf	2024-12-28	2025-12-28
1617	10181	80	473	f	Media	\N	2023-06-24	2024-06-23
1618	10181	80	474	t	Media	/evidencias/10181_474.pdf	2024-10-30	2025-10-30
1619	10182	75	441	t	Media	/evidencias/10182_441.pdf	2023-10-26	2025-10-25
1620	10182	75	442	t	Alta	/evidencias/10182_442.pdf	2023-09-28	2025-09-27
1621	10182	75	443	f	Alta	\N	2024-03-05	2026-03-05
1622	10182	75	444	f	Alta	\N	2023-08-25	2024-08-24
1623	10182	75	444	f	Media	\N	2024-10-18	2026-10-18
1624	10182	75	445	t	Media	/evidencias/10182_445.pdf	2023-09-20	2024-09-19
1625	10182	75	446	t	Media	/evidencias/10182_446.pdf	2026-03-27	2028-03-26
1626	10182	75	446	t	Media	/evidencias/10182_446.pdf	2024-06-24	2026-06-24
1627	10183	100	595	t	Media	/evidencias/10183_595.pdf	2025-01-01	2026-01-01
1628	10183	100	596	f	Alta	\N	2026-05-17	2027-05-17
1629	10183	100	596	t	Alta	/evidencias/10183_596.pdf	2025-04-11	2026-04-11
1630	10183	100	597	t	Alta	/evidencias/10183_597.pdf	2023-06-17	2024-06-16
1631	10183	100	598	t	Alta	/evidencias/10183_598.pdf	2023-10-18	2025-10-17
1632	10183	100	598	t	Media	/evidencias/10183_598.pdf	2023-08-11	2025-08-10
1633	10183	100	599	t	Baja	/evidencias/10183_599.pdf	2024-03-28	2026-03-28
1634	10183	100	599	f	Media	\N	2026-04-14	2027-04-14
1635	10183	100	600	t	Media	/evidencias/10183_600.pdf	2024-03-29	2026-03-29
1636	10183	100	600	t	Alta	/evidencias/10183_600.pdf	2025-01-22	2026-01-22
1637	10183	100	601	t	Alta	/evidencias/10183_601.pdf	2024-09-01	2026-09-01
1638	10183	100	602	t	Alta	/evidencias/10183_602.pdf	2026-01-28	2028-01-28
1639	10183	100	602	f	Baja	\N	2024-01-24	2025-01-23
1640	10184	72	425	f	Media	\N	2023-09-03	2024-09-02
1641	10184	72	426	t	Media	/evidencias/10184_426.pdf	2025-09-27	2027-09-27
1642	10184	72	426	t	Media	/evidencias/10184_426.pdf	2026-03-02	2028-03-01
1643	10184	72	427	f	Alta	\N	2025-09-30	2026-09-30
1644	10184	72	428	t	Media	/evidencias/10184_428.pdf	2023-12-23	2025-12-22
1645	10184	72	428	t	Media	/evidencias/10184_428.pdf	2026-05-13	2027-05-13
1646	10184	72	429	t	Media	/evidencias/10184_429.pdf	2025-09-06	2027-09-06
1647	10184	72	429	t	Baja	/evidencias/10184_429.pdf	2024-02-11	2026-02-10
1648	10184	72	430	t	Baja	/evidencias/10184_430.pdf	2026-04-06	2028-04-05
1649	10184	72	430	t	Alta	/evidencias/10184_430.pdf	2025-05-01	2026-05-01
1650	10184	72	431	t	Media	/evidencias/10184_431.pdf	2026-04-30	2028-04-29
1651	10184	72	431	t	Baja	/evidencias/10184_431.pdf	2024-03-07	2026-03-07
1652	10185	148	882	f	Media	\N	2025-11-01	2027-11-01
1653	10185	148	883	t	Baja	/evidencias/10185_883.pdf	2025-07-22	2027-07-22
1654	10185	148	883	t	Alta	/evidencias/10185_883.pdf	2025-06-19	2026-06-19
1655	10185	148	884	t	Alta	/evidencias/10185_884.pdf	2025-10-16	2027-10-16
1656	10185	148	885	t	Alta	/evidencias/10185_885.pdf	2025-05-06	2027-05-06
1657	10185	148	885	f	Media	\N	2025-09-21	2026-09-21
1658	10185	148	886	f	Media	\N	2024-05-09	2025-05-09
1659	10185	148	887	t	Media	/evidencias/10185_887.pdf	2024-01-14	2025-01-13
1660	10185	148	887	t	Media	/evidencias/10185_887.pdf	2024-02-02	2025-02-01
1661	10185	148	888	t	Alta	/evidencias/10185_888.pdf	2024-09-22	2025-09-22
1662	10186	73	432	t	Alta	/evidencias/10186_432.pdf	2024-04-18	2026-04-18
1663	10186	73	432	f	Alta	\N	2024-05-30	2025-05-30
1664	10186	73	433	f	Alta	\N	2024-02-12	2025-02-11
1665	10186	73	433	t	Baja	/evidencias/10186_433.pdf	2024-01-26	2026-01-25
1666	10186	73	434	t	Media	/evidencias/10186_434.pdf	2025-02-07	2027-02-07
1667	10186	73	434	f	Alta	\N	2025-04-19	2027-04-19
1668	10186	73	435	t	Baja	/evidencias/10186_435.pdf	2024-01-31	2025-01-30
1669	10186	73	435	f	Baja	\N	2025-05-21	2026-05-21
1670	10186	73	436	t	Media	/evidencias/10186_436.pdf	2023-10-07	2024-10-06
1671	10187	20	113	t	Media	/evidencias/10187_113.pdf	2024-12-03	2026-12-03
1672	10187	20	113	f	Alta	\N	2023-08-01	2024-07-31
1673	10187	20	114	f	Media	\N	2024-11-25	2025-11-25
1674	10187	20	114	f	Alta	\N	2023-07-17	2025-07-16
1675	10187	20	115	f	Baja	\N	2025-03-11	2026-03-11
1676	10187	20	116	f	Media	\N	2024-04-13	2025-04-13
1677	10187	20	117	t	Alta	/evidencias/10187_117.pdf	2024-10-18	2025-10-18
1678	10187	20	117	t	Media	/evidencias/10187_117.pdf	2024-07-17	2026-07-17
1679	10187	20	118	f	Media	\N	2024-12-23	2026-12-23
1680	10188	95	564	f	Baja	\N	2025-12-01	2026-12-01
1681	10188	95	564	t	Alta	/evidencias/10188_564.pdf	2025-03-24	2027-03-24
1682	10188	95	565	t	Media	/evidencias/10188_565.pdf	2026-03-06	2027-03-06
1683	10188	95	566	t	Media	/evidencias/10188_566.pdf	2025-12-19	2026-12-19
1684	10188	95	566	t	Baja	/evidencias/10188_566.pdf	2025-03-18	2027-03-18
1685	10188	95	567	t	Media	/evidencias/10188_567.pdf	2024-06-21	2025-06-21
1686	10188	95	568	t	Baja	/evidencias/10188_568.pdf	2025-12-14	2027-12-14
1687	10189	11	67	t	Media	/evidencias/10189_67.pdf	2023-10-26	2025-10-25
1688	10189	11	68	t	Media	/evidencias/10189_68.pdf	2024-12-12	2026-12-12
1689	10189	11	68	t	Baja	/evidencias/10189_68.pdf	2023-10-19	2025-10-18
1690	10189	11	69	t	Baja	/evidencias/10189_69.pdf	2025-02-24	2026-02-24
1691	10189	11	70	t	Alta	/evidencias/10189_70.pdf	2023-08-26	2025-08-25
1692	10190	28	156	t	Baja	/evidencias/10190_156.pdf	2024-03-29	2026-03-29
1693	10190	28	156	t	Baja	/evidencias/10190_156.pdf	2024-09-06	2026-09-06
1694	10190	28	157	t	Media	/evidencias/10190_157.pdf	2023-07-20	2025-07-19
1695	10190	28	157	t	Media	/evidencias/10190_157.pdf	2024-11-08	2025-11-08
1696	10190	28	158	f	Media	\N	2025-03-30	2027-03-30
1697	10190	28	158	t	Media	/evidencias/10190_158.pdf	2023-12-29	2025-12-28
1698	10190	28	159	t	Baja	/evidencias/10190_159.pdf	2026-03-19	2028-03-18
1699	10190	28	159	t	Media	/evidencias/10190_159.pdf	2024-09-28	2025-09-28
1700	10190	28	160	t	Alta	/evidencias/10190_160.pdf	2026-05-25	2028-05-24
1701	10190	28	160	t	Baja	/evidencias/10190_160.pdf	2025-03-16	2027-03-16
1702	10190	28	161	t	Alta	/evidencias/10190_161.pdf	2025-05-03	2026-05-03
1703	10190	28	161	t	Media	/evidencias/10190_161.pdf	2026-04-18	2028-04-17
1704	10191	10	59	t	Media	/evidencias/10191_59.pdf	2023-07-16	2025-07-15
1705	10191	10	60	t	Media	/evidencias/10191_60.pdf	2025-02-18	2026-02-18
1706	10191	10	61	t	Baja	/evidencias/10191_61.pdf	2023-06-25	2025-06-24
1707	10191	10	61	f	Alta	\N	2025-07-08	2027-07-08
1708	10191	10	62	f	Media	\N	2026-04-03	2028-04-02
1709	10191	10	63	t	Media	/evidencias/10191_63.pdf	2026-04-19	2027-04-19
1710	10191	10	63	t	Media	/evidencias/10191_63.pdf	2023-06-25	2025-06-24
1711	10191	10	64	t	Alta	/evidencias/10191_64.pdf	2023-06-28	2025-06-27
1712	10191	10	65	f	Alta	\N	2024-10-24	2026-10-24
1713	10191	10	66	t	Alta	/evidencias/10191_66.pdf	2026-01-31	2028-01-31
1714	10191	10	66	f	Baja	\N	2026-02-22	2028-02-22
1715	10192	123	732	t	Media	/evidencias/10192_732.pdf	2024-05-15	2026-05-15
1716	10192	123	732	t	Alta	/evidencias/10192_732.pdf	2025-01-23	2027-01-23
1717	10192	123	733	f	Alta	\N	2024-09-15	2026-09-15
1718	10192	123	734	f	Alta	\N	2024-08-06	2025-08-06
1719	10192	123	734	t	Media	/evidencias/10192_734.pdf	2023-09-19	2024-09-18
1720	10192	123	735	f	Alta	\N	2025-04-03	2027-04-03
1721	10192	123	735	f	Baja	\N	2025-01-07	2026-01-07
1722	10192	123	736	t	Baja	/evidencias/10192_736.pdf	2025-07-26	2026-07-26
1723	10192	123	737	f	Alta	\N	2023-09-09	2024-09-08
1724	10192	123	737	t	Media	/evidencias/10192_737.pdf	2023-06-23	2025-06-22
1725	10192	123	738	t	Media	/evidencias/10192_738.pdf	2023-12-09	2024-12-08
1726	10192	123	739	t	Media	/evidencias/10192_739.pdf	2025-03-30	2027-03-30
1727	10193	20	113	f	Baja	\N	2025-08-24	2027-08-24
1728	10193	20	113	t	Media	/evidencias/10193_113.pdf	2023-12-22	2025-12-21
1729	10193	20	114	t	Baja	/evidencias/10193_114.pdf	2024-06-03	2026-06-03
1730	10193	20	114	t	Baja	/evidencias/10193_114.pdf	2025-12-05	2026-12-05
1731	10193	20	115	t	Alta	/evidencias/10193_115.pdf	2024-04-29	2025-04-29
1732	10193	20	116	t	Alta	/evidencias/10193_116.pdf	2025-05-14	2026-05-14
1733	10193	20	117	t	Media	/evidencias/10193_117.pdf	2024-09-24	2025-09-24
1734	10193	20	118	t	Baja	/evidencias/10193_118.pdf	2023-12-22	2024-12-21
1735	10193	20	118	f	Media	\N	2024-08-15	2025-08-15
1736	10195	2	8	f	Alta	\N	2024-05-03	2026-05-03
1737	10195	2	9	t	Alta	/evidencias/10195_9.pdf	2025-06-23	2026-06-23
1738	10195	2	9	t	Media	/evidencias/10195_9.pdf	2024-09-30	2026-09-30
1739	10195	2	10	f	Baja	\N	2026-03-27	2027-03-27
1740	10195	2	10	f	Media	\N	2025-04-11	2026-04-11
1741	10195	2	11	t	Alta	/evidencias/10195_11.pdf	2026-04-17	2027-04-17
1742	10195	2	12	f	Media	\N	2023-12-24	2024-12-23
1743	10195	2	12	t	Alta	/evidencias/10195_12.pdf	2023-11-29	2025-11-28
1744	10195	2	13	t	Media	/evidencias/10195_13.pdf	2025-07-21	2027-07-21
1745	10195	2	13	t	Media	/evidencias/10195_13.pdf	2025-08-15	2027-08-15
1746	10196	23	130	f	Media	\N	2025-10-11	2026-10-11
1747	10196	23	131	f	Alta	\N	2025-11-17	2027-11-17
1748	10196	23	131	f	Baja	\N	2023-11-06	2025-11-05
1749	10196	23	132	f	Baja	\N	2023-12-15	2024-12-14
1750	10196	23	133	t	Baja	/evidencias/10196_133.pdf	2026-03-06	2028-03-05
1751	10196	23	133	t	Media	/evidencias/10196_133.pdf	2024-05-06	2026-05-06
1752	10196	23	134	t	Alta	/evidencias/10196_134.pdf	2024-09-05	2026-09-05
1753	10198	24	135	t	Baja	/evidencias/10198_135.pdf	2024-04-28	2025-04-28
1754	10198	24	136	t	Media	/evidencias/10198_136.pdf	2025-08-19	2027-08-19
1755	10198	24	136	f	Media	\N	2025-07-12	2026-07-12
1756	10198	24	137	t	Media	/evidencias/10198_137.pdf	2023-10-07	2024-10-06
1757	10198	24	137	f	Media	\N	2023-10-02	2024-10-01
1758	10198	24	138	t	Baja	/evidencias/10198_138.pdf	2025-06-07	2026-06-07
1759	10198	24	138	t	Media	/evidencias/10198_138.pdf	2025-11-25	2026-11-25
1760	10198	24	139	f	Baja	\N	2026-05-04	2028-05-03
1761	10198	24	139	t	Baja	/evidencias/10198_139.pdf	2024-04-26	2026-04-26
1762	10199	45	257	f	Media	\N	2025-04-19	2027-04-19
1763	10199	45	258	t	Media	/evidencias/10199_258.pdf	2024-05-01	2026-05-01
1764	10199	45	258	t	Media	/evidencias/10199_258.pdf	2025-05-07	2026-05-07
1765	10199	45	259	f	Media	\N	2025-11-25	2027-11-25
1766	10199	45	260	t	Media	/evidencias/10199_260.pdf	2023-08-21	2025-08-20
1767	10199	45	261	f	Baja	\N	2025-06-24	2026-06-24
1768	10199	45	261	t	Baja	/evidencias/10199_261.pdf	2024-10-31	2026-10-31
1769	10199	45	262	t	Baja	/evidencias/10199_262.pdf	2024-04-10	2026-04-10
1770	10199	45	262	t	Alta	/evidencias/10199_262.pdf	2023-07-24	2025-07-23
1771	10199	45	263	t	Media	/evidencias/10199_263.pdf	2025-09-22	2026-09-22
1772	10199	45	264	t	Alta	/evidencias/10199_264.pdf	2023-06-23	2025-06-22
1773	10200	51	295	t	Media	/evidencias/10200_295.pdf	2026-04-29	2028-04-28
1774	10200	51	295	t	Alta	/evidencias/10200_295.pdf	2025-03-05	2027-03-05
1775	10200	51	296	t	Baja	/evidencias/10200_296.pdf	2024-02-01	2025-01-31
1776	10200	51	296	t	Media	/evidencias/10200_296.pdf	2023-09-15	2025-09-14
1777	10200	51	297	f	Media	\N	2024-06-04	2025-06-04
1778	10200	51	297	t	Media	/evidencias/10200_297.pdf	2024-12-20	2026-12-20
1779	10200	51	298	t	Baja	/evidencias/10200_298.pdf	2024-02-27	2025-02-26
1780	10200	51	299	t	Media	/evidencias/10200_299.pdf	2026-03-01	2028-02-29
1781	10200	51	300	t	Baja	/evidencias/10200_300.pdf	2025-11-27	2026-11-27
1782	10200	51	301	t	Baja	/evidencias/10200_301.pdf	2023-11-25	2024-11-24
1783	10200	51	301	t	Alta	/evidencias/10200_301.pdf	2023-07-13	2024-07-12
1784	10200	51	302	t	Alta	/evidencias/10200_302.pdf	2025-11-29	2026-11-29
1785	10200	51	302	t	Baja	/evidencias/10200_302.pdf	2024-04-21	2025-04-21
1786	10201	95	564	f	Media	\N	2025-08-06	2027-08-06
1787	10201	95	564	f	Alta	\N	2025-06-26	2026-06-26
1788	10201	95	565	f	Baja	\N	2025-03-03	2026-03-03
1789	10201	95	565	f	Alta	\N	2023-12-02	2024-12-01
1790	10201	95	566	t	Media	/evidencias/10201_566.pdf	2025-12-25	2026-12-25
1791	10201	95	566	f	Alta	\N	2026-02-03	2027-02-03
1792	10201	95	567	t	Alta	/evidencias/10201_567.pdf	2025-08-15	2027-08-15
3390	10393	49	287	f	Media	\N	2023-08-17	2025-08-16
1793	10201	95	567	t	Baja	/evidencias/10201_567.pdf	2024-01-23	2026-01-22
1794	10201	95	568	t	Alta	/evidencias/10201_568.pdf	2023-09-24	2024-09-23
1795	10201	95	568	f	Alta	\N	2025-08-13	2026-08-13
1796	10202	126	753	t	Media	/evidencias/10202_753.pdf	2025-06-28	2026-06-28
1797	10202	126	753	t	Alta	/evidencias/10202_753.pdf	2023-07-02	2025-07-01
1798	10202	126	754	f	Alta	\N	2026-02-15	2027-02-15
1799	10202	126	754	t	Media	/evidencias/10202_754.pdf	2026-04-24	2027-04-24
1800	10202	126	755	t	Media	/evidencias/10202_755.pdf	2025-09-16	2026-09-16
1801	10202	126	756	t	Alta	/evidencias/10202_756.pdf	2024-10-13	2025-10-13
1802	10203	81	475	t	Media	/evidencias/10203_475.pdf	2025-02-02	2026-02-02
1803	10203	81	476	t	Baja	/evidencias/10203_476.pdf	2025-04-03	2027-04-03
1804	10203	81	476	t	Baja	/evidencias/10203_476.pdf	2025-02-16	2026-02-16
1805	10203	81	477	t	Media	/evidencias/10203_477.pdf	2024-04-06	2026-04-06
1806	10203	81	478	t	Media	/evidencias/10203_478.pdf	2024-09-18	2026-09-18
1807	10203	81	479	t	Alta	/evidencias/10203_479.pdf	2025-10-12	2027-10-12
1808	10203	81	479	f	Baja	\N	2024-09-01	2025-09-01
1809	10203	81	480	t	Baja	/evidencias/10203_480.pdf	2025-06-29	2026-06-29
1810	10203	81	481	t	Baja	/evidencias/10203_481.pdf	2024-07-08	2026-07-08
1811	10204	107	637	t	Media	/evidencias/10204_637.pdf	2026-01-03	2028-01-03
1812	10204	107	638	t	Media	/evidencias/10204_638.pdf	2025-05-16	2026-05-16
1813	10204	107	638	t	Alta	/evidencias/10204_638.pdf	2023-07-18	2024-07-17
1814	10204	107	639	t	Baja	/evidencias/10204_639.pdf	2025-11-06	2026-11-06
1815	10204	107	639	f	Media	\N	2025-11-02	2027-11-02
1816	10204	107	640	t	Media	/evidencias/10204_640.pdf	2026-03-23	2028-03-22
1817	10204	107	641	t	Media	/evidencias/10204_641.pdf	2024-06-30	2026-06-30
1818	10204	107	642	t	Alta	/evidencias/10204_642.pdf	2025-04-24	2026-04-24
1819	10204	107	642	f	Baja	\N	2024-05-07	2026-05-07
1820	10204	107	643	t	Baja	/evidencias/10204_643.pdf	2023-11-27	2025-11-26
1821	10205	24	135	t	Baja	/evidencias/10205_135.pdf	2026-03-15	2027-03-15
1822	10205	24	135	t	Alta	/evidencias/10205_135.pdf	2024-10-16	2025-10-16
1823	10205	24	136	f	Alta	\N	2026-02-15	2027-02-15
1824	10205	24	137	t	Media	/evidencias/10205_137.pdf	2025-01-28	2026-01-28
1825	10205	24	138	t	Media	/evidencias/10205_138.pdf	2024-07-07	2025-07-07
1826	10205	24	138	t	Baja	/evidencias/10205_138.pdf	2024-03-26	2026-03-26
1827	10205	24	139	f	Media	\N	2024-07-11	2025-07-11
1828	10205	24	139	t	Alta	/evidencias/10205_139.pdf	2023-09-25	2024-09-24
1829	10206	42	239	f	Baja	\N	2024-01-30	2025-01-29
1830	10206	42	240	t	Baja	/evidencias/10206_240.pdf	2024-11-27	2025-11-27
1831	10206	42	240	t	Baja	/evidencias/10206_240.pdf	2024-08-03	2026-08-03
1832	10206	42	241	t	Media	/evidencias/10206_241.pdf	2025-01-01	2027-01-01
1833	10206	42	242	t	Alta	/evidencias/10206_242.pdf	2025-06-04	2026-06-04
1834	10206	42	243	f	Alta	\N	2023-08-23	2025-08-22
1835	10206	42	244	f	Alta	\N	2025-06-28	2026-06-28
1836	10206	42	245	t	Baja	/evidencias/10206_245.pdf	2024-01-07	2025-01-06
1837	10206	42	245	t	Media	/evidencias/10206_245.pdf	2024-03-21	2026-03-21
1838	10206	42	246	t	Baja	/evidencias/10206_246.pdf	2023-09-30	2025-09-29
1839	10206	42	246	t	Baja	/evidencias/10206_246.pdf	2023-12-27	2025-12-26
1840	10208	35	201	f	Media	\N	2026-03-16	2028-03-15
1841	10208	35	202	t	Baja	/evidencias/10208_202.pdf	2023-09-21	2025-09-20
1842	10208	35	203	t	Media	/evidencias/10208_203.pdf	2025-12-06	2027-12-06
1843	10208	35	203	t	Alta	/evidencias/10208_203.pdf	2023-10-26	2025-10-25
1844	10208	35	204	f	Alta	\N	2023-08-08	2025-08-07
1845	10208	35	205	t	Alta	/evidencias/10208_205.pdf	2025-06-12	2027-06-12
1846	10209	104	619	t	Alta	/evidencias/10209_619.pdf	2025-10-17	2026-10-17
1847	10209	104	619	t	Baja	/evidencias/10209_619.pdf	2024-08-24	2025-08-24
1848	10209	104	620	t	Baja	/evidencias/10209_620.pdf	2024-09-20	2025-09-20
1849	10209	104	621	t	Alta	/evidencias/10209_621.pdf	2024-03-16	2025-03-16
1850	10209	104	622	t	Alta	/evidencias/10209_622.pdf	2023-06-19	2024-06-18
1851	10209	104	623	t	Alta	/evidencias/10209_623.pdf	2024-06-19	2025-06-19
1852	10209	104	624	t	Baja	/evidencias/10209_624.pdf	2023-06-02	2024-06-01
1853	10209	104	625	t	Alta	/evidencias/10209_625.pdf	2024-08-18	2025-08-18
1854	10209	104	625	t	Media	/evidencias/10209_625.pdf	2025-10-10	2026-10-10
1855	10210	94	557	f	Media	\N	2025-03-21	2026-03-21
1856	10210	94	558	t	Baja	/evidencias/10210_558.pdf	2023-10-23	2025-10-22
1857	10210	94	559	t	Media	/evidencias/10210_559.pdf	2023-12-21	2025-12-20
1858	10210	94	560	f	Alta	\N	2023-09-01	2025-08-31
1859	10210	94	561	t	Media	/evidencias/10210_561.pdf	2025-10-16	2027-10-16
1860	10210	94	562	t	Media	/evidencias/10210_562.pdf	2026-01-13	2028-01-13
1861	10210	94	563	t	Alta	/evidencias/10210_563.pdf	2026-05-16	2027-05-16
1862	10210	94	563	t	Media	/evidencias/10210_563.pdf	2025-09-27	2027-09-27
1863	10211	143	855	t	Media	/evidencias/10211_855.pdf	2024-03-28	2025-03-28
1864	10211	143	856	t	Alta	/evidencias/10211_856.pdf	2025-07-27	2026-07-27
1865	10211	143	857	t	Alta	/evidencias/10211_857.pdf	2024-02-20	2026-02-19
1866	10211	143	858	t	Baja	/evidencias/10211_858.pdf	2025-01-03	2027-01-03
1867	10211	143	858	f	Baja	\N	2024-09-25	2025-09-25
1868	10211	143	859	f	Alta	\N	2025-08-30	2027-08-30
1869	10212	14	81	t	Media	/evidencias/10212_81.pdf	2024-06-23	2025-06-23
1870	10212	14	81	f	Baja	\N	2023-08-20	2025-08-19
1871	10212	14	82	f	Baja	\N	2025-08-29	2027-08-29
1872	10212	14	82	f	Media	\N	2025-10-12	2027-10-12
1873	10212	14	83	t	Alta	/evidencias/10212_83.pdf	2025-11-10	2027-11-10
1874	10212	14	83	t	Media	/evidencias/10212_83.pdf	2024-01-23	2026-01-22
1875	10212	14	84	t	Media	/evidencias/10212_84.pdf	2024-09-04	2026-09-04
1876	10212	14	84	t	Media	/evidencias/10212_84.pdf	2023-11-29	2025-11-28
1877	10212	14	85	t	Media	/evidencias/10212_85.pdf	2023-11-02	2025-11-01
1878	10212	14	85	f	Media	\N	2023-11-30	2025-11-29
1879	10212	14	86	f	Media	\N	2025-10-25	2026-10-25
1880	10212	14	86	t	Media	/evidencias/10212_86.pdf	2024-11-23	2025-11-23
1881	10213	99	589	t	Media	/evidencias/10213_589.pdf	2023-06-22	2025-06-21
1882	10213	99	590	t	Baja	/evidencias/10213_590.pdf	2026-03-02	2027-03-02
1883	10213	99	590	t	Alta	/evidencias/10213_590.pdf	2025-01-27	2026-01-27
1884	10213	99	591	t	Media	/evidencias/10213_591.pdf	2025-06-01	2026-06-01
1885	10213	99	592	t	Media	/evidencias/10213_592.pdf	2024-08-09	2026-08-09
1886	10213	99	592	t	Media	/evidencias/10213_592.pdf	2025-10-23	2026-10-23
1887	10213	99	593	f	Alta	\N	2025-11-19	2026-11-19
1888	10213	99	594	t	Baja	/evidencias/10213_594.pdf	2026-03-23	2028-03-22
1889	10214	120	711	t	Baja	/evidencias/10214_711.pdf	2025-01-20	2026-01-20
1890	10214	120	711	t	Alta	/evidencias/10214_711.pdf	2025-01-22	2026-01-22
1891	10214	120	712	f	Baja	\N	2024-04-01	2025-04-01
1892	10214	120	713	t	Alta	/evidencias/10214_713.pdf	2024-09-17	2026-09-17
1893	10214	120	713	f	Baja	\N	2023-10-29	2025-10-28
1894	10214	120	714	t	Media	/evidencias/10214_714.pdf	2024-04-14	2025-04-14
1895	10214	120	714	t	Alta	/evidencias/10214_714.pdf	2023-06-05	2025-06-04
1896	10214	120	715	f	Alta	\N	2025-01-31	2027-01-31
1897	10214	120	716	t	Alta	/evidencias/10214_716.pdf	2023-11-25	2025-11-24
1898	10214	120	716	t	Media	/evidencias/10214_716.pdf	2024-08-13	2026-08-13
1899	10215	104	619	t	Alta	/evidencias/10215_619.pdf	2026-04-29	2027-04-29
1900	10215	104	620	f	Media	\N	2025-03-02	2026-03-02
1901	10215	104	620	t	Media	/evidencias/10215_620.pdf	2023-12-01	2024-11-30
1902	10215	104	621	f	Alta	\N	2023-11-21	2024-11-20
1903	10215	104	621	t	Media	/evidencias/10215_621.pdf	2024-06-13	2026-06-13
1904	10215	104	622	t	Media	/evidencias/10215_622.pdf	2025-04-25	2026-04-25
1905	10215	104	623	t	Alta	/evidencias/10215_623.pdf	2023-08-16	2024-08-15
1906	10215	104	623	t	Baja	/evidencias/10215_623.pdf	2023-08-12	2024-08-11
1907	10215	104	624	f	Media	\N	2024-08-22	2025-08-22
1908	10215	104	624	t	Alta	/evidencias/10215_624.pdf	2024-07-08	2026-07-08
1909	10215	104	625	t	Baja	/evidencias/10215_625.pdf	2025-10-25	2026-10-25
1910	10215	104	625	f	Alta	\N	2025-07-09	2026-07-09
1911	10216	103	615	t	Baja	/evidencias/10216_615.pdf	2023-10-16	2024-10-15
1912	10216	103	616	t	Media	/evidencias/10216_616.pdf	2023-12-13	2025-12-12
1913	10216	103	617	f	Media	\N	2024-06-19	2025-06-19
1914	10216	103	618	t	Media	/evidencias/10216_618.pdf	2025-06-28	2026-06-28
1915	10217	104	619	f	Alta	\N	2023-09-13	2025-09-12
1916	10217	104	619	t	Alta	/evidencias/10217_619.pdf	2025-06-20	2026-06-20
1917	10217	104	620	f	Baja	\N	2023-10-11	2025-10-10
1918	10217	104	621	t	Media	/evidencias/10217_621.pdf	2025-07-06	2026-07-06
1919	10217	104	621	f	Media	\N	2024-07-22	2025-07-22
1920	10217	104	622	t	Alta	/evidencias/10217_622.pdf	2025-01-23	2026-01-23
1921	10217	104	622	t	Media	/evidencias/10217_622.pdf	2023-07-01	2024-06-30
1922	10217	104	623	t	Alta	/evidencias/10217_623.pdf	2023-10-28	2025-10-27
1923	10217	104	624	f	Alta	\N	2023-06-22	2024-06-21
1924	10217	104	624	t	Media	/evidencias/10217_624.pdf	2023-11-09	2025-11-08
1925	10217	104	625	t	Alta	/evidencias/10217_625.pdf	2023-09-18	2025-09-17
1926	10219	93	550	f	Alta	\N	2026-04-18	2027-04-18
1927	10219	93	550	t	Alta	/evidencias/10219_550.pdf	2024-01-04	2026-01-03
1928	10219	93	551	f	Alta	\N	2024-08-19	2026-08-19
1929	10219	93	552	t	Alta	/evidencias/10219_552.pdf	2023-12-26	2024-12-25
1930	10219	93	552	f	Alta	\N	2024-04-27	2025-04-27
1931	10219	93	553	t	Alta	/evidencias/10219_553.pdf	2026-01-17	2027-01-17
1932	10219	93	553	t	Alta	/evidencias/10219_553.pdf	2023-12-11	2024-12-10
1933	10219	93	554	t	Media	/evidencias/10219_554.pdf	2024-04-10	2025-04-10
1934	10219	93	555	t	Media	/evidencias/10219_555.pdf	2023-08-25	2024-08-24
1935	10219	93	556	t	Alta	/evidencias/10219_556.pdf	2023-08-05	2025-08-04
1936	10220	125	746	f	Baja	\N	2024-01-30	2025-01-29
1937	10220	125	746	t	Alta	/evidencias/10220_746.pdf	2023-08-29	2025-08-28
1938	10220	125	747	t	Alta	/evidencias/10220_747.pdf	2026-04-23	2027-04-23
1939	10220	125	747	t	Alta	/evidencias/10220_747.pdf	2025-04-19	2026-04-19
1940	10220	125	748	t	Baja	/evidencias/10220_748.pdf	2023-07-07	2024-07-06
1941	10220	125	748	t	Alta	/evidencias/10220_748.pdf	2024-08-31	2026-08-31
1942	10220	125	749	t	Baja	/evidencias/10220_749.pdf	2025-10-02	2026-10-02
1943	10220	125	749	t	Media	/evidencias/10220_749.pdf	2023-11-12	2025-11-11
1944	10220	125	750	f	Media	\N	2025-02-03	2026-02-03
1945	10220	125	750	t	Media	/evidencias/10220_750.pdf	2025-08-04	2026-08-04
1946	10220	125	751	t	Alta	/evidencias/10220_751.pdf	2026-05-08	2028-05-07
1947	10220	125	751	f	Alta	\N	2026-05-02	2027-05-02
1948	10220	125	752	f	Alta	\N	2025-01-30	2027-01-30
1949	10220	125	752	f	Alta	\N	2024-03-02	2026-03-02
1950	10221	58	334	t	Baja	/evidencias/10221_334.pdf	2023-11-19	2024-11-18
1951	10221	58	335	t	Media	/evidencias/10221_335.pdf	2024-11-19	2025-11-19
1952	10221	58	335	t	Baja	/evidencias/10221_335.pdf	2023-06-18	2024-06-17
1953	10221	58	336	t	Alta	/evidencias/10221_336.pdf	2024-11-07	2026-11-07
1954	10221	58	337	t	Media	/evidencias/10221_337.pdf	2024-01-19	2025-01-18
1955	10221	58	337	t	Media	/evidencias/10221_337.pdf	2025-01-15	2027-01-15
1956	10224	7	40	t	Alta	/evidencias/10224_40.pdf	2023-07-13	2024-07-12
1957	10224	7	41	t	Alta	/evidencias/10224_41.pdf	2024-04-24	2025-04-24
1958	10224	7	42	t	Baja	/evidencias/10224_42.pdf	2025-05-04	2027-05-04
1959	10224	7	42	t	Alta	/evidencias/10224_42.pdf	2025-09-20	2026-09-20
1960	10224	7	43	t	Baja	/evidencias/10224_43.pdf	2024-06-08	2025-06-08
1961	10224	7	44	f	Alta	\N	2025-01-09	2026-01-09
1962	10224	7	44	f	Alta	\N	2025-11-23	2026-11-23
1963	10224	7	45	t	Media	/evidencias/10224_45.pdf	2025-10-14	2027-10-14
1964	10225	1	1	t	Media	/evidencias/10225_1.pdf	2024-10-13	2026-10-13
1965	10225	1	1	t	Baja	/evidencias/10225_1.pdf	2025-08-24	2027-08-24
1966	10225	1	2	f	Alta	\N	2024-01-27	2025-01-26
1967	10225	1	3	t	Alta	/evidencias/10225_3.pdf	2026-02-20	2028-02-20
1968	10225	1	3	t	Baja	/evidencias/10225_3.pdf	2024-08-17	2025-08-17
1969	10225	1	4	f	Alta	\N	2025-03-09	2026-03-09
1970	10225	1	4	t	Baja	/evidencias/10225_4.pdf	2023-12-30	2025-12-29
1971	10225	1	5	t	Media	/evidencias/10225_5.pdf	2024-12-15	2026-12-15
1972	10225	1	5	f	Baja	\N	2025-07-09	2026-07-09
1973	10225	1	6	f	Alta	\N	2026-04-07	2027-04-07
1974	10225	1	7	t	Baja	/evidencias/10225_7.pdf	2025-11-01	2027-11-01
1975	10226	65	374	t	Alta	/evidencias/10226_374.pdf	2024-02-16	2025-02-15
1976	10226	65	374	f	Alta	\N	2024-10-21	2025-10-21
1977	10226	65	375	t	Media	/evidencias/10226_375.pdf	2024-01-04	2025-01-03
1978	10226	65	376	f	Baja	\N	2025-10-05	2026-10-05
1979	10226	65	376	t	Alta	/evidencias/10226_376.pdf	2025-11-19	2027-11-19
1980	10226	65	377	f	Media	\N	2023-09-12	2025-09-11
1981	10226	65	377	f	Media	\N	2025-11-05	2026-11-05
1982	10226	65	378	t	Media	/evidencias/10226_378.pdf	2024-02-12	2026-02-11
1983	10226	65	379	t	Alta	/evidencias/10226_379.pdf	2024-07-24	2025-07-24
1984	10226	65	380	t	Baja	/evidencias/10226_380.pdf	2024-10-09	2025-10-09
1985	10226	65	380	t	Alta	/evidencias/10226_380.pdf	2025-03-03	2026-03-03
1986	10226	65	381	t	Media	/evidencias/10226_381.pdf	2025-10-05	2026-10-05
1987	10226	65	381	t	Media	/evidencias/10226_381.pdf	2024-03-17	2026-03-17
1988	10227	35	201	f	Baja	\N	2024-01-06	2025-01-05
1989	10227	35	201	f	Baja	\N	2023-12-05	2024-12-04
1990	10227	35	202	t	Baja	/evidencias/10227_202.pdf	2026-05-13	2027-05-13
1991	10227	35	203	t	Media	/evidencias/10227_203.pdf	2024-05-20	2025-05-20
1992	10227	35	204	t	Alta	/evidencias/10227_204.pdf	2025-09-18	2026-09-18
1993	10227	35	204	t	Baja	/evidencias/10227_204.pdf	2025-10-10	2026-10-10
1994	10227	35	205	t	Baja	/evidencias/10227_205.pdf	2025-08-11	2027-08-11
1995	10228	34	193	t	Media	/evidencias/10228_193.pdf	2024-09-13	2025-09-13
1996	10228	34	193	f	Media	\N	2025-01-04	2027-01-04
1997	10228	34	194	t	Alta	/evidencias/10228_194.pdf	2023-10-30	2024-10-29
1998	10228	34	194	f	Media	\N	2025-03-07	2026-03-07
1999	10228	34	195	t	Media	/evidencias/10228_195.pdf	2023-06-27	2025-06-26
2000	10228	34	195	f	Media	\N	2023-11-03	2025-11-02
2001	10228	34	196	t	Media	/evidencias/10228_196.pdf	2025-02-18	2026-02-18
2002	10228	34	196	t	Alta	/evidencias/10228_196.pdf	2025-03-31	2026-03-31
2003	10228	34	197	t	Alta	/evidencias/10228_197.pdf	2024-01-30	2026-01-29
2004	10228	34	197	f	Media	\N	2024-11-04	2026-11-04
2005	10228	34	198	t	Baja	/evidencias/10228_198.pdf	2025-04-27	2026-04-27
2006	10228	34	199	t	Baja	/evidencias/10228_199.pdf	2025-03-06	2026-03-06
2007	10228	34	199	t	Media	/evidencias/10228_199.pdf	2023-08-04	2024-08-03
2008	10228	34	200	f	Baja	\N	2024-12-22	2025-12-22
2009	10229	134	802	f	Alta	\N	2025-06-29	2027-06-29
2010	10229	134	802	t	Alta	/evidencias/10229_802.pdf	2023-06-10	2025-06-09
2011	10229	134	803	f	Baja	\N	2024-05-02	2026-05-02
2012	10229	134	804	f	Alta	\N	2025-03-11	2027-03-11
2013	10229	134	805	t	Alta	/evidencias/10229_805.pdf	2026-02-15	2028-02-15
2014	10229	134	806	t	Alta	/evidencias/10229_806.pdf	2024-06-24	2025-06-24
2015	10229	134	807	t	Media	/evidencias/10229_807.pdf	2024-04-14	2026-04-14
2016	10229	134	808	t	Alta	/evidencias/10229_808.pdf	2025-03-30	2027-03-30
2017	10229	134	808	f	Alta	\N	2025-07-23	2027-07-23
2018	10230	119	706	f	Media	\N	2025-09-04	2026-09-04
2019	10230	119	707	f	Baja	\N	2025-01-20	2027-01-20
2020	10230	119	708	t	Alta	/evidencias/10230_708.pdf	2025-04-13	2027-04-13
2021	10230	119	709	f	Alta	\N	2025-05-02	2027-05-02
2022	10230	119	709	t	Media	/evidencias/10230_709.pdf	2025-11-10	2027-11-10
2023	10230	119	710	f	Media	\N	2025-12-25	2027-12-25
2024	10230	119	710	t	Alta	/evidencias/10230_710.pdf	2023-11-07	2024-11-06
2025	10231	74	437	t	Baja	/evidencias/10231_437.pdf	2024-01-11	2025-01-10
2026	10231	74	438	t	Media	/evidencias/10231_438.pdf	2024-10-04	2025-10-04
2027	10231	74	439	t	Baja	/evidencias/10231_439.pdf	2024-09-07	2025-09-07
2028	10231	74	439	t	Alta	/evidencias/10231_439.pdf	2024-01-28	2026-01-27
2029	10231	74	440	t	Alta	/evidencias/10231_440.pdf	2024-04-12	2026-04-12
2030	10232	115	685	t	Media	/evidencias/10232_685.pdf	2024-09-04	2026-09-04
2031	10232	115	686	t	Media	/evidencias/10232_686.pdf	2025-07-27	2027-07-27
2032	10232	115	687	t	Alta	/evidencias/10232_687.pdf	2026-01-15	2027-01-15
2033	10232	115	688	t	Alta	/evidencias/10232_688.pdf	2024-12-07	2025-12-07
2034	10232	115	689	f	Media	\N	2024-01-04	2025-01-03
2035	10233	126	753	t	Alta	/evidencias/10233_753.pdf	2024-04-11	2026-04-11
2036	10233	126	753	t	Baja	/evidencias/10233_753.pdf	2023-08-18	2025-08-17
2037	10233	126	754	t	Baja	/evidencias/10233_754.pdf	2024-01-24	2026-01-23
2038	10233	126	754	f	Media	\N	2026-01-22	2028-01-22
2039	10233	126	755	f	Media	\N	2024-06-27	2026-06-27
2040	10233	126	755	t	Media	/evidencias/10233_755.pdf	2024-07-18	2026-07-18
2041	10233	126	756	t	Media	/evidencias/10233_756.pdf	2024-03-24	2025-03-24
2042	10234	120	711	t	Alta	/evidencias/10234_711.pdf	2025-11-01	2026-11-01
2043	10234	120	712	t	Media	/evidencias/10234_712.pdf	2023-08-31	2025-08-30
2044	10234	120	712	f	Media	\N	2025-05-20	2027-05-20
2045	10234	120	713	f	Media	\N	2025-07-08	2026-07-08
2046	10234	120	713	t	Media	/evidencias/10234_713.pdf	2026-04-15	2027-04-15
2047	10234	120	714	f	Media	\N	2023-10-02	2025-10-01
2048	10234	120	715	f	Media	\N	2025-06-26	2027-06-26
2049	10234	120	716	f	Media	\N	2024-05-11	2025-05-11
2050	10235	93	550	t	Media	/evidencias/10235_550.pdf	2024-11-10	2025-11-10
2051	10235	93	550	f	Alta	\N	2026-04-14	2028-04-13
2052	10235	93	551	f	Media	\N	2025-07-08	2026-07-08
2053	10235	93	552	t	Baja	/evidencias/10235_552.pdf	2026-02-20	2028-02-20
2054	10235	93	552	f	Alta	\N	2024-02-10	2026-02-09
2055	10235	93	553	t	Alta	/evidencias/10235_553.pdf	2024-07-19	2026-07-19
2056	10235	93	553	t	Media	/evidencias/10235_553.pdf	2023-11-16	2024-11-15
2057	10235	93	554	t	Baja	/evidencias/10235_554.pdf	2023-08-30	2024-08-29
2058	10235	93	555	t	Baja	/evidencias/10235_555.pdf	2024-06-22	2026-06-22
2059	10235	93	556	t	Alta	/evidencias/10235_556.pdf	2025-10-25	2026-10-25
2060	10235	93	556	f	Alta	\N	2026-02-26	2027-02-26
2061	10236	3	14	f	Alta	\N	2023-08-02	2024-08-01
2062	10236	3	14	f	Media	\N	2025-04-25	2026-04-25
2063	10236	3	15	t	Media	/evidencias/10236_15.pdf	2024-02-07	2025-02-06
2064	10236	3	15	t	Media	/evidencias/10236_15.pdf	2024-02-01	2025-01-31
2065	10236	3	16	t	Media	/evidencias/10236_16.pdf	2025-05-08	2026-05-08
2066	10236	3	16	t	Baja	/evidencias/10236_16.pdf	2023-08-30	2024-08-29
2067	10236	3	17	f	Media	\N	2024-04-15	2026-04-15
2068	10236	3	17	t	Baja	/evidencias/10236_17.pdf	2024-10-12	2025-10-12
2069	10236	3	18	f	Alta	\N	2026-05-29	2027-05-29
2070	10236	3	19	t	Media	/evidencias/10236_19.pdf	2026-04-06	2027-04-06
2071	10236	3	19	t	Media	/evidencias/10236_19.pdf	2025-01-13	2026-01-13
2072	10236	3	20	t	Baja	/evidencias/10236_20.pdf	2024-06-21	2026-06-21
2073	10236	3	20	t	Media	/evidencias/10236_20.pdf	2024-03-09	2025-03-09
2074	10236	3	21	f	Alta	\N	2023-06-08	2024-06-07
2075	10236	3	21	f	Media	\N	2025-02-28	2026-02-28
2076	10237	53	311	t	Baja	/evidencias/10237_311.pdf	2023-11-28	2024-11-27
2077	10237	53	312	t	Alta	/evidencias/10237_312.pdf	2024-02-08	2026-02-07
2078	10237	53	312	f	Media	\N	2024-04-30	2025-04-30
2079	10237	53	313	t	Media	/evidencias/10237_313.pdf	2024-06-24	2025-06-24
2080	10237	53	313	f	Media	\N	2025-06-04	2027-06-04
2081	10237	53	314	f	Alta	\N	2024-04-23	2026-04-23
2082	10237	53	315	t	Alta	/evidencias/10237_315.pdf	2025-05-23	2026-05-23
2083	10237	53	315	t	Media	/evidencias/10237_315.pdf	2025-01-19	2026-01-19
2084	10238	119	706	t	Media	/evidencias/10238_706.pdf	2024-06-23	2025-06-23
2085	10238	119	707	t	Alta	/evidencias/10238_707.pdf	2024-06-06	2025-06-06
2086	10238	119	708	t	Baja	/evidencias/10238_708.pdf	2025-02-01	2027-02-01
2087	10238	119	709	t	Media	/evidencias/10238_709.pdf	2024-06-02	2025-06-02
2088	10238	119	709	t	Baja	/evidencias/10238_709.pdf	2023-09-26	2024-09-25
2089	10238	119	710	f	Media	\N	2025-11-02	2027-11-02
2090	10238	119	710	f	Alta	\N	2023-10-27	2024-10-26
2091	10239	103	615	t	Alta	/evidencias/10239_615.pdf	2025-07-03	2026-07-03
2092	10239	103	615	t	Media	/evidencias/10239_615.pdf	2023-12-23	2024-12-22
2093	10239	103	616	t	Baja	/evidencias/10239_616.pdf	2024-01-17	2026-01-16
2094	10239	103	616	t	Alta	/evidencias/10239_616.pdf	2025-04-21	2026-04-21
2095	10239	103	617	t	Alta	/evidencias/10239_617.pdf	2023-06-29	2025-06-28
2096	10239	103	617	t	Alta	/evidencias/10239_617.pdf	2025-11-17	2026-11-17
2097	10239	103	618	f	Baja	\N	2024-01-02	2026-01-01
2098	10240	107	637	t	Alta	/evidencias/10240_637.pdf	2023-10-13	2025-10-12
2099	10240	107	638	f	Media	\N	2024-05-06	2025-05-06
2100	10240	107	639	t	Media	/evidencias/10240_639.pdf	2024-09-04	2026-09-04
2101	10240	107	640	f	Media	\N	2025-02-17	2027-02-17
2102	10240	107	641	f	Media	\N	2024-03-10	2025-03-10
2103	10240	107	641	t	Alta	/evidencias/10240_641.pdf	2024-04-28	2025-04-28
2104	10240	107	642	t	Alta	/evidencias/10240_642.pdf	2026-05-04	2027-05-04
2105	10240	107	642	t	Baja	/evidencias/10240_642.pdf	2024-01-11	2025-01-10
2106	10240	107	643	t	Media	/evidencias/10240_643.pdf	2025-10-01	2026-10-01
2107	10241	87	513	f	Alta	\N	2026-05-27	2027-05-27
2108	10241	87	513	t	Baja	/evidencias/10241_513.pdf	2024-04-23	2026-04-23
2109	10241	87	514	f	Media	\N	2024-06-07	2026-06-07
2110	10241	87	514	t	Alta	/evidencias/10241_514.pdf	2024-12-23	2026-12-23
2111	10241	87	515	f	Alta	\N	2023-06-06	2025-06-05
2112	10241	87	515	t	Media	/evidencias/10241_515.pdf	2023-12-04	2024-12-03
2113	10241	87	516	f	Media	\N	2024-04-17	2025-04-17
2114	10241	87	516	t	Media	/evidencias/10241_516.pdf	2024-01-28	2026-01-27
2115	10242	78	459	f	Baja	\N	2026-05-18	2028-05-17
2116	10242	78	460	t	Baja	/evidencias/10242_460.pdf	2024-04-04	2025-04-04
2117	10242	78	461	t	Alta	/evidencias/10242_461.pdf	2024-07-19	2026-07-19
2118	10242	78	462	f	Alta	\N	2025-07-03	2027-07-03
2119	10242	78	462	f	Alta	\N	2024-04-18	2025-04-18
2120	10243	64	367	f	Media	\N	2026-01-28	2028-01-28
2121	10243	64	368	t	Media	/evidencias/10243_368.pdf	2023-12-19	2025-12-18
2122	10243	64	369	f	Alta	\N	2026-02-17	2027-02-17
2123	10243	64	369	t	Media	/evidencias/10243_369.pdf	2024-08-21	2026-08-21
2124	10243	64	370	t	Media	/evidencias/10243_370.pdf	2026-02-25	2028-02-25
2125	10243	64	370	f	Media	\N	2026-03-11	2028-03-10
2126	10243	64	371	f	Media	\N	2023-10-08	2025-10-07
2127	10243	64	372	t	Baja	/evidencias/10243_372.pdf	2026-04-15	2027-04-15
2128	10243	64	373	t	Baja	/evidencias/10243_373.pdf	2025-08-24	2026-08-24
2129	10244	114	678	f	Media	\N	2025-03-23	2026-03-23
2130	10244	114	678	t	Media	/evidencias/10244_678.pdf	2026-04-29	2027-04-29
2131	10244	114	679	f	Baja	\N	2025-02-10	2026-02-10
2132	10244	114	680	t	Media	/evidencias/10244_680.pdf	2024-02-09	2025-02-08
2133	10244	114	680	f	Alta	\N	2025-12-16	2027-12-16
2134	10244	114	681	f	Alta	\N	2024-05-05	2026-05-05
2135	10244	114	681	t	Baja	/evidencias/10244_681.pdf	2023-08-12	2025-08-11
2136	10244	114	682	t	Alta	/evidencias/10244_682.pdf	2025-11-28	2026-11-28
2137	10244	114	683	t	Media	/evidencias/10244_683.pdf	2024-10-02	2026-10-02
2138	10244	114	683	t	Alta	/evidencias/10244_683.pdf	2024-08-24	2026-08-24
2139	10244	114	684	t	Media	/evidencias/10244_684.pdf	2024-11-20	2025-11-20
2140	10245	2	8	f	Baja	\N	2024-03-03	2025-03-03
2141	10245	2	8	t	Media	/evidencias/10245_8.pdf	2026-02-25	2027-02-25
2142	10245	2	9	t	Alta	/evidencias/10245_9.pdf	2024-07-11	2026-07-11
2143	10245	2	9	t	Alta	/evidencias/10245_9.pdf	2026-04-13	2027-04-13
2144	10245	2	10	f	Media	\N	2024-02-13	2025-02-12
2145	10245	2	10	f	Alta	\N	2023-07-03	2024-07-02
2146	10245	2	11	t	Alta	/evidencias/10245_11.pdf	2023-06-30	2024-06-29
2147	10245	2	12	f	Media	\N	2025-04-11	2026-04-11
2148	10245	2	12	f	Baja	\N	2023-07-01	2024-06-30
2149	10245	2	13	t	Alta	/evidencias/10245_13.pdf	2025-05-05	2026-05-05
2150	10245	2	13	t	Media	/evidencias/10245_13.pdf	2024-03-14	2025-03-14
2151	10246	8	46	t	Media	/evidencias/10246_46.pdf	2024-03-30	2026-03-30
2152	10246	8	47	f	Baja	\N	2023-06-14	2025-06-13
2153	10246	8	47	t	Media	/evidencias/10246_47.pdf	2023-12-26	2025-12-25
2154	10246	8	48	t	Media	/evidencias/10246_48.pdf	2023-12-02	2025-12-01
2155	10246	8	48	t	Alta	/evidencias/10246_48.pdf	2024-04-20	2026-04-20
2156	10246	8	49	t	Media	/evidencias/10246_49.pdf	2024-06-08	2026-06-08
2157	10246	8	50	t	Alta	/evidencias/10246_50.pdf	2023-09-14	2025-09-13
2158	10246	8	50	t	Alta	/evidencias/10246_50.pdf	2026-04-26	2027-04-26
2159	10246	8	51	t	Baja	/evidencias/10246_51.pdf	2024-11-07	2026-11-07
2160	10246	8	51	t	Baja	/evidencias/10246_51.pdf	2026-03-19	2027-03-19
2161	10247	23	130	t	Baja	/evidencias/10247_130.pdf	2025-05-17	2027-05-17
2162	10247	23	130	f	Media	\N	2025-07-19	2026-07-19
2163	10247	23	131	t	Media	/evidencias/10247_131.pdf	2026-04-11	2028-04-10
2164	10247	23	132	f	Media	\N	2024-01-07	2026-01-06
2165	10247	23	132	t	Baja	/evidencias/10247_132.pdf	2023-12-28	2024-12-27
2166	10247	23	133	f	Media	\N	2025-09-29	2027-09-29
2167	10247	23	134	t	Alta	/evidencias/10247_134.pdf	2023-12-18	2025-12-17
2168	10248	128	763	t	Media	/evidencias/10248_763.pdf	2024-02-19	2026-02-18
2169	10248	128	763	t	Alta	/evidencias/10248_763.pdf	2026-02-11	2027-02-11
2170	10248	128	764	t	Baja	/evidencias/10248_764.pdf	2025-08-18	2026-08-18
2171	10248	128	764	f	Media	\N	2026-05-13	2028-05-12
2172	10248	128	765	t	Alta	/evidencias/10248_765.pdf	2025-07-26	2027-07-26
2173	10248	128	765	t	Alta	/evidencias/10248_765.pdf	2023-09-29	2024-09-28
2174	10248	128	766	t	Alta	/evidencias/10248_766.pdf	2025-08-19	2027-08-19
2175	10248	128	767	t	Media	/evidencias/10248_767.pdf	2024-12-16	2025-12-16
2176	10248	128	767	t	Baja	/evidencias/10248_767.pdf	2025-12-21	2026-12-21
2177	10248	128	768	t	Media	/evidencias/10248_768.pdf	2023-11-26	2024-11-25
2178	10248	128	768	f	Alta	\N	2026-04-01	2027-04-01
2179	10249	17	97	f	Baja	\N	2023-11-19	2025-11-18
2180	10249	17	98	t	Media	/evidencias/10249_98.pdf	2026-03-13	2027-03-13
2181	10249	17	99	f	Alta	\N	2024-09-06	2025-09-06
2182	10249	17	99	t	Media	/evidencias/10249_99.pdf	2023-08-04	2025-08-03
2183	10249	17	100	t	Media	/evidencias/10249_100.pdf	2024-07-11	2025-07-11
2184	10249	17	100	t	Media	/evidencias/10249_100.pdf	2024-08-13	2026-08-13
2185	10249	17	101	f	Baja	\N	2025-01-02	2027-01-02
2186	10249	17	102	f	Alta	\N	2025-05-04	2026-05-04
2187	10249	17	102	f	Media	\N	2023-10-25	2025-10-24
2188	10249	17	103	f	Baja	\N	2026-03-09	2027-03-09
2189	10249	17	103	t	Alta	/evidencias/10249_103.pdf	2025-10-25	2026-10-25
2190	10250	54	316	t	Baja	/evidencias/10250_316.pdf	2025-04-20	2026-04-20
2191	10250	54	317	t	Alta	/evidencias/10250_317.pdf	2023-11-11	2024-11-10
2192	10250	54	317	t	Media	/evidencias/10250_317.pdf	2025-05-08	2027-05-08
2193	10250	54	318	t	Alta	/evidencias/10250_318.pdf	2026-02-28	2028-02-28
2194	10250	54	318	t	Baja	/evidencias/10250_318.pdf	2023-07-14	2025-07-13
2195	10250	54	319	t	Media	/evidencias/10250_319.pdf	2026-03-06	2027-03-06
2196	10250	54	319	f	Alta	\N	2023-09-21	2025-09-20
2197	10250	54	320	t	Baja	/evidencias/10250_320.pdf	2026-03-06	2028-03-05
2198	10250	54	320	t	Media	/evidencias/10250_320.pdf	2024-04-30	2026-04-30
2199	10251	74	437	t	Baja	/evidencias/10251_437.pdf	2023-06-21	2025-06-20
2200	10251	74	438	t	Media	/evidencias/10251_438.pdf	2024-06-21	2025-06-21
2201	10251	74	438	t	Alta	/evidencias/10251_438.pdf	2024-08-01	2025-08-01
2202	10251	74	439	f	Media	\N	2025-09-10	2027-09-10
2203	10251	74	440	t	Media	/evidencias/10251_440.pdf	2023-06-16	2024-06-15
2204	10251	74	440	t	Alta	/evidencias/10251_440.pdf	2023-08-14	2025-08-13
2205	10252	101	603	t	Media	/evidencias/10252_603.pdf	2025-09-28	2027-09-28
2206	10252	101	603	t	Media	/evidencias/10252_603.pdf	2023-08-15	2024-08-14
2207	10252	101	604	t	Media	/evidencias/10252_604.pdf	2025-11-09	2026-11-09
2208	10252	101	605	t	Alta	/evidencias/10252_605.pdf	2025-10-28	2026-10-28
2209	10252	101	605	t	Baja	/evidencias/10252_605.pdf	2025-12-17	2026-12-17
2210	10252	101	606	t	Alta	/evidencias/10252_606.pdf	2025-02-10	2026-02-10
2211	10252	101	607	t	Media	/evidencias/10252_607.pdf	2023-08-22	2024-08-21
2212	10252	101	607	t	Media	/evidencias/10252_607.pdf	2025-03-19	2027-03-19
2213	10252	101	608	f	Baja	\N	2024-03-24	2025-03-24
2214	10252	101	608	t	Alta	/evidencias/10252_608.pdf	2024-07-11	2025-07-11
2215	10253	148	882	t	Baja	/evidencias/10253_882.pdf	2025-04-08	2027-04-08
2216	10253	148	882	f	Alta	\N	2024-08-20	2025-08-20
2217	10253	148	883	f	Media	\N	2024-11-15	2026-11-15
2218	10253	148	884	t	Alta	/evidencias/10253_884.pdf	2023-06-07	2024-06-06
2219	10253	148	885	f	Media	\N	2024-12-05	2026-12-05
2220	10253	148	885	f	Media	\N	2025-06-06	2027-06-06
2221	10253	148	886	f	Alta	\N	2024-04-07	2026-04-07
2222	10253	148	887	t	Alta	/evidencias/10253_887.pdf	2026-01-26	2028-01-26
2223	10253	148	887	f	Alta	\N	2025-05-05	2026-05-05
2224	10253	148	888	f	Alta	\N	2023-06-19	2025-06-18
2225	10254	102	609	f	Media	\N	2023-12-05	2024-12-04
2226	10254	102	609	f	Baja	\N	2024-11-25	2025-11-25
2227	10254	102	610	f	Media	\N	2026-01-18	2027-01-18
2228	10254	102	611	t	Media	/evidencias/10254_611.pdf	2024-02-11	2026-02-10
2229	10254	102	612	t	Alta	/evidencias/10254_612.pdf	2025-02-28	2026-02-28
2230	10254	102	612	t	Alta	/evidencias/10254_612.pdf	2023-06-17	2025-06-16
2231	10254	102	613	t	Media	/evidencias/10254_613.pdf	2024-02-12	2026-02-11
2232	10254	102	614	f	Media	\N	2024-02-07	2025-02-06
2233	10255	57	329	f	Alta	\N	2024-08-06	2026-08-06
2234	10255	57	330	t	Baja	/evidencias/10255_330.pdf	2024-04-21	2026-04-21
2235	10255	57	330	f	Media	\N	2023-09-10	2024-09-09
2236	10255	57	331	t	Baja	/evidencias/10255_331.pdf	2024-05-08	2025-05-08
2237	10255	57	331	t	Baja	/evidencias/10255_331.pdf	2024-04-14	2026-04-14
2238	10255	57	332	t	Media	/evidencias/10255_332.pdf	2025-04-29	2027-04-29
2239	10255	57	332	f	Alta	\N	2025-10-12	2026-10-12
2240	10255	57	333	f	Alta	\N	2025-10-09	2026-10-09
2241	10256	24	135	t	Alta	/evidencias/10256_135.pdf	2024-09-22	2025-09-22
2242	10256	24	135	f	Media	\N	2026-04-05	2027-04-05
2243	10256	24	136	t	Baja	/evidencias/10256_136.pdf	2025-12-29	2026-12-29
2244	10256	24	137	t	Media	/evidencias/10256_137.pdf	2025-01-10	2027-01-10
2245	10256	24	137	t	Media	/evidencias/10256_137.pdf	2024-10-28	2025-10-28
2246	10256	24	138	f	Media	\N	2026-02-03	2028-02-03
2247	10256	24	139	f	Alta	\N	2023-12-16	2024-12-15
2248	10256	24	139	t	Alta	/evidencias/10256_139.pdf	2023-09-21	2024-09-20
2249	10257	96	569	f	Media	\N	2026-01-27	2027-01-27
2250	10257	96	570	t	Media	/evidencias/10257_570.pdf	2023-10-02	2025-10-01
2251	10257	96	571	t	Baja	/evidencias/10257_571.pdf	2023-11-25	2025-11-24
2252	10257	96	571	t	Baja	/evidencias/10257_571.pdf	2024-12-24	2026-12-24
2253	10257	96	572	t	Baja	/evidencias/10257_572.pdf	2026-04-03	2028-04-02
2254	10257	96	572	t	Media	/evidencias/10257_572.pdf	2026-01-22	2028-01-22
2255	10257	96	573	t	Media	/evidencias/10257_573.pdf	2025-11-18	2027-11-18
2256	10257	96	574	f	Alta	\N	2026-04-18	2028-04-17
2257	10257	96	574	t	Alta	/evidencias/10257_574.pdf	2025-07-01	2027-07-01
2258	10257	96	575	t	Alta	/evidencias/10257_575.pdf	2025-03-10	2026-03-10
2259	10257	96	575	t	Baja	/evidencias/10257_575.pdf	2026-02-02	2027-02-02
2260	10257	96	576	t	Baja	/evidencias/10257_576.pdf	2026-04-03	2027-04-03
2261	10257	96	576	t	Media	/evidencias/10257_576.pdf	2025-12-17	2026-12-17
2262	10258	99	589	f	Media	\N	2024-07-28	2025-07-28
2263	10258	99	589	t	Baja	/evidencias/10258_589.pdf	2023-10-09	2025-10-08
2264	10258	99	590	f	Alta	\N	2023-12-14	2024-12-13
2265	10258	99	591	t	Baja	/evidencias/10258_591.pdf	2023-11-16	2024-11-15
2266	10258	99	592	t	Alta	/evidencias/10258_592.pdf	2025-08-16	2027-08-16
2267	10258	99	593	t	Media	/evidencias/10258_593.pdf	2026-05-25	2027-05-25
2268	10258	99	593	t	Alta	/evidencias/10258_593.pdf	2024-12-24	2026-12-24
2269	10258	99	594	t	Baja	/evidencias/10258_594.pdf	2026-02-03	2028-02-03
2270	10259	104	619	t	Media	/evidencias/10259_619.pdf	2024-03-28	2026-03-28
2271	10259	104	619	f	Media	\N	2025-02-13	2027-02-13
2272	10259	104	620	t	Baja	/evidencias/10259_620.pdf	2025-02-24	2026-02-24
2273	10259	104	620	t	Media	/evidencias/10259_620.pdf	2024-02-29	2025-02-28
2274	10259	104	621	t	Media	/evidencias/10259_621.pdf	2025-12-12	2027-12-12
2275	10259	104	622	t	Media	/evidencias/10259_622.pdf	2025-03-06	2027-03-06
2276	10259	104	622	t	Media	/evidencias/10259_622.pdf	2026-01-24	2028-01-24
2277	10259	104	623	t	Media	/evidencias/10259_623.pdf	2026-04-22	2028-04-21
2278	10259	104	624	t	Alta	/evidencias/10259_624.pdf	2024-08-11	2026-08-11
2279	10259	104	625	t	Media	/evidencias/10259_625.pdf	2026-02-15	2027-02-15
2280	10259	104	625	t	Alta	/evidencias/10259_625.pdf	2025-10-08	2026-10-08
2281	10260	110	654	f	Media	\N	2023-08-08	2024-08-07
2282	10260	110	654	t	Baja	/evidencias/10260_654.pdf	2025-10-10	2026-10-10
2283	10260	110	655	f	Media	\N	2024-10-28	2025-10-28
2284	10260	110	656	f	Media	\N	2024-03-06	2026-03-06
2285	10260	110	656	t	Baja	/evidencias/10260_656.pdf	2026-04-03	2027-04-03
2286	10260	110	657	f	Baja	\N	2024-06-15	2026-06-15
2287	10260	110	657	f	Baja	\N	2026-04-20	2027-04-20
2288	10260	110	658	f	Alta	\N	2024-11-11	2026-11-11
2289	10260	110	658	t	Media	/evidencias/10260_658.pdf	2024-09-17	2025-09-17
2290	10261	74	437	t	Alta	/evidencias/10261_437.pdf	2024-08-23	2025-08-23
2291	10261	74	438	t	Baja	/evidencias/10261_438.pdf	2024-04-09	2025-04-09
2292	10261	74	438	t	Alta	/evidencias/10261_438.pdf	2025-03-25	2027-03-25
2293	10261	74	439	t	Alta	/evidencias/10261_439.pdf	2026-02-20	2028-02-20
2294	10261	74	440	t	Media	/evidencias/10261_440.pdf	2024-10-14	2026-10-14
2295	10261	74	440	t	Alta	/evidencias/10261_440.pdf	2025-05-02	2026-05-02
2296	10262	73	432	t	Alta	/evidencias/10262_432.pdf	2023-10-17	2024-10-16
2297	10262	73	433	t	Alta	/evidencias/10262_433.pdf	2025-07-26	2026-07-26
2298	10262	73	433	f	Media	\N	2025-07-10	2027-07-10
2299	10262	73	434	t	Baja	/evidencias/10262_434.pdf	2023-12-03	2024-12-02
2300	10262	73	435	t	Alta	/evidencias/10262_435.pdf	2025-06-18	2027-06-18
2301	10262	73	436	t	Alta	/evidencias/10262_436.pdf	2024-04-22	2025-04-22
2302	10262	73	436	t	Baja	/evidencias/10262_436.pdf	2025-02-20	2027-02-20
2303	10263	134	802	t	Media	/evidencias/10263_802.pdf	2026-02-14	2028-02-14
2304	10263	134	802	t	Media	/evidencias/10263_802.pdf	2023-11-11	2025-11-10
2305	10263	134	803	f	Media	\N	2025-08-27	2026-08-27
2306	10263	134	804	t	Baja	/evidencias/10263_804.pdf	2025-08-08	2026-08-08
2307	10263	134	804	t	Alta	/evidencias/10263_804.pdf	2024-10-07	2025-10-07
2308	10263	134	805	f	Media	\N	2024-11-20	2026-11-20
2309	10263	134	805	f	Alta	\N	2024-04-22	2025-04-22
2310	10263	134	806	f	Alta	\N	2024-02-09	2026-02-08
2311	10263	134	806	t	Media	/evidencias/10263_806.pdf	2026-04-10	2028-04-09
2312	10263	134	807	f	Alta	\N	2026-05-18	2028-05-17
2313	10263	134	807	t	Media	/evidencias/10263_807.pdf	2023-10-08	2025-10-07
2314	10263	134	808	t	Baja	/evidencias/10263_808.pdf	2023-10-20	2025-10-19
2315	10264	54	316	t	Alta	/evidencias/10264_316.pdf	2023-10-14	2024-10-13
2316	10264	54	316	f	Baja	\N	2025-09-23	2026-09-23
2317	10264	54	317	t	Alta	/evidencias/10264_317.pdf	2026-03-29	2027-03-29
2318	10264	54	317	t	Media	/evidencias/10264_317.pdf	2025-07-04	2027-07-04
2319	10264	54	318	t	Alta	/evidencias/10264_318.pdf	2024-02-11	2026-02-10
2320	10264	54	319	t	Baja	/evidencias/10264_319.pdf	2025-08-12	2027-08-12
2321	10264	54	320	t	Baja	/evidencias/10264_320.pdf	2026-02-02	2028-02-02
2322	10265	8	46	t	Alta	/evidencias/10265_46.pdf	2025-07-04	2026-07-04
2323	10265	8	47	f	Alta	\N	2025-02-11	2026-02-11
2324	10265	8	48	t	Baja	/evidencias/10265_48.pdf	2023-07-25	2024-07-24
2325	10265	8	48	t	Media	/evidencias/10265_48.pdf	2023-12-28	2024-12-27
2326	10265	8	49	t	Alta	/evidencias/10265_49.pdf	2024-04-25	2026-04-25
2327	10265	8	50	t	Media	/evidencias/10265_50.pdf	2025-12-01	2027-12-01
2328	10265	8	51	t	Media	/evidencias/10265_51.pdf	2025-05-24	2027-05-24
2329	10266	85	499	t	Media	/evidencias/10266_499.pdf	2026-01-29	2027-01-29
2330	10266	85	499	t	Media	/evidencias/10266_499.pdf	2024-12-15	2025-12-15
2331	10266	85	500	t	Media	/evidencias/10266_500.pdf	2023-09-27	2024-09-26
2332	10266	85	500	t	Baja	/evidencias/10266_500.pdf	2024-10-26	2025-10-26
2333	10266	85	501	t	Baja	/evidencias/10266_501.pdf	2023-07-26	2025-07-25
2334	10266	85	502	f	Media	\N	2025-07-22	2026-07-22
2335	10266	85	502	t	Alta	/evidencias/10266_502.pdf	2026-05-30	2027-05-30
2336	10266	85	503	t	Baja	/evidencias/10266_503.pdf	2023-09-16	2025-09-15
2337	10266	85	503	t	Media	/evidencias/10266_503.pdf	2024-07-31	2025-07-31
2338	10266	85	504	t	Media	/evidencias/10266_504.pdf	2023-10-05	2025-10-04
2339	10266	85	505	f	Alta	\N	2026-01-29	2027-01-29
2340	10267	19	108	t	Alta	/evidencias/10267_108.pdf	2025-07-18	2026-07-18
2341	10267	19	109	f	Media	\N	2024-03-04	2025-03-04
2342	10267	19	110	t	Baja	/evidencias/10267_110.pdf	2025-07-06	2026-07-06
2343	10267	19	111	f	Media	\N	2025-12-08	2026-12-08
2344	10267	19	111	t	Media	/evidencias/10267_111.pdf	2024-08-23	2026-08-23
2345	10267	19	112	t	Media	/evidencias/10267_112.pdf	2024-05-24	2025-05-24
2346	10268	97	577	t	Alta	/evidencias/10268_577.pdf	2024-03-03	2026-03-03
2347	10268	97	577	t	Media	/evidencias/10268_577.pdf	2024-04-02	2025-04-02
2348	10268	97	578	t	Alta	/evidencias/10268_578.pdf	2023-10-13	2024-10-12
2349	10268	97	579	t	Media	/evidencias/10268_579.pdf	2024-10-23	2025-10-23
2350	10268	97	580	t	Baja	/evidencias/10268_580.pdf	2023-10-23	2024-10-22
2351	10268	97	581	f	Media	\N	2025-04-10	2027-04-10
2352	10268	97	581	t	Alta	/evidencias/10268_581.pdf	2026-05-30	2028-05-29
2353	10270	90	531	f	Alta	\N	2025-05-28	2027-05-28
2354	10270	90	531	t	Baja	/evidencias/10270_531.pdf	2025-05-25	2027-05-25
2355	10270	90	532	t	Alta	/evidencias/10270_532.pdf	2026-03-12	2027-03-12
2356	10270	90	533	f	Media	\N	2025-10-22	2026-10-22
2357	10270	90	533	f	Alta	\N	2023-12-02	2025-12-01
2358	10270	90	534	f	Alta	\N	2024-09-18	2025-09-18
2359	10270	90	535	t	Media	/evidencias/10270_535.pdf	2023-08-29	2024-08-28
2360	10270	90	536	f	Media	\N	2025-11-25	2026-11-25
2361	10270	90	536	f	Alta	\N	2024-01-17	2026-01-16
2362	10270	90	537	t	Media	/evidencias/10270_537.pdf	2023-06-28	2025-06-27
2363	10271	17	97	t	Media	/evidencias/10271_97.pdf	2024-09-23	2025-09-23
2364	10271	17	97	t	Media	/evidencias/10271_97.pdf	2025-02-11	2027-02-11
2365	10271	17	98	f	Baja	\N	2025-05-27	2027-05-27
2366	10271	17	98	f	Media	\N	2024-08-08	2026-08-08
2367	10271	17	99	f	Alta	\N	2026-04-22	2028-04-21
2368	10271	17	99	t	Alta	/evidencias/10271_99.pdf	2024-04-17	2026-04-17
2369	10271	17	100	t	Media	/evidencias/10271_100.pdf	2024-06-30	2025-06-30
2370	10271	17	101	f	Media	\N	2025-09-12	2026-09-12
2371	10271	17	102	f	Alta	\N	2024-07-07	2025-07-07
2372	10271	17	103	t	Media	/evidencias/10271_103.pdf	2025-11-24	2026-11-24
2373	10271	17	103	t	Alta	/evidencias/10271_103.pdf	2023-09-19	2025-09-18
2374	10272	77	454	t	Baja	/evidencias/10272_454.pdf	2025-02-11	2027-02-11
2375	10272	77	455	t	Media	/evidencias/10272_455.pdf	2025-07-20	2026-07-20
2376	10272	77	455	t	Media	/evidencias/10272_455.pdf	2024-03-29	2026-03-29
2377	10272	77	456	t	Media	/evidencias/10272_456.pdf	2025-05-27	2027-05-27
2378	10272	77	456	f	Alta	\N	2024-01-30	2026-01-29
2379	10272	77	457	t	Baja	/evidencias/10272_457.pdf	2024-10-06	2025-10-06
2380	10272	77	458	t	Media	/evidencias/10272_458.pdf	2026-05-04	2028-05-03
2381	10273	145	867	t	Media	/evidencias/10273_867.pdf	2026-01-03	2028-01-03
2382	10273	145	867	f	Media	\N	2023-08-19	2024-08-18
2383	10273	145	868	t	Baja	/evidencias/10273_868.pdf	2024-02-24	2026-02-23
2384	10273	145	868	t	Media	/evidencias/10273_868.pdf	2026-05-31	2028-05-30
2385	10273	145	869	t	Alta	/evidencias/10273_869.pdf	2025-11-23	2026-11-23
2386	10273	145	870	t	Alta	/evidencias/10273_870.pdf	2025-02-04	2026-02-04
2387	10273	145	871	f	Baja	\N	2026-04-17	2027-04-17
2388	10273	145	871	f	Alta	\N	2026-02-12	2028-02-12
2389	10275	69	404	f	Alta	\N	2024-11-05	2025-11-05
2390	10275	69	404	t	Alta	/evidencias/10275_404.pdf	2024-07-28	2026-07-28
2391	10275	69	405	t	Baja	/evidencias/10275_405.pdf	2024-10-26	2026-10-26
2392	10275	69	405	t	Baja	/evidencias/10275_405.pdf	2025-11-19	2027-11-19
2393	10275	69	406	t	Alta	/evidencias/10275_406.pdf	2024-12-28	2026-12-28
2394	10275	69	406	t	Media	/evidencias/10275_406.pdf	2025-09-21	2026-09-21
2395	10275	69	407	t	Baja	/evidencias/10275_407.pdf	2023-06-13	2024-06-12
2396	10275	69	408	t	Alta	/evidencias/10275_408.pdf	2026-02-03	2028-02-03
2397	10275	69	409	t	Media	/evidencias/10275_409.pdf	2024-10-29	2025-10-29
2398	10276	112	665	t	Alta	/evidencias/10276_665.pdf	2026-05-23	2027-05-23
2399	10276	112	665	t	Alta	/evidencias/10276_665.pdf	2024-10-17	2026-10-17
2400	10276	112	666	f	Media	\N	2025-11-16	2026-11-16
2401	10276	112	667	t	Baja	/evidencias/10276_667.pdf	2023-10-24	2025-10-23
2402	10276	112	668	t	Media	/evidencias/10276_668.pdf	2025-06-03	2027-06-03
2403	10276	112	669	t	Media	/evidencias/10276_669.pdf	2024-04-03	2025-04-03
2404	10277	20	113	t	Alta	/evidencias/10277_113.pdf	2025-08-17	2026-08-17
2405	10277	20	114	t	Alta	/evidencias/10277_114.pdf	2024-02-01	2026-01-31
2406	10277	20	114	t	Baja	/evidencias/10277_114.pdf	2026-01-22	2028-01-22
2407	10277	20	115	f	Baja	\N	2023-12-22	2025-12-21
2408	10277	20	116	t	Baja	/evidencias/10277_116.pdf	2026-01-21	2028-01-21
2409	10277	20	117	t	Baja	/evidencias/10277_117.pdf	2024-12-28	2025-12-28
2410	10277	20	117	f	Alta	\N	2026-02-21	2028-02-21
2411	10277	20	118	t	Baja	/evidencias/10277_118.pdf	2024-12-02	2025-12-02
2412	10277	20	118	f	Alta	\N	2025-08-15	2026-08-15
2413	10278	21	119	f	Media	\N	2025-08-09	2027-08-09
2414	10278	21	120	t	Baja	/evidencias/10278_120.pdf	2024-01-18	2025-01-17
2415	10278	21	120	f	Media	\N	2024-07-02	2025-07-02
2416	10278	21	121	t	Baja	/evidencias/10278_121.pdf	2023-09-11	2025-09-10
2417	10278	21	122	t	Alta	/evidencias/10278_122.pdf	2025-06-22	2027-06-22
2418	10278	21	123	f	Media	\N	2023-10-17	2024-10-16
2419	10278	21	124	t	Alta	/evidencias/10278_124.pdf	2024-08-26	2026-08-26
2420	10278	21	124	t	Baja	/evidencias/10278_124.pdf	2024-01-21	2025-01-20
2421	10279	74	437	f	Baja	\N	2023-07-15	2025-07-14
2422	10279	74	437	t	Media	/evidencias/10279_437.pdf	2025-12-29	2027-12-29
2423	10279	74	438	t	Alta	/evidencias/10279_438.pdf	2025-02-08	2026-02-08
2424	10279	74	439	t	Alta	/evidencias/10279_439.pdf	2023-09-18	2025-09-17
2425	10279	74	439	f	Media	\N	2025-03-27	2027-03-27
2426	10279	74	440	f	Baja	\N	2025-12-09	2026-12-09
2427	10280	31	173	t	Baja	/evidencias/10280_173.pdf	2026-05-05	2028-05-04
2428	10280	31	173	f	Media	\N	2025-10-28	2026-10-28
2429	10280	31	174	f	Media	\N	2023-06-02	2025-06-01
2430	10280	31	174	f	Alta	\N	2024-11-08	2026-11-08
2431	10280	31	175	t	Media	/evidencias/10280_175.pdf	2024-09-19	2025-09-19
2432	10280	31	175	t	Media	/evidencias/10280_175.pdf	2025-01-28	2027-01-28
2433	10280	31	176	f	Media	\N	2026-04-11	2027-04-11
2434	10280	31	177	t	Media	/evidencias/10280_177.pdf	2024-12-11	2025-12-11
2435	10281	21	119	t	Media	/evidencias/10281_119.pdf	2024-12-22	2025-12-22
2436	10281	21	120	f	Media	\N	2025-07-20	2026-07-20
2437	10281	21	121	t	Alta	/evidencias/10281_121.pdf	2025-08-28	2026-08-28
2438	10281	21	121	f	Alta	\N	2025-10-29	2026-10-29
2439	10281	21	122	t	Media	/evidencias/10281_122.pdf	2024-08-05	2025-08-05
2440	10281	21	123	f	Baja	\N	2024-07-31	2026-07-31
2441	10281	21	124	f	Baja	\N	2026-02-08	2028-02-08
2442	10281	21	124	t	Media	/evidencias/10281_124.pdf	2024-10-19	2025-10-19
2443	10282	99	589	f	Baja	\N	2025-08-01	2026-08-01
2444	10282	99	590	t	Media	/evidencias/10282_590.pdf	2024-09-04	2026-09-04
2445	10282	99	590	t	Baja	/evidencias/10282_590.pdf	2024-11-11	2026-11-11
2446	10282	99	591	t	Alta	/evidencias/10282_591.pdf	2024-12-06	2026-12-06
2447	10282	99	591	t	Baja	/evidencias/10282_591.pdf	2024-11-11	2026-11-11
2448	10282	99	592	t	Alta	/evidencias/10282_592.pdf	2025-10-24	2027-10-24
2449	10282	99	593	t	Media	/evidencias/10282_593.pdf	2026-02-16	2027-02-16
2450	10282	99	593	f	Alta	\N	2024-06-20	2026-06-20
2451	10282	99	594	t	Alta	/evidencias/10282_594.pdf	2025-06-12	2027-06-12
2452	10283	19	108	t	Baja	/evidencias/10283_108.pdf	2024-12-28	2026-12-28
2453	10283	19	108	t	Media	/evidencias/10283_108.pdf	2025-05-29	2027-05-29
2454	10283	19	109	f	Media	\N	2023-07-21	2024-07-20
2455	10283	19	110	t	Alta	/evidencias/10283_110.pdf	2025-04-17	2026-04-17
2456	10283	19	110	f	Alta	\N	2025-06-24	2027-06-24
2457	10283	19	111	f	Alta	\N	2026-01-18	2028-01-18
2458	10283	19	111	t	Alta	/evidencias/10283_111.pdf	2025-02-21	2026-02-21
2459	10283	19	112	t	Alta	/evidencias/10283_112.pdf	2025-04-29	2026-04-29
2460	10284	60	343	t	Media	/evidencias/10284_343.pdf	2024-12-07	2026-12-07
2461	10284	60	344	t	Media	/evidencias/10284_344.pdf	2024-02-08	2025-02-07
2462	10284	60	344	f	Media	\N	2024-09-20	2025-09-20
2463	10284	60	345	t	Media	/evidencias/10284_345.pdf	2024-06-23	2025-06-23
2464	10284	60	346	t	Alta	/evidencias/10284_346.pdf	2024-05-03	2026-05-03
2465	10284	60	346	t	Baja	/evidencias/10284_346.pdf	2025-10-17	2026-10-17
2466	10284	60	347	t	Alta	/evidencias/10284_347.pdf	2025-05-28	2027-05-28
2467	10284	60	347	t	Media	/evidencias/10284_347.pdf	2025-12-28	2027-12-28
2468	10285	109	648	f	Alta	\N	2025-06-20	2027-06-20
2469	10285	109	649	t	Alta	/evidencias/10285_649.pdf	2024-07-19	2025-07-19
2470	10285	109	649	t	Media	/evidencias/10285_649.pdf	2024-02-21	2026-02-20
2471	10285	109	650	t	Media	/evidencias/10285_650.pdf	2025-04-08	2026-04-08
2472	10285	109	651	t	Alta	/evidencias/10285_651.pdf	2026-03-22	2028-03-21
2473	10285	109	651	t	Media	/evidencias/10285_651.pdf	2023-07-26	2025-07-25
2474	10285	109	652	t	Alta	/evidencias/10285_652.pdf	2025-09-09	2027-09-09
2475	10285	109	652	t	Alta	/evidencias/10285_652.pdf	2023-06-02	2025-06-01
2476	10285	109	653	t	Media	/evidencias/10285_653.pdf	2026-03-01	2027-03-01
2477	10285	109	653	t	Baja	/evidencias/10285_653.pdf	2023-11-19	2025-11-18
2478	10286	71	417	t	Baja	/evidencias/10286_417.pdf	2025-08-16	2026-08-16
2479	10286	71	417	f	Alta	\N	2024-10-31	2025-10-31
2480	10286	71	418	f	Baja	\N	2025-04-03	2027-04-03
2481	10286	71	418	f	Alta	\N	2025-07-03	2027-07-03
2482	10286	71	419	t	Alta	/evidencias/10286_419.pdf	2025-04-12	2026-04-12
2483	10286	71	420	t	Media	/evidencias/10286_420.pdf	2025-05-27	2027-05-27
2484	10286	71	421	t	Media	/evidencias/10286_421.pdf	2025-07-04	2026-07-04
2485	10286	71	421	t	Media	/evidencias/10286_421.pdf	2023-11-10	2025-11-09
2486	10286	71	422	t	Alta	/evidencias/10286_422.pdf	2024-02-09	2026-02-08
2487	10286	71	423	t	Media	/evidencias/10286_423.pdf	2025-08-10	2026-08-10
2488	10286	71	424	t	Media	/evidencias/10286_424.pdf	2025-07-20	2027-07-20
2489	10286	71	424	t	Baja	/evidencias/10286_424.pdf	2025-11-26	2027-11-26
2490	10287	98	582	t	Alta	/evidencias/10287_582.pdf	2023-07-28	2024-07-27
2491	10287	98	583	f	Media	\N	2026-04-24	2027-04-24
2492	10287	98	584	f	Baja	\N	2026-05-07	2028-05-06
2493	10287	98	585	f	Alta	\N	2024-07-25	2025-07-25
2494	10287	98	585	f	Media	\N	2023-10-26	2024-10-25
2495	10287	98	586	f	Media	\N	2026-01-23	2028-01-23
2496	10287	98	587	t	Media	/evidencias/10287_587.pdf	2023-10-15	2024-10-14
4084	10477	65	379	f	Baja	\N	2026-01-28	2027-01-28
2497	10287	98	587	t	Media	/evidencias/10287_587.pdf	2024-11-05	2026-11-05
2498	10287	98	588	t	Baja	/evidencias/10287_588.pdf	2025-08-12	2027-08-12
2499	10287	98	588	t	Alta	/evidencias/10287_588.pdf	2025-07-21	2027-07-21
2500	10288	100	595	t	Media	/evidencias/10288_595.pdf	2026-05-24	2027-05-24
2501	10288	100	595	t	Baja	/evidencias/10288_595.pdf	2025-07-19	2026-07-19
2502	10288	100	596	t	Media	/evidencias/10288_596.pdf	2024-11-14	2025-11-14
2503	10288	100	597	f	Alta	\N	2025-07-30	2026-07-30
2504	10288	100	597	f	Baja	\N	2023-12-20	2025-12-19
2505	10288	100	598	t	Media	/evidencias/10288_598.pdf	2025-10-14	2026-10-14
2506	10288	100	599	t	Media	/evidencias/10288_599.pdf	2025-05-17	2026-05-17
2507	10288	100	599	t	Media	/evidencias/10288_599.pdf	2024-06-24	2026-06-24
2508	10288	100	600	f	Baja	\N	2024-02-13	2025-02-12
2509	10288	100	601	f	Alta	\N	2024-12-20	2026-12-20
2510	10288	100	601	t	Media	/evidencias/10288_601.pdf	2023-08-12	2025-08-11
2511	10288	100	602	t	Alta	/evidencias/10288_602.pdf	2024-07-05	2026-07-05
2512	10288	100	602	t	Alta	/evidencias/10288_602.pdf	2026-03-27	2028-03-26
2513	10289	48	277	t	Media	/evidencias/10289_277.pdf	2024-05-23	2025-05-23
2514	10289	48	278	t	Baja	/evidencias/10289_278.pdf	2025-07-23	2027-07-23
2515	10289	48	279	t	Media	/evidencias/10289_279.pdf	2024-06-28	2025-06-28
2516	10289	48	279	t	Media	/evidencias/10289_279.pdf	2026-01-30	2028-01-30
2517	10289	48	280	f	Baja	\N	2025-03-08	2026-03-08
2518	10289	48	280	f	Media	\N	2025-09-30	2027-09-30
2519	10289	48	281	t	Baja	/evidencias/10289_281.pdf	2026-02-24	2028-02-24
2520	10289	48	282	t	Media	/evidencias/10289_282.pdf	2026-04-20	2027-04-20
2521	10289	48	282	f	Baja	\N	2025-09-26	2026-09-26
2522	10289	48	283	t	Baja	/evidencias/10289_283.pdf	2025-01-11	2026-01-11
2523	10289	48	283	f	Baja	\N	2024-08-27	2026-08-27
2524	10289	48	284	t	Baja	/evidencias/10289_284.pdf	2025-12-08	2026-12-08
2525	10289	48	284	t	Alta	/evidencias/10289_284.pdf	2026-03-03	2028-03-02
2526	10290	142	848	t	Alta	/evidencias/10290_848.pdf	2024-02-28	2026-02-27
2527	10290	142	849	t	Media	/evidencias/10290_849.pdf	2026-05-18	2027-05-18
2528	10290	142	850	t	Alta	/evidencias/10290_850.pdf	2026-02-05	2028-02-05
2529	10290	142	850	t	Media	/evidencias/10290_850.pdf	2025-11-19	2026-11-19
2530	10290	142	851	t	Media	/evidencias/10290_851.pdf	2024-11-18	2025-11-18
2531	10290	142	851	t	Baja	/evidencias/10290_851.pdf	2024-11-13	2025-11-13
2532	10290	142	852	f	Media	\N	2023-08-14	2024-08-13
2533	10290	142	852	t	Media	/evidencias/10290_852.pdf	2023-11-20	2024-11-19
2534	10290	142	853	t	Baja	/evidencias/10290_853.pdf	2023-06-30	2024-06-29
2535	10290	142	853	t	Media	/evidencias/10290_853.pdf	2025-01-08	2027-01-08
2536	10290	142	854	t	Baja	/evidencias/10290_854.pdf	2024-07-15	2026-07-15
2537	10290	142	854	t	Alta	/evidencias/10290_854.pdf	2025-12-06	2026-12-06
2538	10291	114	678	f	Baja	\N	2024-09-24	2025-09-24
2539	10291	114	679	f	Baja	\N	2025-09-21	2027-09-21
2540	10291	114	679	f	Baja	\N	2025-12-20	2027-12-20
2541	10291	114	680	f	Media	\N	2024-12-18	2026-12-18
2542	10291	114	680	t	Media	/evidencias/10291_680.pdf	2026-04-27	2027-04-27
2543	10291	114	681	t	Alta	/evidencias/10291_681.pdf	2024-10-07	2026-10-07
2544	10291	114	682	f	Media	\N	2023-12-30	2025-12-29
2545	10291	114	682	t	Media	/evidencias/10291_682.pdf	2024-09-24	2026-09-24
2546	10291	114	683	t	Baja	/evidencias/10291_683.pdf	2023-10-28	2024-10-27
2547	10291	114	684	f	Alta	\N	2025-04-29	2027-04-29
2548	10292	65	374	t	Baja	/evidencias/10292_374.pdf	2025-02-01	2026-02-01
2549	10292	65	375	f	Media	\N	2023-11-26	2025-11-25
2550	10292	65	375	t	Baja	/evidencias/10292_375.pdf	2023-11-24	2024-11-23
2551	10292	65	376	t	Baja	/evidencias/10292_376.pdf	2024-07-28	2026-07-28
2552	10292	65	376	t	Media	/evidencias/10292_376.pdf	2024-08-21	2026-08-21
2553	10292	65	377	t	Baja	/evidencias/10292_377.pdf	2024-02-04	2026-02-03
2554	10292	65	377	t	Baja	/evidencias/10292_377.pdf	2025-09-08	2026-09-08
2555	10292	65	378	t	Alta	/evidencias/10292_378.pdf	2026-01-24	2027-01-24
2556	10292	65	379	t	Alta	/evidencias/10292_379.pdf	2026-04-14	2028-04-13
2557	10292	65	379	t	Alta	/evidencias/10292_379.pdf	2023-08-09	2024-08-08
2558	10292	65	380	t	Alta	/evidencias/10292_380.pdf	2023-12-21	2024-12-20
2559	10292	65	381	t	Baja	/evidencias/10292_381.pdf	2023-09-10	2025-09-09
2560	10294	93	550	t	Media	/evidencias/10294_550.pdf	2024-08-16	2026-08-16
2561	10294	93	550	t	Baja	/evidencias/10294_550.pdf	2025-04-19	2026-04-19
2562	10294	93	551	t	Media	/evidencias/10294_551.pdf	2024-03-17	2025-03-17
2563	10294	93	552	f	Media	\N	2024-09-27	2026-09-27
2564	10294	93	553	t	Media	/evidencias/10294_553.pdf	2023-12-15	2025-12-14
2565	10294	93	554	t	Media	/evidencias/10294_554.pdf	2024-12-19	2025-12-19
2566	10294	93	555	f	Baja	\N	2024-07-03	2026-07-03
2567	10294	93	555	f	Alta	\N	2025-07-19	2027-07-19
2568	10294	93	556	t	Media	/evidencias/10294_556.pdf	2023-06-24	2024-06-23
2569	10294	93	556	t	Baja	/evidencias/10294_556.pdf	2024-08-22	2025-08-22
2570	10295	106	632	t	Baja	/evidencias/10295_632.pdf	2026-02-19	2027-02-19
2571	10295	106	633	t	Baja	/evidencias/10295_633.pdf	2024-11-03	2026-11-03
2572	10295	106	633	f	Alta	\N	2025-08-11	2026-08-11
2573	10295	106	634	f	Alta	\N	2025-12-27	2027-12-27
2574	10295	106	634	f	Alta	\N	2023-06-18	2024-06-17
2575	10295	106	635	f	Media	\N	2025-08-01	2027-08-01
2576	10295	106	635	t	Baja	/evidencias/10295_635.pdf	2024-03-30	2025-03-30
2577	10295	106	636	t	Alta	/evidencias/10295_636.pdf	2025-12-05	2026-12-05
2578	10295	106	636	t	Media	/evidencias/10295_636.pdf	2024-07-11	2026-07-11
2579	10296	18	104	t	Baja	/evidencias/10296_104.pdf	2026-01-27	2027-01-27
2580	10296	18	104	t	Alta	/evidencias/10296_104.pdf	2023-08-03	2025-08-02
2581	10296	18	105	f	Media	\N	2025-03-06	2026-03-06
2582	10296	18	105	f	Baja	\N	2025-01-07	2027-01-07
2583	10296	18	106	t	Media	/evidencias/10296_106.pdf	2025-10-08	2026-10-08
2584	10296	18	106	t	Alta	/evidencias/10296_106.pdf	2025-04-05	2026-04-05
2585	10296	18	107	t	Media	/evidencias/10296_107.pdf	2024-12-07	2025-12-07
2586	10296	18	107	t	Media	/evidencias/10296_107.pdf	2026-03-23	2027-03-23
2587	10297	116	690	f	Baja	\N	2024-02-01	2025-01-31
2588	10297	116	691	t	Media	/evidencias/10297_691.pdf	2026-04-09	2027-04-09
2589	10297	116	692	t	Alta	/evidencias/10297_692.pdf	2025-06-11	2026-06-11
2590	10297	116	692	f	Media	\N	2024-11-15	2026-11-15
2591	10297	116	693	f	Alta	\N	2025-11-18	2027-11-18
2592	10298	36	206	t	Baja	/evidencias/10298_206.pdf	2023-09-01	2024-08-31
2593	10298	36	206	t	Alta	/evidencias/10298_206.pdf	2024-02-21	2025-02-20
2594	10298	36	207	t	Alta	/evidencias/10298_207.pdf	2024-11-13	2026-11-13
2595	10298	36	207	t	Alta	/evidencias/10298_207.pdf	2025-07-24	2027-07-24
4983	10578	130	779	f	Baja	\N	2025-08-31	2027-08-31
2596	10298	36	208	t	Media	/evidencias/10298_208.pdf	2024-06-10	2025-06-10
2597	10298	36	208	t	Baja	/evidencias/10298_208.pdf	2026-05-01	2027-05-01
2598	10298	36	209	f	Media	\N	2024-04-14	2025-04-14
2599	10298	36	209	t	Media	/evidencias/10298_209.pdf	2023-10-04	2025-10-03
2600	10299	14	81	t	Media	/evidencias/10299_81.pdf	2026-02-21	2027-02-21
2601	10299	14	81	f	Media	\N	2026-03-03	2028-03-02
2602	10299	14	82	t	Media	/evidencias/10299_82.pdf	2025-02-08	2027-02-08
2603	10299	14	82	f	Media	\N	2025-06-08	2026-06-08
2604	10299	14	83	t	Alta	/evidencias/10299_83.pdf	2024-09-02	2025-09-02
2605	10299	14	84	t	Media	/evidencias/10299_84.pdf	2023-12-10	2024-12-09
2606	10299	14	85	t	Media	/evidencias/10299_85.pdf	2026-01-09	2028-01-09
2607	10299	14	86	t	Baja	/evidencias/10299_86.pdf	2025-07-26	2027-07-26
2608	10300	122	724	t	Media	/evidencias/10300_724.pdf	2025-12-19	2027-12-19
2609	10300	122	724	f	Media	\N	2023-12-10	2024-12-09
2610	10300	122	725	t	Media	/evidencias/10300_725.pdf	2024-06-13	2025-06-13
2611	10300	122	726	t	Alta	/evidencias/10300_726.pdf	2024-04-25	2026-04-25
2612	10300	122	726	t	Alta	/evidencias/10300_726.pdf	2025-11-22	2026-11-22
2613	10300	122	727	t	Alta	/evidencias/10300_727.pdf	2026-02-21	2027-02-21
2614	10300	122	728	t	Media	/evidencias/10300_728.pdf	2025-08-06	2027-08-06
2615	10300	122	729	f	Alta	\N	2023-09-17	2024-09-16
2616	10300	122	729	f	Media	\N	2025-04-13	2026-04-13
2617	10300	122	730	f	Media	\N	2023-08-08	2024-08-07
2618	10300	122	730	t	Media	/evidencias/10300_730.pdf	2024-03-10	2025-03-10
2619	10300	122	731	t	Alta	/evidencias/10300_731.pdf	2023-12-04	2024-12-03
2620	10301	23	130	t	Baja	/evidencias/10301_130.pdf	2025-06-08	2026-06-08
2621	10301	23	131	t	Media	/evidencias/10301_131.pdf	2024-10-09	2026-10-09
2622	10301	23	132	t	Media	/evidencias/10301_132.pdf	2024-01-12	2026-01-11
2623	10301	23	132	f	Alta	\N	2023-10-24	2024-10-23
2624	10301	23	133	t	Alta	/evidencias/10301_133.pdf	2026-04-12	2027-04-12
2625	10301	23	134	f	Media	\N	2025-02-10	2026-02-10
2626	10301	23	134	f	Baja	\N	2026-04-19	2027-04-19
2627	10302	55	321	t	Alta	/evidencias/10302_321.pdf	2026-05-31	2027-05-31
2628	10302	55	321	f	Alta	\N	2025-12-28	2026-12-28
2629	10302	55	322	t	Media	/evidencias/10302_322.pdf	2024-07-03	2025-07-03
2630	10302	55	323	t	Alta	/evidencias/10302_323.pdf	2023-09-19	2024-09-18
2631	10302	55	323	f	Media	\N	2025-12-05	2026-12-05
2632	10302	55	324	t	Alta	/evidencias/10302_324.pdf	2025-03-07	2026-03-07
2633	10302	55	324	t	Alta	/evidencias/10302_324.pdf	2023-12-15	2025-12-14
2634	10303	81	475	t	Baja	/evidencias/10303_475.pdf	2026-05-17	2028-05-16
2635	10303	81	476	t	Baja	/evidencias/10303_476.pdf	2026-03-02	2027-03-02
2636	10303	81	476	f	Media	\N	2025-10-24	2027-10-24
2637	10303	81	477	t	Media	/evidencias/10303_477.pdf	2025-07-21	2027-07-21
2638	10303	81	478	t	Media	/evidencias/10303_478.pdf	2024-04-14	2026-04-14
2639	10303	81	479	f	Baja	\N	2025-11-10	2027-11-10
2640	10303	81	480	t	Alta	/evidencias/10303_480.pdf	2024-10-29	2025-10-29
2641	10303	81	481	t	Media	/evidencias/10303_481.pdf	2023-09-07	2024-09-06
2642	10304	84	494	t	Baja	/evidencias/10304_494.pdf	2026-01-03	2027-01-03
2643	10304	84	494	t	Baja	/evidencias/10304_494.pdf	2026-01-12	2028-01-12
2644	10304	84	495	t	Media	/evidencias/10304_495.pdf	2025-09-07	2027-09-07
2645	10304	84	495	t	Media	/evidencias/10304_495.pdf	2024-02-16	2025-02-15
2646	10304	84	496	f	Alta	\N	2025-12-03	2027-12-03
2647	10304	84	497	t	Alta	/evidencias/10304_497.pdf	2025-05-04	2026-05-04
2648	10304	84	498	t	Media	/evidencias/10304_498.pdf	2024-11-19	2026-11-19
2649	10304	84	498	t	Baja	/evidencias/10304_498.pdf	2024-07-07	2026-07-07
2650	10305	104	619	t	Media	/evidencias/10305_619.pdf	2026-04-28	2027-04-28
2651	10305	104	620	t	Baja	/evidencias/10305_620.pdf	2023-07-10	2025-07-09
2652	10305	104	620	t	Alta	/evidencias/10305_620.pdf	2024-10-12	2026-10-12
2653	10305	104	621	t	Alta	/evidencias/10305_621.pdf	2024-11-23	2025-11-23
2654	10305	104	621	t	Baja	/evidencias/10305_621.pdf	2025-10-02	2027-10-02
2655	10305	104	622	t	Media	/evidencias/10305_622.pdf	2024-01-17	2025-01-16
2656	10305	104	622	t	Baja	/evidencias/10305_622.pdf	2024-05-09	2026-05-09
2657	10305	104	623	t	Media	/evidencias/10305_623.pdf	2025-12-13	2027-12-13
2658	10305	104	624	t	Alta	/evidencias/10305_624.pdf	2024-06-05	2025-06-05
2659	10305	104	625	t	Media	/evidencias/10305_625.pdf	2025-11-13	2027-11-13
2660	10306	51	295	f	Alta	\N	2025-07-08	2027-07-08
2661	10306	51	295	t	Media	/evidencias/10306_295.pdf	2024-12-27	2025-12-27
2662	10306	51	296	t	Alta	/evidencias/10306_296.pdf	2024-06-02	2025-06-02
2663	10306	51	297	f	Media	\N	2026-03-28	2028-03-27
2664	10306	51	298	t	Alta	/evidencias/10306_298.pdf	2026-03-21	2027-03-21
2665	10306	51	299	t	Alta	/evidencias/10306_299.pdf	2024-05-06	2025-05-06
2666	10306	51	299	t	Media	/evidencias/10306_299.pdf	2023-08-06	2024-08-05
2667	10306	51	300	t	Baja	/evidencias/10306_300.pdf	2023-08-28	2024-08-27
2668	10306	51	300	t	Alta	/evidencias/10306_300.pdf	2023-07-25	2024-07-24
2669	10306	51	301	t	Media	/evidencias/10306_301.pdf	2026-04-14	2027-04-14
2670	10306	51	301	t	Alta	/evidencias/10306_301.pdf	2026-03-26	2027-03-26
2671	10306	51	302	t	Media	/evidencias/10306_302.pdf	2026-03-06	2028-03-05
2672	10307	125	746	f	Media	\N	2025-03-16	2026-03-16
2673	10307	125	746	t	Media	/evidencias/10307_746.pdf	2026-04-09	2027-04-09
2674	10307	125	747	t	Media	/evidencias/10307_747.pdf	2024-09-23	2025-09-23
2675	10307	125	747	t	Baja	/evidencias/10307_747.pdf	2025-04-21	2026-04-21
2676	10307	125	748	t	Baja	/evidencias/10307_748.pdf	2023-12-03	2024-12-02
2677	10307	125	748	t	Alta	/evidencias/10307_748.pdf	2024-09-11	2026-09-11
2678	10307	125	749	t	Media	/evidencias/10307_749.pdf	2026-03-22	2028-03-21
2679	10307	125	749	t	Media	/evidencias/10307_749.pdf	2024-07-13	2026-07-13
2680	10307	125	750	f	Alta	\N	2024-06-28	2026-06-28
2681	10307	125	750	f	Media	\N	2024-04-15	2025-04-15
2682	10307	125	751	t	Alta	/evidencias/10307_751.pdf	2024-10-01	2026-10-01
2683	10307	125	751	t	Media	/evidencias/10307_751.pdf	2024-08-25	2025-08-25
2684	10307	125	752	t	Alta	/evidencias/10307_752.pdf	2025-04-09	2027-04-09
2685	10307	125	752	t	Media	/evidencias/10307_752.pdf	2025-03-14	2026-03-14
2686	10308	76	447	t	Baja	/evidencias/10308_447.pdf	2024-01-15	2026-01-14
2687	10308	76	447	t	Baja	/evidencias/10308_447.pdf	2026-02-18	2027-02-18
2688	10308	76	448	t	Alta	/evidencias/10308_448.pdf	2026-04-16	2028-04-15
2689	10308	76	448	t	Alta	/evidencias/10308_448.pdf	2024-05-05	2025-05-05
2690	10308	76	449	t	Media	/evidencias/10308_449.pdf	2023-09-08	2025-09-07
2691	10308	76	449	t	Media	/evidencias/10308_449.pdf	2023-07-22	2024-07-21
2692	10308	76	450	t	Alta	/evidencias/10308_450.pdf	2025-06-26	2026-06-26
2693	10308	76	451	f	Baja	\N	2023-09-03	2025-09-02
2694	10308	76	452	t	Alta	/evidencias/10308_452.pdf	2025-01-15	2026-01-15
2695	10308	76	452	t	Baja	/evidencias/10308_452.pdf	2025-04-17	2027-04-17
2696	10308	76	453	t	Alta	/evidencias/10308_453.pdf	2026-03-14	2027-03-14
2697	10308	76	453	t	Alta	/evidencias/10308_453.pdf	2023-08-16	2024-08-15
2698	10309	80	469	t	Alta	/evidencias/10309_469.pdf	2025-02-20	2026-02-20
2699	10309	80	469	f	Media	\N	2025-12-20	2027-12-20
2700	10309	80	470	t	Media	/evidencias/10309_470.pdf	2026-05-04	2027-05-04
2701	10309	80	470	t	Alta	/evidencias/10309_470.pdf	2023-10-30	2025-10-29
2702	10309	80	471	t	Baja	/evidencias/10309_471.pdf	2025-09-14	2027-09-14
2703	10309	80	471	t	Media	/evidencias/10309_471.pdf	2023-09-01	2024-08-31
2704	10309	80	472	t	Media	/evidencias/10309_472.pdf	2026-03-12	2028-03-11
2705	10309	80	473	t	Alta	/evidencias/10309_473.pdf	2026-05-28	2027-05-28
2706	10309	80	474	t	Baja	/evidencias/10309_474.pdf	2025-05-26	2027-05-26
2707	10309	80	474	t	Media	/evidencias/10309_474.pdf	2024-07-30	2026-07-30
2708	10310	132	788	f	Media	\N	2025-07-10	2026-07-10
2709	10310	132	788	t	Baja	/evidencias/10310_788.pdf	2025-10-20	2027-10-20
2710	10310	132	789	f	Alta	\N	2026-01-20	2028-01-20
2711	10310	132	790	t	Baja	/evidencias/10310_790.pdf	2026-03-04	2028-03-03
2712	10310	132	791	t	Baja	/evidencias/10310_791.pdf	2024-09-11	2025-09-11
2713	10310	132	792	t	Baja	/evidencias/10310_792.pdf	2025-08-03	2027-08-03
2714	10310	132	793	t	Media	/evidencias/10310_793.pdf	2024-08-04	2025-08-04
2715	10310	132	793	f	Baja	\N	2025-07-03	2027-07-03
2716	10310	132	794	t	Alta	/evidencias/10310_794.pdf	2025-07-15	2027-07-15
2717	10310	132	795	t	Media	/evidencias/10310_795.pdf	2024-04-02	2025-04-02
2718	10310	132	795	t	Media	/evidencias/10310_795.pdf	2025-05-16	2026-05-16
2719	10311	122	724	t	Baja	/evidencias/10311_724.pdf	2025-02-02	2027-02-02
2720	10311	122	725	t	Media	/evidencias/10311_725.pdf	2023-11-05	2025-11-04
2721	10311	122	726	t	Alta	/evidencias/10311_726.pdf	2025-01-06	2026-01-06
2722	10311	122	727	t	Media	/evidencias/10311_727.pdf	2024-09-03	2025-09-03
2723	10311	122	728	f	Media	\N	2024-11-27	2025-11-27
2724	10311	122	729	t	Media	/evidencias/10311_729.pdf	2025-06-20	2026-06-20
2725	10311	122	730	f	Alta	\N	2025-09-01	2026-09-01
2726	10311	122	730	t	Media	/evidencias/10311_730.pdf	2024-07-24	2025-07-24
2727	10311	122	731	t	Baja	/evidencias/10311_731.pdf	2025-01-03	2026-01-03
2728	10311	122	731	t	Baja	/evidencias/10311_731.pdf	2026-03-19	2028-03-18
2729	10312	121	717	f	Media	\N	2024-09-28	2025-09-28
2730	10312	121	718	f	Media	\N	2024-07-21	2025-07-21
2731	10312	121	719	f	Alta	\N	2025-01-21	2027-01-21
2732	10312	121	719	t	Alta	/evidencias/10312_719.pdf	2023-09-24	2025-09-23
2733	10312	121	720	t	Media	/evidencias/10312_720.pdf	2025-08-21	2026-08-21
2734	10312	121	720	t	Media	/evidencias/10312_720.pdf	2023-07-05	2024-07-04
2735	10312	121	721	f	Alta	\N	2025-08-06	2027-08-06
2736	10312	121	722	t	Alta	/evidencias/10312_722.pdf	2024-05-11	2026-05-11
2737	10312	121	722	t	Baja	/evidencias/10312_722.pdf	2026-02-26	2028-02-26
2738	10312	121	723	t	Media	/evidencias/10312_723.pdf	2024-03-29	2026-03-29
2739	10312	121	723	t	Alta	/evidencias/10312_723.pdf	2025-01-08	2026-01-08
2740	10313	77	454	t	Media	/evidencias/10313_454.pdf	2024-12-17	2026-12-17
2741	10313	77	455	t	Media	/evidencias/10313_455.pdf	2023-10-22	2025-10-21
2742	10313	77	455	t	Alta	/evidencias/10313_455.pdf	2024-03-22	2026-03-22
2743	10313	77	456	t	Baja	/evidencias/10313_456.pdf	2024-03-18	2026-03-18
2744	10313	77	456	t	Baja	/evidencias/10313_456.pdf	2024-06-07	2025-06-07
2745	10313	77	457	t	Baja	/evidencias/10313_457.pdf	2025-11-14	2027-11-14
2746	10313	77	457	t	Baja	/evidencias/10313_457.pdf	2025-07-11	2026-07-11
2747	10313	77	458	t	Alta	/evidencias/10313_458.pdf	2023-09-05	2024-09-04
2748	10313	77	458	t	Baja	/evidencias/10313_458.pdf	2023-11-18	2024-11-17
2749	10314	100	595	f	Media	\N	2025-06-22	2027-06-22
2750	10314	100	596	f	Baja	\N	2024-06-29	2026-06-29
2751	10314	100	597	t	Baja	/evidencias/10314_597.pdf	2024-09-07	2026-09-07
2752	10314	100	598	t	Media	/evidencias/10314_598.pdf	2023-07-02	2024-07-01
2753	10314	100	599	f	Baja	\N	2024-05-25	2026-05-25
2754	10314	100	599	f	Alta	\N	2024-06-19	2025-06-19
2755	10314	100	600	t	Alta	/evidencias/10314_600.pdf	2025-08-12	2027-08-12
2756	10314	100	600	t	Media	/evidencias/10314_600.pdf	2025-06-22	2027-06-22
2757	10314	100	601	t	Baja	/evidencias/10314_601.pdf	2025-05-26	2026-05-26
2758	10314	100	601	t	Media	/evidencias/10314_601.pdf	2025-12-17	2026-12-17
2759	10314	100	602	t	Media	/evidencias/10314_602.pdf	2025-09-16	2026-09-16
2760	10314	100	602	t	Baja	/evidencias/10314_602.pdf	2024-12-10	2025-12-10
2761	10315	16	92	f	Media	\N	2024-04-16	2025-04-16
2762	10315	16	92	f	Alta	\N	2024-11-25	2026-11-25
2763	10315	16	93	t	Alta	/evidencias/10315_93.pdf	2023-07-30	2024-07-29
2764	10315	16	94	f	Media	\N	2024-09-24	2025-09-24
2765	10315	16	94	t	Alta	/evidencias/10315_94.pdf	2023-11-28	2025-11-27
2766	10315	16	95	t	Media	/evidencias/10315_95.pdf	2024-07-24	2025-07-24
2767	10315	16	96	t	Media	/evidencias/10315_96.pdf	2024-09-15	2025-09-15
2768	10316	91	538	t	Baja	/evidencias/10316_538.pdf	2025-08-08	2026-08-08
2769	10316	91	539	t	Media	/evidencias/10316_539.pdf	2026-04-28	2028-04-27
2770	10316	91	539	f	Media	\N	2025-05-02	2026-05-02
2771	10316	91	540	t	Media	/evidencias/10316_540.pdf	2024-08-23	2026-08-23
2772	10316	91	540	t	Baja	/evidencias/10316_540.pdf	2023-09-08	2025-09-07
2773	10316	91	541	f	Media	\N	2025-02-11	2027-02-11
2774	10316	91	541	t	Alta	/evidencias/10316_541.pdf	2024-01-20	2025-01-19
2775	10316	91	542	t	Baja	/evidencias/10316_542.pdf	2023-10-19	2024-10-18
2776	10316	91	543	t	Baja	/evidencias/10316_543.pdf	2024-05-12	2025-05-12
2777	10316	91	543	f	Media	\N	2024-06-29	2025-06-29
2778	10316	91	544	t	Baja	/evidencias/10316_544.pdf	2025-01-17	2027-01-17
2779	10317	131	781	t	Media	/evidencias/10317_781.pdf	2023-07-01	2024-06-30
2780	10317	131	781	t	Baja	/evidencias/10317_781.pdf	2024-05-24	2026-05-24
2781	10317	131	782	t	Media	/evidencias/10317_782.pdf	2025-03-28	2027-03-28
2782	10317	131	783	t	Alta	/evidencias/10317_783.pdf	2024-04-17	2025-04-17
2783	10317	131	784	t	Media	/evidencias/10317_784.pdf	2025-01-18	2027-01-18
2784	10317	131	784	f	Alta	\N	2024-01-12	2025-01-11
2785	10317	131	785	f	Baja	\N	2024-10-19	2026-10-19
2786	10317	131	785	t	Alta	/evidencias/10317_785.pdf	2026-03-04	2028-03-03
2787	10317	131	786	t	Media	/evidencias/10317_786.pdf	2025-03-22	2027-03-22
2788	10317	131	786	t	Baja	/evidencias/10317_786.pdf	2025-10-05	2027-10-05
2789	10317	131	787	t	Alta	/evidencias/10317_787.pdf	2025-03-30	2027-03-30
2790	10318	99	589	t	Alta	/evidencias/10318_589.pdf	2025-09-16	2027-09-16
2791	10318	99	590	t	Media	/evidencias/10318_590.pdf	2025-11-16	2027-11-16
2792	10318	99	590	t	Baja	/evidencias/10318_590.pdf	2024-11-11	2025-11-11
2793	10318	99	591	f	Baja	\N	2025-09-01	2026-09-01
2794	10318	99	591	t	Media	/evidencias/10318_591.pdf	2023-12-30	2025-12-29
2795	10318	99	592	f	Media	\N	2025-01-25	2026-01-25
2796	10318	99	592	t	Baja	/evidencias/10318_592.pdf	2026-03-14	2028-03-13
2797	10318	99	593	f	Media	\N	2024-12-14	2025-12-14
2798	10318	99	593	f	Baja	\N	2025-03-15	2026-03-15
2799	10318	99	594	t	Alta	/evidencias/10318_594.pdf	2025-02-07	2026-02-07
2800	10319	69	404	t	Alta	/evidencias/10319_404.pdf	2025-10-29	2027-10-29
2801	10319	69	404	f	Alta	\N	2025-08-11	2026-08-11
2802	10319	69	405	t	Media	/evidencias/10319_405.pdf	2024-10-17	2026-10-17
2803	10319	69	406	t	Media	/evidencias/10319_406.pdf	2025-05-21	2027-05-21
2804	10319	69	407	t	Baja	/evidencias/10319_407.pdf	2026-02-19	2028-02-19
2805	10319	69	408	f	Media	\N	2024-04-24	2026-04-24
2806	10319	69	409	t	Baja	/evidencias/10319_409.pdf	2025-07-01	2026-07-01
2807	10320	9	52	t	Media	/evidencias/10320_52.pdf	2024-12-19	2025-12-19
2808	10320	9	52	t	Alta	/evidencias/10320_52.pdf	2023-06-20	2024-06-19
2809	10320	9	53	f	Baja	\N	2025-08-24	2027-08-24
2810	10320	9	54	t	Alta	/evidencias/10320_54.pdf	2025-03-08	2026-03-08
2811	10320	9	55	t	Alta	/evidencias/10320_55.pdf	2024-09-29	2025-09-29
2812	10320	9	56	t	Media	/evidencias/10320_56.pdf	2024-09-11	2025-09-11
2813	10320	9	56	t	Media	/evidencias/10320_56.pdf	2025-08-31	2026-08-31
2814	10320	9	57	f	Baja	\N	2025-09-21	2027-09-21
2815	10320	9	57	t	Alta	/evidencias/10320_57.pdf	2023-06-18	2024-06-17
2816	10320	9	58	f	Media	\N	2025-03-02	2027-03-02
2817	10320	9	58	t	Media	/evidencias/10320_58.pdf	2024-05-06	2026-05-06
2818	10321	1	1	t	Media	/evidencias/10321_1.pdf	2024-05-08	2026-05-08
2819	10321	1	2	f	Alta	\N	2025-12-18	2027-12-18
2820	10321	1	2	t	Media	/evidencias/10321_2.pdf	2025-09-17	2027-09-17
2821	10321	1	3	t	Alta	/evidencias/10321_3.pdf	2024-02-26	2025-02-25
2822	10321	1	4	f	Media	\N	2025-11-30	2027-11-30
2823	10321	1	5	f	Media	\N	2026-01-20	2028-01-20
2824	10321	1	5	t	Alta	/evidencias/10321_5.pdf	2026-02-12	2027-02-12
2825	10321	1	6	t	Media	/evidencias/10321_6.pdf	2025-08-13	2026-08-13
2826	10321	1	6	f	Media	\N	2025-10-27	2027-10-27
2827	10321	1	7	t	Alta	/evidencias/10321_7.pdf	2025-03-13	2026-03-13
2828	10321	1	7	t	Alta	/evidencias/10321_7.pdf	2025-03-26	2027-03-26
2829	10322	84	494	f	Baja	\N	2026-01-15	2027-01-15
2830	10322	84	495	f	Alta	\N	2025-11-12	2027-11-12
2831	10322	84	495	t	Media	/evidencias/10322_495.pdf	2024-04-22	2026-04-22
2832	10322	84	496	t	Alta	/evidencias/10322_496.pdf	2025-06-28	2027-06-28
2833	10322	84	496	t	Media	/evidencias/10322_496.pdf	2024-06-04	2026-06-04
2834	10322	84	497	t	Media	/evidencias/10322_497.pdf	2023-08-02	2025-08-01
2835	10322	84	497	t	Media	/evidencias/10322_497.pdf	2026-01-02	2027-01-02
2836	10322	84	498	t	Media	/evidencias/10322_498.pdf	2024-10-19	2025-10-19
2837	10322	84	498	t	Media	/evidencias/10322_498.pdf	2024-06-19	2026-06-19
2838	10323	128	763	t	Baja	/evidencias/10323_763.pdf	2025-08-08	2027-08-08
2839	10323	128	764	t	Alta	/evidencias/10323_764.pdf	2025-10-25	2026-10-25
2840	10323	128	765	t	Baja	/evidencias/10323_765.pdf	2024-07-07	2026-07-07
2841	10323	128	765	t	Media	/evidencias/10323_765.pdf	2023-07-26	2025-07-25
2842	10323	128	766	t	Media	/evidencias/10323_766.pdf	2025-10-11	2027-10-11
2843	10323	128	766	t	Alta	/evidencias/10323_766.pdf	2024-09-11	2026-09-11
2844	10323	128	767	t	Alta	/evidencias/10323_767.pdf	2025-01-26	2027-01-26
2845	10323	128	768	t	Media	/evidencias/10323_768.pdf	2026-04-18	2028-04-17
2846	10324	82	482	t	Media	/evidencias/10324_482.pdf	2024-06-18	2026-06-18
2847	10324	82	483	t	Alta	/evidencias/10324_483.pdf	2023-06-08	2024-06-07
2848	10324	82	483	t	Baja	/evidencias/10324_483.pdf	2024-01-24	2026-01-23
2849	10324	82	484	t	Alta	/evidencias/10324_484.pdf	2024-10-01	2026-10-01
2850	10324	82	484	t	Media	/evidencias/10324_484.pdf	2023-12-05	2025-12-04
2851	10324	82	485	f	Media	\N	2024-10-13	2026-10-13
2852	10324	82	486	t	Media	/evidencias/10324_486.pdf	2025-01-15	2027-01-15
2853	10324	82	487	t	Alta	/evidencias/10324_487.pdf	2025-04-05	2026-04-05
2854	10324	82	488	t	Media	/evidencias/10324_488.pdf	2025-07-18	2027-07-18
2855	10324	82	488	f	Alta	\N	2024-03-21	2025-03-21
2856	10325	139	829	f	Alta	\N	2024-04-26	2026-04-26
2857	10325	139	829	t	Media	/evidencias/10325_829.pdf	2025-07-06	2026-07-06
2858	10325	139	830	t	Alta	/evidencias/10325_830.pdf	2025-08-05	2027-08-05
2859	10325	139	831	t	Media	/evidencias/10325_831.pdf	2026-02-18	2027-02-18
2860	10325	139	831	t	Alta	/evidencias/10325_831.pdf	2025-08-18	2026-08-18
2861	10325	139	832	t	Baja	/evidencias/10325_832.pdf	2025-02-12	2027-02-12
2862	10325	139	833	f	Media	\N	2024-05-24	2025-05-24
2863	10325	139	834	t	Media	/evidencias/10325_834.pdf	2023-10-19	2025-10-18
2864	10325	139	835	f	Media	\N	2024-11-20	2026-11-20
2865	10326	143	855	f	Media	\N	2024-06-27	2026-06-27
2866	10326	143	855	t	Media	/evidencias/10326_855.pdf	2024-06-07	2026-06-07
2867	10326	143	856	f	Alta	\N	2025-01-04	2027-01-04
2868	10326	143	857	t	Media	/evidencias/10326_857.pdf	2023-12-16	2025-12-15
2869	10326	143	857	f	Alta	\N	2023-06-22	2024-06-21
2870	10326	143	858	f	Baja	\N	2024-08-07	2026-08-07
2871	10326	143	858	t	Baja	/evidencias/10326_858.pdf	2025-06-27	2026-06-27
2872	10326	143	859	f	Baja	\N	2024-01-26	2026-01-25
2873	10326	143	859	f	Baja	\N	2024-06-07	2026-06-07
2874	10328	30	166	f	Alta	\N	2024-05-23	2026-05-23
2875	10328	30	167	t	Baja	/evidencias/10328_167.pdf	2026-04-29	2027-04-29
2876	10328	30	167	t	Baja	/evidencias/10328_167.pdf	2024-08-21	2025-08-21
2877	10328	30	168	t	Media	/evidencias/10328_168.pdf	2026-05-26	2028-05-25
2878	10328	30	169	t	Baja	/evidencias/10328_169.pdf	2026-02-23	2027-02-23
2879	10328	30	170	t	Media	/evidencias/10328_170.pdf	2026-05-16	2028-05-15
2880	10328	30	171	t	Media	/evidencias/10328_171.pdf	2024-05-14	2025-05-14
2881	10328	30	172	t	Alta	/evidencias/10328_172.pdf	2024-04-20	2026-04-20
2882	10328	30	172	t	Alta	/evidencias/10328_172.pdf	2025-05-22	2027-05-22
2883	10329	38	215	t	Baja	/evidencias/10329_215.pdf	2025-03-11	2026-03-11
2884	10329	38	216	t	Media	/evidencias/10329_216.pdf	2026-04-03	2028-04-02
2885	10329	38	217	f	Media	\N	2025-01-01	2026-01-01
2886	10329	38	218	f	Media	\N	2023-10-05	2025-10-04
2887	10329	38	219	f	Media	\N	2025-07-29	2026-07-29
2888	10330	84	494	t	Media	/evidencias/10330_494.pdf	2026-05-17	2027-05-17
2889	10330	84	494	t	Media	/evidencias/10330_494.pdf	2025-02-22	2027-02-22
2890	10330	84	495	f	Alta	\N	2024-08-31	2026-08-31
2891	10330	84	496	f	Media	\N	2025-06-05	2026-06-05
2892	10330	84	496	t	Media	/evidencias/10330_496.pdf	2025-10-30	2026-10-30
2893	10330	84	497	f	Baja	\N	2024-07-20	2025-07-20
2894	10330	84	497	t	Alta	/evidencias/10330_497.pdf	2025-05-17	2026-05-17
2895	10330	84	498	f	Baja	\N	2024-04-18	2025-04-18
2896	10330	84	498	t	Alta	/evidencias/10330_498.pdf	2025-02-19	2027-02-19
2897	10331	3	14	f	Media	\N	2025-01-09	2026-01-09
2898	10331	3	14	t	Alta	/evidencias/10331_14.pdf	2026-03-21	2027-03-21
2899	10331	3	15	t	Media	/evidencias/10331_15.pdf	2025-11-03	2027-11-03
2900	10331	3	15	f	Alta	\N	2026-01-04	2027-01-04
2901	10331	3	16	t	Media	/evidencias/10331_16.pdf	2024-03-31	2025-03-31
2902	10331	3	17	t	Media	/evidencias/10331_17.pdf	2024-11-28	2025-11-28
2903	10331	3	17	t	Alta	/evidencias/10331_17.pdf	2025-01-12	2027-01-12
2904	10331	3	18	t	Baja	/evidencias/10331_18.pdf	2023-12-06	2025-12-05
2905	10331	3	19	f	Media	\N	2026-03-25	2028-03-24
2906	10331	3	20	t	Media	/evidencias/10331_20.pdf	2025-07-10	2026-07-10
2907	10331	3	21	t	Alta	/evidencias/10331_21.pdf	2023-10-28	2024-10-27
2908	10332	108	644	f	Alta	\N	2023-11-11	2024-11-10
2909	10332	108	645	f	Alta	\N	2024-02-24	2025-02-23
2910	10332	108	646	t	Media	/evidencias/10332_646.pdf	2023-11-03	2024-11-02
2911	10332	108	646	f	Media	\N	2025-08-27	2026-08-27
2912	10332	108	647	t	Media	/evidencias/10332_647.pdf	2025-07-01	2027-07-01
2913	10333	108	644	t	Media	/evidencias/10333_644.pdf	2023-10-19	2024-10-18
2914	10333	108	644	f	Alta	\N	2024-07-04	2026-07-04
2915	10333	108	645	t	Baja	/evidencias/10333_645.pdf	2023-12-18	2025-12-17
2916	10333	108	645	t	Media	/evidencias/10333_645.pdf	2026-04-28	2028-04-27
2917	10333	108	646	t	Baja	/evidencias/10333_646.pdf	2025-03-09	2026-03-09
2918	10333	108	646	t	Media	/evidencias/10333_646.pdf	2025-07-21	2027-07-21
2919	10333	108	647	t	Alta	/evidencias/10333_647.pdf	2024-11-14	2025-11-14
2920	10334	27	149	t	Media	/evidencias/10334_149.pdf	2024-06-09	2025-06-09
2921	10334	27	150	t	Media	/evidencias/10334_150.pdf	2024-03-29	2026-03-29
2922	10334	27	151	t	Media	/evidencias/10334_151.pdf	2024-11-12	2026-11-12
2923	10334	27	151	t	Media	/evidencias/10334_151.pdf	2026-03-06	2027-03-06
2924	10334	27	152	t	Alta	/evidencias/10334_152.pdf	2026-01-04	2027-01-04
2925	10334	27	153	t	Baja	/evidencias/10334_153.pdf	2026-02-11	2028-02-11
2926	10334	27	154	t	Alta	/evidencias/10334_154.pdf	2024-05-29	2026-05-29
2927	10334	27	155	t	Alta	/evidencias/10334_155.pdf	2025-01-31	2026-01-31
2928	10335	44	253	t	Media	/evidencias/10335_253.pdf	2025-05-22	2027-05-22
2929	10335	44	253	t	Alta	/evidencias/10335_253.pdf	2024-10-31	2025-10-31
2930	10335	44	254	t	Media	/evidencias/10335_254.pdf	2024-08-14	2025-08-14
2931	10335	44	255	f	Alta	\N	2023-10-30	2025-10-29
2932	10335	44	256	t	Alta	/evidencias/10335_256.pdf	2024-11-05	2026-11-05
2933	10335	44	256	f	Alta	\N	2024-05-09	2026-05-09
2934	10336	87	513	t	Media	/evidencias/10336_513.pdf	2025-10-26	2027-10-26
2935	10336	87	513	t	Alta	/evidencias/10336_513.pdf	2024-04-11	2025-04-11
2936	10336	87	514	t	Media	/evidencias/10336_514.pdf	2024-09-19	2025-09-19
2937	10336	87	514	t	Media	/evidencias/10336_514.pdf	2025-05-01	2027-05-01
2938	10336	87	515	f	Media	\N	2025-04-21	2026-04-21
2939	10336	87	516	t	Baja	/evidencias/10336_516.pdf	2026-01-04	2027-01-04
2940	10337	105	626	t	Media	/evidencias/10337_626.pdf	2025-02-02	2027-02-02
2941	10337	105	627	f	Media	\N	2024-07-05	2026-07-05
2942	10337	105	628	t	Media	/evidencias/10337_628.pdf	2025-09-08	2027-09-08
2943	10337	105	628	t	Baja	/evidencias/10337_628.pdf	2025-06-09	2027-06-09
2944	10337	105	629	t	Alta	/evidencias/10337_629.pdf	2023-08-29	2025-08-28
2945	10337	105	629	t	Media	/evidencias/10337_629.pdf	2023-09-04	2024-09-03
2946	10337	105	630	t	Alta	/evidencias/10337_630.pdf	2023-09-14	2024-09-13
2947	10337	105	631	f	Media	\N	2026-04-25	2027-04-25
2948	10337	105	631	t	Media	/evidencias/10337_631.pdf	2024-03-07	2025-03-07
2949	10338	89	524	t	Media	/evidencias/10338_524.pdf	2024-12-08	2026-12-08
2950	10338	89	524	t	Baja	/evidencias/10338_524.pdf	2023-08-14	2024-08-13
2951	10338	89	525	t	Baja	/evidencias/10338_525.pdf	2023-09-05	2024-09-04
2952	10338	89	526	f	Alta	\N	2025-09-19	2026-09-19
2953	10338	89	527	t	Alta	/evidencias/10338_527.pdf	2025-04-30	2026-04-30
2954	10338	89	527	t	Alta	/evidencias/10338_527.pdf	2025-10-01	2027-10-01
2955	10338	89	528	f	Alta	\N	2024-07-02	2026-07-02
2956	10338	89	528	t	Media	/evidencias/10338_528.pdf	2025-01-05	2027-01-05
2957	10338	89	529	t	Baja	/evidencias/10338_529.pdf	2025-10-15	2026-10-15
2958	10338	89	530	f	Media	\N	2026-02-18	2027-02-18
2959	10339	115	685	t	Media	/evidencias/10339_685.pdf	2023-11-16	2025-11-15
2960	10339	115	685	f	Alta	\N	2025-02-09	2026-02-09
2961	10339	115	686	t	Media	/evidencias/10339_686.pdf	2026-03-01	2028-02-29
2962	10339	115	686	t	Alta	/evidencias/10339_686.pdf	2025-07-10	2027-07-10
2963	10339	115	687	f	Alta	\N	2024-05-29	2025-05-29
2964	10339	115	688	t	Media	/evidencias/10339_688.pdf	2025-11-22	2026-11-22
2965	10339	115	688	f	Alta	\N	2024-08-24	2025-08-24
2966	10339	115	689	t	Baja	/evidencias/10339_689.pdf	2023-07-23	2024-07-22
2967	10339	115	689	t	Alta	/evidencias/10339_689.pdf	2023-07-06	2024-07-05
2968	10340	88	517	t	Baja	/evidencias/10340_517.pdf	2024-08-30	2025-08-30
2969	10340	88	518	f	Media	\N	2025-01-23	2027-01-23
2970	10340	88	518	f	Baja	\N	2024-03-14	2025-03-14
2971	10340	88	519	t	Media	/evidencias/10340_519.pdf	2026-03-02	2027-03-02
2972	10340	88	519	t	Alta	/evidencias/10340_519.pdf	2024-10-05	2026-10-05
2973	10340	88	520	f	Media	\N	2023-09-15	2024-09-14
2974	10340	88	521	t	Media	/evidencias/10340_521.pdf	2025-03-17	2026-03-17
2975	10340	88	521	t	Baja	/evidencias/10340_521.pdf	2026-04-18	2028-04-17
2976	10340	88	522	f	Alta	\N	2025-10-04	2027-10-04
2977	10340	88	522	f	Alta	\N	2023-08-14	2024-08-13
2978	10340	88	523	f	Alta	\N	2023-11-17	2024-11-16
2979	10341	124	740	t	Media	/evidencias/10341_740.pdf	2026-03-14	2028-03-13
2980	10341	124	741	f	Baja	\N	2025-11-29	2026-11-29
2981	10341	124	742	t	Baja	/evidencias/10341_742.pdf	2025-09-26	2027-09-26
2982	10341	124	742	t	Alta	/evidencias/10341_742.pdf	2023-07-08	2025-07-07
2983	10341	124	743	t	Alta	/evidencias/10341_743.pdf	2025-02-15	2027-02-15
2984	10341	124	744	t	Baja	/evidencias/10341_744.pdf	2024-06-12	2025-06-12
2985	10341	124	744	t	Alta	/evidencias/10341_744.pdf	2024-07-19	2025-07-19
2986	10341	124	745	f	Alta	\N	2023-08-26	2024-08-25
2987	10341	124	745	t	Media	/evidencias/10341_745.pdf	2026-02-06	2027-02-06
2988	10342	62	352	f	Baja	\N	2025-05-12	2027-05-12
2989	10342	62	353	t	Alta	/evidencias/10342_353.pdf	2024-02-17	2025-02-16
2990	10342	62	354	t	Alta	/evidencias/10342_354.pdf	2024-02-02	2025-02-01
2991	10342	62	354	t	Baja	/evidencias/10342_354.pdf	2025-03-15	2027-03-15
2992	10342	62	355	t	Alta	/evidencias/10342_355.pdf	2024-10-01	2025-10-01
2993	10342	62	356	t	Media	/evidencias/10342_356.pdf	2025-04-27	2026-04-27
2994	10342	62	356	t	Media	/evidencias/10342_356.pdf	2024-09-08	2026-09-08
2995	10342	62	357	t	Media	/evidencias/10342_357.pdf	2026-01-06	2027-01-06
2996	10342	62	358	f	Baja	\N	2023-09-04	2025-09-03
2997	10342	62	359	t	Alta	/evidencias/10342_359.pdf	2025-11-11	2026-11-11
2998	10342	62	359	t	Media	/evidencias/10342_359.pdf	2025-04-28	2027-04-28
2999	10343	120	711	t	Media	/evidencias/10343_711.pdf	2024-10-26	2025-10-26
3000	10343	120	711	t	Baja	/evidencias/10343_711.pdf	2023-08-25	2025-08-24
3001	10343	120	712	t	Media	/evidencias/10343_712.pdf	2026-01-27	2027-01-27
3002	10343	120	712	f	Alta	\N	2024-09-29	2026-09-29
3003	10343	120	713	t	Alta	/evidencias/10343_713.pdf	2023-07-06	2024-07-05
3004	10343	120	713	f	Baja	\N	2026-02-18	2028-02-18
3005	10343	120	714	f	Media	\N	2023-06-08	2025-06-07
3006	10343	120	715	t	Media	/evidencias/10343_715.pdf	2024-10-11	2026-10-11
3007	10343	120	715	t	Media	/evidencias/10343_715.pdf	2024-02-07	2026-02-06
3008	10343	120	716	t	Media	/evidencias/10343_716.pdf	2024-08-30	2026-08-30
3009	10343	120	716	f	Media	\N	2024-12-06	2025-12-06
3010	10345	141	844	f	Baja	\N	2024-04-25	2025-04-25
3011	10345	141	845	t	Alta	/evidencias/10345_845.pdf	2026-04-30	2027-04-30
3012	10345	141	846	t	Media	/evidencias/10345_846.pdf	2023-10-26	2025-10-25
3013	10345	141	847	f	Media	\N	2023-09-04	2025-09-03
3014	10345	141	847	t	Media	/evidencias/10345_847.pdf	2026-03-09	2028-03-08
3015	10346	73	432	f	Media	\N	2025-09-11	2026-09-11
3016	10346	73	433	f	Media	\N	2023-09-21	2024-09-20
3017	10346	73	433	f	Media	\N	2025-01-01	2027-01-01
3018	10346	73	434	t	Alta	/evidencias/10346_434.pdf	2023-09-04	2024-09-03
3019	10346	73	435	f	Baja	\N	2024-08-25	2026-08-25
3020	10346	73	436	t	Baja	/evidencias/10346_436.pdf	2023-12-03	2024-12-02
3021	10346	73	436	f	Media	\N	2024-09-02	2026-09-02
3022	10348	66	382	t	Alta	/evidencias/10348_382.pdf	2024-09-30	2026-09-30
3023	10348	66	382	t	Media	/evidencias/10348_382.pdf	2025-06-23	2027-06-23
3024	10348	66	383	t	Media	/evidencias/10348_383.pdf	2025-06-27	2026-06-27
3025	10348	66	384	t	Media	/evidencias/10348_384.pdf	2024-01-05	2026-01-04
3026	10348	66	384	t	Media	/evidencias/10348_384.pdf	2024-01-16	2026-01-15
3027	10348	66	385	t	Media	/evidencias/10348_385.pdf	2023-08-16	2025-08-15
3028	10348	66	386	f	Media	\N	2024-04-05	2026-04-05
3029	10348	66	387	t	Baja	/evidencias/10348_387.pdf	2024-01-23	2026-01-22
3030	10348	66	387	t	Baja	/evidencias/10348_387.pdf	2023-09-18	2025-09-17
3031	10349	55	321	t	Alta	/evidencias/10349_321.pdf	2025-04-26	2026-04-26
3032	10349	55	322	t	Media	/evidencias/10349_322.pdf	2024-10-23	2026-10-23
3033	10349	55	323	f	Media	\N	2025-07-11	2027-07-11
3034	10349	55	323	t	Alta	/evidencias/10349_323.pdf	2023-07-02	2024-07-01
3035	10349	55	324	t	Alta	/evidencias/10349_324.pdf	2024-07-16	2026-07-16
3036	10350	80	469	f	Baja	\N	2026-01-02	2028-01-02
3037	10350	80	469	t	Alta	/evidencias/10350_469.pdf	2023-08-26	2024-08-25
3038	10350	80	470	t	Baja	/evidencias/10350_470.pdf	2025-04-30	2027-04-30
3039	10350	80	471	f	Media	\N	2025-11-03	2026-11-03
3040	10350	80	471	t	Media	/evidencias/10350_471.pdf	2023-09-02	2024-09-01
3041	10350	80	472	t	Media	/evidencias/10350_472.pdf	2024-11-17	2025-11-17
3042	10350	80	473	f	Media	\N	2025-06-16	2026-06-16
3043	10350	80	474	f	Media	\N	2026-03-30	2028-03-29
3044	10351	130	777	t	Media	/evidencias/10351_777.pdf	2025-12-12	2027-12-12
3045	10351	130	777	t	Media	/evidencias/10351_777.pdf	2025-09-02	2026-09-02
3046	10351	130	778	t	Baja	/evidencias/10351_778.pdf	2024-03-09	2025-03-09
3047	10351	130	779	f	Alta	\N	2025-09-13	2027-09-13
3048	10351	130	780	f	Alta	\N	2025-03-24	2026-03-24
3049	10351	130	780	t	Media	/evidencias/10351_780.pdf	2024-03-05	2025-03-05
3050	10352	52	303	t	Media	/evidencias/10352_303.pdf	2026-04-16	2028-04-15
3051	10352	52	304	t	Baja	/evidencias/10352_304.pdf	2026-01-02	2027-01-02
3052	10352	52	305	t	Alta	/evidencias/10352_305.pdf	2024-04-01	2025-04-01
3053	10352	52	305	t	Media	/evidencias/10352_305.pdf	2024-11-09	2026-11-09
3054	10352	52	306	t	Alta	/evidencias/10352_306.pdf	2025-08-27	2026-08-27
3055	10352	52	306	t	Alta	/evidencias/10352_306.pdf	2024-05-25	2025-05-25
3056	10352	52	307	t	Media	/evidencias/10352_307.pdf	2025-07-12	2026-07-12
3057	10352	52	308	t	Media	/evidencias/10352_308.pdf	2025-02-19	2027-02-19
3058	10352	52	308	t	Alta	/evidencias/10352_308.pdf	2024-02-25	2025-02-24
3059	10352	52	309	t	Media	/evidencias/10352_309.pdf	2024-03-08	2025-03-08
3060	10352	52	310	t	Media	/evidencias/10352_310.pdf	2023-06-11	2025-06-10
3061	10352	52	310	t	Alta	/evidencias/10352_310.pdf	2025-12-19	2027-12-19
3062	10353	128	763	t	Media	/evidencias/10353_763.pdf	2025-11-07	2027-11-07
3063	10353	128	763	t	Alta	/evidencias/10353_763.pdf	2024-09-05	2025-09-05
3064	10353	128	764	t	Media	/evidencias/10353_764.pdf	2024-04-02	2026-04-02
3065	10353	128	765	f	Media	\N	2024-08-14	2025-08-14
3066	10353	128	765	t	Alta	/evidencias/10353_765.pdf	2026-01-13	2027-01-13
3067	10353	128	766	t	Media	/evidencias/10353_766.pdf	2026-01-01	2028-01-01
3068	10353	128	766	t	Alta	/evidencias/10353_766.pdf	2024-10-10	2025-10-10
3069	10353	128	767	t	Baja	/evidencias/10353_767.pdf	2024-11-01	2026-11-01
3070	10353	128	768	f	Media	\N	2023-08-19	2024-08-18
3071	10354	110	654	t	Alta	/evidencias/10354_654.pdf	2025-05-13	2026-05-13
3072	10354	110	654	t	Alta	/evidencias/10354_654.pdf	2023-08-23	2024-08-22
3073	10354	110	655	f	Baja	\N	2025-10-31	2027-10-31
3074	10354	110	656	f	Media	\N	2026-01-18	2028-01-18
3075	10354	110	657	t	Alta	/evidencias/10354_657.pdf	2025-07-27	2027-07-27
3076	10354	110	658	t	Baja	/evidencias/10354_658.pdf	2023-12-29	2025-12-28
3077	10354	110	658	t	Media	/evidencias/10354_658.pdf	2026-04-19	2027-04-19
3078	10355	11	67	f	Media	\N	2025-02-04	2027-02-04
3079	10355	11	68	t	Media	/evidencias/10355_68.pdf	2023-09-14	2025-09-13
3080	10355	11	68	f	Media	\N	2024-06-12	2026-06-12
3081	10355	11	69	t	Alta	/evidencias/10355_69.pdf	2024-07-14	2026-07-14
3082	10355	11	69	t	Alta	/evidencias/10355_69.pdf	2026-05-28	2027-05-28
3083	10355	11	70	t	Media	/evidencias/10355_70.pdf	2025-08-13	2026-08-13
3084	10356	100	595	t	Media	/evidencias/10356_595.pdf	2025-08-15	2026-08-15
3085	10356	100	595	f	Media	\N	2025-01-19	2027-01-19
3086	10356	100	596	t	Alta	/evidencias/10356_596.pdf	2024-12-27	2025-12-27
3087	10356	100	597	t	Media	/evidencias/10356_597.pdf	2025-06-18	2026-06-18
3088	10356	100	597	t	Baja	/evidencias/10356_597.pdf	2024-03-13	2026-03-13
3089	10356	100	598	t	Alta	/evidencias/10356_598.pdf	2026-04-22	2028-04-21
3090	10356	100	598	t	Media	/evidencias/10356_598.pdf	2026-05-04	2028-05-03
3091	10356	100	599	t	Media	/evidencias/10356_599.pdf	2024-07-25	2026-07-25
3092	10356	100	600	f	Alta	\N	2026-02-21	2027-02-21
3093	10356	100	600	t	Media	/evidencias/10356_600.pdf	2025-05-29	2027-05-29
3094	10356	100	601	t	Media	/evidencias/10356_601.pdf	2025-11-24	2026-11-24
3095	10356	100	602	f	Baja	\N	2023-09-24	2025-09-23
3096	10357	110	654	t	Media	/evidencias/10357_654.pdf	2026-04-17	2028-04-16
3097	10357	110	655	t	Media	/evidencias/10357_655.pdf	2023-12-31	2024-12-30
3098	10357	110	655	t	Media	/evidencias/10357_655.pdf	2026-02-02	2028-02-02
3099	10357	110	656	f	Alta	\N	2023-09-09	2025-09-08
3100	10357	110	657	t	Baja	/evidencias/10357_657.pdf	2024-04-18	2026-04-18
3101	10357	110	658	t	Baja	/evidencias/10357_658.pdf	2025-05-23	2026-05-23
3102	10357	110	658	t	Baja	/evidencias/10357_658.pdf	2025-03-07	2026-03-07
3103	10358	124	740	f	Media	\N	2023-10-30	2024-10-29
3104	10358	124	740	t	Media	/evidencias/10358_740.pdf	2026-03-18	2027-03-18
3105	10358	124	741	t	Alta	/evidencias/10358_741.pdf	2023-11-11	2025-11-10
3106	10358	124	742	t	Media	/evidencias/10358_742.pdf	2023-06-21	2024-06-20
3107	10358	124	743	f	Alta	\N	2024-03-26	2026-03-26
3108	10358	124	744	t	Alta	/evidencias/10358_744.pdf	2025-11-02	2027-11-02
3109	10358	124	744	f	Media	\N	2025-04-12	2026-04-12
3110	10358	124	745	t	Alta	/evidencias/10358_745.pdf	2024-04-22	2026-04-22
3111	10359	146	872	t	Baja	/evidencias/10359_872.pdf	2023-07-22	2024-07-21
3112	10359	146	872	t	Alta	/evidencias/10359_872.pdf	2023-09-01	2024-08-31
3113	10359	146	873	t	Media	/evidencias/10359_873.pdf	2024-01-16	2025-01-15
3114	10359	146	873	t	Baja	/evidencias/10359_873.pdf	2025-12-11	2027-12-11
3115	10359	146	874	t	Media	/evidencias/10359_874.pdf	2025-06-17	2027-06-17
3116	10359	146	875	t	Baja	/evidencias/10359_875.pdf	2025-04-02	2026-04-02
3117	10359	146	876	t	Media	/evidencias/10359_876.pdf	2026-03-22	2028-03-21
3118	10359	146	876	f	Alta	\N	2025-12-01	2027-12-01
3119	10360	145	867	t	Media	/evidencias/10360_867.pdf	2025-08-21	2027-08-21
3120	10360	145	867	t	Alta	/evidencias/10360_867.pdf	2023-08-21	2025-08-20
3121	10360	145	868	f	Alta	\N	2024-09-30	2025-09-30
3122	10360	145	869	f	Media	\N	2025-05-22	2026-05-22
3123	10360	145	869	t	Baja	/evidencias/10360_869.pdf	2024-04-16	2025-04-16
3124	10360	145	870	t	Baja	/evidencias/10360_870.pdf	2025-07-22	2027-07-22
3125	10360	145	870	f	Alta	\N	2025-10-03	2026-10-03
3126	10360	145	871	f	Baja	\N	2023-10-26	2024-10-25
3127	10360	145	871	t	Alta	/evidencias/10360_871.pdf	2026-04-20	2028-04-19
3128	10361	3	14	t	Media	/evidencias/10361_14.pdf	2025-04-29	2026-04-29
3129	10361	3	14	t	Baja	/evidencias/10361_14.pdf	2023-09-04	2025-09-03
3130	10361	3	15	f	Baja	\N	2025-09-10	2027-09-10
3131	10361	3	16	t	Baja	/evidencias/10361_16.pdf	2024-01-01	2025-12-31
3132	10361	3	16	t	Alta	/evidencias/10361_16.pdf	2023-10-01	2024-09-30
3133	10361	3	17	t	Baja	/evidencias/10361_17.pdf	2024-11-07	2026-11-07
3134	10361	3	18	t	Media	/evidencias/10361_18.pdf	2023-12-21	2025-12-20
3135	10361	3	18	t	Media	/evidencias/10361_18.pdf	2024-03-05	2026-03-05
3136	10361	3	19	t	Baja	/evidencias/10361_19.pdf	2023-08-18	2024-08-17
3137	10361	3	19	t	Media	/evidencias/10361_19.pdf	2024-02-28	2026-02-27
3138	10361	3	20	f	Media	\N	2024-03-16	2025-03-16
3139	10361	3	21	t	Baja	/evidencias/10361_21.pdf	2025-02-17	2027-02-17
3140	10361	3	21	t	Alta	/evidencias/10361_21.pdf	2026-01-15	2028-01-15
3141	10362	141	844	f	Alta	\N	2024-03-22	2025-03-22
3142	10362	141	845	f	Alta	\N	2025-04-22	2027-04-22
3143	10362	141	845	t	Alta	/evidencias/10362_845.pdf	2025-01-17	2027-01-17
3144	10362	141	846	t	Media	/evidencias/10362_846.pdf	2025-05-17	2026-05-17
3145	10362	141	847	f	Media	\N	2024-03-17	2025-03-17
3146	10363	89	524	f	Baja	\N	2026-03-02	2027-03-02
3147	10363	89	525	t	Alta	/evidencias/10363_525.pdf	2024-06-06	2026-06-06
3148	10363	89	526	t	Media	/evidencias/10363_526.pdf	2025-10-10	2027-10-10
3149	10363	89	526	t	Media	/evidencias/10363_526.pdf	2025-09-09	2026-09-09
3150	10363	89	527	t	Alta	/evidencias/10363_527.pdf	2024-08-17	2025-08-17
3151	10363	89	528	t	Alta	/evidencias/10363_528.pdf	2024-03-05	2025-03-05
3152	10363	89	528	t	Baja	/evidencias/10363_528.pdf	2023-09-10	2024-09-09
3153	10363	89	529	t	Alta	/evidencias/10363_529.pdf	2025-04-09	2027-04-09
3154	10363	89	529	t	Baja	/evidencias/10363_529.pdf	2025-11-05	2026-11-05
3155	10363	89	530	t	Media	/evidencias/10363_530.pdf	2023-09-30	2024-09-29
3156	10364	65	374	t	Media	/evidencias/10364_374.pdf	2025-08-15	2027-08-15
3157	10364	65	374	t	Baja	/evidencias/10364_374.pdf	2024-02-18	2026-02-17
3158	10364	65	375	t	Baja	/evidencias/10364_375.pdf	2024-09-12	2025-09-12
3159	10364	65	375	t	Media	/evidencias/10364_375.pdf	2024-03-08	2026-03-08
3160	10364	65	376	f	Alta	\N	2025-02-08	2026-02-08
3161	10364	65	377	t	Media	/evidencias/10364_377.pdf	2024-08-22	2026-08-22
3162	10364	65	378	t	Alta	/evidencias/10364_378.pdf	2025-09-20	2027-09-20
3163	10364	65	379	t	Baja	/evidencias/10364_379.pdf	2025-03-31	2027-03-31
3164	10364	65	380	t	Baja	/evidencias/10364_380.pdf	2024-03-29	2026-03-29
3165	10364	65	381	t	Baja	/evidencias/10364_381.pdf	2024-04-29	2026-04-29
3166	10364	65	381	t	Media	/evidencias/10364_381.pdf	2025-04-16	2027-04-16
3167	10365	12	71	f	Media	\N	2024-11-07	2026-11-07
3168	10365	12	72	t	Media	/evidencias/10365_72.pdf	2026-04-03	2027-04-03
3169	10365	12	73	t	Alta	/evidencias/10365_73.pdf	2025-09-12	2027-09-12
3170	10365	12	73	t	Baja	/evidencias/10365_73.pdf	2023-06-17	2025-06-16
3171	10365	12	74	f	Baja	\N	2025-04-30	2027-04-30
3172	10365	12	74	t	Baja	/evidencias/10365_74.pdf	2025-03-23	2026-03-23
3173	10365	12	75	f	Alta	\N	2025-03-17	2026-03-17
3174	10365	12	75	f	Media	\N	2023-10-08	2025-10-07
3175	10365	12	76	t	Media	/evidencias/10365_76.pdf	2025-09-12	2026-09-12
3176	10366	29	162	t	Baja	/evidencias/10366_162.pdf	2023-06-09	2024-06-08
3177	10366	29	162	t	Baja	/evidencias/10366_162.pdf	2024-04-11	2026-04-11
3178	10366	29	163	t	Media	/evidencias/10366_163.pdf	2025-08-02	2027-08-02
3179	10366	29	163	t	Alta	/evidencias/10366_163.pdf	2025-03-03	2027-03-03
3180	10366	29	164	t	Media	/evidencias/10366_164.pdf	2024-10-07	2026-10-07
3181	10366	29	165	t	Alta	/evidencias/10366_165.pdf	2025-11-27	2027-11-27
3182	10368	148	882	t	Alta	/evidencias/10368_882.pdf	2026-02-09	2028-02-09
3183	10368	148	882	t	Baja	/evidencias/10368_882.pdf	2024-08-20	2025-08-20
3184	10368	148	883	t	Media	/evidencias/10368_883.pdf	2024-07-15	2025-07-15
3185	10368	148	883	t	Baja	/evidencias/10368_883.pdf	2025-04-18	2027-04-18
3186	10368	148	884	f	Media	\N	2024-06-18	2026-06-18
3187	10368	148	885	t	Media	/evidencias/10368_885.pdf	2026-01-22	2028-01-22
3188	10368	148	885	t	Baja	/evidencias/10368_885.pdf	2025-07-21	2027-07-21
3189	10368	148	886	t	Baja	/evidencias/10368_886.pdf	2025-04-07	2027-04-07
3190	10368	148	887	t	Media	/evidencias/10368_887.pdf	2024-06-13	2025-06-13
3191	10368	148	888	t	Alta	/evidencias/10368_888.pdf	2024-09-16	2025-09-16
3192	10369	35	201	f	Baja	\N	2023-06-17	2025-06-16
3193	10369	35	201	t	Media	/evidencias/10369_201.pdf	2024-03-24	2026-03-24
3194	10369	35	202	f	Media	\N	2026-05-24	2028-05-23
3195	10369	35	203	t	Media	/evidencias/10369_203.pdf	2023-07-07	2024-07-06
3196	10369	35	204	t	Alta	/evidencias/10369_204.pdf	2024-07-25	2025-07-25
3197	10369	35	205	f	Baja	\N	2023-10-25	2024-10-24
3198	10370	115	685	t	Media	/evidencias/10370_685.pdf	2025-01-15	2027-01-15
3199	10370	115	685	f	Baja	\N	2025-08-18	2026-08-18
3200	10370	115	686	t	Alta	/evidencias/10370_686.pdf	2026-05-29	2028-05-28
3201	10370	115	686	t	Media	/evidencias/10370_686.pdf	2024-01-07	2025-01-06
3202	10370	115	687	f	Alta	\N	2024-09-12	2026-09-12
3203	10370	115	687	t	Baja	/evidencias/10370_687.pdf	2024-09-30	2025-09-30
3204	10370	115	688	t	Media	/evidencias/10370_688.pdf	2023-08-15	2025-08-14
3205	10370	115	688	t	Media	/evidencias/10370_688.pdf	2023-10-19	2024-10-18
3206	10370	115	689	t	Baja	/evidencias/10370_689.pdf	2025-09-07	2027-09-07
3207	10370	115	689	f	Alta	\N	2025-11-29	2026-11-29
3208	10371	87	513	f	Baja	\N	2024-03-21	2025-03-21
3209	10371	87	514	t	Baja	/evidencias/10371_514.pdf	2023-12-08	2024-12-07
3210	10371	87	515	f	Alta	\N	2025-12-12	2026-12-12
3211	10371	87	515	t	Baja	/evidencias/10371_515.pdf	2023-06-03	2024-06-02
3212	10371	87	516	t	Alta	/evidencias/10371_516.pdf	2026-03-28	2028-03-27
3213	10372	68	396	t	Alta	/evidencias/10372_396.pdf	2025-08-11	2027-08-11
3214	10372	68	396	t	Media	/evidencias/10372_396.pdf	2025-10-10	2027-10-10
3215	10372	68	397	f	Media	\N	2025-01-27	2027-01-27
3216	10372	68	397	t	Alta	/evidencias/10372_397.pdf	2023-09-02	2025-09-01
3217	10372	68	398	t	Alta	/evidencias/10372_398.pdf	2023-10-07	2025-10-06
3218	10372	68	398	t	Media	/evidencias/10372_398.pdf	2023-10-25	2024-10-24
3219	10372	68	399	t	Media	/evidencias/10372_399.pdf	2026-04-13	2028-04-12
3220	10372	68	399	f	Baja	\N	2024-05-17	2025-05-17
3221	10372	68	400	f	Media	\N	2024-04-20	2026-04-20
3222	10372	68	400	t	Media	/evidencias/10372_400.pdf	2026-03-30	2027-03-30
3223	10372	68	401	t	Baja	/evidencias/10372_401.pdf	2024-04-30	2026-04-30
3224	10372	68	402	t	Media	/evidencias/10372_402.pdf	2024-06-11	2025-06-11
3225	10372	68	403	t	Alta	/evidencias/10372_403.pdf	2025-10-14	2026-10-14
3226	10373	7	40	t	Alta	/evidencias/10373_40.pdf	2024-11-07	2026-11-07
3227	10373	7	40	t	Media	/evidencias/10373_40.pdf	2024-05-21	2025-05-21
3228	10373	7	41	t	Alta	/evidencias/10373_41.pdf	2026-02-25	2028-02-25
3229	10373	7	42	t	Media	/evidencias/10373_42.pdf	2026-05-15	2027-05-15
3230	10373	7	42	f	Media	\N	2024-02-06	2025-02-05
3231	10373	7	43	t	Baja	/evidencias/10373_43.pdf	2024-02-10	2025-02-09
3232	10373	7	44	f	Baja	\N	2026-04-03	2028-04-02
3233	10373	7	44	f	Media	\N	2024-11-03	2025-11-03
3234	10373	7	45	t	Baja	/evidencias/10373_45.pdf	2025-02-22	2027-02-22
3235	10374	113	670	f	Alta	\N	2023-11-15	2024-11-14
3236	10374	113	670	t	Media	/evidencias/10374_670.pdf	2025-05-17	2026-05-17
3237	10374	113	671	t	Media	/evidencias/10374_671.pdf	2026-03-19	2027-03-19
3238	10374	113	672	t	Baja	/evidencias/10374_672.pdf	2023-12-24	2024-12-23
3239	10374	113	673	t	Media	/evidencias/10374_673.pdf	2023-09-29	2025-09-28
3240	10374	113	673	t	Media	/evidencias/10374_673.pdf	2025-02-22	2027-02-22
3241	10374	113	674	t	Media	/evidencias/10374_674.pdf	2025-10-28	2027-10-28
3242	10374	113	675	t	Alta	/evidencias/10374_675.pdf	2023-06-12	2025-06-11
3243	10374	113	676	t	Alta	/evidencias/10374_676.pdf	2025-11-19	2026-11-19
3244	10374	113	677	t	Media	/evidencias/10374_677.pdf	2025-04-20	2027-04-20
3245	10374	113	677	t	Alta	/evidencias/10374_677.pdf	2025-03-03	2027-03-03
3246	10375	114	678	t	Media	/evidencias/10375_678.pdf	2023-07-19	2024-07-18
3247	10375	114	679	f	Baja	\N	2023-11-17	2025-11-16
3248	10375	114	680	t	Media	/evidencias/10375_680.pdf	2024-04-04	2025-04-04
3249	10375	114	681	t	Media	/evidencias/10375_681.pdf	2025-08-28	2026-08-28
3250	10375	114	681	t	Alta	/evidencias/10375_681.pdf	2023-09-11	2024-09-10
3251	10375	114	682	f	Media	\N	2025-07-06	2026-07-06
3252	10375	114	682	f	Alta	\N	2023-12-01	2024-11-30
3253	10375	114	683	t	Baja	/evidencias/10375_683.pdf	2024-01-16	2026-01-15
3254	10375	114	683	t	Media	/evidencias/10375_683.pdf	2025-05-16	2026-05-16
3255	10375	114	684	t	Alta	/evidencias/10375_684.pdf	2026-02-01	2028-02-01
3256	10375	114	684	t	Media	/evidencias/10375_684.pdf	2024-06-12	2025-06-12
3257	10376	99	589	f	Baja	\N	2025-07-11	2026-07-11
3258	10376	99	590	t	Media	/evidencias/10376_590.pdf	2025-05-05	2026-05-05
3259	10376	99	590	f	Alta	\N	2025-11-27	2027-11-27
3260	10376	99	591	t	Media	/evidencias/10376_591.pdf	2025-04-06	2027-04-06
3261	10376	99	591	f	Media	\N	2024-01-31	2025-01-30
3262	10376	99	592	f	Media	\N	2025-12-24	2026-12-24
3263	10376	99	592	t	Media	/evidencias/10376_592.pdf	2026-02-28	2027-02-28
3264	10376	99	593	f	Baja	\N	2025-07-08	2026-07-08
3265	10376	99	593	t	Media	/evidencias/10376_593.pdf	2025-03-10	2026-03-10
3266	10376	99	594	f	Media	\N	2025-07-06	2027-07-06
3267	10377	130	777	t	Alta	/evidencias/10377_777.pdf	2024-05-11	2025-05-11
3268	10377	130	778	t	Media	/evidencias/10377_778.pdf	2024-12-13	2026-12-13
3269	10377	130	779	t	Media	/evidencias/10377_779.pdf	2023-08-16	2024-08-15
3270	10377	130	780	t	Alta	/evidencias/10377_780.pdf	2024-04-14	2026-04-14
3271	10377	130	780	t	Media	/evidencias/10377_780.pdf	2023-08-28	2025-08-27
3272	10379	126	753	t	Media	/evidencias/10379_753.pdf	2024-02-07	2025-02-06
3273	10379	126	754	t	Media	/evidencias/10379_754.pdf	2025-12-08	2026-12-08
3274	10379	126	754	t	Alta	/evidencias/10379_754.pdf	2023-06-15	2025-06-14
3275	10379	126	755	t	Media	/evidencias/10379_755.pdf	2025-06-22	2027-06-22
3276	10379	126	756	t	Media	/evidencias/10379_756.pdf	2024-12-18	2026-12-18
3277	10379	126	756	f	Media	\N	2024-12-21	2026-12-21
3278	10380	22	125	t	Media	/evidencias/10380_125.pdf	2025-09-08	2026-09-08
3279	10380	22	126	t	Media	/evidencias/10380_126.pdf	2024-11-21	2026-11-21
3280	10380	22	126	f	Alta	\N	2025-07-20	2026-07-20
3281	10380	22	127	t	Media	/evidencias/10380_127.pdf	2026-04-05	2027-04-05
3282	10380	22	127	t	Media	/evidencias/10380_127.pdf	2025-10-07	2027-10-07
3283	10380	22	128	t	Alta	/evidencias/10380_128.pdf	2024-08-12	2026-08-12
3284	10380	22	129	t	Alta	/evidencias/10380_129.pdf	2024-03-01	2025-03-01
3285	10380	22	129	t	Alta	/evidencias/10380_129.pdf	2024-08-22	2026-08-22
3286	10381	52	303	f	Alta	\N	2026-02-17	2027-02-17
3287	10381	52	304	t	Baja	/evidencias/10381_304.pdf	2023-07-20	2025-07-19
3288	10381	52	304	t	Media	/evidencias/10381_304.pdf	2023-09-09	2025-09-08
3289	10381	52	305	f	Media	\N	2025-11-06	2027-11-06
3290	10381	52	305	t	Alta	/evidencias/10381_305.pdf	2025-10-31	2027-10-31
3291	10381	52	306	t	Alta	/evidencias/10381_306.pdf	2025-08-10	2026-08-10
3292	10381	52	306	t	Media	/evidencias/10381_306.pdf	2025-09-11	2027-09-11
3293	10381	52	307	t	Alta	/evidencias/10381_307.pdf	2025-01-28	2027-01-28
3294	10381	52	307	f	Media	\N	2024-11-06	2025-11-06
3295	10381	52	308	t	Baja	/evidencias/10381_308.pdf	2023-10-31	2024-10-30
3296	10381	52	309	t	Alta	/evidencias/10381_309.pdf	2025-10-04	2026-10-04
3297	10381	52	310	t	Media	/evidencias/10381_310.pdf	2024-06-02	2026-06-02
3298	10382	128	763	t	Alta	/evidencias/10382_763.pdf	2025-09-09	2026-09-09
3299	10382	128	763	t	Media	/evidencias/10382_763.pdf	2025-02-28	2026-02-28
3300	10382	128	764	f	Alta	\N	2026-01-28	2028-01-28
3301	10382	128	764	t	Media	/evidencias/10382_764.pdf	2026-05-03	2028-05-02
3302	10382	128	765	t	Media	/evidencias/10382_765.pdf	2025-07-10	2026-07-10
3303	10382	128	765	t	Media	/evidencias/10382_765.pdf	2025-07-23	2026-07-23
3304	10382	128	766	t	Alta	/evidencias/10382_766.pdf	2024-02-01	2025-01-31
3305	10382	128	767	f	Media	\N	2026-05-27	2027-05-27
3306	10382	128	767	t	Media	/evidencias/10382_767.pdf	2024-08-24	2025-08-24
3307	10382	128	768	t	Media	/evidencias/10382_768.pdf	2024-09-13	2025-09-13
3308	10383	137	821	f	Media	\N	2025-12-22	2026-12-22
3309	10383	137	822	t	Media	/evidencias/10383_822.pdf	2023-06-12	2025-06-11
3310	10383	137	822	t	Alta	/evidencias/10383_822.pdf	2025-08-29	2027-08-29
3311	10383	137	823	t	Baja	/evidencias/10383_823.pdf	2025-12-16	2027-12-16
3312	10383	137	823	f	Media	\N	2023-12-09	2024-12-08
3313	10383	137	824	t	Alta	/evidencias/10383_824.pdf	2024-10-18	2025-10-18
3314	10384	52	303	t	Alta	/evidencias/10384_303.pdf	2024-12-15	2026-12-15
3315	10384	52	304	t	Alta	/evidencias/10384_304.pdf	2024-03-06	2025-03-06
3316	10384	52	305	f	Media	\N	2023-09-14	2024-09-13
3317	10384	52	305	t	Baja	/evidencias/10384_305.pdf	2025-08-13	2026-08-13
3318	10384	52	306	t	Baja	/evidencias/10384_306.pdf	2026-05-17	2027-05-17
3319	10384	52	307	t	Media	/evidencias/10384_307.pdf	2023-09-01	2025-08-31
3320	10384	52	308	t	Alta	/evidencias/10384_308.pdf	2026-01-20	2028-01-20
3321	10384	52	308	t	Media	/evidencias/10384_308.pdf	2023-10-22	2025-10-21
3322	10384	52	309	f	Baja	\N	2023-10-03	2024-10-02
3323	10384	52	309	t	Baja	/evidencias/10384_309.pdf	2023-10-30	2025-10-29
3324	10384	52	310	t	Baja	/evidencias/10384_310.pdf	2024-07-28	2025-07-28
3325	10384	52	310	t	Alta	/evidencias/10384_310.pdf	2025-04-04	2026-04-04
3326	10385	51	295	t	Baja	/evidencias/10385_295.pdf	2023-11-09	2024-11-08
3327	10385	51	296	f	Alta	\N	2024-03-22	2025-03-22
3328	10385	51	296	t	Baja	/evidencias/10385_296.pdf	2023-10-25	2024-10-24
3329	10385	51	297	t	Alta	/evidencias/10385_297.pdf	2025-08-04	2026-08-04
3330	10385	51	297	t	Media	/evidencias/10385_297.pdf	2025-06-04	2027-06-04
3331	10385	51	298	f	Media	\N	2025-10-12	2027-10-12
3332	10385	51	298	t	Media	/evidencias/10385_298.pdf	2026-04-05	2028-04-04
3333	10385	51	299	f	Media	\N	2024-09-20	2025-09-20
3334	10385	51	299	t	Baja	/evidencias/10385_299.pdf	2024-08-29	2026-08-29
3335	10385	51	300	t	Alta	/evidencias/10385_300.pdf	2025-04-29	2026-04-29
3336	10385	51	300	f	Baja	\N	2025-10-06	2027-10-06
3337	10385	51	301	t	Alta	/evidencias/10385_301.pdf	2024-05-05	2026-05-05
3338	10385	51	302	t	Baja	/evidencias/10385_302.pdf	2025-12-31	2026-12-31
3339	10385	51	302	t	Alta	/evidencias/10385_302.pdf	2024-05-25	2025-05-25
3340	10386	22	125	t	Baja	/evidencias/10386_125.pdf	2024-09-07	2026-09-07
3341	10386	22	126	f	Baja	\N	2025-06-12	2026-06-12
3342	10386	22	126	t	Media	/evidencias/10386_126.pdf	2025-06-05	2026-06-05
3343	10386	22	127	f	Alta	\N	2025-06-19	2026-06-19
3344	10386	22	128	t	Media	/evidencias/10386_128.pdf	2025-05-20	2026-05-20
3345	10386	22	129	f	Baja	\N	2024-03-23	2025-03-23
3346	10386	22	129	f	Media	\N	2023-10-31	2025-10-30
3347	10387	38	215	f	Baja	\N	2023-07-30	2025-07-29
3348	10387	38	215	t	Media	/evidencias/10387_215.pdf	2024-06-19	2025-06-19
3349	10387	38	216	t	Alta	/evidencias/10387_216.pdf	2025-06-08	2027-06-08
3350	10387	38	217	t	Baja	/evidencias/10387_217.pdf	2024-11-02	2025-11-02
3351	10387	38	217	f	Media	\N	2025-05-24	2027-05-24
3352	10387	38	218	t	Alta	/evidencias/10387_218.pdf	2023-12-01	2024-11-30
3353	10387	38	219	t	Media	/evidencias/10387_219.pdf	2024-09-14	2025-09-14
3354	10388	39	220	t	Media	/evidencias/10388_220.pdf	2023-09-28	2024-09-27
3355	10388	39	221	f	Media	\N	2026-01-15	2028-01-15
3356	10388	39	222	t	Media	/evidencias/10388_222.pdf	2026-03-30	2028-03-29
3357	10388	39	223	t	Alta	/evidencias/10388_223.pdf	2024-09-09	2025-09-09
3358	10388	39	224	f	Baja	\N	2023-06-13	2025-06-12
3359	10388	39	224	t	Media	/evidencias/10388_224.pdf	2026-04-03	2028-04-02
3360	10388	39	225	f	Media	\N	2026-03-28	2027-03-28
3361	10388	39	225	t	Alta	/evidencias/10388_225.pdf	2023-10-27	2024-10-26
3362	10389	23	130	t	Alta	/evidencias/10389_130.pdf	2025-04-22	2027-04-22
3363	10389	23	130	f	Baja	\N	2026-05-13	2027-05-13
3364	10389	23	131	t	Baja	/evidencias/10389_131.pdf	2024-03-30	2026-03-30
3365	10389	23	131	t	Alta	/evidencias/10389_131.pdf	2026-05-16	2028-05-15
3366	10389	23	132	t	Alta	/evidencias/10389_132.pdf	2026-04-20	2028-04-19
3367	10389	23	133	f	Media	\N	2024-06-30	2025-06-30
3368	10389	23	133	t	Baja	/evidencias/10389_133.pdf	2025-05-29	2027-05-29
3369	10389	23	134	f	Baja	\N	2025-08-28	2026-08-28
3370	10390	91	538	t	Media	/evidencias/10390_538.pdf	2024-09-03	2026-09-03
3371	10390	91	538	f	Baja	\N	2026-04-18	2028-04-17
3372	10390	91	539	t	Media	/evidencias/10390_539.pdf	2026-02-14	2027-02-14
3373	10390	91	539	t	Media	/evidencias/10390_539.pdf	2023-07-20	2024-07-19
3374	10390	91	540	t	Baja	/evidencias/10390_540.pdf	2025-10-14	2026-10-14
3375	10390	91	541	t	Media	/evidencias/10390_541.pdf	2025-04-28	2027-04-28
3376	10390	91	541	t	Media	/evidencias/10390_541.pdf	2024-06-30	2025-06-30
3377	10390	91	542	t	Media	/evidencias/10390_542.pdf	2025-12-27	2027-12-27
3378	10390	91	543	t	Baja	/evidencias/10390_543.pdf	2025-09-29	2027-09-29
3379	10390	91	544	t	Baja	/evidencias/10390_544.pdf	2023-10-16	2024-10-15
3380	10390	91	544	f	Media	\N	2023-12-17	2024-12-16
3381	10392	87	513	f	Alta	\N	2024-09-13	2026-09-13
3382	10392	87	514	f	Alta	\N	2025-10-01	2026-10-01
3383	10392	87	514	f	Alta	\N	2025-04-23	2026-04-23
3384	10392	87	515	t	Baja	/evidencias/10392_515.pdf	2026-03-15	2028-03-14
3385	10392	87	516	t	Baja	/evidencias/10392_516.pdf	2026-02-28	2028-02-28
3386	10393	49	285	t	Media	/evidencias/10393_285.pdf	2024-01-10	2026-01-09
3387	10393	49	285	t	Alta	/evidencias/10393_285.pdf	2024-08-10	2026-08-10
3391	10393	49	288	t	Media	/evidencias/10393_288.pdf	2024-04-15	2026-04-15
3392	10393	49	288	t	Baja	/evidencias/10393_288.pdf	2025-10-23	2026-10-23
3393	10394	44	253	f	Alta	\N	2023-10-15	2024-10-14
3394	10394	44	254	f	Alta	\N	2023-07-31	2025-07-30
3395	10394	44	255	t	Alta	/evidencias/10394_255.pdf	2024-05-08	2026-05-08
3396	10394	44	256	t	Baja	/evidencias/10394_256.pdf	2023-10-10	2024-10-09
3397	10395	72	425	t	Media	/evidencias/10395_425.pdf	2024-11-06	2026-11-06
3398	10395	72	425	t	Media	/evidencias/10395_425.pdf	2024-11-18	2025-11-18
3399	10395	72	426	t	Media	/evidencias/10395_426.pdf	2024-11-26	2026-11-26
3400	10395	72	427	f	Baja	\N	2024-05-28	2026-05-28
3401	10395	72	427	f	Media	\N	2026-03-13	2027-03-13
3402	10395	72	428	t	Alta	/evidencias/10395_428.pdf	2024-01-17	2025-01-16
3403	10395	72	428	t	Alta	/evidencias/10395_428.pdf	2025-10-07	2026-10-07
3404	10395	72	429	t	Media	/evidencias/10395_429.pdf	2025-10-17	2027-10-17
3405	10395	72	430	t	Alta	/evidencias/10395_430.pdf	2023-10-12	2024-10-11
3406	10395	72	431	t	Alta	/evidencias/10395_431.pdf	2023-10-02	2025-10-01
3407	10395	72	431	t	Media	/evidencias/10395_431.pdf	2025-12-07	2027-12-07
3408	10396	27	149	f	Baja	\N	2025-04-24	2027-04-24
3409	10396	27	149	t	Media	/evidencias/10396_149.pdf	2025-11-25	2027-11-25
3410	10396	27	150	t	Baja	/evidencias/10396_150.pdf	2026-05-01	2028-04-30
3411	10396	27	150	f	Alta	\N	2026-03-22	2028-03-21
3412	10396	27	151	t	Media	/evidencias/10396_151.pdf	2023-07-06	2025-07-05
3413	10396	27	152	t	Media	/evidencias/10396_152.pdf	2024-03-14	2025-03-14
3414	10396	27	152	t	Baja	/evidencias/10396_152.pdf	2025-05-30	2027-05-30
3415	10396	27	153	t	Media	/evidencias/10396_153.pdf	2025-12-29	2026-12-29
3416	10396	27	153	f	Media	\N	2025-11-08	2026-11-08
3417	10396	27	154	f	Media	\N	2025-06-23	2027-06-23
3418	10396	27	154	t	Media	/evidencias/10396_154.pdf	2024-09-03	2026-09-03
3419	10396	27	155	f	Baja	\N	2025-03-22	2027-03-22
3420	10398	93	550	f	Alta	\N	2024-09-29	2026-09-29
3421	10398	93	551	t	Alta	/evidencias/10398_551.pdf	2025-12-07	2027-12-07
3422	10398	93	552	t	Baja	/evidencias/10398_552.pdf	2026-02-22	2028-02-22
3423	10398	93	553	t	Alta	/evidencias/10398_553.pdf	2026-04-17	2027-04-17
3424	10398	93	553	t	Media	/evidencias/10398_553.pdf	2024-11-13	2026-11-13
3425	10398	93	554	f	Media	\N	2025-02-22	2026-02-22
3426	10398	93	555	t	Media	/evidencias/10398_555.pdf	2025-02-02	2026-02-02
3427	10398	93	556	t	Baja	/evidencias/10398_556.pdf	2025-02-21	2027-02-21
3428	10398	93	556	t	Media	/evidencias/10398_556.pdf	2025-08-15	2027-08-15
3429	10399	131	781	t	Baja	/evidencias/10399_781.pdf	2023-10-28	2024-10-27
3430	10399	131	782	t	Baja	/evidencias/10399_782.pdf	2026-05-18	2027-05-18
3431	10399	131	783	t	Media	/evidencias/10399_783.pdf	2024-12-22	2025-12-22
3432	10399	131	783	t	Alta	/evidencias/10399_783.pdf	2026-01-10	2028-01-10
3433	10399	131	784	f	Media	\N	2024-10-08	2026-10-08
3434	10399	131	784	t	Media	/evidencias/10399_784.pdf	2026-02-02	2027-02-02
3435	10399	131	785	t	Alta	/evidencias/10399_785.pdf	2024-09-16	2026-09-16
3436	10399	131	785	t	Media	/evidencias/10399_785.pdf	2025-08-20	2027-08-20
3437	10399	131	786	t	Alta	/evidencias/10399_786.pdf	2024-03-25	2025-03-25
3438	10399	131	787	t	Media	/evidencias/10399_787.pdf	2024-04-18	2025-04-18
3439	10400	28	156	t	Media	/evidencias/10400_156.pdf	2025-06-07	2027-06-07
3440	10400	28	157	f	Alta	\N	2025-02-22	2026-02-22
3441	10400	28	158	t	Media	/evidencias/10400_158.pdf	2025-06-28	2027-06-28
3442	10400	28	159	f	Media	\N	2023-06-13	2025-06-12
3443	10400	28	159	t	Alta	/evidencias/10400_159.pdf	2025-11-16	2026-11-16
3444	10400	28	160	f	Baja	\N	2026-03-16	2028-03-15
3445	10400	28	161	t	Media	/evidencias/10400_161.pdf	2026-01-01	2028-01-01
3446	10401	29	162	t	Media	/evidencias/10401_162.pdf	2025-11-12	2027-11-12
3447	10401	29	163	t	Baja	/evidencias/10401_163.pdf	2025-07-19	2027-07-19
3448	10401	29	164	f	Baja	\N	2024-08-25	2025-08-25
3449	10401	29	165	f	Baja	\N	2024-12-24	2026-12-24
3450	10402	141	844	t	Media	/evidencias/10402_844.pdf	2025-01-13	2026-01-13
3451	10402	141	845	t	Media	/evidencias/10402_845.pdf	2026-01-20	2027-01-20
3452	10402	141	846	f	Media	\N	2023-12-30	2025-12-29
3453	10402	141	847	f	Alta	\N	2026-04-09	2027-04-09
3454	10402	141	847	t	Media	/evidencias/10402_847.pdf	2026-04-17	2028-04-16
3455	10404	71	417	t	Media	/evidencias/10404_417.pdf	2025-08-19	2027-08-19
3456	10404	71	418	f	Baja	\N	2024-03-02	2025-03-02
3457	10404	71	419	t	Alta	/evidencias/10404_419.pdf	2023-11-22	2025-11-21
3458	10404	71	419	t	Baja	/evidencias/10404_419.pdf	2025-07-17	2027-07-17
3459	10404	71	420	f	Alta	\N	2023-06-14	2024-06-13
3460	10404	71	421	t	Baja	/evidencias/10404_421.pdf	2024-03-27	2026-03-27
3461	10404	71	421	t	Alta	/evidencias/10404_421.pdf	2024-05-08	2026-05-08
3462	10404	71	422	t	Baja	/evidencias/10404_422.pdf	2023-06-02	2025-06-01
3463	10404	71	423	t	Media	/evidencias/10404_423.pdf	2025-12-12	2027-12-12
3464	10404	71	424	t	Alta	/evidencias/10404_424.pdf	2024-11-17	2025-11-17
3465	10405	57	329	t	Baja	/evidencias/10405_329.pdf	2026-03-25	2028-03-24
3466	10405	57	330	f	Baja	\N	2024-10-01	2025-10-01
3467	10405	57	331	f	Alta	\N	2025-11-11	2027-11-11
3468	10405	57	332	t	Media	/evidencias/10405_332.pdf	2023-07-16	2025-07-15
3469	10405	57	332	f	Baja	\N	2025-02-24	2026-02-24
3470	10405	57	333	t	Baja	/evidencias/10405_333.pdf	2024-10-26	2026-10-26
3471	10405	57	333	t	Alta	/evidencias/10405_333.pdf	2025-09-12	2027-09-12
3472	10406	7	40	f	Media	\N	2025-10-11	2026-10-11
3473	10406	7	40	f	Alta	\N	2024-04-12	2026-04-12
3474	10406	7	41	t	Media	/evidencias/10406_41.pdf	2024-01-08	2025-01-07
3475	10406	7	41	t	Media	/evidencias/10406_41.pdf	2026-02-12	2027-02-12
3476	10406	7	42	f	Media	\N	2026-04-21	2027-04-21
3477	10406	7	42	t	Media	/evidencias/10406_42.pdf	2026-03-18	2028-03-17
3478	10406	7	43	t	Media	/evidencias/10406_43.pdf	2024-03-03	2026-03-03
3479	10406	7	43	t	Media	/evidencias/10406_43.pdf	2024-08-04	2025-08-04
3480	10406	7	44	t	Alta	/evidencias/10406_44.pdf	2025-09-19	2027-09-19
3481	10406	7	44	t	Alta	/evidencias/10406_44.pdf	2023-10-31	2024-10-30
3482	10406	7	45	t	Media	/evidencias/10406_45.pdf	2025-08-18	2026-08-18
3483	10407	33	185	t	Baja	/evidencias/10407_185.pdf	2023-11-01	2024-10-31
3484	10407	33	185	t	Media	/evidencias/10407_185.pdf	2024-10-12	2026-10-12
3485	10407	33	186	t	Media	/evidencias/10407_186.pdf	2026-03-07	2027-03-07
3486	10407	33	187	t	Baja	/evidencias/10407_187.pdf	2024-08-05	2026-08-05
3487	10407	33	188	f	Media	\N	2025-10-08	2027-10-08
3488	10407	33	189	f	Alta	\N	2023-10-19	2024-10-18
3489	10407	33	190	t	Media	/evidencias/10407_190.pdf	2025-08-26	2026-08-26
3490	10407	33	191	f	Alta	\N	2026-05-25	2028-05-24
3491	10407	33	192	t	Alta	/evidencias/10407_192.pdf	2025-10-02	2027-10-02
3492	10408	6	33	f	Media	\N	2023-10-27	2025-10-26
3493	10408	6	34	t	Alta	/evidencias/10408_34.pdf	2025-05-16	2026-05-16
3494	10408	6	35	t	Alta	/evidencias/10408_35.pdf	2025-12-02	2027-12-02
3495	10408	6	36	t	Baja	/evidencias/10408_36.pdf	2024-07-03	2025-07-03
3496	10408	6	36	t	Alta	/evidencias/10408_36.pdf	2023-11-19	2024-11-18
3497	10408	6	37	f	Baja	\N	2024-10-20	2026-10-20
3498	10408	6	38	t	Baja	/evidencias/10408_38.pdf	2024-10-14	2025-10-14
3499	10408	6	38	f	Baja	\N	2026-03-18	2028-03-17
3500	10408	6	39	t	Media	/evidencias/10408_39.pdf	2025-01-14	2026-01-14
3501	10409	150	896	f	Media	\N	2024-03-18	2026-03-18
3502	10409	150	896	t	Media	/evidencias/10409_896.pdf	2024-02-15	2025-02-14
3503	10409	150	897	f	Alta	\N	2024-04-29	2025-04-29
3504	10409	150	897	f	Alta	\N	2025-09-27	2026-09-27
3505	10409	150	898	f	Baja	\N	2024-10-06	2025-10-06
3506	10409	150	899	t	Media	/evidencias/10409_899.pdf	2025-01-14	2026-01-14
3507	10409	150	900	t	Alta	/evidencias/10409_900.pdf	2026-04-08	2027-04-08
3508	10409	150	900	t	Media	/evidencias/10409_900.pdf	2024-05-27	2026-05-27
3509	10409	150	901	t	Alta	/evidencias/10409_901.pdf	2025-08-14	2026-08-14
3510	10409	150	901	t	Baja	/evidencias/10409_901.pdf	2025-12-04	2026-12-04
3511	10410	103	615	t	Media	/evidencias/10410_615.pdf	2023-06-26	2024-06-25
3512	10410	103	616	f	Alta	\N	2025-03-29	2026-03-29
3513	10410	103	617	t	Media	/evidencias/10410_617.pdf	2025-08-24	2026-08-24
3514	10410	103	617	t	Baja	/evidencias/10410_617.pdf	2023-10-09	2025-10-08
3515	10410	103	618	f	Baja	\N	2024-09-19	2025-09-19
3516	10411	98	582	t	Alta	/evidencias/10411_582.pdf	2025-07-13	2026-07-13
3517	10411	98	583	t	Media	/evidencias/10411_583.pdf	2024-01-06	2025-01-05
3518	10411	98	583	t	Media	/evidencias/10411_583.pdf	2025-04-07	2027-04-07
3519	10411	98	584	t	Alta	/evidencias/10411_584.pdf	2024-11-05	2025-11-05
3520	10411	98	584	t	Media	/evidencias/10411_584.pdf	2024-05-17	2026-05-17
3521	10411	98	585	t	Media	/evidencias/10411_585.pdf	2024-04-09	2025-04-09
3522	10411	98	586	t	Media	/evidencias/10411_586.pdf	2026-04-20	2028-04-19
3523	10411	98	586	t	Alta	/evidencias/10411_586.pdf	2023-09-20	2025-09-19
3524	10411	98	587	t	Media	/evidencias/10411_587.pdf	2023-12-22	2024-12-21
3525	10411	98	587	t	Media	/evidencias/10411_587.pdf	2023-09-03	2024-09-02
3526	10411	98	588	t	Media	/evidencias/10411_588.pdf	2025-08-27	2026-08-27
3527	10412	6	33	f	Baja	\N	2024-08-06	2026-08-06
3528	10412	6	34	t	Media	/evidencias/10412_34.pdf	2025-09-25	2026-09-25
3529	10412	6	35	t	Alta	/evidencias/10412_35.pdf	2025-07-31	2027-07-31
3530	10412	6	35	f	Baja	\N	2024-07-15	2026-07-15
3531	10412	6	36	t	Baja	/evidencias/10412_36.pdf	2023-12-30	2025-12-29
3532	10412	6	36	f	Media	\N	2024-09-29	2025-09-29
3533	10412	6	37	t	Media	/evidencias/10412_37.pdf	2023-09-10	2025-09-09
3534	10412	6	38	t	Alta	/evidencias/10412_38.pdf	2026-05-22	2028-05-21
3535	10412	6	38	t	Media	/evidencias/10412_38.pdf	2024-11-28	2025-11-28
3536	10412	6	39	t	Media	/evidencias/10412_39.pdf	2023-06-09	2024-06-08
3537	10413	16	92	t	Alta	/evidencias/10413_92.pdf	2025-05-26	2027-05-26
3538	10413	16	92	t	Media	/evidencias/10413_92.pdf	2025-02-01	2027-02-01
3539	10413	16	93	t	Media	/evidencias/10413_93.pdf	2024-06-24	2026-06-24
3540	10413	16	93	f	Baja	\N	2023-09-24	2025-09-23
3541	10413	16	94	t	Alta	/evidencias/10413_94.pdf	2023-12-31	2024-12-30
3542	10413	16	95	t	Media	/evidencias/10413_95.pdf	2024-11-18	2025-11-18
3543	10413	16	96	f	Media	\N	2024-06-09	2025-06-09
3544	10413	16	96	f	Media	\N	2023-10-24	2024-10-23
3545	10414	58	334	t	Baja	/evidencias/10414_334.pdf	2025-04-30	2026-04-30
3546	10414	58	335	t	Alta	/evidencias/10414_335.pdf	2023-10-22	2024-10-21
3547	10414	58	335	f	Media	\N	2026-03-10	2027-03-10
3548	10414	58	336	t	Alta	/evidencias/10414_336.pdf	2025-12-25	2026-12-25
3549	10414	58	337	t	Media	/evidencias/10414_337.pdf	2026-03-28	2027-03-28
3550	10415	56	325	t	Alta	/evidencias/10415_325.pdf	2024-01-28	2026-01-27
3551	10415	56	326	t	Media	/evidencias/10415_326.pdf	2026-02-15	2028-02-15
3552	10415	56	326	f	Baja	\N	2025-06-24	2027-06-24
3553	10415	56	327	t	Alta	/evidencias/10415_327.pdf	2025-01-07	2027-01-07
3554	10415	56	328	f	Alta	\N	2025-11-25	2026-11-25
3555	10416	32	178	f	Baja	\N	2025-08-06	2027-08-06
3556	10416	32	179	t	Media	/evidencias/10416_179.pdf	2023-11-20	2025-11-19
3557	10416	32	180	t	Baja	/evidencias/10416_180.pdf	2024-12-15	2026-12-15
3558	10416	32	181	t	Baja	/evidencias/10416_181.pdf	2023-08-24	2024-08-23
3559	10416	32	181	f	Media	\N	2023-06-29	2025-06-28
3560	10416	32	182	t	Baja	/evidencias/10416_182.pdf	2024-08-06	2026-08-06
3561	10416	32	183	f	Media	\N	2026-04-10	2028-04-09
3562	10416	32	183	t	Alta	/evidencias/10416_183.pdf	2023-09-13	2024-09-12
3563	10416	32	184	t	Media	/evidencias/10416_184.pdf	2023-07-05	2025-07-04
3564	10416	32	184	t	Media	/evidencias/10416_184.pdf	2025-12-15	2026-12-15
3565	10417	73	432	t	Media	/evidencias/10417_432.pdf	2025-08-22	2026-08-22
3566	10417	73	432	t	Baja	/evidencias/10417_432.pdf	2026-02-16	2027-02-16
3567	10417	73	433	f	Media	\N	2023-10-18	2024-10-17
3568	10417	73	433	t	Baja	/evidencias/10417_433.pdf	2024-09-30	2026-09-30
3569	10417	73	434	f	Baja	\N	2024-04-06	2026-04-06
3570	10417	73	434	t	Media	/evidencias/10417_434.pdf	2025-06-12	2026-06-12
3571	10417	73	435	f	Media	\N	2025-10-11	2027-10-11
3572	10417	73	435	t	Alta	/evidencias/10417_435.pdf	2025-09-27	2026-09-27
3573	10417	73	436	f	Alta	\N	2024-11-19	2026-11-19
3574	10419	40	226	f	Alta	\N	2023-12-23	2025-12-22
3575	10419	40	226	f	Alta	\N	2025-03-06	2026-03-06
3576	10419	40	227	t	Baja	/evidencias/10419_227.pdf	2025-01-09	2027-01-09
3577	10419	40	227	t	Media	/evidencias/10419_227.pdf	2024-06-03	2026-06-03
3578	10419	40	228	t	Media	/evidencias/10419_228.pdf	2024-12-22	2025-12-22
3579	10419	40	229	f	Baja	\N	2025-12-22	2027-12-22
3580	10419	40	230	f	Baja	\N	2024-02-26	2025-02-25
3581	10419	40	231	t	Media	/evidencias/10419_231.pdf	2023-12-11	2024-12-10
3582	10419	40	231	f	Media	\N	2025-03-11	2026-03-11
3583	10420	109	648	f	Media	\N	2026-01-25	2028-01-25
3584	10420	109	648	t	Alta	/evidencias/10420_648.pdf	2025-02-15	2027-02-15
3585	10420	109	649	t	Baja	/evidencias/10420_649.pdf	2024-11-20	2026-11-20
3586	10420	109	650	t	Baja	/evidencias/10420_650.pdf	2025-10-20	2027-10-20
3587	10420	109	651	t	Media	/evidencias/10420_651.pdf	2024-11-02	2025-11-02
3588	10420	109	651	f	Media	\N	2025-01-21	2026-01-21
3589	10420	109	652	t	Baja	/evidencias/10420_652.pdf	2024-04-04	2025-04-04
3590	10420	109	653	t	Alta	/evidencias/10420_653.pdf	2023-10-04	2024-10-03
3591	10420	109	653	f	Baja	\N	2025-09-06	2027-09-06
3592	10421	31	173	t	Alta	/evidencias/10421_173.pdf	2026-02-05	2027-02-05
3593	10421	31	174	t	Alta	/evidencias/10421_174.pdf	2023-12-02	2025-12-01
3594	10421	31	174	t	Alta	/evidencias/10421_174.pdf	2024-08-03	2026-08-03
3595	10421	31	175	t	Alta	/evidencias/10421_175.pdf	2023-08-23	2025-08-22
3596	10421	31	176	t	Media	/evidencias/10421_176.pdf	2025-10-25	2027-10-25
3597	10421	31	176	t	Media	/evidencias/10421_176.pdf	2024-12-07	2025-12-07
3598	10421	31	177	t	Baja	/evidencias/10421_177.pdf	2023-10-17	2025-10-16
3599	10421	31	177	t	Baja	/evidencias/10421_177.pdf	2025-05-19	2027-05-19
3600	10422	107	637	t	Alta	/evidencias/10422_637.pdf	2024-12-13	2026-12-13
3601	10422	107	637	f	Alta	\N	2026-03-08	2028-03-07
3602	10422	107	638	t	Media	/evidencias/10422_638.pdf	2023-06-16	2024-06-15
3603	10422	107	638	f	Media	\N	2025-07-08	2027-07-08
3604	10422	107	639	f	Baja	\N	2025-07-03	2026-07-03
3605	10422	107	640	t	Alta	/evidencias/10422_640.pdf	2023-09-27	2025-09-26
3606	10422	107	641	t	Media	/evidencias/10422_641.pdf	2025-11-18	2026-11-18
3607	10422	107	641	t	Baja	/evidencias/10422_641.pdf	2024-03-01	2026-03-01
3608	10422	107	642	t	Media	/evidencias/10422_642.pdf	2026-01-02	2027-01-02
3609	10422	107	643	t	Alta	/evidencias/10422_643.pdf	2025-07-26	2026-07-26
3610	10423	71	417	t	Alta	/evidencias/10423_417.pdf	2024-01-25	2026-01-24
3611	10423	71	418	t	Media	/evidencias/10423_418.pdf	2025-03-22	2027-03-22
3612	10423	71	419	t	Media	/evidencias/10423_419.pdf	2024-06-08	2025-06-08
3613	10423	71	419	t	Baja	/evidencias/10423_419.pdf	2023-07-02	2025-07-01
3614	10423	71	420	t	Media	/evidencias/10423_420.pdf	2024-08-02	2025-08-02
3615	10423	71	420	t	Alta	/evidencias/10423_420.pdf	2024-01-31	2026-01-30
3616	10423	71	421	t	Media	/evidencias/10423_421.pdf	2025-01-22	2027-01-22
3617	10423	71	422	t	Baja	/evidencias/10423_422.pdf	2025-02-20	2026-02-20
3618	10423	71	422	f	Media	\N	2025-07-24	2026-07-24
3619	10423	71	423	f	Baja	\N	2026-01-16	2027-01-16
3620	10423	71	423	t	Alta	/evidencias/10423_423.pdf	2024-01-11	2026-01-10
3621	10423	71	424	t	Alta	/evidencias/10423_424.pdf	2024-06-10	2026-06-10
3622	10424	120	711	t	Media	/evidencias/10424_711.pdf	2026-04-07	2027-04-07
3623	10424	120	712	f	Baja	\N	2024-08-27	2025-08-27
3624	10424	120	713	f	Media	\N	2024-02-21	2026-02-20
3625	10424	120	714	f	Media	\N	2023-09-25	2025-09-24
3626	10424	120	714	t	Media	/evidencias/10424_714.pdf	2023-12-31	2024-12-30
3627	10424	120	715	t	Media	/evidencias/10424_715.pdf	2026-04-18	2028-04-17
3628	10424	120	716	t	Media	/evidencias/10424_716.pdf	2026-05-25	2027-05-25
3629	10424	120	716	t	Alta	/evidencias/10424_716.pdf	2024-04-15	2025-04-15
3630	10426	75	441	f	Baja	\N	2023-10-30	2024-10-29
3631	10426	75	442	t	Media	/evidencias/10426_442.pdf	2023-11-28	2025-11-27
3632	10426	75	443	t	Alta	/evidencias/10426_443.pdf	2024-04-24	2025-04-24
3633	10426	75	444	t	Baja	/evidencias/10426_444.pdf	2026-01-05	2027-01-05
3634	10426	75	445	f	Media	\N	2024-12-03	2025-12-03
3635	10426	75	446	f	Alta	\N	2024-06-23	2026-06-23
3636	10427	88	517	f	Baja	\N	2025-01-05	2027-01-05
3637	10427	88	517	t	Alta	/evidencias/10427_517.pdf	2025-01-16	2027-01-16
3638	10427	88	518	t	Baja	/evidencias/10427_518.pdf	2024-04-22	2025-04-22
3639	10427	88	518	t	Baja	/evidencias/10427_518.pdf	2023-08-29	2025-08-28
3640	10427	88	519	t	Alta	/evidencias/10427_519.pdf	2026-03-24	2028-03-23
3641	10427	88	519	t	Media	/evidencias/10427_519.pdf	2025-04-04	2026-04-04
3642	10427	88	520	t	Media	/evidencias/10427_520.pdf	2024-10-18	2025-10-18
3643	10427	88	520	t	Media	/evidencias/10427_520.pdf	2026-05-27	2027-05-27
3644	10427	88	521	t	Baja	/evidencias/10427_521.pdf	2023-10-21	2024-10-20
3645	10427	88	522	t	Media	/evidencias/10427_522.pdf	2026-05-04	2028-05-03
3646	10427	88	522	t	Media	/evidencias/10427_522.pdf	2023-12-31	2024-12-30
3647	10427	88	523	t	Media	/evidencias/10427_523.pdf	2024-10-08	2026-10-08
3648	10428	71	417	t	Alta	/evidencias/10428_417.pdf	2023-06-26	2025-06-25
3649	10428	71	417	f	Media	\N	2024-06-23	2025-06-23
3650	10428	71	418	t	Media	/evidencias/10428_418.pdf	2025-02-28	2027-02-28
3651	10428	71	419	t	Alta	/evidencias/10428_419.pdf	2026-03-05	2027-03-05
3652	10428	71	419	t	Media	/evidencias/10428_419.pdf	2024-08-08	2025-08-08
3653	10428	71	420	t	Baja	/evidencias/10428_420.pdf	2026-04-10	2027-04-10
3654	10428	71	421	t	Media	/evidencias/10428_421.pdf	2025-08-30	2027-08-30
3655	10428	71	422	t	Media	/evidencias/10428_422.pdf	2025-12-06	2027-12-06
3656	10428	71	422	t	Media	/evidencias/10428_422.pdf	2025-12-03	2027-12-03
3657	10428	71	423	t	Baja	/evidencias/10428_423.pdf	2026-04-18	2028-04-17
3658	10428	71	424	t	Media	/evidencias/10428_424.pdf	2025-03-30	2026-03-30
3659	10429	148	882	t	Media	/evidencias/10429_882.pdf	2025-07-19	2027-07-19
3660	10429	148	882	f	Baja	\N	2025-08-08	2026-08-08
3661	10429	148	883	t	Media	/evidencias/10429_883.pdf	2026-02-07	2027-02-07
3662	10429	148	884	t	Media	/evidencias/10429_884.pdf	2025-11-01	2027-11-01
3663	10429	148	885	t	Alta	/evidencias/10429_885.pdf	2024-04-07	2025-04-07
3664	10429	148	885	t	Alta	/evidencias/10429_885.pdf	2024-03-09	2025-03-09
3665	10429	148	886	f	Baja	\N	2023-12-20	2024-12-19
3666	10429	148	886	t	Media	/evidencias/10429_886.pdf	2024-05-28	2025-05-28
3667	10429	148	887	t	Media	/evidencias/10429_887.pdf	2023-11-01	2024-10-31
3668	10429	148	888	t	Baja	/evidencias/10429_888.pdf	2023-07-01	2025-06-30
3669	10430	10	59	t	Baja	/evidencias/10430_59.pdf	2025-08-31	2026-08-31
3670	10430	10	60	t	Media	/evidencias/10430_60.pdf	2023-09-16	2024-09-15
3671	10430	10	61	t	Media	/evidencias/10430_61.pdf	2025-06-22	2026-06-22
3672	10430	10	61	t	Media	/evidencias/10430_61.pdf	2023-06-30	2025-06-29
3673	10430	10	62	t	Alta	/evidencias/10430_62.pdf	2023-07-27	2025-07-26
3674	10430	10	63	f	Media	\N	2025-09-15	2027-09-15
3675	10430	10	63	t	Media	/evidencias/10430_63.pdf	2024-11-05	2026-11-05
3676	10430	10	64	f	Baja	\N	2023-11-09	2025-11-08
3677	10430	10	64	f	Media	\N	2023-06-24	2025-06-23
3678	10430	10	65	t	Media	/evidencias/10430_65.pdf	2025-05-26	2027-05-26
3679	10430	10	65	t	Baja	/evidencias/10430_65.pdf	2026-01-24	2028-01-24
3680	10430	10	66	t	Alta	/evidencias/10430_66.pdf	2024-09-21	2025-09-21
3681	10431	7	40	t	Baja	/evidencias/10431_40.pdf	2026-02-04	2027-02-04
3682	10431	7	40	t	Alta	/evidencias/10431_40.pdf	2025-01-21	2026-01-21
3683	10431	7	41	f	Media	\N	2025-02-20	2026-02-20
3684	10431	7	42	t	Alta	/evidencias/10431_42.pdf	2025-09-04	2027-09-04
3685	10431	7	43	t	Baja	/evidencias/10431_43.pdf	2023-08-13	2024-08-12
3686	10431	7	44	t	Media	/evidencias/10431_44.pdf	2023-11-13	2025-11-12
3687	10431	7	45	f	Alta	\N	2025-06-09	2026-06-09
3688	10431	7	45	t	Alta	/evidencias/10431_45.pdf	2024-08-12	2026-08-12
3689	10432	61	348	t	Media	/evidencias/10432_348.pdf	2026-05-26	2027-05-26
3690	10432	61	349	t	Baja	/evidencias/10432_349.pdf	2025-12-22	2027-12-22
3691	10432	61	350	f	Media	\N	2025-11-15	2026-11-15
3692	10432	61	351	t	Baja	/evidencias/10432_351.pdf	2023-12-21	2024-12-20
3693	10433	106	632	t	Alta	/evidencias/10433_632.pdf	2025-11-23	2027-11-23
3694	10433	106	632	t	Media	/evidencias/10433_632.pdf	2026-01-26	2027-01-26
3695	10433	106	633	t	Media	/evidencias/10433_633.pdf	2026-05-20	2027-05-20
3696	10433	106	634	t	Baja	/evidencias/10433_634.pdf	2023-10-23	2025-10-22
3697	10433	106	635	t	Alta	/evidencias/10433_635.pdf	2024-07-28	2026-07-28
3698	10433	106	636	t	Baja	/evidencias/10433_636.pdf	2024-02-07	2025-02-06
3699	10433	106	636	t	Media	/evidencias/10433_636.pdf	2024-01-01	2025-12-31
3700	10434	96	569	t	Baja	/evidencias/10434_569.pdf	2023-09-02	2024-09-01
3701	10434	96	570	t	Alta	/evidencias/10434_570.pdf	2025-06-26	2027-06-26
3702	10434	96	571	t	Media	/evidencias/10434_571.pdf	2025-04-16	2026-04-16
3703	10434	96	571	t	Media	/evidencias/10434_571.pdf	2025-07-26	2027-07-26
3704	10434	96	572	t	Alta	/evidencias/10434_572.pdf	2024-04-13	2025-04-13
3705	10434	96	572	f	Baja	\N	2024-05-21	2025-05-21
3706	10434	96	573	t	Alta	/evidencias/10434_573.pdf	2024-08-28	2025-08-28
3707	10434	96	574	t	Media	/evidencias/10434_574.pdf	2025-11-08	2026-11-08
3708	10434	96	574	t	Media	/evidencias/10434_574.pdf	2024-12-10	2025-12-10
3709	10434	96	575	t	Alta	/evidencias/10434_575.pdf	2025-12-08	2027-12-08
3710	10434	96	576	t	Media	/evidencias/10434_576.pdf	2024-12-26	2026-12-26
3711	10434	96	576	f	Media	\N	2025-01-18	2026-01-18
3712	10435	2	8	f	Baja	\N	2023-10-30	2025-10-29
3713	10435	2	8	f	Baja	\N	2023-11-04	2025-11-03
3714	10435	2	9	t	Media	/evidencias/10435_9.pdf	2024-05-22	2025-05-22
3715	10435	2	10	t	Baja	/evidencias/10435_10.pdf	2026-03-02	2028-03-01
3716	10435	2	10	t	Media	/evidencias/10435_10.pdf	2026-01-12	2028-01-12
3717	10435	2	11	t	Media	/evidencias/10435_11.pdf	2024-03-31	2025-03-31
3718	10435	2	12	t	Media	/evidencias/10435_12.pdf	2026-05-20	2027-05-20
3719	10435	2	12	f	Alta	\N	2025-03-23	2026-03-23
3720	10435	2	13	t	Media	/evidencias/10435_13.pdf	2024-09-24	2025-09-24
3721	10436	113	670	f	Media	\N	2023-08-18	2025-08-17
3722	10436	113	670	t	Media	/evidencias/10436_670.pdf	2023-12-14	2024-12-13
3723	10436	113	671	t	Media	/evidencias/10436_671.pdf	2023-10-05	2024-10-04
3724	10436	113	672	f	Baja	\N	2025-10-07	2027-10-07
3725	10436	113	673	t	Alta	/evidencias/10436_673.pdf	2024-05-07	2026-05-07
3726	10436	113	673	t	Media	/evidencias/10436_673.pdf	2025-07-24	2026-07-24
3727	10436	113	674	f	Media	\N	2026-04-12	2028-04-11
3728	10436	113	674	t	Media	/evidencias/10436_674.pdf	2026-05-19	2027-05-19
3729	10436	113	675	t	Baja	/evidencias/10436_675.pdf	2026-05-03	2028-05-02
3730	10436	113	676	t	Alta	/evidencias/10436_676.pdf	2026-05-02	2027-05-02
3731	10436	113	677	t	Media	/evidencias/10436_677.pdf	2023-06-20	2025-06-19
3732	10436	113	677	t	Alta	/evidencias/10436_677.pdf	2024-10-16	2025-10-16
3733	10437	101	603	f	Baja	\N	2025-01-11	2027-01-11
3734	10437	101	603	t	Media	/evidencias/10437_603.pdf	2025-06-15	2026-06-15
3735	10437	101	604	t	Media	/evidencias/10437_604.pdf	2025-01-30	2027-01-30
3736	10437	101	604	t	Media	/evidencias/10437_604.pdf	2025-07-17	2026-07-17
3737	10437	101	605	f	Alta	\N	2024-12-06	2025-12-06
3738	10437	101	606	f	Alta	\N	2025-05-31	2026-05-31
3739	10437	101	606	t	Alta	/evidencias/10437_606.pdf	2024-12-04	2026-12-04
3740	10437	101	607	t	Baja	/evidencias/10437_607.pdf	2024-03-21	2026-03-21
3741	10437	101	607	t	Baja	/evidencias/10437_607.pdf	2024-01-01	2024-12-31
3742	10437	101	608	t	Alta	/evidencias/10437_608.pdf	2025-11-02	2026-11-02
3743	10437	101	608	t	Media	/evidencias/10437_608.pdf	2023-08-12	2024-08-11
3744	10438	122	724	t	Baja	/evidencias/10438_724.pdf	2024-10-06	2025-10-06
3745	10438	122	725	f	Alta	\N	2026-05-10	2027-05-10
3746	10438	122	725	t	Media	/evidencias/10438_725.pdf	2024-08-03	2025-08-03
3747	10438	122	726	t	Media	/evidencias/10438_726.pdf	2024-06-10	2026-06-10
3748	10438	122	726	t	Media	/evidencias/10438_726.pdf	2024-08-15	2025-08-15
3749	10438	122	727	t	Baja	/evidencias/10438_727.pdf	2025-02-17	2027-02-17
3750	10438	122	728	t	Baja	/evidencias/10438_728.pdf	2026-05-25	2027-05-25
3751	10438	122	728	f	Media	\N	2024-05-30	2025-05-30
3752	10438	122	729	f	Alta	\N	2024-07-07	2026-07-07
3753	10438	122	729	t	Media	/evidencias/10438_729.pdf	2024-10-22	2026-10-22
3754	10438	122	730	t	Baja	/evidencias/10438_730.pdf	2023-07-24	2025-07-23
3755	10438	122	731	t	Alta	/evidencias/10438_731.pdf	2025-09-01	2026-09-01
3756	10439	128	763	t	Baja	/evidencias/10439_763.pdf	2023-07-04	2025-07-03
3757	10439	128	764	t	Media	/evidencias/10439_764.pdf	2026-04-30	2027-04-30
3758	10439	128	764	t	Baja	/evidencias/10439_764.pdf	2023-07-14	2025-07-13
3759	10439	128	765	f	Alta	\N	2025-08-11	2027-08-11
3760	10439	128	766	t	Media	/evidencias/10439_766.pdf	2023-08-29	2024-08-28
3761	10439	128	767	t	Media	/evidencias/10439_767.pdf	2025-03-02	2027-03-02
3762	10439	128	768	t	Media	/evidencias/10439_768.pdf	2024-09-30	2025-09-30
3763	10439	128	768	t	Media	/evidencias/10439_768.pdf	2023-12-12	2025-12-11
3764	10440	107	637	t	Alta	/evidencias/10440_637.pdf	2025-06-29	2026-06-29
3765	10440	107	637	t	Alta	/evidencias/10440_637.pdf	2026-01-27	2028-01-27
3766	10440	107	638	f	Media	\N	2025-09-02	2027-09-02
3767	10440	107	638	t	Media	/evidencias/10440_638.pdf	2024-04-06	2026-04-06
3768	10440	107	639	f	Baja	\N	2026-01-08	2028-01-08
3769	10440	107	640	t	Media	/evidencias/10440_640.pdf	2025-06-30	2026-06-30
3770	10440	107	640	t	Alta	/evidencias/10440_640.pdf	2025-02-11	2027-02-11
3771	10440	107	641	t	Media	/evidencias/10440_641.pdf	2025-05-29	2027-05-29
3772	10440	107	642	t	Media	/evidencias/10440_642.pdf	2025-12-13	2026-12-13
3773	10440	107	642	t	Baja	/evidencias/10440_642.pdf	2024-11-07	2026-11-07
3774	10440	107	643	t	Media	/evidencias/10440_643.pdf	2024-02-10	2025-02-09
3775	10440	107	643	f	Media	\N	2024-01-04	2026-01-03
3776	10441	99	589	f	Media	\N	2023-12-09	2024-12-08
3777	10441	99	589	t	Alta	/evidencias/10441_589.pdf	2024-05-31	2026-05-31
3778	10441	99	590	t	Baja	/evidencias/10441_590.pdf	2025-04-23	2027-04-23
3779	10441	99	590	t	Baja	/evidencias/10441_590.pdf	2023-08-18	2025-08-17
3780	10441	99	591	t	Media	/evidencias/10441_591.pdf	2023-11-07	2025-11-06
3781	10441	99	591	f	Baja	\N	2025-09-29	2027-09-29
3782	10441	99	592	t	Media	/evidencias/10441_592.pdf	2024-08-08	2025-08-08
3783	10441	99	592	t	Media	/evidencias/10441_592.pdf	2024-08-31	2025-08-31
3784	10441	99	593	f	Alta	\N	2025-01-19	2026-01-19
3785	10441	99	594	f	Media	\N	2026-04-14	2027-04-14
3786	10441	99	594	t	Media	/evidencias/10441_594.pdf	2023-06-10	2024-06-09
3787	10442	20	113	t	Alta	/evidencias/10442_113.pdf	2025-11-11	2026-11-11
3788	10442	20	113	t	Alta	/evidencias/10442_113.pdf	2024-06-28	2026-06-28
3789	10442	20	114	t	Alta	/evidencias/10442_114.pdf	2024-11-14	2026-11-14
3790	10442	20	114	t	Alta	/evidencias/10442_114.pdf	2025-03-29	2026-03-29
3791	10442	20	115	t	Baja	/evidencias/10442_115.pdf	2025-05-01	2027-05-01
3792	10442	20	115	t	Media	/evidencias/10442_115.pdf	2026-01-03	2027-01-03
3793	10442	20	116	t	Alta	/evidencias/10442_116.pdf	2023-12-26	2024-12-25
3794	10442	20	117	t	Alta	/evidencias/10442_117.pdf	2025-08-22	2026-08-22
3795	10442	20	117	t	Baja	/evidencias/10442_117.pdf	2023-12-24	2025-12-23
3796	10442	20	118	t	Media	/evidencias/10442_118.pdf	2024-12-05	2025-12-05
3797	10443	69	404	t	Baja	/evidencias/10443_404.pdf	2026-02-26	2027-02-26
3798	10443	69	404	t	Baja	/evidencias/10443_404.pdf	2024-06-03	2026-06-03
3799	10443	69	405	t	Media	/evidencias/10443_405.pdf	2026-01-27	2027-01-27
3800	10443	69	406	t	Alta	/evidencias/10443_406.pdf	2024-03-17	2026-03-17
3801	10443	69	406	t	Media	/evidencias/10443_406.pdf	2024-05-08	2025-05-08
3802	10443	69	407	t	Media	/evidencias/10443_407.pdf	2026-05-29	2028-05-28
3803	10443	69	407	f	Alta	\N	2023-12-31	2025-12-30
3804	10443	69	408	f	Alta	\N	2025-06-03	2026-06-03
3805	10443	69	409	t	Media	/evidencias/10443_409.pdf	2025-01-11	2026-01-11
3806	10444	36	206	t	Media	/evidencias/10444_206.pdf	2024-07-06	2026-07-06
3807	10444	36	207	t	Baja	/evidencias/10444_207.pdf	2024-08-29	2026-08-29
3808	10444	36	207	t	Media	/evidencias/10444_207.pdf	2026-04-18	2028-04-17
3809	10444	36	208	t	Alta	/evidencias/10444_208.pdf	2025-08-09	2027-08-09
3810	10444	36	209	f	Media	\N	2025-08-29	2027-08-29
3811	10445	51	295	t	Baja	/evidencias/10445_295.pdf	2025-10-24	2026-10-24
3812	10445	51	295	t	Media	/evidencias/10445_295.pdf	2026-01-11	2027-01-11
3813	10445	51	296	t	Baja	/evidencias/10445_296.pdf	2023-10-29	2024-10-28
3814	10445	51	297	f	Media	\N	2025-01-07	2026-01-07
3815	10445	51	298	t	Baja	/evidencias/10445_298.pdf	2024-11-09	2025-11-09
3816	10445	51	299	t	Media	/evidencias/10445_299.pdf	2026-05-18	2028-05-17
3817	10445	51	299	t	Media	/evidencias/10445_299.pdf	2024-01-31	2025-01-30
3818	10445	51	300	t	Alta	/evidencias/10445_300.pdf	2023-09-02	2024-09-01
3819	10445	51	301	t	Media	/evidencias/10445_301.pdf	2025-07-11	2026-07-11
3820	10445	51	301	t	Baja	/evidencias/10445_301.pdf	2023-10-02	2025-10-01
3821	10445	51	302	t	Alta	/evidencias/10445_302.pdf	2025-02-05	2027-02-05
3822	10446	88	517	t	Alta	/evidencias/10446_517.pdf	2024-10-17	2025-10-17
3823	10446	88	517	f	Baja	\N	2025-02-19	2027-02-19
3824	10446	88	518	t	Media	/evidencias/10446_518.pdf	2025-06-25	2027-06-25
3825	10446	88	518	t	Media	/evidencias/10446_518.pdf	2026-03-23	2027-03-23
3826	10446	88	519	f	Media	\N	2025-10-23	2027-10-23
3827	10446	88	519	t	Baja	/evidencias/10446_519.pdf	2023-12-13	2025-12-12
3828	10446	88	520	t	Baja	/evidencias/10446_520.pdf	2024-07-11	2026-07-11
3829	10446	88	520	t	Alta	/evidencias/10446_520.pdf	2023-08-27	2025-08-26
3830	10446	88	521	t	Media	/evidencias/10446_521.pdf	2023-06-15	2025-06-14
3831	10446	88	522	t	Alta	/evidencias/10446_522.pdf	2024-11-04	2025-11-04
3832	10446	88	523	f	Alta	\N	2023-11-18	2025-11-17
3833	10447	36	206	t	Baja	/evidencias/10447_206.pdf	2024-04-02	2026-04-02
3834	10447	36	206	t	Media	/evidencias/10447_206.pdf	2025-03-27	2026-03-27
3835	10447	36	207	t	Media	/evidencias/10447_207.pdf	2025-02-14	2026-02-14
3836	10447	36	207	t	Baja	/evidencias/10447_207.pdf	2024-05-06	2025-05-06
3837	10447	36	208	f	Baja	\N	2024-03-23	2026-03-23
3838	10447	36	209	t	Media	/evidencias/10447_209.pdf	2024-11-01	2025-11-01
3839	10447	36	209	t	Baja	/evidencias/10447_209.pdf	2023-06-06	2024-06-05
3840	10448	24	135	t	Media	/evidencias/10448_135.pdf	2024-05-15	2025-05-15
3841	10448	24	136	t	Baja	/evidencias/10448_136.pdf	2025-03-08	2026-03-08
3842	10448	24	136	f	Alta	\N	2023-09-29	2024-09-28
3843	10448	24	137	t	Alta	/evidencias/10448_137.pdf	2025-08-24	2026-08-24
3844	10448	24	138	t	Baja	/evidencias/10448_138.pdf	2025-07-09	2026-07-09
3845	10448	24	138	t	Media	/evidencias/10448_138.pdf	2025-02-23	2026-02-23
3846	10448	24	139	t	Media	/evidencias/10448_139.pdf	2026-05-20	2027-05-20
3847	10449	149	889	t	Media	/evidencias/10449_889.pdf	2024-10-28	2026-10-28
3848	10449	149	889	f	Alta	\N	2024-06-04	2026-06-04
3849	10449	149	890	t	Alta	/evidencias/10449_890.pdf	2025-11-27	2026-11-27
3850	10449	149	890	t	Media	/evidencias/10449_890.pdf	2023-09-28	2024-09-27
3851	10449	149	891	f	Alta	\N	2023-07-18	2025-07-17
3852	10449	149	891	f	Media	\N	2025-10-24	2027-10-24
3853	10449	149	892	t	Media	/evidencias/10449_892.pdf	2025-10-27	2026-10-27
3854	10449	149	892	t	Media	/evidencias/10449_892.pdf	2023-07-29	2025-07-28
3855	10449	149	893	t	Media	/evidencias/10449_893.pdf	2026-05-10	2027-05-10
3856	10449	149	894	f	Alta	\N	2024-01-16	2025-01-15
3857	10449	149	895	t	Alta	/evidencias/10449_895.pdf	2024-04-21	2025-04-21
3858	10450	108	644	t	Baja	/evidencias/10450_644.pdf	2023-08-10	2025-08-09
3859	10450	108	645	t	Alta	/evidencias/10450_645.pdf	2024-08-31	2025-08-31
3860	10450	108	646	t	Baja	/evidencias/10450_646.pdf	2024-08-13	2025-08-13
3861	10450	108	646	f	Alta	\N	2025-09-26	2026-09-26
3862	10450	108	647	t	Media	/evidencias/10450_647.pdf	2023-10-14	2025-10-13
3863	10451	129	769	t	Media	/evidencias/10451_769.pdf	2024-11-11	2025-11-11
3864	10451	129	769	f	Alta	\N	2025-01-20	2027-01-20
3865	10451	129	770	t	Media	/evidencias/10451_770.pdf	2025-12-05	2027-12-05
3866	10451	129	771	t	Alta	/evidencias/10451_771.pdf	2026-04-22	2027-04-22
3867	10451	129	772	t	Alta	/evidencias/10451_772.pdf	2025-06-26	2026-06-26
3868	10451	129	773	f	Media	\N	2023-11-20	2025-11-19
3869	10451	129	774	f	Alta	\N	2025-04-20	2027-04-20
3870	10451	129	774	t	Alta	/evidencias/10451_774.pdf	2024-10-07	2025-10-07
3871	10451	129	775	t	Media	/evidencias/10451_775.pdf	2024-12-14	2026-12-14
3872	10451	129	776	t	Media	/evidencias/10451_776.pdf	2024-01-04	2026-01-03
3873	10452	143	855	t	Alta	/evidencias/10452_855.pdf	2026-02-20	2028-02-20
3874	10452	143	855	t	Media	/evidencias/10452_855.pdf	2024-03-31	2026-03-31
3875	10452	143	856	f	Baja	\N	2024-03-29	2025-03-29
3876	10452	143	857	t	Media	/evidencias/10452_857.pdf	2026-05-21	2027-05-21
3877	10452	143	857	f	Alta	\N	2025-08-02	2026-08-02
3878	10452	143	858	t	Baja	/evidencias/10452_858.pdf	2024-02-22	2025-02-21
3879	10452	143	859	t	Alta	/evidencias/10452_859.pdf	2025-11-24	2026-11-24
3880	10452	143	859	t	Baja	/evidencias/10452_859.pdf	2026-01-13	2027-01-13
3881	10453	98	582	t	Baja	/evidencias/10453_582.pdf	2024-07-10	2025-07-10
3882	10453	98	582	t	Media	/evidencias/10453_582.pdf	2025-11-07	2027-11-07
3883	10453	98	583	t	Media	/evidencias/10453_583.pdf	2025-08-26	2027-08-26
3884	10453	98	583	t	Baja	/evidencias/10453_583.pdf	2026-04-04	2028-04-03
3885	10453	98	584	t	Alta	/evidencias/10453_584.pdf	2023-10-16	2025-10-15
3886	10453	98	584	t	Media	/evidencias/10453_584.pdf	2023-07-16	2025-07-15
3887	10453	98	585	t	Media	/evidencias/10453_585.pdf	2024-09-26	2025-09-26
3888	10453	98	585	t	Baja	/evidencias/10453_585.pdf	2024-07-13	2026-07-13
3889	10453	98	586	t	Media	/evidencias/10453_586.pdf	2025-08-26	2027-08-26
3890	10453	98	587	t	Baja	/evidencias/10453_587.pdf	2025-12-07	2027-12-07
3891	10453	98	587	f	Alta	\N	2023-11-27	2025-11-26
3892	10453	98	588	t	Media	/evidencias/10453_588.pdf	2025-01-02	2026-01-02
3893	10453	98	588	t	Media	/evidencias/10453_588.pdf	2025-06-26	2027-06-26
3894	10454	20	113	f	Alta	\N	2023-12-17	2024-12-16
3895	10454	20	114	f	Baja	\N	2024-02-03	2026-02-02
3896	10454	20	114	t	Alta	/evidencias/10454_114.pdf	2024-11-09	2025-11-09
3897	10454	20	115	t	Baja	/evidencias/10454_115.pdf	2026-04-19	2027-04-19
3898	10454	20	115	t	Alta	/evidencias/10454_115.pdf	2026-01-03	2027-01-03
3899	10454	20	116	t	Media	/evidencias/10454_116.pdf	2026-02-03	2028-02-03
3900	10454	20	117	t	Alta	/evidencias/10454_117.pdf	2024-08-06	2026-08-06
3901	10454	20	118	f	Media	\N	2025-07-04	2027-07-04
3902	10454	20	118	t	Baja	/evidencias/10454_118.pdf	2025-11-13	2026-11-13
3903	10455	140	836	t	Media	/evidencias/10455_836.pdf	2025-01-25	2026-01-25
3904	10455	140	836	t	Media	/evidencias/10455_836.pdf	2024-11-27	2025-11-27
3905	10455	140	837	t	Baja	/evidencias/10455_837.pdf	2023-10-06	2025-10-05
3906	10455	140	837	t	Media	/evidencias/10455_837.pdf	2024-02-14	2025-02-13
3907	10455	140	838	t	Alta	/evidencias/10455_838.pdf	2025-08-12	2026-08-12
3908	10455	140	839	t	Alta	/evidencias/10455_839.pdf	2025-06-11	2026-06-11
3909	10455	140	839	t	Alta	/evidencias/10455_839.pdf	2025-10-19	2026-10-19
3910	10455	140	840	t	Alta	/evidencias/10455_840.pdf	2023-07-11	2024-07-10
3911	10455	140	840	t	Media	/evidencias/10455_840.pdf	2025-06-02	2027-06-02
3912	10455	140	841	f	Alta	\N	2025-04-17	2026-04-17
3913	10455	140	841	f	Baja	\N	2026-02-01	2028-02-01
3914	10455	140	842	t	Media	/evidencias/10455_842.pdf	2024-10-13	2026-10-13
3915	10455	140	842	t	Alta	/evidencias/10455_842.pdf	2025-05-12	2026-05-12
3916	10455	140	843	t	Baja	/evidencias/10455_843.pdf	2026-03-05	2028-03-04
3917	10455	140	843	f	Media	\N	2025-10-14	2026-10-14
3918	10456	109	648	t	Media	/evidencias/10456_648.pdf	2025-06-02	2026-06-02
3919	10456	109	649	t	Media	/evidencias/10456_649.pdf	2025-06-13	2027-06-13
3920	10456	109	649	t	Alta	/evidencias/10456_649.pdf	2025-08-22	2026-08-22
3921	10456	109	650	t	Media	/evidencias/10456_650.pdf	2024-08-06	2025-08-06
3922	10456	109	650	t	Alta	/evidencias/10456_650.pdf	2023-09-04	2025-09-03
3923	10456	109	651	f	Baja	\N	2025-02-04	2027-02-04
3924	10456	109	652	t	Alta	/evidencias/10456_652.pdf	2025-01-20	2026-01-20
3925	10456	109	653	f	Media	\N	2025-11-21	2027-11-21
3926	10457	111	659	t	Alta	/evidencias/10457_659.pdf	2023-08-28	2024-08-27
3927	10457	111	659	t	Baja	/evidencias/10457_659.pdf	2025-10-04	2027-10-04
3928	10457	111	660	t	Alta	/evidencias/10457_660.pdf	2024-10-10	2025-10-10
3929	10457	111	660	f	Media	\N	2023-11-27	2024-11-26
3930	10457	111	661	t	Alta	/evidencias/10457_661.pdf	2023-12-31	2024-12-30
3931	10457	111	661	t	Baja	/evidencias/10457_661.pdf	2026-03-19	2027-03-19
3932	10457	111	662	t	Media	/evidencias/10457_662.pdf	2024-01-19	2026-01-18
3933	10457	111	662	t	Media	/evidencias/10457_662.pdf	2025-02-08	2026-02-08
3934	10457	111	663	f	Alta	\N	2026-02-12	2027-02-12
3935	10457	111	663	f	Baja	\N	2025-12-30	2026-12-30
3936	10457	111	664	f	Alta	\N	2025-04-12	2027-04-12
3937	10457	111	664	t	Alta	/evidencias/10457_664.pdf	2025-07-22	2027-07-22
3938	10460	38	215	f	Media	\N	2025-01-27	2026-01-27
3939	10460	38	215	t	Baja	/evidencias/10460_215.pdf	2026-01-25	2027-01-25
3940	10460	38	216	t	Alta	/evidencias/10460_216.pdf	2024-08-28	2026-08-28
3941	10460	38	216	t	Baja	/evidencias/10460_216.pdf	2026-04-23	2027-04-23
3942	10460	38	217	f	Baja	\N	2026-03-21	2027-03-21
3943	10460	38	217	t	Baja	/evidencias/10460_217.pdf	2024-09-17	2025-09-17
3944	10460	38	218	t	Baja	/evidencias/10460_218.pdf	2026-02-07	2028-02-07
3945	10460	38	218	t	Media	/evidencias/10460_218.pdf	2023-10-13	2024-10-12
3946	10460	38	219	t	Media	/evidencias/10460_219.pdf	2025-01-19	2026-01-19
3947	10461	67	388	t	Media	/evidencias/10461_388.pdf	2025-01-31	2027-01-31
3948	10461	67	389	f	Alta	\N	2026-04-16	2028-04-15
3949	10461	67	390	t	Baja	/evidencias/10461_390.pdf	2025-09-27	2026-09-27
3950	10461	67	390	f	Baja	\N	2024-03-14	2025-03-14
3951	10461	67	391	f	Alta	\N	2025-05-16	2027-05-16
3952	10461	67	392	t	Baja	/evidencias/10461_392.pdf	2024-10-24	2026-10-24
3953	10461	67	392	t	Baja	/evidencias/10461_392.pdf	2024-02-13	2026-02-12
3954	10461	67	393	f	Alta	\N	2024-08-14	2026-08-14
3955	10461	67	394	t	Baja	/evidencias/10461_394.pdf	2025-10-11	2026-10-11
3956	10461	67	395	t	Alta	/evidencias/10461_395.pdf	2025-10-24	2027-10-24
3957	10461	67	395	t	Media	/evidencias/10461_395.pdf	2025-11-13	2026-11-13
3958	10464	150	896	t	Alta	/evidencias/10464_896.pdf	2024-12-11	2025-12-11
3959	10464	150	897	t	Media	/evidencias/10464_897.pdf	2025-03-04	2027-03-04
3960	10464	150	898	t	Media	/evidencias/10464_898.pdf	2025-02-07	2026-02-07
3961	10464	150	898	f	Alta	\N	2023-07-26	2024-07-25
3962	10464	150	899	t	Media	/evidencias/10464_899.pdf	2026-01-03	2027-01-03
3963	10464	150	899	f	Media	\N	2025-08-19	2026-08-19
3964	10464	150	900	f	Media	\N	2026-04-13	2028-04-12
3965	10464	150	901	t	Alta	/evidencias/10464_901.pdf	2024-06-01	2025-06-01
3966	10464	150	901	t	Alta	/evidencias/10464_901.pdf	2024-11-23	2025-11-23
3967	10465	134	802	t	Media	/evidencias/10465_802.pdf	2024-04-03	2025-04-03
3968	10465	134	802	f	Media	\N	2025-09-02	2026-09-02
3969	10465	134	803	t	Alta	/evidencias/10465_803.pdf	2025-11-19	2026-11-19
3970	10465	134	804	f	Alta	\N	2024-11-28	2026-11-28
3971	10465	134	805	f	Media	\N	2023-10-23	2024-10-22
3972	10465	134	806	t	Alta	/evidencias/10465_806.pdf	2025-12-22	2027-12-22
3973	10465	134	807	t	Alta	/evidencias/10465_807.pdf	2024-03-16	2026-03-16
3974	10465	134	808	t	Baja	/evidencias/10465_808.pdf	2024-06-02	2025-06-02
3975	10465	134	808	t	Baja	/evidencias/10465_808.pdf	2025-05-04	2027-05-04
3976	10466	40	226	t	Alta	/evidencias/10466_226.pdf	2026-04-26	2027-04-26
3977	10466	40	226	f	Baja	\N	2024-06-21	2026-06-21
3978	10466	40	227	t	Media	/evidencias/10466_227.pdf	2026-03-01	2028-02-29
3979	10466	40	227	t	Baja	/evidencias/10466_227.pdf	2026-02-24	2027-02-24
3980	10466	40	228	f	Media	\N	2025-11-04	2026-11-04
3981	10466	40	229	t	Media	/evidencias/10466_229.pdf	2025-10-15	2026-10-15
3982	10466	40	230	f	Baja	\N	2023-08-13	2025-08-12
3983	10466	40	231	t	Media	/evidencias/10466_231.pdf	2023-10-25	2025-10-24
3984	10466	40	231	t	Alta	/evidencias/10466_231.pdf	2024-07-29	2025-07-29
3985	10467	121	717	t	Media	/evidencias/10467_717.pdf	2024-08-12	2025-08-12
3986	10467	121	717	t	Alta	/evidencias/10467_717.pdf	2024-11-21	2026-11-21
3987	10467	121	718	t	Media	/evidencias/10467_718.pdf	2026-03-09	2027-03-09
3988	10467	121	718	f	Baja	\N	2025-08-21	2027-08-21
3989	10467	121	719	f	Alta	\N	2024-11-13	2026-11-13
3990	10467	121	719	f	Alta	\N	2024-06-10	2026-06-10
3991	10467	121	720	t	Baja	/evidencias/10467_720.pdf	2025-02-26	2027-02-26
3992	10467	121	721	t	Media	/evidencias/10467_721.pdf	2024-03-11	2025-03-11
3993	10467	121	721	t	Baja	/evidencias/10467_721.pdf	2023-08-13	2025-08-12
3994	10467	121	722	t	Media	/evidencias/10467_722.pdf	2024-03-07	2026-03-07
3995	10467	121	722	t	Media	/evidencias/10467_722.pdf	2023-10-08	2025-10-07
3996	10467	121	723	t	Media	/evidencias/10467_723.pdf	2024-11-08	2025-11-08
3997	10467	121	723	t	Alta	/evidencias/10467_723.pdf	2025-01-28	2027-01-28
3998	10469	137	821	f	Media	\N	2023-07-22	2025-07-21
3999	10469	137	822	t	Media	/evidencias/10469_822.pdf	2023-08-31	2024-08-30
4000	10469	137	822	t	Media	/evidencias/10469_822.pdf	2025-02-28	2026-02-28
4001	10469	137	823	f	Alta	\N	2023-08-07	2025-08-06
4002	10469	137	823	f	Baja	\N	2025-01-30	2027-01-30
4003	10469	137	824	t	Media	/evidencias/10469_824.pdf	2023-12-20	2024-12-19
4004	10470	81	475	f	Baja	\N	2023-10-24	2024-10-23
4005	10470	81	476	t	Alta	/evidencias/10470_476.pdf	2024-09-01	2025-09-01
4006	10470	81	476	f	Baja	\N	2025-09-15	2027-09-15
4007	10470	81	477	t	Alta	/evidencias/10470_477.pdf	2023-11-28	2024-11-27
4008	10470	81	477	t	Baja	/evidencias/10470_477.pdf	2024-11-16	2026-11-16
4009	10470	81	478	f	Baja	\N	2024-03-21	2026-03-21
4010	10470	81	478	t	Media	/evidencias/10470_478.pdf	2024-08-20	2026-08-20
4011	10470	81	479	f	Baja	\N	2024-01-30	2025-01-29
4012	10470	81	480	f	Media	\N	2025-02-09	2027-02-09
4013	10470	81	480	f	Media	\N	2023-11-04	2024-11-03
4014	10470	81	481	t	Alta	/evidencias/10470_481.pdf	2025-08-13	2027-08-13
4015	10471	148	882	t	Media	/evidencias/10471_882.pdf	2026-03-18	2028-03-17
4016	10471	148	882	f	Media	\N	2024-12-28	2025-12-28
4017	10471	148	883	t	Alta	/evidencias/10471_883.pdf	2025-07-10	2026-07-10
4018	10471	148	884	f	Baja	\N	2024-08-04	2026-08-04
4019	10471	148	885	t	Media	/evidencias/10471_885.pdf	2025-10-22	2027-10-22
4020	10471	148	886	t	Alta	/evidencias/10471_886.pdf	2023-10-06	2024-10-05
4021	10471	148	887	f	Baja	\N	2024-05-05	2026-05-05
4022	10471	148	887	t	Baja	/evidencias/10471_887.pdf	2023-10-16	2024-10-15
4023	10471	148	888	t	Alta	/evidencias/10471_888.pdf	2023-11-29	2025-11-28
4024	10472	122	724	t	Baja	/evidencias/10472_724.pdf	2025-07-04	2027-07-04
4025	10472	122	724	t	Alta	/evidencias/10472_724.pdf	2025-03-31	2027-03-31
4026	10472	122	725	t	Baja	/evidencias/10472_725.pdf	2023-07-02	2025-07-01
4027	10472	122	726	t	Media	/evidencias/10472_726.pdf	2026-04-11	2027-04-11
4028	10472	122	726	f	Baja	\N	2023-10-08	2024-10-07
4029	10472	122	727	f	Media	\N	2025-05-20	2026-05-20
4030	10472	122	727	t	Media	/evidencias/10472_727.pdf	2024-04-13	2026-04-13
4031	10472	122	728	t	Media	/evidencias/10472_728.pdf	2024-01-14	2026-01-13
4032	10472	122	729	t	Baja	/evidencias/10472_729.pdf	2024-06-04	2025-06-04
4033	10472	122	730	t	Baja	/evidencias/10472_730.pdf	2024-08-18	2025-08-18
4034	10472	122	731	f	Baja	\N	2025-12-09	2027-12-09
4035	10472	122	731	t	Alta	/evidencias/10472_731.pdf	2024-11-07	2025-11-07
4036	10473	109	648	t	Baja	/evidencias/10473_648.pdf	2025-05-03	2026-05-03
4037	10473	109	648	t	Media	/evidencias/10473_648.pdf	2023-06-14	2025-06-13
4038	10473	109	649	f	Alta	\N	2024-02-22	2026-02-21
4039	10473	109	649	t	Baja	/evidencias/10473_649.pdf	2024-01-21	2025-01-20
4040	10473	109	650	t	Media	/evidencias/10473_650.pdf	2024-12-18	2026-12-18
4041	10473	109	650	t	Media	/evidencias/10473_650.pdf	2024-09-06	2025-09-06
4042	10473	109	651	f	Baja	\N	2024-12-24	2026-12-24
4043	10473	109	652	t	Alta	/evidencias/10473_652.pdf	2024-12-14	2026-12-14
4044	10473	109	652	t	Baja	/evidencias/10473_652.pdf	2024-07-31	2025-07-31
4045	10473	109	653	t	Alta	/evidencias/10473_653.pdf	2024-08-01	2025-08-01
4046	10473	109	653	t	Alta	/evidencias/10473_653.pdf	2026-01-03	2028-01-03
4047	10474	72	425	t	Media	/evidencias/10474_425.pdf	2023-12-04	2024-12-03
4048	10474	72	425	t	Alta	/evidencias/10474_425.pdf	2023-11-12	2025-11-11
4049	10474	72	426	f	Media	\N	2024-06-15	2026-06-15
4050	10474	72	426	f	Alta	\N	2023-12-19	2024-12-18
4051	10474	72	427	t	Baja	/evidencias/10474_427.pdf	2025-12-20	2026-12-20
4052	10474	72	428	t	Alta	/evidencias/10474_428.pdf	2025-03-07	2027-03-07
4053	10474	72	428	f	Alta	\N	2024-05-01	2025-05-01
4054	10474	72	429	f	Media	\N	2025-02-19	2026-02-19
4055	10474	72	429	f	Media	\N	2025-03-07	2026-03-07
4056	10474	72	430	t	Media	/evidencias/10474_430.pdf	2023-12-31	2025-12-30
4057	10474	72	431	t	Media	/evidencias/10474_431.pdf	2024-01-03	2026-01-02
4058	10475	92	545	f	Alta	\N	2026-03-11	2027-03-11
4059	10475	92	546	t	Baja	/evidencias/10475_546.pdf	2025-12-18	2026-12-18
4060	10475	92	547	t	Media	/evidencias/10475_547.pdf	2023-11-05	2024-11-04
4061	10475	92	547	t	Media	/evidencias/10475_547.pdf	2024-02-18	2025-02-17
4062	10475	92	548	t	Alta	/evidencias/10475_548.pdf	2024-11-02	2025-11-02
4063	10475	92	548	t	Alta	/evidencias/10475_548.pdf	2024-03-13	2025-03-13
4064	10475	92	549	t	Baja	/evidencias/10475_549.pdf	2024-06-01	2025-06-01
4065	10476	140	836	t	Alta	/evidencias/10476_836.pdf	2023-07-09	2025-07-08
4066	10476	140	836	t	Media	/evidencias/10476_836.pdf	2025-06-02	2027-06-02
4067	10476	140	837	f	Alta	\N	2025-12-14	2026-12-14
4068	10476	140	838	t	Alta	/evidencias/10476_838.pdf	2023-09-20	2025-09-19
4069	10476	140	839	t	Media	/evidencias/10476_839.pdf	2026-01-20	2028-01-20
4070	10476	140	839	t	Media	/evidencias/10476_839.pdf	2023-10-06	2025-10-05
4071	10476	140	840	t	Baja	/evidencias/10476_840.pdf	2026-02-16	2028-02-16
4072	10476	140	841	t	Alta	/evidencias/10476_841.pdf	2024-05-20	2025-05-20
4073	10476	140	841	t	Alta	/evidencias/10476_841.pdf	2026-05-19	2028-05-18
4074	10476	140	842	t	Baja	/evidencias/10476_842.pdf	2025-12-19	2026-12-19
4075	10476	140	842	t	Baja	/evidencias/10476_842.pdf	2026-01-21	2028-01-21
4076	10476	140	843	t	Media	/evidencias/10476_843.pdf	2023-08-14	2024-08-13
4077	10477	65	374	t	Alta	/evidencias/10477_374.pdf	2023-12-07	2024-12-06
4078	10477	65	375	t	Alta	/evidencias/10477_375.pdf	2026-03-27	2027-03-27
4079	10477	65	376	f	Media	\N	2025-05-31	2027-05-31
4080	10477	65	377	t	Alta	/evidencias/10477_377.pdf	2023-06-28	2025-06-27
4081	10477	65	377	t	Media	/evidencias/10477_377.pdf	2025-03-10	2026-03-10
4082	10477	65	378	t	Media	/evidencias/10477_378.pdf	2025-02-12	2026-02-12
4083	10477	65	379	t	Media	/evidencias/10477_379.pdf	2024-04-30	2026-04-30
4085	10477	65	380	t	Media	/evidencias/10477_380.pdf	2024-12-18	2025-12-18
4086	10477	65	381	f	Alta	\N	2025-11-17	2026-11-17
4087	10478	141	844	f	Baja	\N	2026-02-16	2028-02-16
4088	10478	141	845	t	Baja	/evidencias/10478_845.pdf	2024-01-25	2026-01-24
4089	10478	141	846	t	Alta	/evidencias/10478_846.pdf	2025-08-30	2027-08-30
4090	10478	141	846	t	Media	/evidencias/10478_846.pdf	2024-08-13	2025-08-13
4091	10478	141	847	t	Media	/evidencias/10478_847.pdf	2025-08-31	2026-08-31
4092	10479	138	825	t	Media	/evidencias/10479_825.pdf	2025-03-22	2027-03-22
4093	10479	138	825	f	Media	\N	2024-09-26	2025-09-26
4094	10479	138	826	f	Media	\N	2025-01-12	2027-01-12
4095	10479	138	827	f	Alta	\N	2026-04-01	2028-03-31
4096	10479	138	828	t	Alta	/evidencias/10479_828.pdf	2024-08-12	2026-08-12
4097	10480	67	388	f	Media	\N	2024-02-21	2026-02-20
4098	10480	67	389	t	Alta	/evidencias/10480_389.pdf	2024-11-16	2025-11-16
4099	10480	67	389	t	Baja	/evidencias/10480_389.pdf	2023-08-13	2024-08-12
4100	10480	67	390	f	Media	\N	2025-08-03	2027-08-03
4101	10480	67	390	t	Baja	/evidencias/10480_390.pdf	2025-07-14	2027-07-14
4102	10480	67	391	f	Alta	\N	2025-05-17	2026-05-17
4103	10480	67	391	t	Media	/evidencias/10480_391.pdf	2024-07-20	2026-07-20
4104	10480	67	392	f	Baja	\N	2024-07-30	2025-07-30
4105	10480	67	393	t	Media	/evidencias/10480_393.pdf	2024-08-04	2025-08-04
4106	10480	67	394	t	Media	/evidencias/10480_394.pdf	2026-02-24	2027-02-24
4107	10480	67	394	t	Baja	/evidencias/10480_394.pdf	2026-02-15	2027-02-15
4108	10480	67	395	t	Media	/evidencias/10480_395.pdf	2024-12-04	2025-12-04
4109	10481	94	557	t	Media	/evidencias/10481_557.pdf	2024-09-07	2025-09-07
4110	10481	94	557	t	Alta	/evidencias/10481_557.pdf	2025-06-22	2027-06-22
4111	10481	94	558	t	Baja	/evidencias/10481_558.pdf	2025-12-29	2027-12-29
4112	10481	94	558	t	Baja	/evidencias/10481_558.pdf	2025-06-27	2026-06-27
4113	10481	94	559	t	Baja	/evidencias/10481_559.pdf	2024-02-28	2025-02-27
4114	10481	94	560	t	Media	/evidencias/10481_560.pdf	2026-04-10	2027-04-10
4115	10481	94	561	f	Baja	\N	2024-11-03	2025-11-03
4116	10481	94	562	t	Baja	/evidencias/10481_562.pdf	2024-04-12	2025-04-12
4117	10481	94	562	t	Media	/evidencias/10481_562.pdf	2023-10-01	2025-09-30
4118	10481	94	563	f	Alta	\N	2025-12-10	2026-12-10
4119	10482	47	270	t	Alta	/evidencias/10482_270.pdf	2025-01-27	2027-01-27
4120	10482	47	270	t	Media	/evidencias/10482_270.pdf	2024-11-08	2026-11-08
4121	10482	47	271	t	Alta	/evidencias/10482_271.pdf	2025-09-30	2026-09-30
4122	10482	47	271	f	Media	\N	2024-11-20	2026-11-20
4123	10482	47	272	f	Media	\N	2024-03-31	2025-03-31
4124	10482	47	272	t	Media	/evidencias/10482_272.pdf	2024-02-11	2025-02-10
4125	10482	47	273	t	Baja	/evidencias/10482_273.pdf	2023-06-02	2025-06-01
4126	10482	47	274	t	Baja	/evidencias/10482_274.pdf	2024-01-29	2025-01-28
4127	10482	47	274	t	Media	/evidencias/10482_274.pdf	2025-01-22	2026-01-22
4128	10482	47	275	t	Alta	/evidencias/10482_275.pdf	2024-08-04	2025-08-04
4129	10482	47	276	f	Media	\N	2023-10-17	2025-10-16
4130	10482	47	276	t	Media	/evidencias/10482_276.pdf	2026-04-08	2028-04-07
4131	10483	10	59	t	Alta	/evidencias/10483_59.pdf	2025-09-10	2026-09-10
4132	10483	10	59	t	Alta	/evidencias/10483_59.pdf	2025-04-27	2027-04-27
4133	10483	10	60	t	Media	/evidencias/10483_60.pdf	2023-10-12	2024-10-11
4134	10483	10	60	f	Baja	\N	2026-05-19	2027-05-19
4135	10483	10	61	t	Baja	/evidencias/10483_61.pdf	2024-10-13	2026-10-13
4136	10483	10	62	t	Baja	/evidencias/10483_62.pdf	2025-08-10	2026-08-10
4137	10483	10	62	t	Media	/evidencias/10483_62.pdf	2023-09-10	2025-09-09
4138	10483	10	63	t	Media	/evidencias/10483_63.pdf	2024-10-07	2025-10-07
4139	10483	10	64	t	Alta	/evidencias/10483_64.pdf	2024-03-25	2025-03-25
4140	10483	10	65	f	Media	\N	2023-08-20	2024-08-19
4141	10483	10	65	t	Alta	/evidencias/10483_65.pdf	2024-06-19	2025-06-19
4142	10483	10	66	t	Media	/evidencias/10483_66.pdf	2023-10-24	2025-10-23
4143	10483	10	66	f	Media	\N	2024-02-28	2025-02-27
4144	10484	42	239	t	Alta	/evidencias/10484_239.pdf	2025-12-05	2026-12-05
4145	10484	42	240	t	Baja	/evidencias/10484_240.pdf	2024-04-22	2025-04-22
4146	10484	42	240	t	Baja	/evidencias/10484_240.pdf	2025-02-15	2026-02-15
4147	10484	42	241	t	Alta	/evidencias/10484_241.pdf	2023-09-19	2024-09-18
4148	10484	42	242	t	Baja	/evidencias/10484_242.pdf	2025-01-28	2026-01-28
4149	10484	42	243	t	Media	/evidencias/10484_243.pdf	2024-03-03	2026-03-03
4150	10484	42	243	t	Media	/evidencias/10484_243.pdf	2023-12-09	2024-12-08
4151	10484	42	244	t	Media	/evidencias/10484_244.pdf	2025-07-10	2026-07-10
4152	10484	42	245	t	Media	/evidencias/10484_245.pdf	2026-04-05	2028-04-04
4153	10484	42	246	t	Media	/evidencias/10484_246.pdf	2025-02-09	2026-02-09
4154	10485	101	603	f	Alta	\N	2026-04-23	2027-04-23
4155	10485	101	603	t	Media	/evidencias/10485_603.pdf	2026-04-05	2028-04-04
4156	10485	101	604	t	Baja	/evidencias/10485_604.pdf	2023-07-01	2024-06-30
4157	10485	101	605	t	Media	/evidencias/10485_605.pdf	2025-08-06	2026-08-06
4158	10485	101	606	t	Baja	/evidencias/10485_606.pdf	2025-09-29	2026-09-29
4159	10485	101	606	t	Baja	/evidencias/10485_606.pdf	2024-03-04	2026-03-04
4160	10485	101	607	t	Media	/evidencias/10485_607.pdf	2026-03-14	2028-03-13
4161	10485	101	607	t	Alta	/evidencias/10485_607.pdf	2023-07-21	2024-07-20
4162	10485	101	608	t	Alta	/evidencias/10485_608.pdf	2025-11-09	2026-11-09
4163	10486	34	193	t	Baja	/evidencias/10486_193.pdf	2024-07-26	2026-07-26
4164	10486	34	194	t	Alta	/evidencias/10486_194.pdf	2024-07-25	2025-07-25
4165	10486	34	195	t	Media	/evidencias/10486_195.pdf	2023-08-19	2025-08-18
4166	10486	34	196	t	Media	/evidencias/10486_196.pdf	2023-11-23	2024-11-22
4167	10486	34	196	t	Alta	/evidencias/10486_196.pdf	2023-07-11	2025-07-10
4168	10486	34	197	f	Media	\N	2024-02-28	2026-02-27
4169	10486	34	198	t	Baja	/evidencias/10486_198.pdf	2025-05-25	2027-05-25
4170	10486	34	198	f	Alta	\N	2023-06-17	2024-06-16
4171	10486	34	199	f	Media	\N	2024-12-09	2025-12-09
4172	10486	34	199	t	Alta	/evidencias/10486_199.pdf	2026-01-22	2027-01-22
4173	10486	34	200	t	Alta	/evidencias/10486_200.pdf	2025-02-22	2027-02-22
4174	10486	34	200	t	Baja	/evidencias/10486_200.pdf	2023-09-20	2024-09-19
4175	10487	137	821	t	Media	/evidencias/10487_821.pdf	2024-08-14	2025-08-14
4176	10487	137	822	t	Baja	/evidencias/10487_822.pdf	2024-04-12	2025-04-12
4177	10487	137	822	t	Baja	/evidencias/10487_822.pdf	2026-03-07	2027-03-07
4178	10487	137	823	t	Baja	/evidencias/10487_823.pdf	2023-07-16	2024-07-15
4179	10487	137	824	t	Media	/evidencias/10487_824.pdf	2025-10-03	2027-10-03
4180	10487	137	824	f	Media	\N	2026-05-18	2027-05-18
4181	10488	146	872	f	Media	\N	2026-01-01	2028-01-01
4182	10488	146	872	t	Baja	/evidencias/10488_872.pdf	2025-10-11	2026-10-11
4183	10488	146	873	t	Media	/evidencias/10488_873.pdf	2025-09-15	2026-09-15
4184	10488	146	873	t	Alta	/evidencias/10488_873.pdf	2025-03-03	2026-03-03
4185	10488	146	874	t	Alta	/evidencias/10488_874.pdf	2024-02-21	2026-02-20
4186	10488	146	875	t	Media	/evidencias/10488_875.pdf	2023-10-11	2024-10-10
4187	10488	146	876	t	Alta	/evidencias/10488_876.pdf	2023-11-26	2024-11-25
4188	10489	128	763	t	Baja	/evidencias/10489_763.pdf	2025-05-04	2026-05-04
4189	10489	128	763	t	Media	/evidencias/10489_763.pdf	2023-10-05	2024-10-04
4190	10489	128	764	t	Baja	/evidencias/10489_764.pdf	2024-04-21	2026-04-21
4191	10489	128	765	t	Baja	/evidencias/10489_765.pdf	2025-01-21	2026-01-21
4192	10489	128	766	f	Media	\N	2023-08-03	2025-08-02
4193	10489	128	766	t	Baja	/evidencias/10489_766.pdf	2023-08-27	2025-08-26
4194	10489	128	767	t	Media	/evidencias/10489_767.pdf	2024-07-02	2025-07-02
4195	10489	128	768	t	Media	/evidencias/10489_768.pdf	2026-01-31	2028-01-31
4196	10490	125	746	t	Alta	/evidencias/10490_746.pdf	2025-06-20	2026-06-20
4197	10490	125	746	t	Media	/evidencias/10490_746.pdf	2023-10-11	2024-10-10
4198	10490	125	747	t	Alta	/evidencias/10490_747.pdf	2025-09-26	2027-09-26
4199	10490	125	747	f	Baja	\N	2025-11-10	2027-11-10
4200	10490	125	748	t	Media	/evidencias/10490_748.pdf	2024-10-29	2026-10-29
4201	10490	125	748	f	Media	\N	2023-12-27	2024-12-26
4202	10490	125	749	t	Alta	/evidencias/10490_749.pdf	2025-11-25	2027-11-25
4203	10490	125	749	t	Media	/evidencias/10490_749.pdf	2024-04-05	2025-04-05
4204	10490	125	750	f	Media	\N	2024-05-30	2026-05-30
4205	10490	125	750	f	Alta	\N	2025-11-17	2026-11-17
4206	10490	125	751	t	Alta	/evidencias/10490_751.pdf	2024-09-20	2025-09-20
4207	10490	125	752	t	Media	/evidencias/10490_752.pdf	2023-09-23	2025-09-22
4208	10490	125	752	t	Alta	/evidencias/10490_752.pdf	2024-04-06	2025-04-06
4209	10491	69	404	t	Alta	/evidencias/10491_404.pdf	2023-07-22	2025-07-21
4210	10491	69	405	t	Media	/evidencias/10491_405.pdf	2023-07-24	2025-07-23
4211	10491	69	405	t	Baja	/evidencias/10491_405.pdf	2025-04-27	2027-04-27
4212	10491	69	406	t	Media	/evidencias/10491_406.pdf	2023-10-20	2025-10-19
4213	10491	69	406	t	Media	/evidencias/10491_406.pdf	2023-12-07	2024-12-06
4214	10491	69	407	t	Alta	/evidencias/10491_407.pdf	2023-12-15	2024-12-14
4215	10491	69	407	f	Alta	\N	2023-07-22	2024-07-21
4216	10491	69	408	t	Baja	/evidencias/10491_408.pdf	2024-01-01	2025-12-31
4217	10491	69	408	t	Media	/evidencias/10491_408.pdf	2024-03-17	2025-03-17
4218	10491	69	409	t	Alta	/evidencias/10491_409.pdf	2024-06-05	2026-06-05
4219	10491	69	409	f	Media	\N	2025-11-17	2027-11-17
4220	10492	7	40	t	Baja	/evidencias/10492_40.pdf	2023-06-02	2025-06-01
4221	10492	7	41	f	Baja	\N	2025-06-25	2026-06-25
4222	10492	7	41	t	Media	/evidencias/10492_41.pdf	2024-12-31	2026-12-31
4223	10492	7	42	t	Baja	/evidencias/10492_42.pdf	2024-07-12	2025-07-12
4224	10492	7	43	t	Alta	/evidencias/10492_43.pdf	2025-09-10	2027-09-10
4225	10492	7	43	t	Media	/evidencias/10492_43.pdf	2024-03-09	2025-03-09
4226	10492	7	44	t	Media	/evidencias/10492_44.pdf	2024-10-29	2026-10-29
4227	10492	7	44	t	Alta	/evidencias/10492_44.pdf	2024-09-15	2026-09-15
4228	10492	7	45	t	Media	/evidencias/10492_45.pdf	2023-09-30	2024-09-29
4229	10493	58	334	f	Media	\N	2023-09-15	2025-09-14
4230	10493	58	335	t	Alta	/evidencias/10493_335.pdf	2024-08-05	2026-08-05
4231	10493	58	336	t	Media	/evidencias/10493_336.pdf	2024-05-09	2025-05-09
4232	10493	58	336	t	Media	/evidencias/10493_336.pdf	2024-12-27	2025-12-27
4233	10493	58	337	f	Baja	\N	2025-03-27	2026-03-27
4234	10494	44	253	f	Baja	\N	2024-12-31	2026-12-31
4235	10494	44	253	f	Media	\N	2025-12-06	2026-12-06
4236	10494	44	254	t	Media	/evidencias/10494_254.pdf	2025-01-11	2027-01-11
4237	10494	44	254	t	Baja	/evidencias/10494_254.pdf	2025-10-24	2027-10-24
4238	10494	44	255	t	Alta	/evidencias/10494_255.pdf	2025-12-24	2026-12-24
4239	10494	44	255	t	Alta	/evidencias/10494_255.pdf	2023-11-17	2025-11-16
4240	10494	44	256	f	Media	\N	2024-11-25	2025-11-25
4241	10495	45	257	t	Media	/evidencias/10495_257.pdf	2024-05-11	2025-05-11
4242	10495	45	258	t	Media	/evidencias/10495_258.pdf	2025-10-22	2026-10-22
4243	10495	45	258	t	Baja	/evidencias/10495_258.pdf	2025-03-19	2027-03-19
4244	10495	45	259	f	Media	\N	2023-09-19	2025-09-18
4245	10495	45	259	t	Baja	/evidencias/10495_259.pdf	2025-09-21	2027-09-21
4246	10495	45	260	t	Baja	/evidencias/10495_260.pdf	2026-05-15	2027-05-15
4247	10495	45	261	f	Alta	\N	2025-03-03	2026-03-03
4248	10495	45	261	f	Baja	\N	2023-06-09	2025-06-08
4249	10495	45	262	t	Media	/evidencias/10495_262.pdf	2023-10-10	2024-10-09
4250	10495	45	262	t	Alta	/evidencias/10495_262.pdf	2023-10-01	2024-09-30
4251	10495	45	263	f	Alta	\N	2025-07-02	2027-07-02
4252	10495	45	264	t	Media	/evidencias/10495_264.pdf	2026-03-05	2027-03-05
4253	10496	71	417	t	Media	/evidencias/10496_417.pdf	2024-08-22	2026-08-22
4254	10496	71	418	f	Media	\N	2026-05-16	2028-05-15
4255	10496	71	418	t	Media	/evidencias/10496_418.pdf	2025-12-10	2026-12-10
4256	10496	71	419	t	Baja	/evidencias/10496_419.pdf	2026-05-03	2028-05-02
4257	10496	71	419	t	Media	/evidencias/10496_419.pdf	2025-10-25	2027-10-25
4258	10496	71	420	t	Media	/evidencias/10496_420.pdf	2023-08-27	2025-08-26
4259	10496	71	420	t	Alta	/evidencias/10496_420.pdf	2024-05-19	2025-05-19
4260	10496	71	421	t	Media	/evidencias/10496_421.pdf	2025-01-11	2027-01-11
4261	10496	71	422	t	Alta	/evidencias/10496_422.pdf	2024-01-03	2026-01-02
4262	10496	71	422	t	Alta	/evidencias/10496_422.pdf	2024-07-16	2025-07-16
4263	10496	71	423	t	Alta	/evidencias/10496_423.pdf	2025-09-27	2026-09-27
4264	10496	71	423	f	Media	\N	2023-09-04	2024-09-03
4265	10496	71	424	f	Media	\N	2026-04-27	2028-04-26
4266	10496	71	424	t	Baja	/evidencias/10496_424.pdf	2023-06-15	2025-06-14
4267	10497	41	232	f	Alta	\N	2023-07-20	2024-07-19
4268	10497	41	233	f	Alta	\N	2023-11-16	2025-11-15
4269	10497	41	234	f	Media	\N	2023-10-09	2025-10-08
4270	10497	41	235	t	Alta	/evidencias/10497_235.pdf	2024-07-08	2026-07-08
4271	10497	41	236	t	Baja	/evidencias/10497_236.pdf	2025-02-21	2026-02-21
4272	10497	41	237	t	Alta	/evidencias/10497_237.pdf	2024-04-20	2026-04-20
4273	10497	41	237	f	Media	\N	2023-08-26	2025-08-25
4274	10497	41	238	t	Alta	/evidencias/10497_238.pdf	2024-05-11	2025-05-11
4275	10498	58	334	f	Baja	\N	2024-09-26	2025-09-26
4276	10498	58	334	t	Media	/evidencias/10498_334.pdf	2024-09-21	2026-09-21
4277	10498	58	335	f	Media	\N	2025-02-22	2026-02-22
4278	10498	58	336	t	Alta	/evidencias/10498_336.pdf	2023-10-14	2024-10-13
4279	10498	58	337	f	Media	\N	2025-03-17	2027-03-17
4280	10500	39	220	f	Alta	\N	2024-12-23	2026-12-23
4281	10500	39	220	f	Baja	\N	2025-09-07	2026-09-07
4282	10500	39	221	t	Alta	/evidencias/10500_221.pdf	2025-12-11	2027-12-11
4283	10500	39	222	t	Media	/evidencias/10500_222.pdf	2024-02-24	2025-02-23
4284	10500	39	222	t	Media	/evidencias/10500_222.pdf	2024-02-25	2026-02-24
4285	10500	39	223	t	Baja	/evidencias/10500_223.pdf	2026-03-24	2027-03-24
4286	10500	39	224	t	Baja	/evidencias/10500_224.pdf	2023-09-20	2025-09-19
4287	10500	39	225	t	Baja	/evidencias/10500_225.pdf	2025-04-06	2026-04-06
4288	10501	70	410	t	Baja	/evidencias/10501_410.pdf	2025-07-07	2026-07-07
4289	10501	70	410	f	Media	\N	2025-05-08	2027-05-08
4290	10501	70	411	t	Media	/evidencias/10501_411.pdf	2024-02-03	2026-02-02
4291	10501	70	411	t	Baja	/evidencias/10501_411.pdf	2023-11-26	2025-11-25
4292	10501	70	412	f	Baja	\N	2024-06-03	2025-06-03
4293	10501	70	412	f	Alta	\N	2025-08-19	2027-08-19
4294	10501	70	413	t	Media	/evidencias/10501_413.pdf	2026-03-10	2028-03-09
4295	10501	70	414	t	Media	/evidencias/10501_414.pdf	2023-10-18	2024-10-17
4296	10501	70	415	t	Alta	/evidencias/10501_415.pdf	2025-09-01	2027-09-01
4297	10501	70	415	t	Alta	/evidencias/10501_415.pdf	2025-11-24	2026-11-24
4298	10501	70	416	f	Media	\N	2024-02-10	2025-02-09
4299	10501	70	416	t	Baja	/evidencias/10501_416.pdf	2024-06-21	2025-06-21
4300	10502	68	396	t	Baja	/evidencias/10502_396.pdf	2024-12-30	2025-12-30
4301	10502	68	397	t	Baja	/evidencias/10502_397.pdf	2023-10-26	2024-10-25
4302	10502	68	397	t	Baja	/evidencias/10502_397.pdf	2025-03-28	2026-03-28
4303	10502	68	398	t	Baja	/evidencias/10502_398.pdf	2025-11-30	2027-11-30
4304	10502	68	399	t	Alta	/evidencias/10502_399.pdf	2026-01-02	2027-01-02
4305	10502	68	399	t	Alta	/evidencias/10502_399.pdf	2024-10-12	2025-10-12
4306	10502	68	400	t	Alta	/evidencias/10502_400.pdf	2025-03-31	2026-03-31
4307	10502	68	400	f	Alta	\N	2024-08-20	2025-08-20
4308	10502	68	401	f	Alta	\N	2026-03-12	2027-03-12
4309	10502	68	401	f	Media	\N	2024-08-26	2025-08-26
4310	10502	68	402	t	Alta	/evidencias/10502_402.pdf	2026-02-26	2028-02-26
4311	10502	68	402	t	Alta	/evidencias/10502_402.pdf	2026-01-20	2028-01-20
4312	10502	68	403	t	Alta	/evidencias/10502_403.pdf	2023-11-26	2024-11-25
4313	10502	68	403	f	Baja	\N	2025-04-17	2027-04-17
4314	10503	2	8	f	Baja	\N	2024-03-07	2025-03-07
4315	10503	2	9	t	Baja	/evidencias/10503_9.pdf	2026-04-16	2027-04-16
4316	10503	2	9	t	Media	/evidencias/10503_9.pdf	2023-07-11	2025-07-10
4317	10503	2	10	t	Media	/evidencias/10503_10.pdf	2024-05-12	2025-05-12
4318	10503	2	11	t	Alta	/evidencias/10503_11.pdf	2026-02-23	2028-02-23
4319	10503	2	12	t	Baja	/evidencias/10503_12.pdf	2025-11-22	2027-11-22
4320	10503	2	13	t	Media	/evidencias/10503_13.pdf	2024-02-13	2026-02-12
4321	10503	2	13	t	Media	/evidencias/10503_13.pdf	2024-09-01	2026-09-01
4322	10504	55	321	t	Alta	/evidencias/10504_321.pdf	2024-09-07	2025-09-07
4323	10504	55	322	t	Baja	/evidencias/10504_322.pdf	2025-01-02	2027-01-02
4324	10504	55	322	t	Media	/evidencias/10504_322.pdf	2025-03-13	2027-03-13
4325	10504	55	323	f	Baja	\N	2024-06-14	2026-06-14
4326	10504	55	323	t	Alta	/evidencias/10504_323.pdf	2025-04-27	2027-04-27
4327	10504	55	324	t	Baja	/evidencias/10504_324.pdf	2025-09-30	2027-09-30
4328	10505	88	517	f	Alta	\N	2024-12-21	2026-12-21
4329	10505	88	517	f	Media	\N	2024-12-28	2025-12-28
4330	10505	88	518	t	Alta	/evidencias/10505_518.pdf	2023-09-10	2025-09-09
4331	10505	88	518	f	Media	\N	2023-10-13	2025-10-12
4332	10505	88	519	t	Media	/evidencias/10505_519.pdf	2024-09-25	2026-09-25
4333	10505	88	519	t	Media	/evidencias/10505_519.pdf	2024-07-26	2025-07-26
4334	10505	88	520	t	Baja	/evidencias/10505_520.pdf	2025-07-08	2027-07-08
4335	10505	88	520	t	Baja	/evidencias/10505_520.pdf	2024-11-16	2025-11-16
4336	10505	88	521	f	Media	\N	2024-06-13	2026-06-13
4337	10505	88	522	t	Media	/evidencias/10505_522.pdf	2025-04-24	2027-04-24
4338	10505	88	523	t	Baja	/evidencias/10505_523.pdf	2024-10-03	2025-10-03
4339	10506	42	239	f	Media	\N	2023-06-11	2024-06-10
4340	10506	42	240	f	Alta	\N	2024-06-25	2026-06-25
4341	10506	42	240	f	Baja	\N	2024-09-12	2025-09-12
4342	10506	42	241	t	Alta	/evidencias/10506_241.pdf	2023-07-30	2025-07-29
4343	10506	42	241	f	Media	\N	2024-04-13	2025-04-13
4344	10506	42	242	t	Alta	/evidencias/10506_242.pdf	2024-04-11	2025-04-11
4345	10506	42	243	t	Baja	/evidencias/10506_243.pdf	2025-08-10	2027-08-10
4346	10506	42	243	f	Media	\N	2024-09-24	2025-09-24
4347	10506	42	244	f	Alta	\N	2025-06-16	2027-06-16
4348	10506	42	245	t	Baja	/evidencias/10506_245.pdf	2024-02-02	2026-02-01
4349	10506	42	246	t	Baja	/evidencias/10506_246.pdf	2025-10-19	2026-10-19
4350	10506	42	246	t	Media	/evidencias/10506_246.pdf	2023-09-22	2024-09-21
4351	10507	96	569	t	Baja	/evidencias/10507_569.pdf	2025-01-15	2026-01-15
4352	10507	96	569	f	Media	\N	2024-12-23	2026-12-23
4353	10507	96	570	f	Alta	\N	2024-10-17	2025-10-17
4354	10507	96	571	t	Baja	/evidencias/10507_571.pdf	2023-10-22	2024-10-21
4355	10507	96	571	t	Media	/evidencias/10507_571.pdf	2025-12-15	2026-12-15
4356	10507	96	572	t	Baja	/evidencias/10507_572.pdf	2024-04-10	2026-04-10
4357	10507	96	572	t	Baja	/evidencias/10507_572.pdf	2024-05-21	2025-05-21
4358	10507	96	573	t	Alta	/evidencias/10507_573.pdf	2023-07-02	2025-07-01
4359	10507	96	574	t	Baja	/evidencias/10507_574.pdf	2025-05-12	2026-05-12
4360	10507	96	575	t	Media	/evidencias/10507_575.pdf	2026-04-24	2028-04-23
4361	10507	96	575	t	Media	/evidencias/10507_575.pdf	2025-09-05	2026-09-05
4362	10507	96	576	f	Media	\N	2024-07-09	2025-07-09
4363	10507	96	576	t	Baja	/evidencias/10507_576.pdf	2024-12-16	2026-12-16
4364	10508	130	777	t	Media	/evidencias/10508_777.pdf	2025-08-13	2026-08-13
4365	10508	130	778	t	Baja	/evidencias/10508_778.pdf	2024-02-06	2025-02-05
4366	10508	130	778	t	Media	/evidencias/10508_778.pdf	2024-06-10	2026-06-10
4367	10508	130	779	f	Alta	\N	2023-07-22	2024-07-21
4368	10508	130	779	t	Baja	/evidencias/10508_779.pdf	2024-10-17	2026-10-17
4369	10508	130	780	f	Baja	\N	2023-11-21	2025-11-20
4370	10509	5	27	t	Media	/evidencias/10509_27.pdf	2025-03-28	2027-03-28
4371	10509	5	28	f	Media	\N	2025-05-28	2026-05-28
4372	10509	5	29	t	Media	/evidencias/10509_29.pdf	2024-01-18	2025-01-17
4373	10509	5	30	t	Media	/evidencias/10509_30.pdf	2023-09-21	2025-09-20
4374	10509	5	31	t	Baja	/evidencias/10509_31.pdf	2026-03-09	2027-03-09
4375	10509	5	31	t	Alta	/evidencias/10509_31.pdf	2025-04-05	2027-04-05
4376	10509	5	32	t	Media	/evidencias/10509_32.pdf	2026-02-24	2027-02-24
4377	10510	49	285	t	Baja	/evidencias/10510_285.pdf	2024-08-31	2025-08-31
4378	10510	49	286	t	Baja	/evidencias/10510_286.pdf	2023-08-29	2024-08-28
4379	10510	49	286	f	Media	\N	2023-08-27	2025-08-26
4380	10510	49	287	t	Media	/evidencias/10510_287.pdf	2024-05-27	2025-05-27
4381	10510	49	287	f	Media	\N	2024-09-14	2026-09-14
4382	10510	49	288	t	Alta	/evidencias/10510_288.pdf	2023-11-30	2024-11-29
4383	10511	114	678	f	Media	\N	2023-12-28	2025-12-27
4384	10511	114	678	t	Alta	/evidencias/10511_678.pdf	2024-11-08	2025-11-08
4385	10511	114	679	t	Alta	/evidencias/10511_679.pdf	2023-07-12	2024-07-11
4386	10511	114	679	t	Media	/evidencias/10511_679.pdf	2024-08-18	2026-08-18
4387	10511	114	680	t	Baja	/evidencias/10511_680.pdf	2025-05-19	2027-05-19
4388	10511	114	681	t	Media	/evidencias/10511_681.pdf	2025-02-25	2027-02-25
4389	10511	114	682	f	Media	\N	2025-08-16	2027-08-16
4390	10511	114	683	t	Media	/evidencias/10511_683.pdf	2025-05-12	2027-05-12
4391	10511	114	684	t	Media	/evidencias/10511_684.pdf	2025-04-04	2027-04-04
4392	10512	138	825	t	Media	/evidencias/10512_825.pdf	2023-10-12	2025-10-11
4393	10512	138	826	t	Media	/evidencias/10512_826.pdf	2023-07-17	2024-07-16
4394	10512	138	827	t	Media	/evidencias/10512_827.pdf	2025-04-08	2026-04-08
4395	10512	138	827	t	Media	/evidencias/10512_827.pdf	2025-10-04	2027-10-04
4396	10512	138	828	f	Alta	\N	2025-11-06	2027-11-06
4397	10512	138	828	t	Baja	/evidencias/10512_828.pdf	2024-07-24	2025-07-24
4398	10513	26	145	t	Alta	/evidencias/10513_145.pdf	2024-05-24	2026-05-24
4399	10513	26	145	t	Alta	/evidencias/10513_145.pdf	2024-06-04	2025-06-04
4400	10513	26	146	f	Baja	\N	2024-12-02	2026-12-02
4401	10513	26	146	f	Baja	\N	2026-05-20	2028-05-19
4402	10513	26	147	f	Media	\N	2026-01-09	2027-01-09
4403	10513	26	148	t	Alta	/evidencias/10513_148.pdf	2024-11-29	2026-11-29
4404	10514	114	678	t	Alta	/evidencias/10514_678.pdf	2023-11-18	2025-11-17
4405	10514	114	678	t	Baja	/evidencias/10514_678.pdf	2024-05-27	2026-05-27
4406	10514	114	679	f	Media	\N	2025-10-26	2026-10-26
4407	10514	114	680	f	Alta	\N	2025-02-22	2027-02-22
4408	10514	114	680	t	Baja	/evidencias/10514_680.pdf	2024-05-02	2025-05-02
4409	10514	114	681	t	Alta	/evidencias/10514_681.pdf	2026-03-10	2028-03-09
4410	10514	114	681	f	Alta	\N	2023-07-05	2024-07-04
4411	10514	114	682	t	Baja	/evidencias/10514_682.pdf	2023-08-29	2024-08-28
4412	10514	114	682	t	Media	/evidencias/10514_682.pdf	2024-06-29	2025-06-29
4413	10514	114	683	t	Media	/evidencias/10514_683.pdf	2024-05-22	2026-05-22
4414	10514	114	683	t	Baja	/evidencias/10514_683.pdf	2024-10-08	2026-10-08
4415	10514	114	684	f	Media	\N	2023-12-16	2024-12-15
4416	10516	21	119	t	Media	/evidencias/10516_119.pdf	2024-10-20	2025-10-20
4417	10516	21	120	t	Media	/evidencias/10516_120.pdf	2025-11-04	2027-11-04
4418	10516	21	120	t	Media	/evidencias/10516_120.pdf	2023-07-23	2024-07-22
4419	10516	21	121	t	Baja	/evidencias/10516_121.pdf	2023-11-27	2025-11-26
4420	10516	21	121	f	Media	\N	2024-07-29	2026-07-29
4421	10516	21	122	t	Media	/evidencias/10516_122.pdf	2025-10-24	2027-10-24
4422	10516	21	122	f	Alta	\N	2025-08-12	2027-08-12
4423	10516	21	123	t	Baja	/evidencias/10516_123.pdf	2024-10-21	2026-10-21
4424	10516	21	123	t	Alta	/evidencias/10516_123.pdf	2026-05-11	2028-05-10
4425	10516	21	124	f	Media	\N	2025-10-19	2027-10-19
4426	10516	21	124	f	Media	\N	2024-06-07	2025-06-07
4427	10517	129	769	t	Media	/evidencias/10517_769.pdf	2023-09-13	2024-09-12
4428	10517	129	770	t	Baja	/evidencias/10517_770.pdf	2025-12-02	2026-12-02
4429	10517	129	770	t	Media	/evidencias/10517_770.pdf	2024-01-07	2026-01-06
4430	10517	129	771	t	Media	/evidencias/10517_771.pdf	2024-03-02	2026-03-02
4431	10517	129	771	t	Baja	/evidencias/10517_771.pdf	2023-06-26	2024-06-25
4432	10517	129	772	f	Media	\N	2024-08-22	2025-08-22
4433	10517	129	772	t	Media	/evidencias/10517_772.pdf	2024-06-07	2026-06-07
4434	10517	129	773	t	Baja	/evidencias/10517_773.pdf	2025-03-01	2027-03-01
4435	10517	129	773	t	Alta	/evidencias/10517_773.pdf	2023-11-05	2025-11-04
4436	10517	129	774	f	Alta	\N	2026-03-03	2028-03-02
4437	10517	129	775	t	Alta	/evidencias/10517_775.pdf	2025-01-17	2026-01-17
4438	10517	129	775	t	Alta	/evidencias/10517_775.pdf	2025-06-21	2027-06-21
4439	10517	129	776	f	Media	\N	2025-12-31	2027-12-31
4440	10518	25	140	t	Alta	/evidencias/10518_140.pdf	2025-02-27	2027-02-27
4441	10518	25	140	f	Alta	\N	2024-07-21	2025-07-21
4442	10518	25	141	f	Media	\N	2023-07-25	2025-07-24
4443	10518	25	142	t	Media	/evidencias/10518_142.pdf	2025-02-01	2027-02-01
4444	10518	25	143	t	Media	/evidencias/10518_143.pdf	2025-08-28	2026-08-28
4445	10518	25	144	f	Media	\N	2026-04-20	2028-04-19
4446	10518	25	144	t	Baja	/evidencias/10518_144.pdf	2025-06-14	2027-06-14
4447	10519	14	81	t	Alta	/evidencias/10519_81.pdf	2025-12-15	2027-12-15
4448	10519	14	82	t	Media	/evidencias/10519_82.pdf	2024-01-05	2026-01-04
4449	10519	14	82	t	Alta	/evidencias/10519_82.pdf	2026-02-15	2027-02-15
4450	10519	14	83	t	Media	/evidencias/10519_83.pdf	2024-05-21	2026-05-21
4451	10519	14	84	f	Media	\N	2026-01-10	2027-01-10
4452	10519	14	84	t	Alta	/evidencias/10519_84.pdf	2026-03-29	2028-03-28
4453	10519	14	85	t	Media	/evidencias/10519_85.pdf	2026-05-14	2027-05-14
4454	10519	14	86	t	Alta	/evidencias/10519_86.pdf	2023-09-18	2024-09-17
4455	10520	26	145	t	Media	/evidencias/10520_145.pdf	2023-07-04	2025-07-03
4456	10520	26	145	t	Media	/evidencias/10520_145.pdf	2026-05-31	2028-05-30
4457	10520	26	146	t	Baja	/evidencias/10520_146.pdf	2025-05-11	2026-05-11
4458	10520	26	146	t	Baja	/evidencias/10520_146.pdf	2024-05-12	2026-05-12
4459	10520	26	147	t	Alta	/evidencias/10520_147.pdf	2023-06-08	2025-06-07
4460	10520	26	148	t	Baja	/evidencias/10520_148.pdf	2025-08-29	2027-08-29
4461	10520	26	148	t	Media	/evidencias/10520_148.pdf	2025-09-24	2027-09-24
4462	10521	84	494	t	Media	/evidencias/10521_494.pdf	2024-07-18	2026-07-18
4463	10521	84	495	f	Media	\N	2024-03-13	2026-03-13
4464	10521	84	495	t	Alta	/evidencias/10521_495.pdf	2023-12-14	2024-12-13
4465	10521	84	496	t	Alta	/evidencias/10521_496.pdf	2024-02-11	2026-02-10
4466	10521	84	496	t	Alta	/evidencias/10521_496.pdf	2025-04-13	2027-04-13
4467	10521	84	497	t	Alta	/evidencias/10521_497.pdf	2024-02-07	2026-02-06
4468	10521	84	497	t	Media	/evidencias/10521_497.pdf	2024-04-20	2025-04-20
4469	10521	84	498	f	Media	\N	2025-07-01	2026-07-01
4470	10522	112	665	f	Baja	\N	2024-10-14	2025-10-14
4471	10522	112	666	t	Media	/evidencias/10522_666.pdf	2026-03-14	2028-03-13
4472	10522	112	666	t	Baja	/evidencias/10522_666.pdf	2025-02-28	2027-02-28
4473	10522	112	667	t	Alta	/evidencias/10522_667.pdf	2025-09-01	2027-09-01
4474	10522	112	668	t	Alta	/evidencias/10522_668.pdf	2024-09-23	2026-09-23
4475	10522	112	668	t	Baja	/evidencias/10522_668.pdf	2024-10-28	2026-10-28
4476	10522	112	669	t	Media	/evidencias/10522_669.pdf	2024-06-09	2025-06-09
4477	10522	112	669	f	Alta	\N	2025-07-03	2027-07-03
4478	10523	65	374	t	Baja	/evidencias/10523_374.pdf	2026-04-27	2027-04-27
4479	10523	65	374	t	Media	/evidencias/10523_374.pdf	2023-10-14	2024-10-13
4480	10523	65	375	t	Baja	/evidencias/10523_375.pdf	2025-10-17	2026-10-17
4481	10523	65	376	f	Alta	\N	2023-12-14	2025-12-13
4482	10523	65	376	f	Media	\N	2025-09-22	2027-09-22
4483	10523	65	377	t	Alta	/evidencias/10523_377.pdf	2025-10-27	2026-10-27
4484	10523	65	377	f	Baja	\N	2025-08-10	2027-08-10
4485	10523	65	378	t	Alta	/evidencias/10523_378.pdf	2026-05-05	2028-05-04
4486	10523	65	378	t	Alta	/evidencias/10523_378.pdf	2025-01-11	2026-01-11
4487	10523	65	379	t	Alta	/evidencias/10523_379.pdf	2024-07-24	2026-07-24
4488	10523	65	380	t	Media	/evidencias/10523_380.pdf	2026-03-21	2028-03-20
4489	10523	65	380	t	Media	/evidencias/10523_380.pdf	2024-02-20	2026-02-19
4490	10523	65	381	t	Media	/evidencias/10523_381.pdf	2023-07-21	2025-07-20
4491	10525	40	226	t	Media	/evidencias/10525_226.pdf	2025-10-26	2026-10-26
4492	10525	40	227	t	Alta	/evidencias/10525_227.pdf	2025-04-28	2027-04-28
4493	10525	40	228	t	Alta	/evidencias/10525_228.pdf	2024-10-12	2025-10-12
4494	10525	40	228	f	Media	\N	2024-06-03	2026-06-03
4495	10525	40	229	f	Media	\N	2025-10-07	2027-10-07
4496	10525	40	229	t	Media	/evidencias/10525_229.pdf	2026-02-12	2028-02-12
4497	10525	40	230	t	Alta	/evidencias/10525_230.pdf	2025-06-19	2027-06-19
4498	10525	40	231	t	Media	/evidencias/10525_231.pdf	2025-01-17	2026-01-17
4499	10525	40	231	t	Alta	/evidencias/10525_231.pdf	2025-04-29	2027-04-29
4500	10526	62	352	t	Media	/evidencias/10526_352.pdf	2025-01-04	2027-01-04
4501	10526	62	353	f	Media	\N	2025-12-23	2026-12-23
4502	10526	62	354	t	Media	/evidencias/10526_354.pdf	2025-01-09	2026-01-09
4503	10526	62	354	f	Alta	\N	2024-11-12	2025-11-12
4504	10526	62	355	t	Baja	/evidencias/10526_355.pdf	2024-03-27	2026-03-27
4505	10526	62	356	f	Media	\N	2024-11-12	2026-11-12
4506	10526	62	357	f	Alta	\N	2025-11-16	2026-11-16
4507	10526	62	357	f	Baja	\N	2026-05-25	2028-05-24
4508	10526	62	358	t	Baja	/evidencias/10526_358.pdf	2026-01-07	2028-01-07
4509	10526	62	358	t	Alta	/evidencias/10526_358.pdf	2024-06-24	2026-06-24
4510	10526	62	359	t	Media	/evidencias/10526_359.pdf	2024-04-16	2026-04-16
4511	10526	62	359	t	Baja	/evidencias/10526_359.pdf	2025-12-07	2026-12-07
4512	10527	133	796	f	Baja	\N	2024-01-13	2025-01-12
4513	10527	133	796	t	Alta	/evidencias/10527_796.pdf	2025-02-04	2026-02-04
4514	10527	133	797	t	Baja	/evidencias/10527_797.pdf	2025-06-07	2027-06-07
4515	10527	133	798	f	Media	\N	2026-01-21	2028-01-21
4516	10527	133	799	t	Alta	/evidencias/10527_799.pdf	2026-05-07	2027-05-07
4517	10527	133	799	f	Baja	\N	2025-05-30	2027-05-30
4518	10527	133	800	t	Alta	/evidencias/10527_800.pdf	2025-09-23	2027-09-23
4519	10527	133	801	f	Alta	\N	2023-07-16	2024-07-15
4520	10527	133	801	t	Baja	/evidencias/10527_801.pdf	2025-04-20	2026-04-20
4521	10528	104	619	f	Media	\N	2023-12-24	2024-12-23
4522	10528	104	619	f	Media	\N	2024-07-07	2026-07-07
4523	10528	104	620	f	Baja	\N	2024-05-28	2026-05-28
4524	10528	104	621	t	Media	/evidencias/10528_621.pdf	2025-12-23	2027-12-23
4525	10528	104	622	t	Baja	/evidencias/10528_622.pdf	2024-04-19	2025-04-19
4526	10528	104	623	t	Baja	/evidencias/10528_623.pdf	2023-07-18	2025-07-17
4527	10528	104	624	t	Alta	/evidencias/10528_624.pdf	2025-12-19	2026-12-19
4528	10528	104	624	t	Media	/evidencias/10528_624.pdf	2024-03-24	2026-03-24
4529	10528	104	625	t	Media	/evidencias/10528_625.pdf	2023-06-07	2024-06-06
4530	10528	104	625	t	Alta	/evidencias/10528_625.pdf	2025-02-25	2026-02-25
4531	10529	121	717	t	Baja	/evidencias/10529_717.pdf	2025-10-03	2026-10-03
4532	10529	121	718	t	Alta	/evidencias/10529_718.pdf	2024-12-04	2026-12-04
4533	10529	121	719	f	Alta	\N	2026-05-02	2028-05-01
4534	10529	121	720	t	Media	/evidencias/10529_720.pdf	2023-06-27	2024-06-26
4535	10529	121	720	f	Media	\N	2025-03-05	2027-03-05
4536	10529	121	721	f	Baja	\N	2026-02-28	2027-02-28
4537	10529	121	722	t	Media	/evidencias/10529_722.pdf	2026-02-18	2028-02-18
4538	10529	121	722	t	Media	/evidencias/10529_722.pdf	2026-01-03	2027-01-03
4539	10529	121	723	t	Alta	/evidencias/10529_723.pdf	2023-09-27	2025-09-26
4540	10530	113	670	f	Media	\N	2025-02-25	2026-02-25
4541	10530	113	670	f	Media	\N	2023-10-29	2024-10-28
4542	10530	113	671	t	Media	/evidencias/10530_671.pdf	2023-12-08	2025-12-07
4543	10530	113	672	f	Alta	\N	2025-04-02	2026-04-02
4544	10530	113	673	t	Baja	/evidencias/10530_673.pdf	2023-12-19	2024-12-18
4545	10530	113	674	t	Media	/evidencias/10530_674.pdf	2025-06-17	2026-06-17
4546	10530	113	675	t	Media	/evidencias/10530_675.pdf	2024-01-09	2026-01-08
4547	10530	113	676	t	Media	/evidencias/10530_676.pdf	2025-12-21	2026-12-21
4548	10530	113	676	t	Media	/evidencias/10530_676.pdf	2023-12-24	2025-12-23
4549	10530	113	677	t	Media	/evidencias/10530_677.pdf	2025-09-01	2027-09-01
4550	10531	130	777	t	Baja	/evidencias/10531_777.pdf	2025-02-21	2026-02-21
4551	10531	130	777	t	Baja	/evidencias/10531_777.pdf	2024-12-25	2025-12-25
4552	10531	130	778	f	Baja	\N	2024-06-17	2025-06-17
4553	10531	130	778	t	Media	/evidencias/10531_778.pdf	2024-07-29	2025-07-29
4554	10531	130	779	t	Alta	/evidencias/10531_779.pdf	2026-01-30	2028-01-30
4555	10531	130	780	t	Baja	/evidencias/10531_780.pdf	2024-04-30	2026-04-30
4556	10532	113	670	f	Alta	\N	2025-02-28	2027-02-28
4557	10532	113	670	f	Media	\N	2024-01-17	2026-01-16
4558	10532	113	671	t	Baja	/evidencias/10532_671.pdf	2024-05-21	2026-05-21
4559	10532	113	671	f	Media	\N	2024-03-14	2026-03-14
4560	10532	113	672	t	Baja	/evidencias/10532_672.pdf	2024-11-20	2026-11-20
4561	10532	113	673	f	Alta	\N	2025-07-28	2026-07-28
4562	10532	113	674	t	Alta	/evidencias/10532_674.pdf	2026-05-24	2027-05-24
4563	10532	113	674	t	Alta	/evidencias/10532_674.pdf	2025-11-11	2026-11-11
4564	10532	113	675	t	Media	/evidencias/10532_675.pdf	2024-02-03	2026-02-02
4565	10532	113	676	t	Media	/evidencias/10532_676.pdf	2023-10-17	2025-10-16
4566	10532	113	676	f	Baja	\N	2026-01-24	2027-01-24
4567	10532	113	677	t	Baja	/evidencias/10532_677.pdf	2024-06-17	2025-06-17
4568	10532	113	677	t	Media	/evidencias/10532_677.pdf	2024-09-19	2025-09-19
4569	10533	44	253	t	Baja	/evidencias/10533_253.pdf	2024-07-12	2026-07-12
4570	10533	44	253	t	Media	/evidencias/10533_253.pdf	2023-08-10	2024-08-09
4571	10533	44	254	t	Alta	/evidencias/10533_254.pdf	2024-09-09	2026-09-09
4572	10533	44	254	t	Baja	/evidencias/10533_254.pdf	2024-01-17	2026-01-16
4573	10533	44	255	t	Alta	/evidencias/10533_255.pdf	2024-12-01	2025-12-01
4574	10533	44	255	t	Media	/evidencias/10533_255.pdf	2024-09-16	2025-09-16
4575	10533	44	256	t	Media	/evidencias/10533_256.pdf	2023-11-30	2025-11-29
4576	10533	44	256	f	Baja	\N	2026-05-10	2027-05-10
4577	10534	20	113	f	Media	\N	2024-03-27	2026-03-27
4578	10534	20	113	f	Alta	\N	2025-09-17	2026-09-17
4579	10534	20	114	t	Media	/evidencias/10534_114.pdf	2025-12-23	2027-12-23
4580	10534	20	114	t	Baja	/evidencias/10534_114.pdf	2026-01-08	2027-01-08
4581	10534	20	115	t	Media	/evidencias/10534_115.pdf	2026-03-19	2028-03-18
4582	10534	20	116	f	Media	\N	2025-06-17	2027-06-17
4583	10534	20	117	t	Media	/evidencias/10534_117.pdf	2024-03-11	2026-03-11
4584	10534	20	118	t	Media	/evidencias/10534_118.pdf	2023-07-24	2025-07-23
4585	10534	20	118	f	Alta	\N	2024-12-21	2026-12-21
4586	10535	51	295	t	Baja	/evidencias/10535_295.pdf	2026-04-17	2027-04-17
4587	10535	51	296	t	Media	/evidencias/10535_296.pdf	2025-09-11	2026-09-11
4588	10535	51	296	f	Alta	\N	2026-01-07	2027-01-07
4589	10535	51	297	t	Media	/evidencias/10535_297.pdf	2025-03-04	2026-03-04
4590	10535	51	298	t	Baja	/evidencias/10535_298.pdf	2024-05-11	2026-05-11
4591	10535	51	298	t	Baja	/evidencias/10535_298.pdf	2024-12-16	2026-12-16
4592	10535	51	299	f	Media	\N	2025-10-20	2027-10-20
4593	10535	51	299	t	Alta	/evidencias/10535_299.pdf	2024-01-29	2026-01-28
4594	10535	51	300	t	Media	/evidencias/10535_300.pdf	2025-08-06	2027-08-06
4595	10535	51	301	f	Alta	\N	2024-05-19	2026-05-19
4596	10535	51	302	f	Media	\N	2024-07-13	2025-07-13
4597	10535	51	302	f	Media	\N	2025-04-06	2027-04-06
4598	10536	14	81	f	Baja	\N	2023-12-01	2024-11-30
4599	10536	14	81	t	Alta	/evidencias/10536_81.pdf	2025-03-30	2026-03-30
4600	10536	14	82	t	Alta	/evidencias/10536_82.pdf	2026-02-25	2028-02-25
4601	10536	14	83	t	Alta	/evidencias/10536_83.pdf	2025-05-21	2027-05-21
4602	10536	14	83	t	Media	/evidencias/10536_83.pdf	2024-08-10	2026-08-10
4603	10536	14	84	t	Alta	/evidencias/10536_84.pdf	2024-09-05	2026-09-05
4604	10536	14	84	f	Alta	\N	2025-10-06	2027-10-06
4605	10536	14	85	f	Alta	\N	2023-08-20	2025-08-19
4606	10536	14	85	f	Alta	\N	2024-06-24	2025-06-24
4607	10536	14	86	t	Media	/evidencias/10536_86.pdf	2024-11-09	2025-11-09
4608	10536	14	86	t	Baja	/evidencias/10536_86.pdf	2023-07-31	2024-07-30
4609	10537	125	746	t	Media	/evidencias/10537_746.pdf	2024-01-24	2026-01-23
4610	10537	125	746	t	Baja	/evidencias/10537_746.pdf	2025-10-24	2027-10-24
4611	10537	125	747	t	Baja	/evidencias/10537_747.pdf	2025-01-22	2026-01-22
4612	10537	125	748	t	Media	/evidencias/10537_748.pdf	2024-09-02	2026-09-02
4613	10537	125	748	t	Media	/evidencias/10537_748.pdf	2023-08-30	2024-08-29
4614	10537	125	749	t	Alta	/evidencias/10537_749.pdf	2026-05-16	2027-05-16
4615	10537	125	749	t	Media	/evidencias/10537_749.pdf	2023-07-28	2025-07-27
4616	10537	125	750	f	Media	\N	2025-09-10	2026-09-10
4617	10537	125	751	t	Alta	/evidencias/10537_751.pdf	2025-06-30	2027-06-30
4618	10537	125	752	t	Media	/evidencias/10537_752.pdf	2023-11-04	2025-11-03
4619	10538	100	595	f	Media	\N	2024-12-06	2025-12-06
4620	10538	100	595	f	Baja	\N	2026-01-01	2028-01-01
4621	10538	100	596	t	Media	/evidencias/10538_596.pdf	2025-09-23	2026-09-23
4622	10538	100	597	t	Alta	/evidencias/10538_597.pdf	2023-08-09	2025-08-08
4623	10538	100	598	t	Baja	/evidencias/10538_598.pdf	2026-02-12	2027-02-12
4624	10538	100	599	t	Alta	/evidencias/10538_599.pdf	2025-11-04	2026-11-04
4625	10538	100	600	f	Media	\N	2023-11-18	2025-11-17
4626	10538	100	601	f	Media	\N	2025-02-28	2027-02-28
4627	10538	100	602	t	Alta	/evidencias/10538_602.pdf	2025-01-28	2026-01-28
4628	10539	98	582	t	Media	/evidencias/10539_582.pdf	2025-11-22	2026-11-22
4629	10539	98	583	f	Alta	\N	2025-10-04	2027-10-04
4630	10539	98	583	f	Media	\N	2024-12-02	2026-12-02
4631	10539	98	584	t	Alta	/evidencias/10539_584.pdf	2023-08-04	2025-08-03
4632	10539	98	584	t	Media	/evidencias/10539_584.pdf	2025-02-21	2026-02-21
4633	10539	98	585	f	Alta	\N	2025-11-18	2027-11-18
4634	10539	98	585	t	Media	/evidencias/10539_585.pdf	2025-04-04	2026-04-04
4635	10539	98	586	t	Media	/evidencias/10539_586.pdf	2023-09-05	2024-09-04
4636	10539	98	587	t	Media	/evidencias/10539_587.pdf	2025-10-13	2026-10-13
4637	10539	98	588	t	Alta	/evidencias/10539_588.pdf	2025-06-10	2026-06-10
4638	10539	98	588	t	Media	/evidencias/10539_588.pdf	2024-10-24	2025-10-24
4639	10540	81	475	t	Media	/evidencias/10540_475.pdf	2026-03-12	2027-03-12
4640	10540	81	475	f	Alta	\N	2025-05-05	2026-05-05
4641	10540	81	476	t	Baja	/evidencias/10540_476.pdf	2024-06-29	2026-06-29
4642	10540	81	477	t	Baja	/evidencias/10540_477.pdf	2026-03-31	2027-03-31
4643	10540	81	478	t	Baja	/evidencias/10540_478.pdf	2023-09-12	2024-09-11
4644	10540	81	479	t	Baja	/evidencias/10540_479.pdf	2024-04-06	2026-04-06
4645	10540	81	480	f	Media	\N	2026-02-20	2027-02-20
4646	10540	81	480	f	Alta	\N	2023-12-21	2024-12-20
4647	10540	81	481	t	Media	/evidencias/10540_481.pdf	2024-08-18	2025-08-18
4648	10540	81	481	t	Alta	/evidencias/10540_481.pdf	2025-05-10	2026-05-10
4649	10541	48	277	f	Media	\N	2024-05-14	2025-05-14
4650	10541	48	278	f	Media	\N	2026-01-17	2028-01-17
4651	10541	48	278	f	Media	\N	2024-03-11	2025-03-11
4652	10541	48	279	t	Media	/evidencias/10541_279.pdf	2025-02-17	2027-02-17
4653	10541	48	279	f	Alta	\N	2023-12-23	2024-12-22
4654	10541	48	280	t	Media	/evidencias/10541_280.pdf	2025-06-14	2027-06-14
4655	10541	48	280	t	Alta	/evidencias/10541_280.pdf	2024-03-04	2025-03-04
4656	10541	48	281	t	Media	/evidencias/10541_281.pdf	2025-06-05	2026-06-05
4657	10541	48	281	t	Alta	/evidencias/10541_281.pdf	2025-03-23	2026-03-23
4658	10541	48	282	t	Media	/evidencias/10541_282.pdf	2024-06-24	2025-06-24
4659	10541	48	283	t	Baja	/evidencias/10541_283.pdf	2024-12-13	2026-12-13
4660	10541	48	284	t	Alta	/evidencias/10541_284.pdf	2025-11-07	2026-11-07
4661	10541	48	284	t	Alta	/evidencias/10541_284.pdf	2025-11-29	2026-11-29
4662	10542	28	156	t	Media	/evidencias/10542_156.pdf	2024-12-17	2025-12-17
4663	10542	28	156	t	Alta	/evidencias/10542_156.pdf	2024-07-07	2025-07-07
4664	10542	28	157	t	Media	/evidencias/10542_157.pdf	2026-05-16	2027-05-16
4665	10542	28	158	f	Alta	\N	2025-11-01	2026-11-01
4666	10542	28	158	f	Alta	\N	2026-04-28	2028-04-27
4667	10542	28	159	t	Media	/evidencias/10542_159.pdf	2025-11-28	2027-11-28
4668	10542	28	159	t	Media	/evidencias/10542_159.pdf	2025-05-08	2027-05-08
4669	10542	28	160	f	Alta	\N	2024-05-12	2026-05-12
4670	10542	28	161	f	Media	\N	2026-01-09	2028-01-09
4671	10544	132	788	t	Media	/evidencias/10544_788.pdf	2025-06-25	2026-06-25
4672	10544	132	789	t	Media	/evidencias/10544_789.pdf	2025-09-21	2027-09-21
4673	10544	132	790	t	Baja	/evidencias/10544_790.pdf	2025-08-07	2027-08-07
4674	10544	132	790	t	Media	/evidencias/10544_790.pdf	2025-04-23	2026-04-23
4675	10544	132	791	t	Media	/evidencias/10544_791.pdf	2024-09-21	2025-09-21
4676	10544	132	792	t	Baja	/evidencias/10544_792.pdf	2024-05-25	2025-05-25
4677	10544	132	793	t	Baja	/evidencias/10544_793.pdf	2024-07-23	2025-07-23
4678	10544	132	793	t	Baja	/evidencias/10544_793.pdf	2023-06-18	2025-06-17
4679	10544	132	794	f	Media	\N	2026-02-12	2028-02-12
4680	10544	132	794	f	Baja	\N	2025-12-10	2027-12-10
4681	10544	132	795	t	Media	/evidencias/10544_795.pdf	2023-06-22	2024-06-21
4682	10544	132	795	t	Alta	/evidencias/10544_795.pdf	2024-10-07	2026-10-07
4683	10545	7	40	t	Baja	/evidencias/10545_40.pdf	2024-09-04	2025-09-04
4684	10545	7	40	t	Alta	/evidencias/10545_40.pdf	2024-08-28	2026-08-28
4685	10545	7	41	t	Alta	/evidencias/10545_41.pdf	2026-04-03	2027-04-03
4686	10545	7	41	t	Media	/evidencias/10545_41.pdf	2024-03-10	2026-03-10
4687	10545	7	42	f	Media	\N	2024-05-16	2026-05-16
4688	10545	7	43	t	Media	/evidencias/10545_43.pdf	2023-07-13	2024-07-12
4689	10545	7	43	t	Media	/evidencias/10545_43.pdf	2024-10-28	2025-10-28
4690	10545	7	44	t	Alta	/evidencias/10545_44.pdf	2025-12-24	2027-12-24
4691	10545	7	45	t	Alta	/evidencias/10545_45.pdf	2025-04-09	2027-04-09
4692	10546	147	877	t	Alta	/evidencias/10546_877.pdf	2025-12-28	2026-12-28
4693	10546	147	877	f	Baja	\N	2026-01-06	2028-01-06
4694	10546	147	878	f	Alta	\N	2025-01-15	2027-01-15
4695	10546	147	879	t	Baja	/evidencias/10546_879.pdf	2025-03-20	2026-03-20
4696	10546	147	879	t	Baja	/evidencias/10546_879.pdf	2024-01-06	2025-01-05
4697	10546	147	880	t	Media	/evidencias/10546_880.pdf	2024-02-22	2026-02-21
4698	10546	147	880	t	Media	/evidencias/10546_880.pdf	2024-02-11	2026-02-10
4699	10546	147	881	f	Alta	\N	2023-10-06	2024-10-05
4700	10547	76	447	t	Media	/evidencias/10547_447.pdf	2024-05-11	2025-05-11
4701	10547	76	447	f	Media	\N	2025-05-16	2027-05-16
4702	10547	76	448	t	Media	/evidencias/10547_448.pdf	2024-03-29	2025-03-29
4703	10547	76	449	t	Media	/evidencias/10547_449.pdf	2026-01-22	2028-01-22
4704	10547	76	450	t	Alta	/evidencias/10547_450.pdf	2025-01-07	2027-01-07
4705	10547	76	451	f	Media	\N	2024-04-12	2025-04-12
4706	10547	76	452	t	Alta	/evidencias/10547_452.pdf	2025-11-04	2027-11-04
4707	10547	76	453	t	Media	/evidencias/10547_453.pdf	2023-08-11	2025-08-10
4708	10547	76	453	t	Media	/evidencias/10547_453.pdf	2026-01-15	2028-01-15
4709	10548	52	303	f	Baja	\N	2024-10-15	2025-10-15
4710	10548	52	303	t	Baja	/evidencias/10548_303.pdf	2024-09-09	2025-09-09
4711	10548	52	304	t	Alta	/evidencias/10548_304.pdf	2024-10-21	2026-10-21
4712	10548	52	304	t	Media	/evidencias/10548_304.pdf	2025-10-11	2027-10-11
4713	10548	52	305	t	Media	/evidencias/10548_305.pdf	2024-05-24	2026-05-24
4714	10548	52	305	f	Alta	\N	2024-07-20	2026-07-20
4715	10548	52	306	t	Media	/evidencias/10548_306.pdf	2025-08-07	2027-08-07
4716	10548	52	306	t	Alta	/evidencias/10548_306.pdf	2024-08-18	2025-08-18
4717	10548	52	307	f	Alta	\N	2025-06-12	2027-06-12
4718	10548	52	307	t	Media	/evidencias/10548_307.pdf	2025-10-14	2027-10-14
4719	10548	52	308	f	Alta	\N	2025-05-28	2026-05-28
4720	10548	52	309	t	Alta	/evidencias/10548_309.pdf	2025-12-05	2027-12-05
4721	10548	52	309	t	Alta	/evidencias/10548_309.pdf	2025-06-05	2027-06-05
4722	10548	52	310	f	Media	\N	2025-12-23	2026-12-23
4723	10548	52	310	t	Baja	/evidencias/10548_310.pdf	2025-02-16	2027-02-16
4724	10549	79	463	t	Baja	/evidencias/10549_463.pdf	2024-10-26	2025-10-26
4725	10549	79	464	t	Media	/evidencias/10549_464.pdf	2024-09-12	2025-09-12
4726	10549	79	465	t	Media	/evidencias/10549_465.pdf	2025-09-13	2027-09-13
4727	10549	79	466	t	Alta	/evidencias/10549_466.pdf	2024-06-25	2026-06-25
4728	10549	79	467	f	Media	\N	2024-10-22	2026-10-22
4729	10549	79	467	t	Baja	/evidencias/10549_467.pdf	2023-12-24	2024-12-23
4730	10549	79	468	t	Alta	/evidencias/10549_468.pdf	2023-07-02	2024-07-01
4731	10549	79	468	t	Baja	/evidencias/10549_468.pdf	2025-08-01	2026-08-01
4732	10550	43	247	f	Baja	\N	2023-07-04	2024-07-03
4733	10550	43	248	t	Media	/evidencias/10550_248.pdf	2023-10-28	2024-10-27
4734	10550	43	249	f	Baja	\N	2026-05-29	2027-05-29
4735	10550	43	249	t	Media	/evidencias/10550_249.pdf	2026-01-17	2027-01-17
4736	10550	43	250	t	Media	/evidencias/10550_250.pdf	2026-05-26	2028-05-25
4737	10550	43	251	t	Alta	/evidencias/10550_251.pdf	2025-07-31	2027-07-31
4738	10550	43	251	t	Baja	/evidencias/10550_251.pdf	2024-10-23	2025-10-23
4739	10550	43	252	t	Media	/evidencias/10550_252.pdf	2024-09-21	2025-09-21
4740	10551	21	119	t	Media	/evidencias/10551_119.pdf	2026-01-19	2028-01-19
4741	10551	21	119	t	Baja	/evidencias/10551_119.pdf	2024-10-12	2025-10-12
4742	10551	21	120	t	Alta	/evidencias/10551_120.pdf	2023-12-18	2025-12-17
4743	10551	21	121	t	Alta	/evidencias/10551_121.pdf	2025-01-14	2026-01-14
4744	10551	21	122	t	Media	/evidencias/10551_122.pdf	2024-12-19	2026-12-19
4745	10551	21	123	f	Baja	\N	2025-02-28	2027-02-28
4746	10551	21	123	t	Baja	/evidencias/10551_123.pdf	2024-05-04	2026-05-04
4747	10551	21	124	t	Media	/evidencias/10551_124.pdf	2025-05-14	2026-05-14
4748	10552	127	757	t	Alta	/evidencias/10552_757.pdf	2024-05-23	2025-05-23
4749	10552	127	758	f	Alta	\N	2024-02-07	2026-02-06
4750	10552	127	759	t	Alta	/evidencias/10552_759.pdf	2024-07-17	2026-07-17
4751	10552	127	759	t	Alta	/evidencias/10552_759.pdf	2023-10-19	2025-10-18
4752	10552	127	760	t	Baja	/evidencias/10552_760.pdf	2024-08-24	2026-08-24
4753	10552	127	760	t	Media	/evidencias/10552_760.pdf	2025-03-19	2026-03-19
4754	10552	127	761	f	Alta	\N	2025-08-18	2026-08-18
4755	10552	127	762	t	Media	/evidencias/10552_762.pdf	2024-01-02	2026-01-01
4756	10553	38	215	t	Media	/evidencias/10553_215.pdf	2024-10-25	2026-10-25
4757	10553	38	215	f	Baja	\N	2024-01-09	2025-01-08
4758	10553	38	216	t	Media	/evidencias/10553_216.pdf	2025-09-18	2027-09-18
4759	10553	38	216	t	Media	/evidencias/10553_216.pdf	2024-01-26	2026-01-25
4760	10553	38	217	f	Media	\N	2025-07-20	2026-07-20
4761	10553	38	218	t	Baja	/evidencias/10553_218.pdf	2025-07-25	2027-07-25
4762	10553	38	218	t	Media	/evidencias/10553_218.pdf	2024-01-18	2025-01-17
4763	10553	38	219	f	Baja	\N	2026-01-19	2027-01-19
4764	10553	38	219	t	Baja	/evidencias/10553_219.pdf	2024-02-23	2025-02-22
4765	10554	89	524	f	Media	\N	2024-01-20	2026-01-19
4766	10554	89	524	t	Media	/evidencias/10554_524.pdf	2024-09-08	2026-09-08
4767	10554	89	525	t	Baja	/evidencias/10554_525.pdf	2026-02-08	2028-02-08
4768	10554	89	525	f	Alta	\N	2024-08-14	2026-08-14
4769	10554	89	526	t	Alta	/evidencias/10554_526.pdf	2024-03-03	2025-03-03
4770	10554	89	526	f	Media	\N	2024-02-03	2025-02-02
4771	10554	89	527	t	Media	/evidencias/10554_527.pdf	2025-03-03	2026-03-03
4772	10554	89	528	f	Media	\N	2023-08-27	2025-08-26
4773	10554	89	529	t	Media	/evidencias/10554_529.pdf	2024-12-30	2025-12-30
4774	10554	89	529	f	Baja	\N	2024-06-16	2026-06-16
4775	10554	89	530	f	Media	\N	2024-01-04	2025-01-03
4776	10554	89	530	t	Alta	/evidencias/10554_530.pdf	2026-04-11	2028-04-10
4777	10555	53	311	f	Alta	\N	2023-10-04	2024-10-03
4778	10555	53	312	t	Baja	/evidencias/10555_312.pdf	2024-09-06	2025-09-06
4779	10555	53	313	t	Baja	/evidencias/10555_313.pdf	2026-05-13	2027-05-13
4780	10555	53	314	t	Media	/evidencias/10555_314.pdf	2026-02-12	2027-02-12
4781	10555	53	315	t	Media	/evidencias/10555_315.pdf	2026-01-04	2028-01-04
4782	10556	15	87	t	Baja	/evidencias/10556_87.pdf	2025-08-08	2026-08-08
4783	10556	15	88	t	Baja	/evidencias/10556_88.pdf	2024-02-27	2026-02-26
4784	10556	15	88	f	Media	\N	2023-08-15	2024-08-14
4785	10556	15	89	t	Media	/evidencias/10556_89.pdf	2024-01-02	2025-01-01
4786	10556	15	90	t	Media	/evidencias/10556_90.pdf	2026-01-25	2028-01-25
4787	10556	15	91	t	Baja	/evidencias/10556_91.pdf	2024-10-08	2026-10-08
4788	10556	15	91	t	Baja	/evidencias/10556_91.pdf	2026-02-11	2028-02-11
4789	10557	86	506	t	Alta	/evidencias/10557_506.pdf	2024-03-03	2026-03-03
4790	10557	86	506	f	Media	\N	2024-08-22	2025-08-22
4791	10557	86	507	f	Alta	\N	2024-01-21	2026-01-20
4792	10557	86	508	t	Media	/evidencias/10557_508.pdf	2025-11-07	2026-11-07
4793	10557	86	508	f	Alta	\N	2023-06-13	2024-06-12
4794	10557	86	509	f	Media	\N	2026-05-28	2027-05-28
4795	10557	86	509	f	Media	\N	2025-12-08	2026-12-08
4796	10557	86	510	f	Alta	\N	2025-08-07	2027-08-07
4797	10557	86	510	t	Alta	/evidencias/10557_510.pdf	2024-11-08	2025-11-08
4798	10557	86	511	f	Alta	\N	2023-06-23	2024-06-22
4799	10557	86	511	t	Baja	/evidencias/10557_511.pdf	2023-10-22	2025-10-21
4800	10557	86	512	t	Baja	/evidencias/10557_512.pdf	2026-02-19	2028-02-19
4801	10558	109	648	t	Media	/evidencias/10558_648.pdf	2024-06-10	2026-06-10
4802	10558	109	649	t	Media	/evidencias/10558_649.pdf	2025-11-14	2027-11-14
4803	10558	109	650	t	Media	/evidencias/10558_650.pdf	2026-05-29	2028-05-28
4804	10558	109	650	t	Baja	/evidencias/10558_650.pdf	2024-11-14	2026-11-14
4805	10558	109	651	f	Media	\N	2026-04-21	2027-04-21
4806	10558	109	651	t	Baja	/evidencias/10558_651.pdf	2024-02-08	2025-02-07
4807	10558	109	652	t	Media	/evidencias/10558_652.pdf	2024-06-05	2025-06-05
4808	10558	109	653	f	Media	\N	2024-09-20	2026-09-20
4809	10559	146	872	f	Media	\N	2025-03-31	2026-03-31
4810	10559	146	872	f	Media	\N	2024-01-01	2024-12-31
4811	10559	146	873	f	Baja	\N	2024-11-24	2026-11-24
4812	10559	146	873	t	Alta	/evidencias/10559_873.pdf	2023-07-13	2025-07-12
4813	10559	146	874	t	Alta	/evidencias/10559_874.pdf	2024-12-20	2026-12-20
4814	10559	146	874	t	Alta	/evidencias/10559_874.pdf	2026-02-10	2028-02-10
4815	10559	146	875	t	Media	/evidencias/10559_875.pdf	2025-01-10	2027-01-10
4816	10559	146	875	f	Alta	\N	2025-11-02	2027-11-02
4817	10559	146	876	t	Media	/evidencias/10559_876.pdf	2023-11-25	2025-11-24
4818	10560	143	855	f	Media	\N	2023-10-21	2025-10-20
4819	10560	143	856	t	Alta	/evidencias/10560_856.pdf	2025-11-08	2026-11-08
4820	10560	143	856	t	Media	/evidencias/10560_856.pdf	2024-05-08	2026-05-08
4821	10560	143	857	t	Baja	/evidencias/10560_857.pdf	2025-12-19	2027-12-19
4822	10560	143	857	t	Alta	/evidencias/10560_857.pdf	2024-09-25	2025-09-25
4823	10560	143	858	t	Baja	/evidencias/10560_858.pdf	2025-11-23	2026-11-23
4824	10560	143	859	t	Media	/evidencias/10560_859.pdf	2025-04-15	2026-04-15
4825	10561	43	247	t	Media	/evidencias/10561_247.pdf	2026-05-16	2027-05-16
4826	10561	43	248	f	Baja	\N	2024-12-30	2026-12-30
4827	10561	43	249	f	Alta	\N	2023-11-17	2024-11-16
4828	10561	43	249	t	Baja	/evidencias/10561_249.pdf	2023-07-04	2025-07-03
4829	10561	43	250	f	Media	\N	2024-08-16	2025-08-16
4830	10561	43	251	f	Media	\N	2024-09-07	2026-09-07
4831	10561	43	252	f	Media	\N	2025-03-28	2026-03-28
4832	10561	43	252	t	Media	/evidencias/10561_252.pdf	2024-11-15	2026-11-15
4833	10562	124	740	t	Baja	/evidencias/10562_740.pdf	2024-11-08	2026-11-08
4834	10562	124	740	t	Media	/evidencias/10562_740.pdf	2023-06-24	2025-06-23
4835	10562	124	741	t	Alta	/evidencias/10562_741.pdf	2024-11-25	2026-11-25
4836	10562	124	741	t	Alta	/evidencias/10562_741.pdf	2024-11-28	2025-11-28
4837	10562	124	742	t	Alta	/evidencias/10562_742.pdf	2024-02-06	2026-02-05
4838	10562	124	743	t	Media	/evidencias/10562_743.pdf	2023-11-17	2024-11-16
4839	10562	124	743	t	Baja	/evidencias/10562_743.pdf	2025-02-19	2026-02-19
4840	10562	124	744	t	Media	/evidencias/10562_744.pdf	2025-09-14	2027-09-14
4841	10562	124	744	t	Media	/evidencias/10562_744.pdf	2026-01-19	2028-01-19
4842	10562	124	745	t	Alta	/evidencias/10562_745.pdf	2025-09-02	2026-09-02
4843	10563	76	447	t	Media	/evidencias/10563_447.pdf	2024-12-12	2026-12-12
4844	10563	76	447	t	Baja	/evidencias/10563_447.pdf	2025-11-21	2026-11-21
4845	10563	76	448	t	Media	/evidencias/10563_448.pdf	2024-10-21	2026-10-21
4846	10563	76	449	t	Alta	/evidencias/10563_449.pdf	2025-08-26	2026-08-26
4847	10563	76	449	t	Media	/evidencias/10563_449.pdf	2023-06-13	2024-06-12
4848	10563	76	450	t	Media	/evidencias/10563_450.pdf	2026-05-15	2027-05-15
4849	10563	76	451	t	Baja	/evidencias/10563_451.pdf	2026-04-01	2027-04-01
4850	10563	76	452	t	Media	/evidencias/10563_452.pdf	2025-04-25	2026-04-25
4851	10563	76	452	f	Media	\N	2025-09-17	2026-09-17
4852	10563	76	453	f	Media	\N	2026-02-14	2028-02-14
4853	10564	122	724	t	Media	/evidencias/10564_724.pdf	2024-08-13	2026-08-13
4854	10564	122	724	t	Baja	/evidencias/10564_724.pdf	2023-11-18	2025-11-17
4855	10564	122	725	t	Media	/evidencias/10564_725.pdf	2026-01-09	2028-01-09
4856	10564	122	725	f	Baja	\N	2024-11-01	2026-11-01
4857	10564	122	726	t	Baja	/evidencias/10564_726.pdf	2024-10-19	2025-10-19
4858	10564	122	727	f	Media	\N	2025-09-03	2027-09-03
4859	10564	122	727	f	Media	\N	2024-09-04	2026-09-04
4860	10564	122	728	f	Media	\N	2024-05-19	2025-05-19
4861	10564	122	728	f	Media	\N	2025-04-20	2027-04-20
4862	10564	122	729	f	Baja	\N	2025-07-22	2027-07-22
4863	10564	122	729	t	Media	/evidencias/10564_729.pdf	2025-03-09	2027-03-09
4864	10564	122	730	t	Media	/evidencias/10564_730.pdf	2024-10-25	2026-10-25
4865	10564	122	730	t	Baja	/evidencias/10564_730.pdf	2023-11-09	2025-11-08
4866	10564	122	731	t	Alta	/evidencias/10564_731.pdf	2026-02-24	2028-02-24
4867	10564	122	731	t	Media	/evidencias/10564_731.pdf	2024-08-02	2025-08-02
4868	10565	29	162	t	Baja	/evidencias/10565_162.pdf	2023-09-24	2024-09-23
4869	10565	29	163	t	Alta	/evidencias/10565_163.pdf	2025-10-26	2027-10-26
4870	10565	29	164	f	Alta	\N	2025-05-08	2027-05-08
4871	10565	29	165	t	Media	/evidencias/10565_165.pdf	2024-02-16	2026-02-15
4872	10565	29	165	f	Baja	\N	2025-05-16	2026-05-16
4873	10566	133	796	t	Media	/evidencias/10566_796.pdf	2024-10-03	2025-10-03
4874	10566	133	796	f	Media	\N	2024-08-02	2025-08-02
4875	10566	133	797	f	Media	\N	2024-04-30	2025-04-30
4876	10566	133	798	t	Baja	/evidencias/10566_798.pdf	2025-11-16	2026-11-16
4877	10566	133	798	t	Alta	/evidencias/10566_798.pdf	2025-06-07	2026-06-07
4878	10566	133	799	f	Alta	\N	2025-07-06	2027-07-06
4879	10566	133	800	t	Media	/evidencias/10566_800.pdf	2025-01-27	2027-01-27
4880	10566	133	800	f	Alta	\N	2023-12-01	2025-11-30
4881	10566	133	801	t	Baja	/evidencias/10566_801.pdf	2025-07-17	2027-07-17
4882	10566	133	801	t	Alta	/evidencias/10566_801.pdf	2023-07-24	2025-07-23
4883	10567	105	626	t	Alta	/evidencias/10567_626.pdf	2026-04-29	2028-04-28
4884	10567	105	626	t	Baja	/evidencias/10567_626.pdf	2023-12-05	2024-12-04
4885	10567	105	627	t	Alta	/evidencias/10567_627.pdf	2024-08-22	2025-08-22
4886	10567	105	627	t	Baja	/evidencias/10567_627.pdf	2024-08-24	2025-08-24
4887	10567	105	628	t	Baja	/evidencias/10567_628.pdf	2026-04-03	2027-04-03
4888	10567	105	629	t	Media	/evidencias/10567_629.pdf	2024-11-05	2026-11-05
4889	10567	105	629	t	Alta	/evidencias/10567_629.pdf	2023-08-20	2025-08-19
4890	10567	105	630	t	Media	/evidencias/10567_630.pdf	2023-10-09	2024-10-08
4891	10567	105	630	f	Media	\N	2025-01-18	2026-01-18
4892	10567	105	631	t	Media	/evidencias/10567_631.pdf	2026-04-12	2028-04-11
4893	10567	105	631	t	Alta	/evidencias/10567_631.pdf	2024-10-29	2026-10-29
4894	10568	108	644	t	Alta	/evidencias/10568_644.pdf	2024-07-07	2026-07-07
4895	10568	108	645	t	Media	/evidencias/10568_645.pdf	2026-02-27	2028-02-27
4896	10568	108	646	t	Alta	/evidencias/10568_646.pdf	2024-02-01	2025-01-31
4897	10568	108	646	t	Baja	/evidencias/10568_646.pdf	2024-01-19	2026-01-18
4898	10568	108	647	f	Media	\N	2023-06-11	2024-06-10
4899	10569	67	388	t	Baja	/evidencias/10569_388.pdf	2024-05-02	2025-05-02
4900	10569	67	389	f	Media	\N	2023-07-17	2025-07-16
4901	10569	67	389	f	Media	\N	2024-05-24	2026-05-24
4902	10569	67	390	t	Alta	/evidencias/10569_390.pdf	2024-07-31	2026-07-31
4903	10569	67	391	t	Media	/evidencias/10569_391.pdf	2024-07-23	2025-07-23
4904	10569	67	392	f	Alta	\N	2025-04-08	2027-04-08
4905	10569	67	393	t	Media	/evidencias/10569_393.pdf	2024-02-18	2025-02-17
4906	10569	67	394	t	Media	/evidencias/10569_394.pdf	2025-07-09	2027-07-09
4907	10569	67	394	t	Alta	/evidencias/10569_394.pdf	2024-07-22	2025-07-22
4908	10569	67	395	t	Media	/evidencias/10569_395.pdf	2024-02-03	2025-02-02
4909	10570	21	119	t	Media	/evidencias/10570_119.pdf	2024-11-07	2026-11-07
4910	10570	21	120	t	Media	/evidencias/10570_120.pdf	2024-07-10	2025-07-10
4911	10570	21	120	f	Alta	\N	2024-05-31	2025-05-31
4912	10570	21	121	t	Alta	/evidencias/10570_121.pdf	2023-10-10	2024-10-09
4913	10570	21	121	t	Media	/evidencias/10570_121.pdf	2024-09-28	2026-09-28
4914	10570	21	122	f	Alta	\N	2024-12-04	2025-12-04
4915	10570	21	122	f	Media	\N	2025-02-05	2026-02-05
4916	10570	21	123	f	Alta	\N	2026-02-15	2028-02-15
4917	10570	21	123	t	Media	/evidencias/10570_123.pdf	2024-11-28	2026-11-28
4918	10570	21	124	f	Media	\N	2024-06-28	2026-06-28
4919	10571	56	325	t	Media	/evidencias/10571_325.pdf	2023-06-16	2025-06-15
4920	10571	56	325	t	Alta	/evidencias/10571_325.pdf	2025-08-13	2026-08-13
4921	10571	56	326	t	Baja	/evidencias/10571_326.pdf	2024-03-26	2025-03-26
4922	10571	56	327	f	Alta	\N	2025-08-31	2027-08-31
4923	10571	56	328	t	Media	/evidencias/10571_328.pdf	2025-10-25	2027-10-25
4924	10572	100	595	t	Media	/evidencias/10572_595.pdf	2025-11-03	2026-11-03
4925	10572	100	596	t	Media	/evidencias/10572_596.pdf	2025-10-25	2026-10-25
4926	10572	100	597	t	Baja	/evidencias/10572_597.pdf	2024-12-12	2025-12-12
4927	10572	100	598	f	Alta	\N	2025-03-17	2026-03-17
4928	10572	100	599	t	Baja	/evidencias/10572_599.pdf	2025-09-29	2027-09-29
4929	10572	100	599	t	Alta	/evidencias/10572_599.pdf	2025-11-23	2026-11-23
4930	10572	100	600	f	Media	\N	2024-12-21	2026-12-21
4931	10572	100	600	t	Media	/evidencias/10572_600.pdf	2025-08-17	2027-08-17
4932	10572	100	601	f	Baja	\N	2026-04-30	2027-04-30
4933	10572	100	601	t	Media	/evidencias/10572_601.pdf	2025-01-31	2027-01-31
4934	10572	100	602	f	Alta	\N	2024-08-05	2025-08-05
4935	10573	50	289	t	Baja	/evidencias/10573_289.pdf	2025-06-04	2027-06-04
4936	10573	50	290	t	Alta	/evidencias/10573_290.pdf	2025-07-01	2027-07-01
4937	10573	50	291	f	Alta	\N	2025-05-26	2027-05-26
4938	10573	50	291	t	Media	/evidencias/10573_291.pdf	2024-08-30	2026-08-30
4939	10573	50	292	t	Alta	/evidencias/10573_292.pdf	2025-04-23	2027-04-23
4940	10573	50	293	f	Baja	\N	2026-05-23	2028-05-22
4941	10573	50	293	t	Media	/evidencias/10573_293.pdf	2025-09-24	2026-09-24
4942	10573	50	294	t	Media	/evidencias/10573_294.pdf	2024-01-27	2026-01-26
4943	10573	50	294	f	Alta	\N	2026-01-04	2027-01-04
4944	10574	1	1	t	Media	/evidencias/10574_1.pdf	2024-10-02	2026-10-02
4945	10574	1	2	f	Alta	\N	2024-06-03	2025-06-03
4946	10574	1	3	f	Alta	\N	2023-07-27	2024-07-26
4947	10574	1	4	t	Alta	/evidencias/10574_4.pdf	2025-01-02	2027-01-02
4948	10574	1	4	t	Alta	/evidencias/10574_4.pdf	2026-01-08	2028-01-08
4949	10574	1	5	t	Alta	/evidencias/10574_5.pdf	2023-12-02	2025-12-01
4950	10574	1	6	t	Media	/evidencias/10574_6.pdf	2023-11-07	2024-11-06
4951	10574	1	6	f	Media	\N	2024-07-19	2025-07-19
4952	10574	1	7	t	Baja	/evidencias/10574_7.pdf	2024-08-19	2025-08-19
4953	10574	1	7	t	Media	/evidencias/10574_7.pdf	2026-05-06	2028-05-05
4954	10575	23	130	t	Alta	/evidencias/10575_130.pdf	2026-04-05	2027-04-05
4955	10575	23	131	t	Alta	/evidencias/10575_131.pdf	2026-05-09	2027-05-09
4956	10575	23	132	t	Media	/evidencias/10575_132.pdf	2026-05-06	2028-05-05
4957	10575	23	133	t	Baja	/evidencias/10575_133.pdf	2024-02-01	2026-01-31
4958	10575	23	133	f	Alta	\N	2025-01-07	2027-01-07
4959	10575	23	134	t	Alta	/evidencias/10575_134.pdf	2024-03-23	2025-03-23
4960	10575	23	134	t	Alta	/evidencias/10575_134.pdf	2024-01-11	2025-01-10
4961	10576	14	81	f	Media	\N	2026-03-12	2027-03-12
4962	10576	14	82	t	Media	/evidencias/10576_82.pdf	2025-01-24	2026-01-24
4963	10576	14	82	t	Baja	/evidencias/10576_82.pdf	2025-12-09	2027-12-09
4964	10576	14	83	t	Media	/evidencias/10576_83.pdf	2023-08-01	2025-07-31
4965	10576	14	84	t	Alta	/evidencias/10576_84.pdf	2024-07-15	2025-07-15
4966	10576	14	85	t	Media	/evidencias/10576_85.pdf	2025-10-08	2027-10-08
4967	10576	14	86	f	Baja	\N	2023-11-10	2024-11-09
4968	10577	79	463	t	Media	/evidencias/10577_463.pdf	2026-03-28	2027-03-28
4969	10577	79	463	t	Baja	/evidencias/10577_463.pdf	2024-06-30	2026-06-30
4970	10577	79	464	f	Media	\N	2026-04-07	2027-04-07
4971	10577	79	464	t	Baja	/evidencias/10577_464.pdf	2026-01-17	2028-01-17
4972	10577	79	465	t	Alta	/evidencias/10577_465.pdf	2024-11-25	2026-11-25
4973	10577	79	466	t	Media	/evidencias/10577_466.pdf	2025-09-23	2027-09-23
4974	10577	79	467	t	Baja	/evidencias/10577_467.pdf	2024-08-05	2025-08-05
4975	10577	79	467	t	Alta	/evidencias/10577_467.pdf	2024-01-25	2026-01-24
4976	10577	79	468	f	Media	\N	2026-05-12	2027-05-12
4977	10577	79	468	t	Baja	/evidencias/10577_468.pdf	2025-07-03	2026-07-03
4978	10578	130	777	f	Media	\N	2026-04-02	2028-04-01
4979	10578	130	777	f	Alta	\N	2024-03-28	2025-03-28
4980	10578	130	778	t	Baja	/evidencias/10578_778.pdf	2026-01-22	2027-01-22
4981	10578	130	778	f	Media	\N	2024-11-09	2026-11-09
4982	10578	130	779	t	Media	/evidencias/10578_779.pdf	2026-01-03	2028-01-03
4984	10578	130	780	t	Media	/evidencias/10578_780.pdf	2024-06-02	2026-06-02
4985	10579	53	311	t	Baja	/evidencias/10579_311.pdf	2023-09-15	2025-09-14
4986	10579	53	312	t	Alta	/evidencias/10579_312.pdf	2024-06-21	2025-06-21
4987	10579	53	312	t	Alta	/evidencias/10579_312.pdf	2026-05-29	2028-05-28
4988	10579	53	313	t	Alta	/evidencias/10579_313.pdf	2025-01-15	2027-01-15
4989	10579	53	314	t	Baja	/evidencias/10579_314.pdf	2023-12-16	2024-12-15
4990	10579	53	314	f	Media	\N	2025-04-14	2027-04-14
4991	10579	53	315	t	Alta	/evidencias/10579_315.pdf	2023-08-14	2024-08-13
4992	10580	75	441	t	Alta	/evidencias/10580_441.pdf	2025-10-24	2026-10-24
4993	10580	75	442	t	Media	/evidencias/10580_442.pdf	2025-06-02	2026-06-02
4994	10580	75	443	f	Baja	\N	2025-06-18	2026-06-18
4995	10580	75	443	t	Media	/evidencias/10580_443.pdf	2023-11-01	2025-10-31
4996	10580	75	444	t	Media	/evidencias/10580_444.pdf	2025-09-01	2026-09-01
4997	10580	75	444	f	Media	\N	2024-10-05	2025-10-05
4998	10580	75	445	t	Baja	/evidencias/10580_445.pdf	2026-02-17	2027-02-17
4999	10580	75	446	f	Alta	\N	2025-01-20	2027-01-20
5000	10580	75	446	t	Media	/evidencias/10580_446.pdf	2025-02-08	2027-02-08
5001	10581	149	889	t	Media	/evidencias/10581_889.pdf	2023-12-03	2025-12-02
5002	10581	149	890	f	Media	\N	2024-01-16	2025-01-15
5003	10581	149	890	t	Media	/evidencias/10581_890.pdf	2023-11-13	2025-11-12
5004	10581	149	891	t	Baja	/evidencias/10581_891.pdf	2024-05-05	2026-05-05
5005	10581	149	891	t	Baja	/evidencias/10581_891.pdf	2025-11-22	2026-11-22
5006	10581	149	892	f	Media	\N	2024-02-23	2025-02-22
5007	10581	149	893	f	Media	\N	2024-06-01	2026-06-01
5008	10581	149	894	t	Baja	/evidencias/10581_894.pdf	2026-03-01	2027-03-01
5009	10581	149	895	t	Media	/evidencias/10581_895.pdf	2026-04-21	2027-04-21
5010	10582	4	22	t	Media	/evidencias/10582_22.pdf	2024-05-06	2025-05-06
5011	10582	4	23	t	Alta	/evidencias/10582_23.pdf	2024-05-18	2025-05-18
5012	10582	4	24	t	Media	/evidencias/10582_24.pdf	2024-07-01	2026-07-01
5013	10582	4	25	f	Media	\N	2026-02-26	2027-02-26
5014	10582	4	26	t	Media	/evidencias/10582_26.pdf	2025-09-12	2026-09-12
5015	10583	105	626	t	Baja	/evidencias/10583_626.pdf	2025-07-07	2027-07-07
5016	10583	105	627	t	Alta	/evidencias/10583_627.pdf	2023-10-16	2024-10-15
5017	10583	105	627	t	Media	/evidencias/10583_627.pdf	2025-01-31	2027-01-31
5018	10583	105	628	f	Media	\N	2026-01-27	2028-01-27
5019	10583	105	628	f	Baja	\N	2024-05-05	2026-05-05
5020	10583	105	629	t	Alta	/evidencias/10583_629.pdf	2024-12-20	2025-12-20
5021	10583	105	629	t	Media	/evidencias/10583_629.pdf	2024-06-29	2025-06-29
5022	10583	105	630	f	Media	\N	2026-04-20	2028-04-19
5023	10583	105	631	t	Alta	/evidencias/10583_631.pdf	2026-01-15	2027-01-15
5024	10583	105	631	t	Baja	/evidencias/10583_631.pdf	2025-11-28	2026-11-28
5025	10584	67	388	f	Media	\N	2026-05-27	2028-05-26
5026	10584	67	388	f	Baja	\N	2025-02-28	2027-02-28
5027	10584	67	389	t	Alta	/evidencias/10584_389.pdf	2026-01-18	2027-01-18
5028	10584	67	390	t	Media	/evidencias/10584_390.pdf	2024-12-31	2025-12-31
5029	10584	67	390	f	Alta	\N	2025-07-30	2027-07-30
5030	10584	67	391	t	Alta	/evidencias/10584_391.pdf	2025-12-27	2026-12-27
5031	10584	67	391	f	Media	\N	2026-04-09	2028-04-08
5032	10584	67	392	t	Baja	/evidencias/10584_392.pdf	2025-02-18	2027-02-18
5033	10584	67	392	t	Baja	/evidencias/10584_392.pdf	2025-02-01	2027-02-01
5034	10584	67	393	f	Media	\N	2024-06-24	2025-06-24
5035	10584	67	394	f	Alta	\N	2025-05-23	2027-05-23
5036	10584	67	394	t	Media	/evidencias/10584_394.pdf	2025-07-10	2026-07-10
5037	10584	67	395	f	Media	\N	2023-09-24	2025-09-23
5038	10585	105	626	f	Alta	\N	2025-02-02	2026-02-02
5039	10585	105	626	t	Media	/evidencias/10585_626.pdf	2024-01-03	2026-01-02
5040	10585	105	627	t	Alta	/evidencias/10585_627.pdf	2024-10-16	2025-10-16
5041	10585	105	628	t	Media	/evidencias/10585_628.pdf	2025-10-26	2026-10-26
5042	10585	105	628	t	Media	/evidencias/10585_628.pdf	2023-10-10	2024-10-09
5043	10585	105	629	t	Alta	/evidencias/10585_629.pdf	2023-06-30	2025-06-29
5044	10585	105	630	t	Media	/evidencias/10585_630.pdf	2023-06-14	2024-06-13
5045	10585	105	630	f	Media	\N	2024-07-15	2025-07-15
5046	10585	105	631	t	Media	/evidencias/10585_631.pdf	2026-05-01	2027-05-01
5047	10585	105	631	t	Media	/evidencias/10585_631.pdf	2025-06-29	2026-06-29
5048	10586	138	825	t	Baja	/evidencias/10586_825.pdf	2024-11-22	2026-11-22
5049	10586	138	826	f	Baja	\N	2023-09-20	2024-09-19
5050	10586	138	827	t	Baja	/evidencias/10586_827.pdf	2024-07-12	2025-07-12
5051	10586	138	828	t	Media	/evidencias/10586_828.pdf	2023-06-11	2025-06-10
5052	10586	138	828	f	Media	\N	2025-01-12	2027-01-12
5053	10587	140	836	f	Alta	\N	2024-08-13	2026-08-13
5054	10587	140	837	t	Media	/evidencias/10587_837.pdf	2026-01-02	2028-01-02
5055	10587	140	837	t	Media	/evidencias/10587_837.pdf	2025-04-15	2026-04-15
5056	10587	140	838	t	Media	/evidencias/10587_838.pdf	2026-01-18	2028-01-18
5057	10587	140	838	t	Baja	/evidencias/10587_838.pdf	2023-08-13	2024-08-12
5058	10587	140	839	f	Media	\N	2026-02-08	2028-02-08
5059	10587	140	839	t	Alta	/evidencias/10587_839.pdf	2024-01-29	2026-01-28
5060	10587	140	840	t	Alta	/evidencias/10587_840.pdf	2024-09-17	2025-09-17
5061	10587	140	841	f	Baja	\N	2025-11-29	2027-11-29
5062	10587	140	841	f	Media	\N	2024-12-10	2025-12-10
5063	10587	140	842	t	Baja	/evidencias/10587_842.pdf	2025-05-27	2026-05-27
5064	10587	140	842	t	Alta	/evidencias/10587_842.pdf	2023-08-20	2025-08-19
5065	10587	140	843	f	Media	\N	2024-12-07	2025-12-07
5066	10587	140	843	t	Alta	/evidencias/10587_843.pdf	2024-04-08	2025-04-08
5067	10589	112	665	t	Baja	/evidencias/10589_665.pdf	2023-10-11	2024-10-10
5068	10589	112	666	t	Alta	/evidencias/10589_666.pdf	2025-09-01	2027-09-01
5069	10589	112	667	t	Alta	/evidencias/10589_667.pdf	2025-03-30	2027-03-30
5070	10589	112	668	t	Alta	/evidencias/10589_668.pdf	2024-10-16	2026-10-16
5071	10589	112	668	t	Baja	/evidencias/10589_668.pdf	2026-04-13	2028-04-12
5072	10589	112	669	t	Baja	/evidencias/10589_669.pdf	2024-12-09	2026-12-09
5073	10590	95	564	f	Alta	\N	2023-06-20	2024-06-19
5074	10590	95	564	t	Media	/evidencias/10590_564.pdf	2024-10-16	2025-10-16
5075	10590	95	565	t	Media	/evidencias/10590_565.pdf	2024-02-24	2025-02-23
5076	10590	95	565	f	Media	\N	2025-05-11	2027-05-11
5077	10590	95	566	t	Baja	/evidencias/10590_566.pdf	2024-03-13	2025-03-13
5078	10590	95	566	f	Alta	\N	2025-10-30	2026-10-30
5079	10590	95	567	t	Media	/evidencias/10590_567.pdf	2025-12-02	2027-12-02
5080	10590	95	567	t	Media	/evidencias/10590_567.pdf	2026-02-02	2027-02-02
5081	10590	95	568	t	Media	/evidencias/10590_568.pdf	2026-03-21	2028-03-20
5082	10591	98	582	f	Media	\N	2025-04-11	2027-04-11
5083	10591	98	583	t	Baja	/evidencias/10591_583.pdf	2025-04-01	2027-04-01
5084	10591	98	583	t	Alta	/evidencias/10591_583.pdf	2026-04-14	2028-04-13
5085	10591	98	584	t	Alta	/evidencias/10591_584.pdf	2024-04-09	2025-04-09
5086	10591	98	584	f	Media	\N	2024-04-22	2025-04-22
5087	10591	98	585	t	Media	/evidencias/10591_585.pdf	2026-04-15	2028-04-14
5088	10591	98	586	t	Baja	/evidencias/10591_586.pdf	2024-02-08	2026-02-07
5089	10591	98	586	t	Media	/evidencias/10591_586.pdf	2025-11-23	2026-11-23
5090	10591	98	587	t	Alta	/evidencias/10591_587.pdf	2026-01-08	2027-01-08
5091	10591	98	588	t	Media	/evidencias/10591_588.pdf	2024-08-27	2026-08-27
5092	10592	89	524	t	Media	/evidencias/10592_524.pdf	2023-09-06	2025-09-05
5093	10592	89	524	t	Baja	/evidencias/10592_524.pdf	2025-06-13	2026-06-13
5094	10592	89	525	t	Media	/evidencias/10592_525.pdf	2025-02-05	2027-02-05
5095	10592	89	525	t	Baja	/evidencias/10592_525.pdf	2025-10-22	2026-10-22
5096	10592	89	526	t	Alta	/evidencias/10592_526.pdf	2026-05-16	2028-05-15
5097	10592	89	527	f	Alta	\N	2025-08-10	2027-08-10
5098	10592	89	528	t	Media	/evidencias/10592_528.pdf	2025-09-02	2026-09-02
5099	10592	89	528	t	Media	/evidencias/10592_528.pdf	2023-09-30	2024-09-29
5100	10592	89	529	t	Media	/evidencias/10592_529.pdf	2026-05-16	2027-05-16
5101	10592	89	529	t	Media	/evidencias/10592_529.pdf	2024-05-06	2025-05-06
5102	10592	89	530	f	Media	\N	2024-01-17	2026-01-16
5103	10592	89	530	t	Baja	/evidencias/10592_530.pdf	2025-05-02	2027-05-02
5104	10593	70	410	f	Media	\N	2025-07-01	2027-07-01
5105	10593	70	410	f	Baja	\N	2023-07-08	2024-07-07
5106	10593	70	411	t	Media	/evidencias/10593_411.pdf	2025-06-21	2026-06-21
5107	10593	70	411	t	Alta	/evidencias/10593_411.pdf	2023-07-29	2024-07-28
5108	10593	70	412	t	Alta	/evidencias/10593_412.pdf	2023-09-15	2024-09-14
5109	10593	70	412	t	Baja	/evidencias/10593_412.pdf	2025-10-11	2026-10-11
5110	10593	70	413	t	Alta	/evidencias/10593_413.pdf	2024-09-29	2026-09-29
5111	10593	70	413	t	Baja	/evidencias/10593_413.pdf	2023-07-31	2024-07-30
5112	10593	70	414	f	Baja	\N	2026-01-15	2028-01-15
5113	10593	70	414	t	Media	/evidencias/10593_414.pdf	2023-11-08	2025-11-07
5114	10593	70	415	t	Alta	/evidencias/10593_415.pdf	2023-07-03	2025-07-02
5115	10593	70	416	f	Baja	\N	2023-06-18	2024-06-17
5116	10593	70	416	t	Alta	/evidencias/10593_416.pdf	2025-02-12	2026-02-12
5117	10594	58	334	t	Media	/evidencias/10594_334.pdf	2026-04-30	2028-04-29
5118	10594	58	334	f	Baja	\N	2025-09-04	2026-09-04
5119	10594	58	335	f	Media	\N	2025-05-31	2026-05-31
5120	10594	58	335	t	Media	/evidencias/10594_335.pdf	2024-12-20	2025-12-20
5121	10594	58	336	f	Media	\N	2025-03-03	2027-03-03
5122	10594	58	337	t	Media	/evidencias/10594_337.pdf	2024-08-17	2025-08-17
5123	10594	58	337	t	Alta	/evidencias/10594_337.pdf	2024-05-10	2026-05-10
5124	10595	139	829	f	Alta	\N	2024-07-19	2026-07-19
5125	10595	139	830	t	Media	/evidencias/10595_830.pdf	2023-10-10	2025-10-09
5126	10595	139	831	t	Alta	/evidencias/10595_831.pdf	2026-05-09	2027-05-09
5127	10595	139	831	t	Baja	/evidencias/10595_831.pdf	2023-07-21	2024-07-20
5128	10595	139	832	t	Alta	/evidencias/10595_832.pdf	2025-11-19	2026-11-19
5129	10595	139	833	t	Alta	/evidencias/10595_833.pdf	2025-08-17	2026-08-17
5130	10595	139	834	t	Media	/evidencias/10595_834.pdf	2025-03-16	2026-03-16
5131	10595	139	834	t	Baja	/evidencias/10595_834.pdf	2025-12-21	2026-12-21
5132	10595	139	835	f	Alta	\N	2025-06-23	2027-06-23
5133	10596	57	329	t	Alta	/evidencias/10596_329.pdf	2024-11-27	2025-11-27
5134	10596	57	330	t	Baja	/evidencias/10596_330.pdf	2024-09-16	2026-09-16
5135	10596	57	330	f	Media	\N	2024-12-19	2026-12-19
5136	10596	57	331	t	Baja	/evidencias/10596_331.pdf	2024-07-04	2025-07-04
5137	10596	57	332	f	Baja	\N	2023-10-03	2024-10-02
5138	10596	57	333	t	Media	/evidencias/10596_333.pdf	2025-09-28	2026-09-28
5139	10596	57	333	f	Alta	\N	2024-10-17	2025-10-17
5140	10597	80	469	t	Alta	/evidencias/10597_469.pdf	2023-08-14	2025-08-13
5141	10597	80	469	f	Baja	\N	2024-10-23	2025-10-23
5142	10597	80	470	f	Media	\N	2023-06-29	2025-06-28
5143	10597	80	471	f	Media	\N	2024-05-16	2026-05-16
5144	10597	80	472	t	Media	/evidencias/10597_472.pdf	2023-08-17	2024-08-16
5145	10597	80	473	t	Baja	/evidencias/10597_473.pdf	2024-01-01	2025-12-31
5146	10597	80	473	t	Media	/evidencias/10597_473.pdf	2024-08-02	2026-08-02
5147	10597	80	474	t	Media	/evidencias/10597_474.pdf	2023-12-07	2024-12-06
5148	10597	80	474	f	Baja	\N	2025-11-08	2027-11-08
5149	10598	12	71	t	Alta	/evidencias/10598_71.pdf	2023-08-23	2024-08-22
5150	10598	12	72	t	Media	/evidencias/10598_72.pdf	2025-11-20	2026-11-20
5151	10598	12	73	t	Media	/evidencias/10598_73.pdf	2024-09-11	2026-09-11
5152	10598	12	74	t	Alta	/evidencias/10598_74.pdf	2025-04-05	2026-04-05
5153	10598	12	75	t	Baja	/evidencias/10598_75.pdf	2024-01-17	2026-01-16
5154	10598	12	76	t	Alta	/evidencias/10598_76.pdf	2023-06-03	2024-06-02
5155	10598	12	76	t	Baja	/evidencias/10598_76.pdf	2023-11-10	2025-11-09
5156	10599	149	889	f	Baja	\N	2026-05-04	2028-05-03
5157	10599	149	890	t	Media	/evidencias/10599_890.pdf	2025-12-20	2026-12-20
5158	10599	149	891	t	Alta	/evidencias/10599_891.pdf	2023-10-21	2024-10-20
5159	10599	149	891	f	Alta	\N	2025-10-05	2027-10-05
5160	10599	149	892	t	Alta	/evidencias/10599_892.pdf	2024-07-25	2026-07-25
5161	10599	149	892	f	Media	\N	2024-05-07	2025-05-07
5162	10599	149	893	t	Media	/evidencias/10599_893.pdf	2024-03-02	2026-03-02
5163	10599	149	894	t	Baja	/evidencias/10599_894.pdf	2024-03-28	2026-03-28
5164	10599	149	894	t	Baja	/evidencias/10599_894.pdf	2025-11-03	2027-11-03
5165	10599	149	895	t	Alta	/evidencias/10599_895.pdf	2024-09-18	2026-09-18
5166	10599	149	895	f	Alta	\N	2026-05-02	2027-05-02
\.


--
-- Data for Name: empleados; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.empleados (no_reloj, nombre, email, clave_planta, id_departamento, clave_area, clave_puesto, fecha_ingreso, activo, es_mnj) FROM stdin;
10000	Isabel Ortiz Diaz	emp10000@empresa.com	1	10	27	100	2025-03-16	t	f
10001	Jose Reyes Morales	emp10001@empresa.com	1	17	50	89	2021-06-05	t	f
10002	Patricia Reyes Hernandez	emp10002@empresa.com	2	12	35	84	2020-03-05	t	f
10003	Laura Garcia Martinez	emp10003@empresa.com	2	7	16	25	2020-12-29	t	f
10004	Sofia Garcia Rivera	emp10004@empresa.com	3	14	41	140	2024-04-30	t	f
10005	Ana Chavez Ramirez	emp10005@empresa.com	3	3	6	147	2019-11-09	t	f
10006	Roberto Ramirez Ruiz	emp10006@empresa.com	2	1	2	55	2019-11-09	t	f
10007	Sofia Hernandez Ruiz	emp10007@empresa.com	3	7	17	25	2025-05-30	t	f
10008	Raul Hernandez Cruz	emp10008@empresa.com	1	12	35	48	2022-07-28	t	f
10009	Sofia Ramirez Ramirez	emp10009@empresa.com	2	3	7	75	2025-05-20	f	f
10010	Maria Hernandez Sanchez	emp10010@empresa.com	1	17	50	107	2025-10-30	t	f
10011	Pedro Reyes Chavez	emp10011@empresa.com	3	18	54	144	2019-01-27	t	f
10012	Pedro Chavez Perez	emp10012@empresa.com	3	10	27	10	2019-06-05	t	f
10013	Carmen Cruz Ruiz	emp10013@empresa.com	2	13	38	31	2023-04-08	t	f
10014	Juan Torres Flores	emp10014@empresa.com	1	15	45	15	2022-11-03	t	f
10015	Pedro Gutierrez Garcia	emp10015@empresa.com	1	5	12	77	2020-01-04	t	f
10016	Diana Hernandez Gonzalez	emp10016@empresa.com	1	18	52	144	2019-02-23	t	f
10017	Adriana Ramos Ramos	emp10017@empresa.com	3	15	44	33	2022-09-13	f	t
10018	Isabel Gomez Gomez	emp10018@empresa.com	3	15	44	33	2023-05-28	t	f
10019	Sofia Ortiz Garcia	emp10019@empresa.com	3	3	6	57	2018-09-02	t	f
10020	Jose Lopez Sanchez	emp10020@empresa.com	3	17	51	143	2025-10-29	f	f
10021	Jose Flores Lopez	emp10021@empresa.com	1	15	45	123	2019-01-22	t	f
10022	Raul Cruz Ramirez	emp10022@empresa.com	3	16	46	142	2022-04-08	t	f
10023	Monica Garcia Ramos	emp10023@empresa.com	1	10	26	82	2023-05-14	t	f
10024	Diana Gomez Rivera	emp10024@empresa.com	2	5	11	131	2023-06-25	t	f
10025	Carmen Rivera Reyes	emp10025@empresa.com	2	16	47	88	2018-12-11	t	f
10026	Miguel Gonzalez Ramos	emp10026@empresa.com	1	5	12	149	2021-06-26	t	f
10027	Maria Ramos Gonzalez	emp10027@empresa.com	3	1	2	91	2025-02-22	t	f
10028	Hector Hernandez Garcia	emp10028@empresa.com	3	14	39	68	2020-02-09	t	f
10029	Roberto Rodriguez Gomez	emp10029@empresa.com	3	6	14	150	2021-10-27	t	f
10030	Carlos Lopez Gomez	emp10030@empresa.com	2	5	11	41	2022-05-07	t	f
10031	Sofia Torres Torres	emp10031@empresa.com	1	11	30	11	2020-01-08	t	f
10032	Diana Ramos Garcia	emp10032@empresa.com	2	10	26	100	2019-04-18	t	f
10033	Diana Cruz Garcia	emp10033@empresa.com	1	2	3	92	2024-01-28	t	f
10034	Ana Cruz Ruiz	emp10034@empresa.com	2	6	13	42	2018-11-15	t	f
10035	Elena Perez Ortiz	emp10035@empresa.com	1	17	51	17	2024-05-11	t	f
10036	Pedro Morales Hernandez	emp10036@empresa.com	3	15	42	33	2025-04-08	t	f
10037	Ana Rivera Morales	emp10037@empresa.com	3	6	15	78	2020-06-30	t	f
10038	Monica Reyes Gutierrez	emp10038@empresa.com	1	10	27	64	2022-03-21	t	f
10039	Jose Ruiz Sanchez	emp10039@empresa.com	3	1	2	127	2024-03-14	t	f
10040	Pedro Ruiz Morales	emp10040@empresa.com	1	18	54	144	2021-07-27	t	f
10041	Hector Rivera Rivera	emp10041@empresa.com	3	11	30	119	2021-06-29	t	f
10042	Luis Reyes Gutierrez	emp10042@empresa.com	2	8	19	98	2018-09-21	t	f
10043	Ana Flores Ramirez	emp10043@empresa.com	3	15	44	69	2021-02-07	t	f
10044	Pedro Lopez Ortiz	emp10044@empresa.com	3	15	43	69	2024-09-15	t	f
10045	Jorge Gomez Garcia	emp10045@empresa.com	3	10	28	118	2019-12-04	t	f
10046	Ana Ruiz Morales	emp10046@empresa.com	3	15	44	105	2018-06-26	t	f
10047	Miguel Diaz Rivera	emp10047@empresa.com	2	14	41	140	2018-10-26	t	f
10048	Jose Ortiz Ramirez	emp10048@empresa.com	3	9	22	45	2024-08-16	t	f
10049	Patricia Flores Garcia	emp10049@empresa.com	3	17	51	107	2025-09-01	t	f
10050	Jose Flores Garcia	emp10050@empresa.com	3	13	38	31	2023-09-29	t	f
10051	Carlos Ortiz Perez	emp10051@empresa.com	1	17	51	71	2020-01-17	t	f
10052	Laura Reyes Perez	emp10052@empresa.com	3	4	10	40	2019-04-17	t	f
10053	Roberto Diaz Cruz	emp10053@empresa.com	1	8	19	80	2018-06-14	t	f
10054	Jose Diaz Rodriguez	emp10054@empresa.com	3	10	26	28	2024-01-05	t	f
10055	Monica Ruiz Flores	emp10055@empresa.com	3	6	14	60	2022-03-27	t	f
10056	Patricia Flores Ramirez	emp10056@empresa.com	1	15	44	123	2025-09-04	t	f
10057	Carmen Ramirez Reyes	emp10057@empresa.com	3	6	14	6	2023-11-10	t	f
10058	Miguel Gutierrez Rodriguez	emp10058@empresa.com	3	13	37	103	2021-06-25	t	f
10059	Patricia Chavez Martinez	emp10059@empresa.com	3	5	12	131	2020-05-16	t	f
10060	Pedro Ruiz Flores	emp10060@empresa.com	3	12	34	84	2022-01-19	t	f
10061	Fernando Cruz Gomez	emp10061@empresa.com	3	9	24	45	2019-01-07	t	f
10062	Ricardo Sanchez Perez	emp10062@empresa.com	3	1	1	55	2021-04-11	t	f
10063	Jose Morales Lopez	emp10063@empresa.com	2	15	43	33	2019-10-27	t	f
10064	Gabriela Chavez Ortiz	emp10064@empresa.com	3	4	10	94	2023-12-20	t	f
10065	Luis Ruiz Gutierrez	emp10065@empresa.com	1	4	9	40	2025-05-27	t	f
10066	Sofia Lopez Ramirez	emp10066@empresa.com	1	18	54	72	2020-01-11	t	f
10067	Sofia Rodriguez Gonzalez	emp10067@empresa.com	3	10	26	118	2018-06-19	t	f
10068	Elena Sanchez Cruz	emp10068@empresa.com	1	18	52	126	2022-01-02	t	f
10069	Diana Diaz Lopez	emp10069@empresa.com	3	12	35	120	2022-06-13	t	f
10070	Juan Rodriguez Hernandez	emp10070@empresa.com	3	11	32	11	2022-02-17	t	f
10071	Juan Gonzalez Cruz	emp10071@empresa.com	1	12	34	66	2023-12-11	t	f
10072	Miguel Gonzalez Sanchez	emp10072@empresa.com	2	1	2	109	2023-07-27	t	f
10073	Sofia Ortiz Diaz	emp10073@empresa.com	2	1	2	55	2021-05-05	t	f
10074	Raul Reyes Ortiz	emp10074@empresa.com	1	18	54	54	2019-04-15	t	f
10075	Carlos Rivera Ruiz	emp10075@empresa.com	1	15	42	51	2019-02-10	t	f
10076	Raul Diaz Perez	emp10076@empresa.com	1	9	23	45	2021-04-16	f	f
10077	Diana Rivera Gomez	emp10077@empresa.com	2	15	44	69	2025-12-24	t	f
10078	Patricia Lopez Hernandez	emp10078@empresa.com	2	16	48	70	2024-06-22	t	t
10079	Adriana Ramos Gutierrez	emp10079@empresa.com	3	9	25	117	2025-07-19	t	f
10080	Jose Ruiz Martinez	emp10080@empresa.com	3	18	54	144	2020-12-01	t	f
10081	Jose Torres Rodriguez	emp10081@empresa.com	1	9	22	135	2025-03-09	t	f
10082	Roberto Hernandez Gomez	emp10082@empresa.com	2	10	27	136	2018-11-07	t	f
10083	Luis Flores Lopez	emp10083@empresa.com	1	15	42	123	2025-10-16	t	f
10084	Jose Garcia Rodriguez	emp10084@empresa.com	3	8	21	44	2025-04-16	t	f
10085	Pedro Lopez Torres	emp10085@empresa.com	3	13	38	31	2020-10-22	t	f
10086	Laura Gomez Sanchez	emp10086@empresa.com	2	12	35	120	2020-04-28	t	f
10087	Patricia Sanchez Chavez	emp10087@empresa.com	1	18	52	108	2024-01-09	t	f
10088	Jorge Morales Cruz	emp10088@empresa.com	1	14	41	122	2025-11-27	t	f
10089	Fernando Reyes Lopez	emp10089@empresa.com	3	9	22	99	2022-10-14	t	t
10090	Isabel Gutierrez Garcia	emp10090@empresa.com	3	9	24	81	2022-02-15	t	f
10091	Ana Gutierrez Rivera	emp10091@empresa.com	3	7	18	43	2023-08-28	t	f
10092	Jorge Hernandez Hernandez	emp10092@empresa.com	1	8	20	44	2021-06-04	t	f
10093	Maria Ramirez Gonzalez	emp10093@empresa.com	2	9	23	63	2020-03-15	t	f
10094	Sofia Rodriguez Perez	emp10094@empresa.com	3	4	10	22	2019-01-05	t	f
10095	Gabriela Ruiz Rodriguez	emp10095@empresa.com	3	12	34	30	2022-02-06	t	f
10096	Raul Rodriguez Perez	emp10096@empresa.com	2	12	35	120	2018-10-17	t	f
10097	Carlos Gonzalez Ramos	emp10097@empresa.com	1	13	37	13	2025-05-09	t	f
10098	Patricia Ramirez Martinez	emp10098@empresa.com	3	2	3	74	2019-12-17	t	f
10099	Gabriela Sanchez Morales	emp10099@empresa.com	1	7	18	133	2025-06-28	t	f
10100	Ricardo Martinez Sanchez	emp10100@empresa.com	2	12	34	138	2025-09-26	f	f
10101	Ricardo Ruiz Chavez	emp10101@empresa.com	1	17	50	143	2024-02-01	t	f
10102	Fernando Flores Gomez	emp10102@empresa.com	3	18	53	144	2022-12-17	t	f
10103	Carlos Garcia Rivera	emp10103@empresa.com	1	8	20	44	2025-04-03	t	f
10104	Patricia Lopez Ruiz	emp10104@empresa.com	3	2	3	146	2022-06-22	t	f
10105	Juan Gomez Martinez	emp10105@empresa.com	3	12	33	30	2020-07-03	t	f
10106	Fernando Rivera Martinez	emp10106@empresa.com	3	2	4	146	2018-06-11	t	f
10107	Ana Gomez Sanchez	emp10107@empresa.com	3	11	30	65	2022-09-06	t	f
10108	Elena Ortiz Garcia	emp10108@empresa.com	3	2	3	146	2025-10-08	t	f
10109	Roberto Hernandez Sanchez	emp10109@empresa.com	1	9	25	45	2018-08-21	t	f
10110	Ana Martinez Lopez	emp10110@empresa.com	2	3	8	129	2026-01-16	t	f
10111	Jose Garcia Reyes	emp10111@empresa.com	1	2	4	38	2019-04-07	t	f
10112	Raul Garcia Reyes	emp10112@empresa.com	1	8	21	98	2019-07-03	t	f
10113	Carlos Gomez Ramirez	emp10113@empresa.com	3	12	34	84	2021-03-02	t	f
10114	Ricardo Chavez Diaz	emp10114@empresa.com	2	5	12	77	2020-10-27	t	f
10115	Adriana Ortiz Garcia	emp10115@empresa.com	3	8	19	44	2023-10-18	t	f
10116	Laura Ruiz Flores	emp10116@empresa.com	1	4	10	76	2024-03-24	t	f
10117	Adriana Flores Ramos	emp10117@empresa.com	3	9	23	99	2020-01-27	t	f
10118	Gabriela Ortiz Gomez	emp10118@empresa.com	2	15	44	141	2023-02-18	t	f
10119	Fernando Torres Rodriguez	emp10119@empresa.com	2	9	23	63	2019-02-14	t	f
10120	Monica Gutierrez Lopez	emp10120@empresa.com	3	8	20	44	2021-02-05	t	f
10121	Adriana Torres Rodriguez	emp10121@empresa.com	3	2	3	128	2019-05-26	t	f
10122	Laura Ramos Ortiz	emp10122@empresa.com	3	5	12	77	2020-05-11	t	f
10123	Carmen Gomez Cruz	emp10123@empresa.com	3	4	10	130	2023-08-13	f	f
10124	Adriana Rivera Sanchez	emp10124@empresa.com	2	2	4	110	2019-10-26	t	f
10125	Laura Perez Gonzalez	emp10125@empresa.com	2	8	19	8	2020-08-02	t	t
10126	Fernando Perez Rivera	emp10126@empresa.com	1	5	12	41	2025-09-27	t	f
10127	Jorge Hernandez Reyes	emp10127@empresa.com	3	12	33	30	2019-05-06	t	f
10128	Laura Flores Torres	emp10128@empresa.com	1	8	20	26	2026-01-18	t	f
10129	Ricardo Ramos Diaz	emp10129@empresa.com	1	16	47	88	2024-12-21	t	f
10130	Pedro Chavez Gonzalez	emp10130@empresa.com	1	16	49	142	2024-09-09	t	f
10131	Ricardo Hernandez Ortiz	emp10131@empresa.com	1	3	8	39	2021-05-03	t	f
10132	Monica Reyes Diaz	emp10132@empresa.com	1	6	13	24	2025-05-21	t	f
10133	Carmen Hernandez Rodriguez	emp10133@empresa.com	3	7	17	115	2021-07-08	t	f
10134	Hector Ortiz Cruz	emp10134@empresa.com	2	18	54	18	2023-04-22	t	f
10135	Luis Chavez Chavez	emp10135@empresa.com	2	8	19	44	2022-08-22	t	f
10136	Carmen Martinez Diaz	emp10136@empresa.com	3	9	23	27	2018-12-25	t	f
10137	Isabel Chavez Gutierrez	emp10137@empresa.com	3	14	40	68	2022-08-09	t	f
10138	Fernando Diaz Ramirez	emp10138@empresa.com	2	9	23	135	2025-09-15	t	f
10139	Elena Diaz Ramirez	emp10139@empresa.com	3	9	25	135	2023-10-04	t	f
10140	Carmen Cruz Torres	emp10140@empresa.com	3	6	13	114	2023-02-10	t	f
10141	Miguel Chavez Chavez	emp10141@empresa.com	3	10	26	64	2022-04-21	t	f
10142	Pedro Gomez Ramos	emp10142@empresa.com	3	14	41	32	2021-05-01	t	f
10143	Ana Rivera Diaz	emp10143@empresa.com	2	7	18	97	2018-06-19	t	f
10144	Carmen Garcia Rivera	emp10144@empresa.com	2	2	4	146	2021-10-03	t	f
10145	Carmen Diaz Reyes	emp10145@empresa.com	3	15	42	123	2025-08-05	t	f
10146	Ana Flores Diaz	emp10146@empresa.com	3	4	9	76	2023-02-26	t	f
10147	Miguel Perez Rodriguez	emp10147@empresa.com	1	12	33	66	2025-03-19	t	f
10148	Ana Ruiz Chavez	emp10148@empresa.com	3	4	10	94	2020-01-27	t	f
10149	Luis Hernandez Diaz	emp10149@empresa.com	1	14	40	14	2023-07-08	t	f
10150	Roberto Gomez Rodriguez	emp10150@empresa.com	3	9	22	27	2024-07-21	t	f
10151	Isabel Rivera Ortiz	emp10151@empresa.com	2	7	17	7	2018-07-03	t	f
10152	Isabel Torres Lopez	emp10152@empresa.com	3	13	36	49	2023-02-02	t	f
10153	Jorge Rodriguez Martinez	emp10153@empresa.com	2	7	18	43	2021-01-01	t	f
10154	Raul Ramos Lopez	emp10154@empresa.com	1	15	45	123	2026-01-29	t	f
10155	Miguel Ramirez Reyes	emp10155@empresa.com	1	15	45	33	2020-03-19	t	f
10156	Hector Torres Garcia	emp10156@empresa.com	2	11	30	83	2024-12-06	t	f
10157	Jorge Martinez Garcia	emp10157@empresa.com	1	2	4	20	2021-12-21	t	f
10158	Miguel Flores Ramirez	emp10158@empresa.com	3	17	50	71	2025-01-17	t	f
10159	Hector Sanchez Reyes	emp10159@empresa.com	1	11	29	29	2019-10-30	t	f
10160	Miguel Ortiz Ramirez	emp10160@empresa.com	2	8	19	44	2018-06-05	t	f
10161	Miguel Perez Gonzalez	emp10161@empresa.com	3	13	37	121	2022-01-20	t	f
10162	Gabriela Rodriguez Ortiz	emp10162@empresa.com	1	17	51	35	2022-03-21	t	t
10163	Raul Rodriguez Torres	emp10163@empresa.com	2	17	51	71	2024-05-21	t	f
10164	Elena Hernandez Ramirez	emp10164@empresa.com	1	9	23	27	2018-06-27	t	f
10165	Elena Torres Lopez	emp10165@empresa.com	2	15	44	123	2025-07-23	t	f
10166	Miguel Ramos Perez	emp10166@empresa.com	2	4	9	112	2020-01-12	f	f
10167	Raul Flores Hernandez	emp10167@empresa.com	3	16	46	52	2023-04-02	t	f
10168	Gabriela Chavez Sanchez	emp10168@empresa.com	3	16	48	106	2025-08-10	t	f
10169	Monica Morales Diaz	emp10169@empresa.com	2	4	10	148	2025-05-22	t	f
10170	Gabriela Ramirez Ortiz	emp10170@empresa.com	2	3	6	93	2018-12-24	t	t
10171	Raul Ramos Garcia	emp10171@empresa.com	3	12	33	138	2021-03-24	t	f
10172	Adriana Rodriguez Morales	emp10172@empresa.com	2	14	41	14	2024-06-15	t	f
10173	Hector Ramos Rivera	emp10173@empresa.com	1	14	39	104	2024-09-21	t	f
10174	Raul Perez Ramirez	emp10174@empresa.com	3	1	1	109	2023-09-11	t	f
10175	Maria Cruz Morales	emp10175@empresa.com	3	3	5	3	2022-02-24	t	f
10176	Hector Chavez Torres	emp10176@empresa.com	2	16	47	34	2024-01-29	t	f
10177	Isabel Ortiz Diaz	emp10177@empresa.com	2	2	4	74	2023-11-01	t	t
10178	Adriana Ortiz Chavez	emp10178@empresa.com	2	5	11	95	2019-08-31	t	f
10179	Hector Sanchez Flores	emp10179@empresa.com	1	14	40	68	2019-12-03	t	f
10180	Carlos Reyes Gonzalez	emp10180@empresa.com	1	15	43	69	2023-08-13	t	f
10181	Isabel Reyes Reyes	emp10181@empresa.com	3	8	21	80	2025-08-10	t	f
10182	Raul Rodriguez Ramirez	emp10182@empresa.com	1	3	5	75	2020-11-17	t	f
10183	Fernando Diaz Flores	emp10183@empresa.com	3	10	28	100	2021-05-23	t	f
10184	Hector Rodriguez Cruz	emp10184@empresa.com	2	18	52	72	2024-08-20	t	f
10185	Laura Ramirez Chavez	emp10185@empresa.com	3	4	10	148	2018-07-15	t	f
10186	Roberto Ramirez Morales	emp10186@empresa.com	3	1	1	73	2022-12-19	t	f
10187	Jose Ramirez Gomez	emp10187@empresa.com	1	2	3	20	2025-12-31	t	f
10188	Gabriela Garcia Ortiz	emp10188@empresa.com	1	5	12	95	2026-01-31	t	f
10189	Raul Lopez Garcia	emp10189@empresa.com	1	11	31	11	2025-11-07	t	f
10190	Maria Perez Chavez	emp10190@empresa.com	1	10	27	28	2024-05-04	t	f
10191	Ricardo Rodriguez Perez	emp10191@empresa.com	3	10	27	10	2025-09-06	t	f
10192	Hector Cruz Hernandez	emp10192@empresa.com	2	15	45	123	2021-05-16	t	f
10193	Elena Gomez Sanchez	emp10193@empresa.com	1	2	3	20	2022-02-06	t	f
10194	Laura Cruz Sanchez	emp10194@empresa.com	2	12	33	48	2025-08-26	f	f
10195	Juan Garcia Torres	emp10195@empresa.com	2	2	3	2	2024-03-21	t	f
10196	Patricia Hernandez Flores	emp10196@empresa.com	3	5	12	23	2022-02-23	t	f
10197	Carlos Lopez Diaz	emp10197@empresa.com	3	9	22	63	2021-02-24	f	f
10198	Adriana Reyes Morales	emp10198@empresa.com	2	6	13	24	2025-11-10	t	f
10199	Miguel Chavez Cruz	emp10199@empresa.com	1	9	23	45	2025-05-01	t	f
10200	Maria Lopez Morales	emp10200@empresa.com	1	15	45	51	2024-12-16	t	f
10201	Luis Gutierrez Chavez	emp10201@empresa.com	2	5	11	95	2019-05-16	t	f
10202	Monica Gomez Morales	emp10202@empresa.com	3	18	52	126	2022-04-08	t	f
10203	Isabel Gomez Sanchez	emp10203@empresa.com	2	9	22	81	2022-05-23	t	f
10204	Pedro Gutierrez Reyes	emp10204@empresa.com	3	17	50	107	2023-11-22	t	f
10205	Jose Hernandez Reyes	emp10205@empresa.com	3	6	13	24	2018-06-03	t	f
10206	Jose Sanchez Diaz	emp10206@empresa.com	3	6	14	42	2021-08-26	t	f
10207	Juan Ruiz Chavez	emp10207@empresa.com	3	8	21	44	2024-02-20	f	f
10208	Luis Ramos Lopez	emp10208@empresa.com	1	17	51	35	2025-10-14	t	f
10209	Fernando Sanchez Reyes	emp10209@empresa.com	3	14	39	104	2025-10-21	t	f
10210	Jorge Rodriguez Ramos	emp10210@empresa.com	3	4	9	94	2024-09-28	t	f
10211	Juan Torres Hernandez	emp10211@empresa.com	3	17	51	143	2022-07-31	t	f
10212	Laura Sanchez Ramos	emp10212@empresa.com	1	14	39	14	2024-06-25	t	f
10213	Diana Diaz Perez	emp10213@empresa.com	1	9	24	99	2018-11-07	t	f
10214	Hector Rodriguez Ramos	emp10214@empresa.com	3	12	34	120	2020-05-09	t	f
10215	Ana Gonzalez Hernandez	emp10215@empresa.com	2	14	41	104	2023-12-15	t	f
10216	Ricardo Rodriguez Garcia	emp10216@empresa.com	3	13	36	103	2024-03-22	t	f
10217	Roberto Gomez Chavez	emp10217@empresa.com	1	14	41	104	2022-05-04	t	f
10218	Elena Gomez Flores	emp10218@empresa.com	1	15	45	33	2022-06-29	f	f
10219	Maria Rodriguez Diaz	emp10219@empresa.com	3	3	5	93	2023-12-01	t	f
10220	Diana Morales Martinez	emp10220@empresa.com	2	17	50	125	2018-11-10	t	f
10221	Raul Rivera Martinez	emp10221@empresa.com	2	4	9	58	2021-05-27	t	f
10222	Gabriela Ramos Diaz	emp10222@empresa.com	1	10	28	10	2019-12-22	f	f
10223	Miguel Hernandez Gomez	emp10223@empresa.com	3	12	34	84	2025-03-26	f	f
10224	Sofia Rivera Garcia	emp10224@empresa.com	1	7	16	7	2024-05-02	t	f
10225	Hector Hernandez Martinez	emp10225@empresa.com	1	1	2	1	2023-01-13	t	f
10226	Fernando Perez Torres	emp10226@empresa.com	3	11	29	65	2024-10-14	t	f
10227	Fernando Gomez Ramos	emp10227@empresa.com	2	17	50	35	2025-05-08	t	f
10228	Diana Lopez Gonzalez	emp10228@empresa.com	3	16	46	34	2024-02-16	t	f
10229	Hector Gomez Perez	emp10229@empresa.com	3	8	21	134	2020-08-09	t	f
10230	Jorge Rodriguez Torres	emp10230@empresa.com	1	11	32	119	2025-12-15	t	f
10231	Fernando Flores Torres	emp10231@empresa.com	1	2	4	74	2018-06-21	t	f
10232	Jose Martinez Ramos	emp10232@empresa.com	3	7	17	115	2024-05-01	t	f
10233	Jose Ramos Reyes	emp10233@empresa.com	2	18	54	126	2021-07-23	t	f
10234	Laura Chavez Sanchez	emp10234@empresa.com	3	12	33	120	2021-09-13	t	f
10235	Juan Torres Gutierrez	emp10235@empresa.com	2	3	7	93	2021-09-01	t	f
10236	Maria Flores Diaz	emp10236@empresa.com	1	3	8	3	2023-02-12	t	f
10237	Monica Chavez Gonzalez	emp10237@empresa.com	2	17	51	53	2021-09-23	t	f
10238	Juan Chavez Chavez	emp10238@empresa.com	2	11	29	119	2021-08-03	t	f
10239	Elena Rodriguez Sanchez	emp10239@empresa.com	2	13	38	103	2020-12-07	t	f
10240	Luis Diaz Gomez	emp10240@empresa.com	2	17	50	107	2018-06-27	t	f
10241	Fernando Gutierrez Gomez	emp10241@empresa.com	3	15	45	87	2022-02-13	t	f
10242	Maria Morales Ortiz	emp10242@empresa.com	3	6	15	78	2020-03-18	t	f
10243	Isabel Gonzalez Gonzalez	emp10243@empresa.com	3	10	28	64	2025-09-16	t	f
10244	Roberto Flores Sanchez	emp10244@empresa.com	1	6	14	114	2019-03-05	t	f
10245	Roberto Cruz Chavez	emp10245@empresa.com	1	2	3	2	2020-06-25	t	f
10246	Fernando Lopez Gonzalez	emp10246@empresa.com	1	8	19	8	2025-12-12	t	f
10247	Adriana Lopez Chavez	emp10247@empresa.com	1	5	12	23	2020-03-29	t	f
10248	Maria Gomez Lopez	emp10248@empresa.com	1	2	3	128	2022-12-27	t	f
10249	Ricardo Ramirez Diaz	emp10249@empresa.com	1	17	51	17	2021-10-09	t	f
10250	Isabel Morales Reyes	emp10250@empresa.com	1	18	52	54	2021-01-25	t	f
10251	Hector Rivera Perez	emp10251@empresa.com	3	2	3	74	2022-11-02	t	f
10252	Luis Ramos Rivera	emp10252@empresa.com	3	11	32	101	2024-02-27	t	f
10253	Miguel Perez Gonzalez	emp10253@empresa.com	2	4	9	148	2025-04-09	t	f
10254	Isabel Gutierrez Gonzalez	emp10254@empresa.com	1	12	35	102	2024-03-22	t	f
10255	Ana Gonzalez Gutierrez	emp10255@empresa.com	2	3	6	57	2023-01-10	t	f
10256	Monica Garcia Ruiz	emp10256@empresa.com	3	6	14	24	2024-08-30	t	f
10257	Adriana Gonzalez Rodriguez	emp10257@empresa.com	2	6	13	96	2020-08-01	t	f
10258	Patricia Gutierrez Cruz	emp10258@empresa.com	2	9	24	99	2023-12-19	t	f
10259	Elena Flores Lopez	emp10259@empresa.com	1	14	39	104	2021-04-08	t	f
10260	Pedro Garcia Martinez	emp10260@empresa.com	3	2	4	110	2025-03-20	t	f
10261	Maria Gutierrez Diaz	emp10261@empresa.com	3	2	4	74	2022-01-16	t	f
10262	Diana Rodriguez Garcia	emp10262@empresa.com	3	1	2	73	2020-12-12	t	f
10263	Ana Torres Ortiz	emp10263@empresa.com	1	8	20	134	2024-10-10	t	f
10264	Carlos Rivera Diaz	emp10264@empresa.com	3	18	53	54	2025-08-11	t	f
10265	Hector Perez Reyes	emp10265@empresa.com	1	8	21	8	2020-05-08	t	f
10266	Hector Chavez Diaz	emp10266@empresa.com	1	13	38	85	2025-05-13	t	f
10267	Ana Gutierrez Flores	emp10267@empresa.com	2	1	1	19	2022-11-19	t	f
10268	Carmen Hernandez Rivera	emp10268@empresa.com	3	7	16	97	2020-08-12	t	f
10269	Raul Ramos Lopez	emp10269@empresa.com	1	10	28	64	2025-04-25	f	f
10270	Roberto Rodriguez Ramos	emp10270@empresa.com	1	18	54	90	2019-03-31	t	f
10271	Elena Gutierrez Chavez	emp10271@empresa.com	1	17	50	17	2022-05-17	t	f
10272	Laura Morales Ramos	emp10272@empresa.com	2	5	11	77	2023-07-04	t	f
10273	Roberto Flores Hernandez	emp10273@empresa.com	2	1	2	145	2021-05-28	t	f
10274	Ricardo Torres Ramirez	emp10274@empresa.com	3	1	2	37	2020-05-21	f	f
10275	Diana Gomez Rivera	emp10275@empresa.com	2	15	42	69	2021-12-28	t	f
10276	Pedro Gonzalez Ortiz	emp10276@empresa.com	2	4	9	112	2023-01-13	t	f
10277	Hector Perez Ramirez	emp10277@empresa.com	2	2	4	20	2025-10-06	t	f
10278	Carmen Morales Rivera	emp10278@empresa.com	3	3	6	21	2025-10-30	t	f
10279	Isabel Ramos Gomez	emp10279@empresa.com	3	2	3	74	2018-11-08	t	f
10280	Elena Ruiz Perez	emp10280@empresa.com	3	13	38	31	2023-04-30	t	f
10281	Laura Garcia Morales	emp10281@empresa.com	2	3	7	21	2023-01-07	t	f
10282	Monica Ortiz Cruz	emp10282@empresa.com	3	9	23	99	2018-11-15	t	f
10283	Elena Ramirez Martinez	emp10283@empresa.com	1	1	1	19	2020-04-05	t	f
10284	Raul Ramirez Rodriguez	emp10284@empresa.com	2	6	15	60	2021-04-23	t	f
10285	Ana Ramirez Perez	emp10285@empresa.com	2	1	1	109	2019-07-19	t	f
10286	Ana Cruz Rodriguez	emp10286@empresa.com	2	17	51	71	2021-01-30	t	f
10287	Gabriela Hernandez Morales	emp10287@empresa.com	2	8	20	98	2024-06-16	t	f
10288	Elena Martinez Gonzalez	emp10288@empresa.com	1	10	27	100	2024-06-11	t	t
10289	Jose Ortiz Flores	emp10289@empresa.com	2	12	35	48	2024-08-25	t	f
10290	Sofia Ruiz Rivera	emp10290@empresa.com	3	16	46	142	2019-01-28	t	f
10291	Carlos Morales Gomez	emp10291@empresa.com	3	6	15	114	2020-04-16	t	f
10292	Monica Hernandez Morales	emp10292@empresa.com	3	11	32	65	2019-06-06	t	f
10293	Patricia Flores Diaz	emp10293@empresa.com	2	17	51	89	2021-04-12	f	f
10294	Raul Cruz Perez	emp10294@empresa.com	3	3	7	93	2018-08-20	t	f
10295	Maria Ortiz Ortiz	emp10295@empresa.com	1	16	49	106	2020-07-19	t	f
10296	Sofia Ramirez Torres	emp10296@empresa.com	2	18	55	18	2020-04-09	t	f
10297	Fernando Perez Diaz	emp10297@empresa.com	1	8	20	116	2018-12-26	t	f
10298	Carlos Gutierrez Martinez	emp10298@empresa.com	1	18	52	36	2021-02-13	t	f
10299	Pedro Reyes Flores	emp10299@empresa.com	1	14	39	14	2025-09-26	t	f
10300	Ricardo Cruz Flores	emp10300@empresa.com	3	14	40	122	2022-09-13	t	f
10301	Ana Gomez Gutierrez	emp10301@empresa.com	3	5	11	23	2019-08-18	t	f
10302	Luis Reyes Martinez	emp10302@empresa.com	2	1	1	55	2020-09-06	t	f
10303	Diana Ramirez Perez	emp10303@empresa.com	1	9	22	81	2022-07-04	t	f
10304	Miguel Morales Ramos	emp10304@empresa.com	2	12	35	84	2020-04-27	t	f
10305	Hector Torres Morales	emp10305@empresa.com	2	14	40	104	2025-03-29	t	f
10306	Laura Martinez Gonzalez	emp10306@empresa.com	3	15	43	51	2023-01-21	t	f
10307	Ana Sanchez Gonzalez	emp10307@empresa.com	1	17	51	125	2021-01-25	t	f
10308	Maria Gutierrez Diaz	emp10308@empresa.com	1	4	9	76	2022-12-18	t	f
10309	Ana Torres Perez	emp10309@empresa.com	1	8	19	80	2023-11-18	t	f
10310	Fernando Hernandez Ramos	emp10310@empresa.com	2	6	13	132	2022-11-02	t	f
10311	Elena Martinez Flores	emp10311@empresa.com	1	14	40	122	2020-01-26	t	f
10312	Luis Rivera Lopez	emp10312@empresa.com	3	13	36	121	2025-10-27	t	f
10313	Jorge Rivera Martinez	emp10313@empresa.com	3	5	11	77	2025-03-18	t	f
10314	Jorge Chavez Flores	emp10314@empresa.com	3	10	26	100	2020-01-08	t	f
10315	Patricia Martinez Rodriguez	emp10315@empresa.com	2	16	47	16	2022-01-15	t	f
10316	Isabel Garcia Flores	emp10316@empresa.com	3	1	2	91	2022-03-18	t	f
10317	Maria Garcia Ramos	emp10317@empresa.com	2	5	11	131	2025-09-06	t	f
10318	Carmen Flores Reyes	emp10318@empresa.com	1	9	24	99	2024-02-01	t	f
10319	Maria Gonzalez Lopez	emp10319@empresa.com	2	15	43	69	2021-08-08	t	f
10320	Laura Sanchez Cruz	emp10320@empresa.com	2	9	23	9	2023-02-02	t	f
10321	Ana Chavez Lopez	emp10321@empresa.com	2	1	2	1	2024-06-26	t	f
10322	Pedro Torres Ortiz	emp10322@empresa.com	2	12	33	84	2023-06-01	t	f
10323	Elena Ruiz Rivera	emp10323@empresa.com	3	2	4	128	2025-03-12	t	f
10324	Carmen Chavez Ramos	emp10324@empresa.com	1	10	28	82	2023-12-15	t	f
10325	Ricardo Rodriguez Perez	emp10325@empresa.com	1	13	36	139	2021-07-11	t	f
10326	Miguel Garcia Ramos	emp10326@empresa.com	1	17	51	143	2023-04-30	t	f
10327	Pedro Morales Cruz	emp10327@empresa.com	3	16	46	106	2021-07-10	f	f
10328	Raul Ortiz Perez	emp10328@empresa.com	1	12	35	30	2018-09-02	t	f
10329	Laura Gutierrez Ortiz	emp10329@empresa.com	2	2	4	38	2024-01-07	t	f
10330	Laura Reyes Rodriguez	emp10330@empresa.com	3	12	35	84	2020-10-22	t	f
10331	Gabriela Gomez Gonzalez	emp10331@empresa.com	1	3	5	3	2021-01-30	t	f
10332	Jose Flores Gonzalez	emp10332@empresa.com	1	18	54	108	2020-07-21	t	f
10333	Jose Perez Hernandez	emp10333@empresa.com	3	18	52	108	2025-07-29	t	f
10334	Sofia Gomez Martinez	emp10334@empresa.com	1	9	25	27	2022-12-31	t	f
10335	Ana Flores Lopez	emp10335@empresa.com	3	8	20	44	2025-03-28	t	f
10336	Jorge Reyes Rivera	emp10336@empresa.com	1	15	45	87	2018-09-04	t	f
10337	Carmen Ortiz Ruiz	emp10337@empresa.com	3	15	42	105	2025-02-07	t	f
10338	Fernando Sanchez Gonzalez	emp10338@empresa.com	1	17	50	89	2019-07-01	t	f
10339	Maria Chavez Hernandez	emp10339@empresa.com	2	7	17	115	2023-07-31	t	f
10340	Juan Gomez Rodriguez	emp10340@empresa.com	2	16	49	88	2024-10-01	t	f
10341	Elena Ramirez Reyes	emp10341@empresa.com	3	16	49	124	2019-06-03	t	f
10342	Isabel Cruz Gutierrez	emp10342@empresa.com	1	8	20	62	2018-08-16	t	f
10343	Ricardo Diaz Rodriguez	emp10343@empresa.com	1	12	35	120	2023-12-20	t	f
10344	Pedro Gutierrez Diaz	emp10344@empresa.com	2	13	37	49	2021-11-03	f	f
10345	Ricardo Flores Ramirez	emp10345@empresa.com	2	15	43	141	2020-12-09	t	f
10346	Patricia Ruiz Perez	emp10346@empresa.com	2	1	2	73	2023-08-24	t	f
10347	Isabel Ruiz Gomez	emp10347@empresa.com	2	1	1	73	2023-12-20	f	f
10348	Ana Ortiz Martinez	emp10348@empresa.com	1	12	34	66	2024-09-26	t	f
10349	Patricia Ortiz Gonzalez	emp10349@empresa.com	1	1	1	55	2025-07-02	t	f
10350	Ana Rivera Perez	emp10350@empresa.com	3	8	21	80	2024-01-24	t	f
10351	Juan Reyes Cruz	emp10351@empresa.com	3	4	10	130	2022-11-12	t	f
10352	Ricardo Sanchez Diaz	emp10352@empresa.com	1	16	46	52	2020-09-14	t	f
10353	Carmen Rivera Ramos	emp10353@empresa.com	3	2	3	128	2022-06-21	t	f
10354	Ana Reyes Torres	emp10354@empresa.com	2	2	4	110	2020-07-01	t	f
10355	Carlos Lopez Rodriguez	emp10355@empresa.com	2	11	29	11	2018-09-22	t	f
10356	Ricardo Chavez Reyes	emp10356@empresa.com	3	10	26	100	2023-10-03	t	f
10357	Isabel Chavez Morales	emp10357@empresa.com	3	2	4	110	2025-04-10	t	f
10358	Carlos Diaz Ramirez	emp10358@empresa.com	1	16	47	124	2019-12-19	t	f
10359	Juan Chavez Chavez	emp10359@empresa.com	2	2	4	146	2023-09-22	t	f
10360	Elena Chavez Gomez	emp10360@empresa.com	2	1	2	145	2024-04-14	t	f
10361	Jose Reyes Hernandez	emp10361@empresa.com	3	3	5	3	2019-11-28	t	f
10362	Patricia Ortiz Gonzalez	emp10362@empresa.com	3	15	42	141	2021-06-23	t	f
10363	Maria Torres Perez	emp10363@empresa.com	2	17	51	89	2019-05-22	t	f
10364	Juan Lopez Rivera	emp10364@empresa.com	2	11	31	65	2024-03-19	t	f
10365	Isabel Sanchez Ortiz	emp10365@empresa.com	2	12	34	12	2021-05-06	t	f
10366	Elena Morales Rodriguez	emp10366@empresa.com	2	11	29	29	2020-03-01	t	t
10367	Diana Sanchez Morales	emp10367@empresa.com	3	15	42	105	2022-04-23	f	f
10368	Hector Gutierrez Hernandez	emp10368@empresa.com	3	4	10	148	2021-08-20	t	f
10369	Hector Gonzalez Torres	emp10369@empresa.com	3	17	51	35	2019-09-25	t	f
10370	Juan Reyes Ortiz	emp10370@empresa.com	2	7	18	115	2020-06-03	t	f
10371	Roberto Ruiz Lopez	emp10371@empresa.com	3	15	44	87	2019-12-15	t	f
10372	Pedro Lopez Lopez	emp10372@empresa.com	2	14	41	68	2024-03-29	t	f
10373	Jose Sanchez Flores	emp10373@empresa.com	3	7	18	7	2025-02-21	t	f
10374	Maria Ramirez Perez	emp10374@empresa.com	1	5	12	113	2022-11-15	t	f
10375	Carlos Gomez Ortiz	emp10375@empresa.com	2	6	13	114	2023-12-06	t	f
10376	Hector Diaz Gonzalez	emp10376@empresa.com	2	9	22	99	2025-03-21	t	f
10377	Maria Sanchez Flores	emp10377@empresa.com	3	4	9	130	2024-01-03	t	f
10378	Miguel Rodriguez Rodriguez	emp10378@empresa.com	3	8	20	116	2022-02-21	f	f
10379	Carmen Reyes Torres	emp10379@empresa.com	3	18	55	126	2020-05-28	t	f
10380	Hector Martinez Garcia	emp10380@empresa.com	1	4	9	22	2020-06-05	t	f
10381	Maria Chavez Perez	emp10381@empresa.com	2	16	47	52	2025-06-01	t	f
10382	Carlos Lopez Sanchez	emp10382@empresa.com	1	2	4	128	2020-07-08	t	f
10383	Raul Gonzalez Rodriguez	emp10383@empresa.com	1	11	32	137	2023-02-02	t	f
10384	Jorge Hernandez Cruz	emp10384@empresa.com	2	16	46	52	2019-11-19	t	f
10385	Ricardo Gomez Garcia	emp10385@empresa.com	1	15	43	51	2025-09-24	t	f
10386	Raul Rodriguez Gomez	emp10386@empresa.com	1	4	9	22	2021-10-15	t	f
10387	Raul Flores Flores	emp10387@empresa.com	1	2	3	38	2019-10-04	t	f
10388	Pedro Garcia Morales	emp10388@empresa.com	1	3	6	39	2018-07-20	t	f
10389	Isabel Rivera Reyes	emp10389@empresa.com	2	5	12	23	2021-05-30	t	f
10390	Jose Gutierrez Martinez	emp10390@empresa.com	3	1	1	91	2023-10-26	t	f
10391	Jose Gomez Ruiz	emp10391@empresa.com	1	8	19	26	2024-02-24	f	f
10392	Raul Lopez Morales	emp10392@empresa.com	3	15	43	87	2024-12-28	t	f
10393	Roberto Lopez Ortiz	emp10393@empresa.com	1	13	36	49	2022-05-28	t	f
10394	Elena Chavez Gonzalez	emp10394@empresa.com	1	8	21	44	2022-11-25	t	f
10395	Ana Sanchez Flores	emp10395@empresa.com	1	18	53	72	2020-10-15	t	f
10396	Gabriela Sanchez Flores	emp10396@empresa.com	3	9	22	27	2021-01-14	t	f
10397	Ana Chavez Flores	emp10397@empresa.com	2	4	10	148	2023-12-01	f	f
10398	Ana Ramos Hernandez	emp10398@empresa.com	2	3	6	93	2025-03-01	t	f
10399	Hector Lopez Ortiz	emp10399@empresa.com	1	5	12	131	2018-12-25	t	f
10400	Pedro Diaz Reyes	emp10400@empresa.com	2	10	28	28	2024-01-12	t	f
10401	Sofia Ruiz Hernandez	emp10401@empresa.com	2	11	29	29	2024-10-17	t	f
10402	Elena Rivera Rivera	emp10402@empresa.com	3	15	44	141	2019-11-22	t	f
10403	Carlos Chavez Flores	emp10403@empresa.com	1	12	35	66	2020-08-11	f	f
10404	Adriana Ortiz Sanchez	emp10404@empresa.com	2	17	50	71	2019-06-15	t	f
10405	Adriana Martinez Ramos	emp10405@empresa.com	2	3	7	57	2024-12-10	t	f
10406	Jose Morales Ortiz	emp10406@empresa.com	3	7	16	7	2023-02-24	t	t
10407	Elena Garcia Torres	emp10407@empresa.com	3	15	42	33	2019-06-19	t	f
10408	Monica Sanchez Flores	emp10408@empresa.com	1	6	14	6	2025-09-23	t	f
10409	Pedro Lopez Rodriguez	emp10409@empresa.com	2	6	14	150	2025-08-14	t	f
10410	Jose Lopez Garcia	emp10410@empresa.com	2	13	38	103	2023-10-29	t	f
10411	Ana Rivera Lopez	emp10411@empresa.com	2	8	20	98	2022-09-25	t	f
10412	Laura Sanchez Gomez	emp10412@empresa.com	3	6	14	6	2022-05-24	t	f
10413	Ana Hernandez Garcia	emp10413@empresa.com	2	16	46	16	2019-11-19	t	f
10414	Patricia Garcia Garcia	emp10414@empresa.com	3	4	9	58	2018-11-07	t	t
10415	Adriana Hernandez Garcia	emp10415@empresa.com	2	2	4	56	2025-01-03	t	f
10416	Sofia Lopez Torres	emp10416@empresa.com	3	14	40	32	2022-07-07	t	f
10417	Jose Rivera Lopez	emp10417@empresa.com	3	1	1	73	2019-09-18	t	f
10418	Carlos Perez Gutierrez	emp10418@empresa.com	3	5	11	23	2025-09-30	f	f
10419	Jose Ramirez Rodriguez	emp10419@empresa.com	3	4	10	40	2019-01-04	t	f
10420	Raul Perez Gomez	emp10420@empresa.com	2	1	2	109	2025-09-05	t	f
10421	Sofia Ramirez Chavez	emp10421@empresa.com	3	13	36	31	2021-10-30	t	f
10422	Roberto Gutierrez Rivera	emp10422@empresa.com	3	17	51	107	2019-01-27	t	f
10423	Elena Sanchez Lopez	emp10423@empresa.com	2	17	51	71	2024-11-04	t	f
10424	Hector Flores Morales	emp10424@empresa.com	3	12	33	120	2022-06-17	t	f
10425	Maria Rodriguez Ortiz	emp10425@empresa.com	1	12	35	12	2023-04-24	f	f
10426	Jose Gutierrez Sanchez	emp10426@empresa.com	2	3	7	75	2022-05-23	t	f
10427	Patricia Reyes Reyes	emp10427@empresa.com	2	16	46	88	2023-11-22	t	f
10428	Carmen Hernandez Torres	emp10428@empresa.com	2	17	50	71	2023-09-05	t	f
10429	Jose Martinez Rodriguez	emp10429@empresa.com	3	4	10	148	2023-12-24	t	f
10430	Pedro Hernandez Gonzalez	emp10430@empresa.com	3	10	27	10	2024-05-18	t	f
10431	Diana Flores Diaz	emp10431@empresa.com	1	7	18	7	2019-01-14	t	f
10432	Laura Torres Rivera	emp10432@empresa.com	1	7	17	61	2022-10-30	t	f
10433	Diana Ruiz Reyes	emp10433@empresa.com	1	16	48	106	2024-08-27	t	f
10434	Isabel Ramos Hernandez	emp10434@empresa.com	2	6	13	96	2021-07-10	t	f
10435	Hector Lopez Diaz	emp10435@empresa.com	3	2	4	2	2022-05-22	t	f
10436	Laura Sanchez Ramos	emp10436@empresa.com	3	5	11	113	2018-12-26	t	f
10437	Miguel Cruz Gomez	emp10437@empresa.com	1	11	31	101	2022-08-06	t	f
10438	Fernando Flores Ortiz	emp10438@empresa.com	1	14	40	122	2023-09-04	t	f
10439	Carmen Gomez Rodriguez	emp10439@empresa.com	2	2	4	128	2023-10-05	t	f
10440	Sofia Perez Morales	emp10440@empresa.com	3	17	50	107	2024-05-21	t	f
10441	Laura Hernandez Morales	emp10441@empresa.com	2	9	22	99	2020-01-26	t	f
10442	Jose Gonzalez Ramirez	emp10442@empresa.com	3	2	3	20	2019-02-07	t	f
10443	Fernando Rivera Flores	emp10443@empresa.com	3	15	45	69	2018-11-08	t	f
10444	Miguel Chavez Flores	emp10444@empresa.com	3	18	54	36	2019-07-18	t	f
10445	Luis Gomez Chavez	emp10445@empresa.com	3	15	43	51	2023-09-06	t	f
10446	Monica Martinez Reyes	emp10446@empresa.com	1	16	46	88	2019-07-23	t	f
10447	Patricia Rivera Lopez	emp10447@empresa.com	1	18	55	36	2025-02-26	t	f
10448	Jose Diaz Hernandez	emp10448@empresa.com	1	6	14	24	2023-06-18	t	t
10449	Hector Gutierrez Gomez	emp10449@empresa.com	3	5	12	149	2022-04-16	t	f
10450	Maria Rivera Flores	emp10450@empresa.com	2	18	53	108	2022-12-09	t	f
10451	Jose Ramos Lopez	emp10451@empresa.com	3	3	8	129	2024-08-07	t	f
10452	Ana Diaz Ruiz	emp10452@empresa.com	3	17	51	143	2024-01-12	t	f
10453	Jorge Torres Gutierrez	emp10453@empresa.com	2	8	21	98	2022-07-23	t	f
10454	Carmen Sanchez Torres	emp10454@empresa.com	2	2	3	20	2019-10-12	t	f
10455	Laura Gomez Reyes	emp10455@empresa.com	1	14	40	140	2019-12-27	t	f
10456	Ana Reyes Sanchez	emp10456@empresa.com	3	1	2	109	2018-11-15	t	f
10457	Fernando Rivera Lopez	emp10457@empresa.com	3	3	7	111	2021-09-17	t	f
10458	Fernando Ortiz Martinez	emp10458@empresa.com	2	14	41	32	2024-07-19	f	f
10459	Adriana Morales Martinez	emp10459@empresa.com	2	15	42	69	2024-11-30	f	f
10460	Roberto Garcia Rodriguez	emp10460@empresa.com	1	2	4	38	2020-11-01	t	f
10461	Luis Chavez Sanchez	emp10461@empresa.com	1	13	38	67	2025-10-08	t	f
10462	Juan Ortiz Garcia	emp10462@empresa.com	2	1	1	73	2022-08-13	f	f
10463	Elena Ruiz Cruz	emp10463@empresa.com	1	1	2	73	2021-10-02	f	f
10464	Jose Gomez Reyes	emp10464@empresa.com	1	6	14	150	2020-05-16	t	f
10465	Carmen Sanchez Hernandez	emp10465@empresa.com	1	8	20	134	2023-01-18	t	f
10466	Elena Torres Martinez	emp10466@empresa.com	1	4	10	40	2019-01-15	t	f
10467	Elena Garcia Rivera	emp10467@empresa.com	3	13	38	121	2022-07-07	t	f
10468	Juan Torres Gonzalez	emp10468@empresa.com	2	5	11	149	2018-06-08	f	f
10469	Adriana Ramos Garcia	emp10469@empresa.com	1	11	32	137	2025-03-30	t	f
10470	Monica Flores Morales	emp10470@empresa.com	3	9	22	81	2020-02-09	t	f
10471	Fernando Gomez Ramirez	emp10471@empresa.com	2	4	10	148	2025-07-11	t	f
10472	Gabriela Diaz Ortiz	emp10472@empresa.com	3	14	39	122	2023-03-08	t	f
10473	Adriana Diaz Gutierrez	emp10473@empresa.com	2	1	2	109	2025-10-16	t	f
10474	Adriana Morales Gutierrez	emp10474@empresa.com	1	18	52	72	2022-04-05	t	f
10475	Isabel Flores Chavez	emp10475@empresa.com	2	2	4	92	2019-11-14	t	f
10476	Monica Gomez Martinez	emp10476@empresa.com	1	14	40	140	2019-10-06	t	f
10477	Miguel Lopez Reyes	emp10477@empresa.com	1	11	29	65	2020-03-26	t	f
10478	Sofia Chavez Gomez	emp10478@empresa.com	2	15	42	141	2023-05-22	t	f
10479	Juan Ramirez Rodriguez	emp10479@empresa.com	1	12	34	138	2018-09-29	t	f
10480	Isabel Martinez Ruiz	emp10480@empresa.com	1	13	38	67	2024-01-20	t	f
10481	Jose Sanchez Cruz	emp10481@empresa.com	1	4	10	94	2018-07-09	t	f
10482	Maria Diaz Chavez	emp10482@empresa.com	1	11	32	47	2020-06-21	t	f
10483	Diana Gonzalez Morales	emp10483@empresa.com	2	10	26	10	2025-02-26	t	f
10484	Laura Ruiz Gonzalez	emp10484@empresa.com	3	6	14	42	2019-03-17	t	f
10485	Patricia Rodriguez Sanchez	emp10485@empresa.com	2	11	32	101	2018-09-29	t	f
10486	Maria Rivera Morales	emp10486@empresa.com	1	16	49	34	2022-07-21	t	f
10487	Adriana Flores Garcia	emp10487@empresa.com	1	11	29	137	2020-07-11	t	f
10488	Laura Gutierrez Hernandez	emp10488@empresa.com	1	2	3	146	2024-10-15	t	f
10489	Adriana Rodriguez Rivera	emp10489@empresa.com	2	2	3	128	2020-08-27	t	f
10490	Roberto Diaz Ruiz	emp10490@empresa.com	1	17	50	125	2021-05-30	t	f
10491	Juan Chavez Perez	emp10491@empresa.com	1	15	44	69	2023-03-27	t	f
10492	Juan Flores Torres	emp10492@empresa.com	3	7	17	7	2025-05-08	t	f
10493	Adriana Gonzalez Ortiz	emp10493@empresa.com	1	4	10	58	2022-10-14	t	f
10494	Luis Reyes Ruiz	emp10494@empresa.com	2	8	19	44	2020-09-06	t	f
10495	Maria Martinez Martinez	emp10495@empresa.com	3	9	25	45	2020-08-01	t	f
10496	Isabel Rivera Hernandez	emp10496@empresa.com	3	17	51	71	2024-03-10	t	f
10497	Diana Morales Chavez	emp10497@empresa.com	2	5	12	41	2025-06-08	t	f
10498	Sofia Martinez Cruz	emp10498@empresa.com	2	4	10	58	2023-03-12	t	f
10499	Fernando Diaz Garcia	emp10499@empresa.com	3	11	31	83	2020-01-31	f	f
10500	Diana Ramos Gonzalez	emp10500@empresa.com	3	3	6	39	2023-11-20	t	f
10501	Isabel Flores Garcia	emp10501@empresa.com	3	16	48	70	2022-07-24	t	f
10502	Luis Flores Sanchez	emp10502@empresa.com	1	14	40	68	2025-01-11	t	f
10503	Hector Torres Ramos	emp10503@empresa.com	2	2	3	2	2024-11-12	t	f
10504	Hector Martinez Torres	emp10504@empresa.com	2	1	1	55	2022-12-18	t	t
10505	Raul Perez Cruz	emp10505@empresa.com	3	16	47	88	2024-06-24	t	f
10506	Laura Morales Morales	emp10506@empresa.com	3	6	15	42	2022-09-21	t	f
10507	Carlos Gonzalez Gonzalez	emp10507@empresa.com	1	6	13	96	2020-06-16	t	f
10508	Roberto Ortiz Rodriguez	emp10508@empresa.com	1	4	10	130	2020-12-16	t	f
10509	Isabel Ramos Flores	emp10509@empresa.com	1	5	12	5	2024-04-14	t	f
10510	Roberto Garcia Ortiz	emp10510@empresa.com	2	13	37	49	2022-04-06	t	t
10511	Maria Ortiz Torres	emp10511@empresa.com	1	6	15	114	2022-02-02	t	f
10512	Laura Chavez Gutierrez	emp10512@empresa.com	2	12	35	138	2025-10-12	t	f
10513	Elena Torres Martinez	emp10513@empresa.com	1	8	20	26	2023-09-11	t	f
10514	Carmen Ramos Sanchez	emp10514@empresa.com	1	6	14	114	2021-09-25	t	f
10515	Carlos Morales Ortiz	emp10515@empresa.com	2	4	10	76	2023-02-16	f	f
10516	Jorge Rodriguez Diaz	emp10516@empresa.com	2	3	7	21	2021-12-12	t	f
10517	Hector Morales Perez	emp10517@empresa.com	2	3	5	129	2022-03-10	t	f
10518	Pedro Gutierrez Hernandez	emp10518@empresa.com	2	7	17	25	2024-09-27	t	f
10519	Isabel Garcia Gonzalez	emp10519@empresa.com	1	14	41	14	2025-02-15	t	f
10520	Ana Ramirez Rivera	emp10520@empresa.com	2	8	19	26	2023-03-11	t	f
10521	Roberto Chavez Ruiz	emp10521@empresa.com	1	12	35	84	2020-08-26	t	f
10522	Ricardo Perez Sanchez	emp10522@empresa.com	2	4	10	112	2025-12-21	t	f
10523	Sofia Gutierrez Cruz	emp10523@empresa.com	2	11	30	65	2022-10-19	t	f
10524	Laura Morales Garcia	emp10524@empresa.com	2	14	41	86	2022-05-15	f	f
10525	Ana Perez Gutierrez	emp10525@empresa.com	1	4	9	40	2024-11-17	t	f
10526	Raul Rivera Rodriguez	emp10526@empresa.com	2	8	19	62	2025-04-17	t	f
10527	Raul Lopez Gomez	emp10527@empresa.com	1	7	16	133	2018-11-12	t	f
10528	Ricardo Ramos Gomez	emp10528@empresa.com	1	14	41	104	2022-08-08	t	f
10529	Diana Martinez Sanchez	emp10529@empresa.com	2	13	37	121	2022-08-17	t	f
10530	Ana Ruiz Gomez	emp10530@empresa.com	1	5	12	113	2022-02-27	t	f
10531	Jose Morales Gomez	emp10531@empresa.com	2	4	10	130	2018-06-26	t	f
10532	Laura Ramirez Ramirez	emp10532@empresa.com	1	5	12	113	2020-05-30	t	t
10533	Miguel Gutierrez Sanchez	emp10533@empresa.com	3	8	21	44	2022-03-05	t	f
10534	Laura Rivera Torres	emp10534@empresa.com	2	2	4	20	2022-11-22	t	f
10535	Sofia Gutierrez Torres	emp10535@empresa.com	1	15	43	51	2023-08-07	t	f
10536	Roberto Torres Hernandez	emp10536@empresa.com	2	14	40	14	2020-07-14	t	f
10537	Juan Morales Hernandez	emp10537@empresa.com	1	17	50	125	2025-10-09	t	f
10538	Patricia Garcia Perez	emp10538@empresa.com	2	10	26	100	2025-08-29	t	f
10539	Diana Cruz Diaz	emp10539@empresa.com	1	8	19	98	2021-05-31	t	f
10540	Miguel Ramos Diaz	emp10540@empresa.com	3	9	24	81	2023-11-05	t	f
10541	Elena Rodriguez Cruz	emp10541@empresa.com	1	12	34	48	2020-02-14	t	t
10542	Pedro Torres Morales	emp10542@empresa.com	1	10	28	28	2020-10-05	t	f
10543	Jorge Lopez Lopez	emp10543@empresa.com	1	1	2	127	2024-10-20	f	f
10544	Gabriela Ortiz Cruz	emp10544@empresa.com	1	6	14	132	2019-08-12	t	f
10545	Gabriela Lopez Ortiz	emp10545@empresa.com	2	7	18	7	2023-05-05	t	f
10546	Monica Ortiz Chavez	emp10546@empresa.com	2	3	7	147	2023-05-27	t	f
10547	Elena Diaz Ruiz	emp10547@empresa.com	3	4	9	76	2021-11-25	t	f
10548	Jose Sanchez Diaz	emp10548@empresa.com	3	16	47	52	2023-08-05	t	f
10549	Patricia Gomez Ramos	emp10549@empresa.com	2	7	18	79	2018-07-16	t	f
10550	Roberto Martinez Flores	emp10550@empresa.com	3	7	17	43	2020-04-09	t	f
10551	Adriana Garcia Gomez	emp10551@empresa.com	3	3	5	21	2023-07-30	t	f
10552	Carlos Reyes Lopez	emp10552@empresa.com	2	1	1	127	2019-02-07	t	f
10553	Jorge Ramirez Chavez	emp10553@empresa.com	2	2	4	38	2023-07-26	t	f
10554	Raul Diaz Gonzalez	emp10554@empresa.com	2	17	51	89	2026-01-09	t	f
10555	Ricardo Ramirez Flores	emp10555@empresa.com	2	17	50	53	2019-03-24	t	f
10556	Adriana Sanchez Gonzalez	emp10556@empresa.com	3	15	43	15	2022-04-15	t	f
10557	Pedro Perez Ramirez	emp10557@empresa.com	3	14	39	86	2020-02-06	t	t
10558	Monica Gomez Torres	emp10558@empresa.com	3	1	2	109	2024-03-28	t	f
10559	Sofia Gutierrez Ortiz	emp10559@empresa.com	1	2	4	146	2020-09-14	t	f
10560	Isabel Diaz Gonzalez	emp10560@empresa.com	1	17	50	143	2018-10-06	t	f
10561	Adriana Gonzalez Rodriguez	emp10561@empresa.com	3	7	16	43	2025-09-07	t	f
10562	Pedro Torres Morales	emp10562@empresa.com	3	16	46	124	2020-03-16	t	f
10563	Carlos Garcia Perez	emp10563@empresa.com	2	4	9	76	2020-11-03	t	f
10564	Roberto Lopez Reyes	emp10564@empresa.com	1	14	39	122	2025-05-12	t	f
10565	Ana Flores Ortiz	emp10565@empresa.com	2	11	32	29	2022-10-25	t	f
10566	Miguel Rivera Ruiz	emp10566@empresa.com	3	7	18	133	2025-07-30	t	f
10567	Fernando Reyes Lopez	emp10567@empresa.com	1	15	42	105	2022-03-08	t	f
10568	Laura Garcia Sanchez	emp10568@empresa.com	3	18	55	108	2020-07-23	t	t
10569	Miguel Ortiz Martinez	emp10569@empresa.com	3	13	37	67	2025-12-12	t	f
10570	Elena Martinez Morales	emp10570@empresa.com	1	3	6	21	2025-07-29	t	f
10571	Luis Torres Chavez	emp10571@empresa.com	3	2	4	56	2023-07-19	t	f
10572	Miguel Rodriguez Ortiz	emp10572@empresa.com	1	10	26	100	2022-02-18	t	f
10573	Carmen Rivera Morales	emp10573@empresa.com	2	14	40	50	2020-01-16	t	f
10574	Gabriela Flores Ramos	emp10574@empresa.com	3	1	1	1	2018-12-26	t	f
10575	Luis Ramirez Cruz	emp10575@empresa.com	2	5	11	23	2023-09-04	t	f
10576	Ricardo Cruz Perez	emp10576@empresa.com	1	14	41	14	2022-10-09	t	f
10577	Carmen Ramirez Diaz	emp10577@empresa.com	2	7	16	79	2020-05-03	t	f
10578	Carmen Rivera Torres	emp10578@empresa.com	2	4	9	130	2025-08-27	t	f
10579	Jose Garcia Ruiz	emp10579@empresa.com	1	17	51	53	2026-01-19	t	f
10580	Maria Ramos Morales	emp10580@empresa.com	1	3	7	75	2022-12-14	t	f
10581	Elena Martinez Flores	emp10581@empresa.com	2	5	12	149	2025-10-27	t	f
10582	Patricia Ramos Martinez	emp10582@empresa.com	2	4	9	4	2022-08-09	t	f
10583	Hector Ruiz Gutierrez	emp10583@empresa.com	2	15	44	105	2025-09-04	t	f
10584	Elena Gonzalez Flores	emp10584@empresa.com	3	13	38	67	2022-01-31	t	f
10585	Ana Diaz Ortiz	emp10585@empresa.com	1	15	44	105	2023-09-05	t	f
10586	Roberto Diaz Torres	emp10586@empresa.com	3	12	33	138	2019-11-16	t	f
10587	Gabriela Flores Ramos	emp10587@empresa.com	3	14	39	140	2021-02-26	t	f
10588	Fernando Torres Morales	emp10588@empresa.com	1	5	12	149	2018-06-21	f	f
10589	Elena Sanchez Lopez	emp10589@empresa.com	1	4	10	112	2023-02-28	t	f
10590	Patricia Gomez Rodriguez	emp10590@empresa.com	3	5	12	95	2022-12-15	t	f
10591	Sofia Ruiz Morales	emp10591@empresa.com	3	8	20	98	2021-01-06	t	f
10592	Carmen Martinez Gutierrez	emp10592@empresa.com	3	17	50	89	2019-01-24	t	f
10593	Sofia Morales Reyes	emp10593@empresa.com	3	16	49	70	2020-03-06	t	f
10594	Luis Diaz Chavez	emp10594@empresa.com	3	4	9	58	2022-03-04	t	f
10595	Carmen Garcia Cruz	emp10595@empresa.com	1	13	36	139	2022-08-31	t	f
10596	Laura Ruiz Perez	emp10596@empresa.com	1	3	8	57	2021-12-13	t	f
10597	Ana Lopez Rivera	emp10597@empresa.com	3	8	19	80	2022-05-14	t	f
10598	Luis Lopez Gutierrez	emp10598@empresa.com	2	12	33	12	2020-07-07	t	f
10599	Jorge Flores Gomez	emp10599@empresa.com	2	5	12	149	2021-12-12	t	f
\.


--
-- Data for Name: metricas_productividad; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.metricas_productividad (proceso, tiempo_antes_min, tiempo_despues_min) FROM stdin;
Elaborar Descripcion de Puesto	240	45
Autorizar Descripcion de Puesto	2880	180
Realizar Diagnostico de Necesidades	180	30
Generar Plan Maestro de Entrenamiento	1440	120
Programar Curso	90	15
Consultar evidencia para auditoria	60	3
Firmar documentos (flujo completo)	4320	240
\.


--
-- Data for Name: plan_maestro; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.plan_maestro (id_plan_maestro, id_departamento, anio_fiscal, fecha, revision, firma_mnj_depto, firma_mnj_entto, firma_gerente) FROM stdin;
1	1	2024	2024-01-14	0	t	t	t
2	1	2025	2025-01-18	3	t	t	t
3	1	2026	2026-01-23	2	t	t	f
4	2	2024	2024-01-22	0	t	t	t
5	2	2025	2025-01-26	2	t	t	t
6	2	2026	2026-01-26	3	t	t	t
7	3	2024	2024-01-12	0	t	t	t
8	3	2025	2025-01-07	0	t	t	t
9	3	2026	2026-01-13	3	t	f	t
10	4	2024	2024-01-27	2	t	t	t
11	4	2025	2025-01-18	1	t	t	t
12	4	2026	2026-01-18	0	f	f	f
13	5	2024	2024-01-18	0	t	t	t
14	5	2025	2025-01-23	0	t	t	t
15	5	2026	2026-01-11	2	f	t	t
16	6	2024	2024-01-07	3	t	t	t
17	6	2025	2025-01-10	1	t	t	t
18	6	2026	2026-01-22	1	t	t	t
19	7	2024	2024-01-25	2	t	t	t
20	7	2025	2025-01-17	3	t	t	t
21	7	2026	2026-01-15	2	t	f	f
22	8	2024	2024-01-21	3	t	t	t
23	8	2025	2025-01-22	2	t	t	t
24	8	2026	2026-01-07	3	t	f	t
25	9	2024	2024-01-22	2	t	t	t
26	9	2025	2025-01-21	2	t	t	t
27	9	2026	2026-01-22	1	f	f	f
28	10	2024	2024-01-09	2	t	t	t
29	10	2025	2025-01-08	3	t	t	t
30	10	2026	2026-01-19	1	t	t	f
31	11	2024	2024-01-13	1	t	t	t
32	11	2025	2025-01-26	0	t	t	t
33	11	2026	2026-01-24	0	t	f	t
34	12	2024	2024-01-20	2	t	t	t
35	12	2025	2025-01-10	3	t	t	t
36	12	2026	2026-01-06	1	t	f	t
37	13	2024	2024-01-17	2	t	t	t
38	13	2025	2025-01-14	3	t	t	t
39	13	2026	2026-01-22	2	t	f	t
40	14	2024	2024-01-05	2	t	t	t
41	14	2025	2025-01-05	3	t	t	t
42	14	2026	2026-01-23	3	f	t	t
43	15	2024	2024-01-15	1	t	t	t
44	15	2025	2025-01-21	0	t	t	t
45	15	2026	2026-01-21	1	t	t	f
46	16	2024	2024-01-13	3	t	t	t
47	16	2025	2025-01-08	0	t	t	t
48	16	2026	2026-01-19	3	t	t	t
49	17	2024	2024-01-09	0	t	t	t
50	17	2025	2025-01-13	3	t	t	t
51	17	2026	2026-01-28	3	f	t	f
52	18	2024	2024-01-25	0	t	t	t
53	18	2025	2025-01-09	2	t	t	t
54	18	2026	2026-01-25	0	t	t	t
\.


--
-- Data for Name: plantas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.plantas (clave_planta, planta, ubicacion) FROM stdin;
1	Planta Norte - Monterrey	Nuevo Leon
2	Planta Bajio - Queretaro	Queretaro
3	Planta Centro - Toluca	Estado de Mexico
\.


--
-- Data for Name: puestos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.puestos (clave_puesto, puesto, clasificacion, id_departamento) FROM stdin;
1	Operador de Produccion	Supervision	1
2	Inspector de Calidad	Tecnico	2
3	Ingeniero de Procesos	Operativo	3
4	Tecnico de Mantenimiento	Supervision	4
5	Auxiliar de Logistica	Supervision	5
6	Analista de RH	Gerencial	6
7	Supervisor de Linea	Administrativo	7
8	Comprador	Gerencial	8
9	Almacenista	Supervision	9
10	Planeador	Administrativo	10
11	Metrologo	Gerencial	11
12	Diseñador de Herramentales	Gerencial	12
13	Operador de Inyeccion	Supervision	13
14	Ensamblador	Supervision	14
15	Pintor Industrial	Supervision	15
16	Analista de Sistemas	Tecnico	16
17	Contador	Administrativo	17
18	Coordinador de Entrenamiento	Administrativo	18
19	Lider de Celula	Operativo	1
20	Auditor Interno	Operativo	2
21	Operador de Produccion Tecnico N1	Tecnico	3
22	Inspector de Calidad Gerencial N1	Gerencial	4
23	Ingeniero de Procesos Supervision N1	Supervision	5
24	Tecnico de Mantenimiento Gerencial N1	Gerencial	6
25	Auxiliar de Logistica Supervision N1	Supervision	7
26	Analista de RH Administrativo N1	Administrativo	8
27	Supervisor de Linea Tecnico N1	Tecnico	9
28	Comprador Administrativo N1	Administrativo	10
29	Almacenista Supervision N1	Supervision	11
30	Planeador Supervision N1	Supervision	12
31	Metrologo Gerencial N1	Gerencial	13
32	Diseñador de Herramentales Supervision N1	Supervision	14
33	Operador de Inyeccion Supervision N1	Supervision	15
34	Ensamblador Gerencial N1	Gerencial	16
35	Pintor Industrial Operativo N1	Operativo	17
36	Analista de Sistemas Administrativo N1	Administrativo	18
37	Contador Administrativo N1	Administrativo	1
38	Coordinador de Entrenamiento Supervision N1	Supervision	2
39	Lider de Celula Operativo N1	Operativo	3
40	Auditor Interno Supervision N1	Supervision	4
41	Operador de Produccion Gerencial N2	Gerencial	5
42	Inspector de Calidad Administrativo N2	Administrativo	6
43	Ingeniero de Procesos Supervision N2	Supervision	7
44	Tecnico de Mantenimiento Tecnico N2	Tecnico	8
45	Auxiliar de Logistica Supervision N2	Supervision	9
46	Analista de RH Supervision N2	Supervision	10
47	Supervisor de Linea Operativo N2	Operativo	11
48	Comprador Administrativo N2	Administrativo	12
49	Almacenista Supervision N2	Supervision	13
50	Planeador Administrativo N2	Administrativo	14
51	Metrologo Operativo N2	Operativo	15
52	Diseñador de Herramentales Tecnico N2	Tecnico	16
53	Operador de Inyeccion Supervision N2	Supervision	17
54	Ensamblador Tecnico N2	Tecnico	18
55	Pintor Industrial Supervision N2	Supervision	1
56	Analista de Sistemas Operativo N2	Operativo	2
57	Contador Operativo N2	Operativo	3
58	Coordinador de Entrenamiento Operativo N2	Operativo	4
59	Lider de Celula Supervision N2	Supervision	5
60	Auditor Interno Gerencial N2	Gerencial	6
61	Operador de Produccion Gerencial N3	Gerencial	7
62	Inspector de Calidad Operativo N3	Operativo	8
63	Ingeniero de Procesos Gerencial N3	Gerencial	9
64	Tecnico de Mantenimiento Tecnico N3	Tecnico	10
65	Auxiliar de Logistica Tecnico N3	Tecnico	11
66	Analista de RH Operativo N3	Operativo	12
67	Supervisor de Linea Gerencial N3	Gerencial	13
68	Comprador Operativo N3	Operativo	14
69	Almacenista Gerencial N3	Gerencial	15
70	Planeador Administrativo N3	Administrativo	16
71	Metrologo Administrativo N3	Administrativo	17
72	Diseñador de Herramentales Tecnico N3	Tecnico	18
73	Operador de Inyeccion Operativo N3	Operativo	1
74	Ensamblador Administrativo N3	Administrativo	2
75	Pintor Industrial Gerencial N3	Gerencial	3
76	Analista de Sistemas Gerencial N3	Gerencial	4
77	Contador Supervision N3	Supervision	5
78	Coordinador de Entrenamiento Tecnico N3	Tecnico	6
79	Lider de Celula Gerencial N3	Gerencial	7
80	Auditor Interno Tecnico N3	Tecnico	8
81	Operador de Produccion Supervision N4	Supervision	9
82	Inspector de Calidad Gerencial N4	Gerencial	10
83	Ingeniero de Procesos Tecnico N4	Tecnico	11
84	Tecnico de Mantenimiento Gerencial N4	Gerencial	12
85	Auxiliar de Logistica Gerencial N4	Gerencial	13
86	Analista de RH Administrativo N4	Administrativo	14
87	Supervisor de Linea Operativo N4	Operativo	15
88	Comprador Supervision N4	Supervision	16
89	Almacenista Tecnico N4	Tecnico	17
90	Planeador Tecnico N4	Tecnico	18
91	Metrologo Gerencial N4	Gerencial	1
92	Diseñador de Herramentales Administrativo N4	Administrativo	2
93	Operador de Inyeccion Gerencial N4	Gerencial	3
94	Ensamblador Supervision N4	Supervision	4
95	Pintor Industrial Supervision N4	Supervision	5
96	Analista de Sistemas Tecnico N4	Tecnico	6
97	Contador Gerencial N4	Gerencial	7
98	Coordinador de Entrenamiento Tecnico N4	Tecnico	8
99	Lider de Celula Supervision N4	Supervision	9
100	Auditor Interno Operativo N4	Operativo	10
101	Operador de Produccion Operativo N5	Operativo	11
102	Inspector de Calidad Supervision N5	Supervision	12
103	Ingeniero de Procesos Operativo N5	Operativo	13
104	Tecnico de Mantenimiento Operativo N5	Operativo	14
105	Auxiliar de Logistica Administrativo N5	Administrativo	15
106	Analista de RH Administrativo N5	Administrativo	16
107	Supervisor de Linea Operativo N5	Operativo	17
108	Comprador Operativo N5	Operativo	18
109	Almacenista Gerencial N5	Gerencial	1
110	Planeador Supervision N5	Supervision	2
111	Metrologo Administrativo N5	Administrativo	3
112	Diseñador de Herramentales Administrativo N5	Administrativo	4
113	Operador de Inyeccion Supervision N5	Supervision	5
114	Ensamblador Administrativo N5	Administrativo	6
115	Pintor Industrial Operativo N5	Operativo	7
116	Analista de Sistemas Supervision N5	Supervision	8
117	Contador Supervision N5	Supervision	9
118	Coordinador de Entrenamiento Gerencial N5	Gerencial	10
119	Lider de Celula Gerencial N5	Gerencial	11
120	Auditor Interno Tecnico N5	Tecnico	12
121	Operador de Produccion Tecnico N6	Tecnico	13
122	Inspector de Calidad Gerencial N6	Gerencial	14
123	Ingeniero de Procesos Gerencial N6	Gerencial	15
124	Tecnico de Mantenimiento Tecnico N6	Tecnico	16
125	Auxiliar de Logistica Supervision N6	Supervision	17
126	Analista de RH Gerencial N6	Gerencial	18
127	Supervisor de Linea Administrativo N6	Administrativo	1
128	Comprador Supervision N6	Supervision	2
129	Almacenista Gerencial N6	Gerencial	3
130	Planeador Tecnico N6	Tecnico	4
131	Metrologo Operativo N6	Operativo	5
132	Diseñador de Herramentales Gerencial N6	Gerencial	6
133	Operador de Inyeccion Supervision N6	Supervision	7
134	Ensamblador Operativo N6	Operativo	8
135	Pintor Industrial Tecnico N6	Tecnico	9
136	Analista de Sistemas Tecnico N6	Tecnico	10
137	Contador Operativo N6	Operativo	11
138	Coordinador de Entrenamiento Gerencial N6	Gerencial	12
139	Lider de Celula Operativo N6	Operativo	13
140	Auditor Interno Supervision N6	Supervision	14
141	Operador de Produccion Tecnico N7	Tecnico	15
142	Inspector de Calidad Supervision N7	Supervision	16
143	Ingeniero de Procesos Operativo N7	Operativo	17
144	Tecnico de Mantenimiento Tecnico N7	Tecnico	18
145	Auxiliar de Logistica Gerencial N7	Gerencial	1
146	Analista de RH Tecnico N7	Tecnico	2
147	Supervisor de Linea Gerencial N7	Gerencial	3
148	Comprador Tecnico N7	Tecnico	4
149	Almacenista Tecnico N7	Tecnico	5
150	Planeador Tecnico N7	Tecnico	6
\.


--
-- Name: cursos_participantes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cursos_participantes_id_seq', 1479, true);


--
-- Name: accesos_diarios accesos_diarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accesos_diarios
    ADD CONSTRAINT accesos_diarios_pkey PRIMARY KEY (fecha);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (clave_area);


--
-- Name: competencias_puesto competencias_puesto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competencias_puesto
    ADD CONSTRAINT competencias_puesto_pkey PRIMARY KEY (id_competencia);


--
-- Name: cursos_participantes cursos_participantes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos_participantes
    ADD CONSTRAINT cursos_participantes_pkey PRIMARY KEY (id);


--
-- Name: cursos cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_pkey PRIMARY KEY (id_curso);


--
-- Name: cursos_programados cursos_programados_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos_programados
    ADD CONSTRAINT cursos_programados_pkey PRIMARY KEY (id_curso_programado);


--
-- Name: departamentos departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id_departamento);


--
-- Name: descripciones_puesto descripciones_puesto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descripciones_puesto
    ADD CONSTRAINT descripciones_puesto_pkey PRIMARY KEY (id_descripcion_puesto);


--
-- Name: diagnosticos diagnosticos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnosticos
    ADD CONSTRAINT diagnosticos_pkey PRIMARY KEY (id_diagnostico);


--
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (no_reloj);


--
-- Name: metricas_productividad metricas_productividad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metricas_productividad
    ADD CONSTRAINT metricas_productividad_pkey PRIMARY KEY (proceso);


--
-- Name: plan_maestro plan_maestro_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plan_maestro
    ADD CONSTRAINT plan_maestro_pkey PRIMARY KEY (id_plan_maestro);


--
-- Name: plantas plantas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantas
    ADD CONSTRAINT plantas_pkey PRIMARY KEY (clave_planta);


--
-- Name: puestos puestos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.puestos
    ADD CONSTRAINT puestos_pkey PRIMARY KEY (clave_puesto);


--
-- Name: areas areas_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);


--
-- Name: competencias_puesto competencias_puesto_id_descripcion_puesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competencias_puesto
    ADD CONSTRAINT competencias_puesto_id_descripcion_puesto_fkey FOREIGN KEY (id_descripcion_puesto) REFERENCES public.descripciones_puesto(id_descripcion_puesto);


--
-- Name: cursos cursos_id_competencia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_id_competencia_fkey FOREIGN KEY (id_competencia) REFERENCES public.competencias_puesto(id_competencia);


--
-- Name: cursos_participantes cursos_participantes_id_curso_programado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos_participantes
    ADD CONSTRAINT cursos_participantes_id_curso_programado_fkey FOREIGN KEY (id_curso_programado) REFERENCES public.cursos_programados(id_curso_programado);


--
-- Name: cursos_participantes cursos_participantes_no_reloj_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos_participantes
    ADD CONSTRAINT cursos_participantes_no_reloj_fkey FOREIGN KEY (no_reloj) REFERENCES public.empleados(no_reloj);


--
-- Name: cursos_programados cursos_programados_id_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos_programados
    ADD CONSTRAINT cursos_programados_id_curso_fkey FOREIGN KEY (id_curso) REFERENCES public.cursos(id_curso);


--
-- Name: cursos_programados cursos_programados_id_plan_maestro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos_programados
    ADD CONSTRAINT cursos_programados_id_plan_maestro_fkey FOREIGN KEY (id_plan_maestro) REFERENCES public.plan_maestro(id_plan_maestro);


--
-- Name: descripciones_puesto descripciones_puesto_clave_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descripciones_puesto
    ADD CONSTRAINT descripciones_puesto_clave_area_fkey FOREIGN KEY (clave_area) REFERENCES public.areas(clave_area);


--
-- Name: descripciones_puesto descripciones_puesto_clave_planta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descripciones_puesto
    ADD CONSTRAINT descripciones_puesto_clave_planta_fkey FOREIGN KEY (clave_planta) REFERENCES public.plantas(clave_planta);


--
-- Name: descripciones_puesto descripciones_puesto_clave_puesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descripciones_puesto
    ADD CONSTRAINT descripciones_puesto_clave_puesto_fkey FOREIGN KEY (clave_puesto) REFERENCES public.puestos(clave_puesto);


--
-- Name: descripciones_puesto descripciones_puesto_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descripciones_puesto
    ADD CONSTRAINT descripciones_puesto_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);


--
-- Name: diagnosticos diagnosticos_id_competencia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnosticos
    ADD CONSTRAINT diagnosticos_id_competencia_fkey FOREIGN KEY (id_competencia) REFERENCES public.competencias_puesto(id_competencia);


--
-- Name: diagnosticos diagnosticos_id_descripcion_puesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnosticos
    ADD CONSTRAINT diagnosticos_id_descripcion_puesto_fkey FOREIGN KEY (id_descripcion_puesto) REFERENCES public.descripciones_puesto(id_descripcion_puesto);


--
-- Name: diagnosticos diagnosticos_no_reloj_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnosticos
    ADD CONSTRAINT diagnosticos_no_reloj_fkey FOREIGN KEY (no_reloj) REFERENCES public.empleados(no_reloj);


--
-- Name: empleados empleados_clave_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_clave_area_fkey FOREIGN KEY (clave_area) REFERENCES public.areas(clave_area);


--
-- Name: empleados empleados_clave_planta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_clave_planta_fkey FOREIGN KEY (clave_planta) REFERENCES public.plantas(clave_planta);


--
-- Name: empleados empleados_clave_puesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_clave_puesto_fkey FOREIGN KEY (clave_puesto) REFERENCES public.puestos(clave_puesto);


--
-- Name: empleados empleados_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);


--
-- Name: plan_maestro plan_maestro_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plan_maestro
    ADD CONSTRAINT plan_maestro_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);


--
-- Name: puestos puestos_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.puestos
    ADD CONSTRAINT puestos_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);


--
-- PostgreSQL database dump complete
--

\unrestrict x6dvnTSBu5ansMvB7pbrRZ0cGSe9U3bH6cPXk2oLnIrQe4NZ9x39fB7F5WfobYn

