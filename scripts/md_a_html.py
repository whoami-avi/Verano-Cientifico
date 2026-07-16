#!/usr/bin/env python3
"""Convierte DOCUMENTACION_SEE.md en un HTML con estilo profesional listo para
exportar a PDF (Imprimir -> Guardar como PDF)."""
import markdown

SRC = "/app/import_local/DOCUMENTACION_SEE.md"
OUT = "/app/import_local/DOCUMENTACION_SEE.html"

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
  @media print {
    body { padding: 0; font-size: 12px; max-width: none; }
    h1 { font-size: 24px; } h2 { font-size: 18px; } h3 { font-size: 15px; }
    pre, table { font-size: 11px; }
    h2 { page-break-before: auto; }
  }
</style>
</head>
<body>
""" + body + "\n</body>\n</html>\n"

open(OUT, "w", encoding="utf-8").write(html)
print("HTML generado:", OUT)
print("Tamano:", round(len(html) / 1024, 1), "KB")
