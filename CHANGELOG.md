# Changelog – n8n-Workflow „Prüfanfrage → Prüfumfang → Angebotsentwurf“

Alle wichtigen Änderungen am Workflow, neueste Version oben.

## v1.0 – 2026-10-09 – Abgabeversion
Dateien: `angebot-workflow_v1.0.json`, `sub-speichern-melden_v2.json`, `error-alert_v2.json`

**Stand**
- Alle MUSS- und Bonuskriterien erfüllt
- 12 von 12 Tests bestanden, 7 Befunde gefunden und behoben
- Doku aktualisiert: Architektur-Diagramm, API-Übersicht, Fehlerbehandlung, Einschränkungen

**Performance-Vergleich (gleiche Bedingungen, je 3 Läufe)**
- gpt-4o: 3,8 s und 0,0050 USD pro Angebot
- gpt-4o-mini: 5,5 s und 0,00030 USD pro Angebot
- Gleiche Angebotssummen → bewusst gpt-4o-mini (rund 17-mal günstiger)

**Kosten (Auswertung aus Supabase)**
- 1.000 Angebote kosten rund 0,36 USD KI-Gebühren

## v0.4 – 2026-10-08 – Logging und Sticky Notes
In n8n veröffentlicht als „v0.4 – Logging und Sticky Notes“

**Neu**
- Log-Punkt nach der KI-Extraktion: INFO bei gültiger Antwort, sonst WARN
- Log-Punkt am Abschluss im Sub-Workflow: INFO mit Status und Laufzeit, WARN bei fehlgeschlagener Mail
- Hauptworkflow mit Sticky Notes in 6 Funktionsblöcke gegliedert
- Kostenauswertung per SQL-Abfrage in Supabase

## v0.3 – 2026-10-07 – Sub-Workflow, Error-Workflow, Tests
Dateien: `angebot-workflow_v0.3.json`, `sub-speichern-melden_v1.json`, `error-alert_v1.json`

**Neu**
- Sub-Workflow „Speichern & Melden“: alle 5 Enden des Hauptworkflows laufen hier zusammen, Supabase-Eintrag und passende Mail je Status
- Error-Workflow mit Fehlerart-Erkennung, ERROR-Log und Alert-Mail
- Mail-Node mit „Continue On Fail“, damit ein Mailfehler das Speichern nicht verhindert
- Tabellenname im Katalog-Node fest eingetragen

**Behoben**
- Erfundener Wunschtermin → Prompt-Regel verschärft (T02)
- Unspezifischer Alert-Hinweis bei Verbindungsfehlern → Fehlererkennung erweitert (T11)
- Falscher Header-Name in der OpenRouter-Credential

**Getestet**
- Alle 12 Testfälle durchgeführt und dokumentiert

## v0.2 – 2026-10-06 – Happy Path komplett
Datei: `angebot-workflow_v0.2.json`

**Neu**
- Statusweiche (Switch): verteilt nach „In Bearbeitung“, „Rückfrage“, „Aussortiert“
- Katalogabfrage in Supabase mit Filter auf Produktkategorie und Zielmärkte
- Preisberechnung im Code-Node (Prüfstunden × Stundensatz + Pauschalen)
- Verzweigung „Katalogtreffer?“
- Angebotstext per LLM (OpenRouter), Request wird in eigenem Code-Node gebaut
- Zusammenführung von Angebot, Tokens, Kosten und Laufzeit
- Speichern der Anfrage in der Supabase-Tabelle `anfragen`
- Benachrichtigungsmail mit Angebotsentwurf an den Vertrieb (Resend)

**Behoben**
- LLM meldete die Kategorie „Sonstiges“ als fehlende Angabe → Prompt-Regel und Absicherung im Code
- Fehlende Tabellenrechte in Supabase → `grant` für `service_role`
- Fehleranfälliger Ausdruck im HTTP-Body → Request in Code-Node „Angebot-Prompt bauen“ verlagert
- Listen wurden von Postgres abgelehnt → Umwandlung ins Array-Format `{"EU","USA"}`

**Getestet**
- T01 (Wallbox EU): Angebot 7.310 EUR, Mail erhalten
- T02 (HV-Batteriepack EU + Global): 14.670 EUR
- T06 (Standmixer): Kein Katalogtreffer
- Reserve 13 (Wallbox EU + USA): 13.460 EUR
- Laufzeit vom Formular bis zur Speicherung: ca. 6 Sekunden

## v0.1 – 2026-10-04 – Formular und KI-Extraktion
Datei: `angebot-workflow_v0.1.json`

**Neu**
- Eingangsformular (n8n Form Trigger)
- Datenvorbereitung inkl. Systemprompt
- LLM-Extraktion über OpenRouter (gpt-4o-mini, JSON-Modus)
- Schema-Prüfung und Statusbestimmung im Code-Node
- Verzweigung „JSON gültig?“

**Behoben**
- Wunschtermin mit falschem Jahr (2023) → heutiges Datum wird an das LLM übergeben

**Getestet**
- T01 (In Bearbeitung), T05 (Rückfrage), T07 (Aussortiert)
- Kosten pro Extraktion: ca. 0,00014 USD
