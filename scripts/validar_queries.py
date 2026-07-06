#!/usr/bin/env python3
import json, os, re, psycopg2
OUT = "/opt/grafana/conf/provisioning/dashboards/json"
conn = psycopg2.connect(host="127.0.0.1", dbname="see_db", user="see_user", password="see_pass_2026")
conn.autocommit = True
deptos = ",".join(str(i) for i in range(1, 19))

def sub(sql):
    sql = sql.replace("$planta", "1,2,3").replace("$departamento", deptos)
    sql = re.sub(r"\$__timeFilter\(([^)]+)\)", r"\1 IS NOT NULL", sql)
    return sql

total = ok = bad = 0
for f in sorted(os.listdir(OUT)):
    d = json.load(open(os.path.join(OUT, f)))
    for p in d.get("panels", []):
        for t in p.get("targets", []):
            sql = t.get("rawSql")
            if not sql:
                continue
            total += 1
            try:
                cur = conn.cursor()
                cur.execute(sub(sql))
                cur.fetchall()
                cur.close()
                ok += 1
            except Exception as e:
                bad += 1
                print(f"ERROR [{f}] panel '{p.get('title')}': {str(e).strip()[:120]}")
print(f"\nTotal consultas: {total} | OK: {ok} | FALLIDAS: {bad}")
