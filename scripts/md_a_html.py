#!/usr/bin/env python3
"""Convierte DOCUMENTACION_SEE.md en un HTML con estilo profesional listo para
exportar a PDF (Imprimir -> Guardar como PDF)."""
import markdown
from datetime import datetime

SRC = "/app/import_local/DOCUMENTACION_SEE.md"
OUT = "/app/import_local/DOCUMENTACION_SEE.html"

MESES = ["", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio",
         "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
hoy = datetime.now()
FECHA = f"{MESES[hoy.month].capitalize()} de {hoy.year}"

PORTADA_HTML = f"""
<section class="portada">
  <img class="portada-logo" src="assets/logo_itp.png" alt="Instituto Tecnologico de Pochutla">
  <div class="portada-inst">Instituto Tecnol&oacute;gico de Pochutla</div>
  <div class="portada-prog">Programa de Verano Cient&iacute;fico</div>
  <div class="portada-rule"></div>
  <div class="portada-titulo">Sistema de Entrenamiento Electr&oacute;nico (SEE)</div>
  <div class="portada-sub">Plataforma de Business Intelligence en Grafana para la gesti&oacute;n
  de la capacitaci&oacute;n industrial &mdash; alineada a IATF&nbsp;16949:2016 e ISO&nbsp;9001:2015</div>
  <div class="portada-rule"></div>
  <table class="portada-datos">
    <tr><td>Presenta</td><td>Jefte Abimael L&oacute;pez Jarqu&iacute;n</td></tr>
    <tr><td>Matr&iacute;cula</td><td>20161240</td></tr>
    <tr><td>Docente</td><td>Dra. Ruth de la Pe&ntilde;a Mart&iacute;nez</td></tr>
    <tr><td>Programa</td><td>Verano Cient&iacute;fico</td></tr>
    <tr><td>Fecha</td><td>{FECHA}</td></tr>
  </table>
</section>
"""

md_text = open(SRC, encoding="utf-8").read()
body = markdown.markdown(md_text, extensions=["tables", "fenced_code", "toc"])

html = """<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<title>Documentacion SEE - Sistema de Entrenamiento Electronico</title>
<style>
  :root { --azul:#0b3d6b; --azul2:#1565a7; --gris:#f4f6f9; --texto:#1f2733; }
  * { box-sizing: border-box; }
  body { font-family: -apple-system, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
         color: var(--texto); line-height: 1.6; max-width: 900px; margin: 0 auto;
         padding: 48px 40px; font-size: 15px; }
  h1 { color: var(--azul); font-size: 30px; border-bottom: 4px solid var(--azul);
       padding-bottom: 10px; margin-top: 8px; }
  h2 { color: var(--azul); font-size: 23px; border-bottom: 2px solid #d5dee8;
       padding-bottom: 6px; margin-top: 40px; page-break-after: avoid; }
  h3 { color: var(--azul2); font-size: 18px; margin-top: 28px; page-break-after: avoid; }
  p, li { text-align: justify; }
  table { border-collapse: collapse; width: 100%; margin: 16px 0; font-size: 13.5px;
          page-break-inside: avoid; }
  th { background: var(--azul); color: #fff; text-align: left; padding: 8px 10px; }
  td { border: 1px solid #d5dee8; padding: 7px 10px; vertical-align: top; }
  tr:nth-child(even) td { background: var(--gris); }
  code { background: #eef2f7; padding: 1px 5px; border-radius: 4px;
         font-family: "SF Mono", Menlo, Consolas, monospace; font-size: 12.5px; }
  pre { background: #0f2740; color: #e6edf3; padding: 14px 16px; border-radius: 8px;
        overflow-x: auto; page-break-inside: avoid; border-left: 4px solid var(--azul2); }
  pre code { background: none; color: #e6edf3; padding: 0; font-size: 12.5px; }
  blockquote { border-left: 4px solid var(--azul2); background: var(--gris);
               margin: 16px 0; padding: 8px 16px; color: #33475b; }
  hr { border: none; border-top: 1px solid #d5dee8; margin: 28px 0; }
  strong { color: #12324f; }
  .captura { border: 2px dashed var(--azul2); background: #eef4fb; border-radius: 10px;
             text-align: center; color: var(--azul); font-weight: 700; letter-spacing: .5px;
             padding: 46px 20px; margin: 18px 0; font-size: 15px; page-break-inside: avoid; }
  .captura span { display: block; margin-top: 8px; font-weight: 400; font-size: 13px;
                  color: #5b6b7d; letter-spacing: 0; }
  .figura { display: block; max-width: 92%; margin: 20px auto 6px; border: 1px solid #d5dee8;
            border-radius: 8px; padding: 6px; background: #fff; }
  .figpie { text-align: center; font-size: 12.5px; color: #5b6b7d; margin: 0 0 18px; font-style: italic; }
  .shot { max-width: 100%; border: 1px solid #26374a; border-radius: 8px; padding: 0;
          box-shadow: 0 4px 14px rgba(11,61,107,.18); background: #0f1720; }
  /* Portada */
  .portada { min-height: 92vh; display: flex; flex-direction: column; align-items: center;
             justify-content: center; text-align: center; page-break-after: always; }
  .portada-logo { width: 150px; height: auto; margin-bottom: 18px; }
  .portada-inst { font-size: 22px; font-weight: 700; color: var(--azul); letter-spacing: .5px; }
  .portada-prog { font-size: 15px; color: #5b6b7d; margin-top: 4px; }
  .portada-rule { width: 70%; border-top: 3px solid var(--azul2); margin: 30px 0; }
  .portada-titulo { font-size: 30px; font-weight: 800; color: #12324f; line-height: 1.25; padding: 0 20px; }
  .portada-sub { font-size: 15px; color: #33475b; max-width: 640px; margin: 14px auto 0; line-height: 1.55; }
  .portada-datos { border-collapse: collapse; margin: 8px auto 0; font-size: 15px; width: auto; }
  .portada-datos td { border: none; padding: 5px 14px; text-align: left; }
  .portada-datos td:first-child { color: #5b6b7d; font-weight: 700; text-align: right; }
  .portada-datos tr:nth-child(even) td { background: none; }
  /* Aviso de impresion (solo pantalla) */
  .aviso-pdf { background: #fff7e6; border: 1px solid #f0c98a; border-radius: 8px;
               padding: 12px 16px; margin: 0 0 24px; font-size: 13.5px; color: #7a5a1e; }
  @page { size: A4; margin: 18mm 16mm; }
  @media print {
    .aviso-pdf { display: none; }
    .portada { min-height: 0; height: 96vh; }
  }
  @media print {
    body { padding: 0; font-size: 12px; max-width: none; }
    h1 { font-size: 24px; } h2 { font-size: 18px; } h3 { font-size: 15px; }
    pre, table { font-size: 11px; }
    h2 { page-break-before: auto; }
  }
</style>
</head>
<body>
""" + PORTADA_HTML + """
<div class="aviso-pdf">
  <strong>Para exportar a PDF:</strong> abre este archivo en Chrome &rarr; men&uacute; Imprimir (Cmd+P)
  &rarr; Destino <em>Guardar como PDF</em>. Activa la casilla <em>&laquo;Encabezados y pies de p&aacute;gina&raquo;</em>
  para que se agregue autom&aacute;ticamente la numeraci&oacute;n de p&aacute;ginas. Este aviso no aparece en el PDF.
</div>
""" + body + "\n</body>\n</html>\n"

open(OUT, "w", encoding="utf-8").write(html)
print("HTML generado:", OUT)
print("Tamano:", round(len(html) / 1024, 1), "KB")
