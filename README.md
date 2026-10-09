# Prüfanfrage → Prüfumfang → Angebotsentwurf (n8n)

Ein n8n-Workflow, der unstrukturierte Prüfanfragen per KI in einen geprüften Prüfumfang und einen Angebotsentwurf verwandelt. Der Vertrieb muss statt 30–45 Minuten Handarbeit nur noch freigeben.

Abschlussprojekt der Weiterbildung „KI-Anwendungsexperte“ (Syntax Institut), Modul Automatisierung mit n8n.

## Ergebnisse

- Laufzeit vom Formular bis zur Mail: ca. 6 Sekunden
- KI-Kosten pro Anfrage: unter 0,1 Cent
- 12 von 12 Testfällen bestanden (3 Happy Path, 5 Edge Cases, 4 Fehlerszenarien)

## Aufbau

| Workflow | Aufgabe |
| --- | --- |
| `angebot-workflow` (Hauptworkflow) | Formular, KI-Extraktion, Schema-Prüfung, Statusweiche, Katalogabfrage, Preisberechnung, Angebotstext |
| `sub-speichern-melden` | Speichert jede Anfrage in Supabase und verschickt die passende Mail je Status |
| `error-alert` | Fängt Abstürze ab, schreibt einen Log-Eintrag und schickt eine Alert-Mail |

## Verwendete APIs

| API | Zweck | Authentifizierung |
| --- | --- | --- |
| OpenRouter | Datenextraktion und Angebotstext (gpt-4o-mini) | API-Key als Bearer-Token |
| Supabase | Leistungskatalog, Anfragen, Logs | Service-Role-Key |
| Resend | Benachrichtigungen und Fehler-Alerts | API-Key als Bearer-Token |

## Ordner

- `workflows/` – exportierte n8n-Workflows (versioniert)
- `sql/` – Tabellen anlegen und Beispiel-Leistungskatalog
- `tests/` – synthetische Testanfragen
- `CHANGELOG.md` – Änderungen je Version

## Einrichtung

1. In Supabase `sql/00_create_tables.sql` und danach `sql/01_seed_leistungskatalog.sql` ausführen.
2. Die drei Workflows in n8n importieren.
3. Credentials für OpenRouter, Supabase und Resend in n8n anlegen und in den Nodes auswählen.
4. Im Haupt- und Sub-Workflow unter Settings den Error-Workflow hinterlegen.

## Bekannte Einschränkungen

- Alle Daten sind synthetisch; Normzuordnungen und Preise im Katalog sind Beispiele und fachlich nicht verbindlich.
- Angebote sind unverbindliche Entwürfe und werden nie automatisch an Kunden versendet.
- Resend sendet im Testmodus nur an die registrierte Adresse.
- Für den Echtbetrieb wären Auftragsverarbeitungsvertrag, EU-Hosting und eine bewusste Auswahl der Modellanbieter nötig.
