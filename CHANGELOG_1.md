# Changelog – n8n-Workflow „Prüfanfrage → Prüfumfang → Angebotsentwurf“

Alle wichtigen Änderungen am Workflow, neueste Version oben.

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
