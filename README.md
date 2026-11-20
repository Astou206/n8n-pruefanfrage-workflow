# Prüfanfragen: vom n8n-Workflow zum KI-Agenten

In diesem Repository liegen meine beiden Projekte aus dem Kurs KI Automatisierung am Syntax Institut. Beide bearbeiten Prüfanfragen von Herstellern, zum Beispiel für Ladestationen, Batteriepacks, E-Bike-Akkus und Onboard-Ladegeräte. Am Ende steht jeweils ein Angebotsentwurf, den ein Mensch freigibt.

Die aktuelle Version und alle Änderungen stehen in den [Releases](https://github.com/Astou206/n8n-pruefanfrage-workflow/releases) und in der [CHANGELOG.md](CHANGELOG.md).

## Projekt 2: Prüfanfragen-Agent

Der Agent nimmt Prüfanfragen per Chat oder Mail an, sucht passende Prüfleistungen im Katalog, lässt den Preis ohne KI berechnen und legt einen Angebotsentwurf zur Freigabe vor.

Mein Leitprinzip dabei: Was zuverlässig sein muss, übernimmt der Workflow, nicht das Sprachmodell. Das Sprachmodell versteht die Anfrage und formuliert die Antwort. Preisrechnung, KI-Kennzeichnung und Fehlerbehandlung laufen als feste Schritte.

- **Eingang:** Chat in n8n oder Mail an ein eigenes Postfach (Email Trigger, IMAP). Beide Wege laufen über den Knoten „Eingang vereinheitlichen“.
- **Agent:** ein einzelner Agent mit drei Tools: `katalog_suche`, `angebot_berechnen` und `angebot_speichern`.
- **Absicherung:** „Antwort gültig?“ prüft jede Antwort. Fehlt die Statuszeile, landet die Anfrage in der manuellen Prüfung. Bei Ausfällen greift ein Fehlerzweig mit Logging und Mail an einen Mitarbeiter.
- **Freigabe:** Der Agent hat kein Tool, das an Kunden sendet. Bei Mail-Anfragen geht der Entwurf nur an einen Mitarbeiter.
- **Dienste:** n8n, OpenRouter (GPT-4.1 mini), Supabase, Resend, Gmail (IMAP).
- **Tests:** 24 Testfälle in 79 Läufen, davon 6 Adversarial-Tests, 2 Compliance-Tests und ein Multi-Turn-Test, jeweils bewertet nach Korrektheit, Relevanz, Vollständigkeit und Sicherheit.
- **Compliance:** nach meiner Einschätzung kein Hochrisiko-System. Im Chat gilt die Transparenzpflicht nach Artikel 50 des EU AI Act. Dreizehn Maßnahmen sind umgesetzt.

## Projekt 1: Prüfanfrage-Workflow

Projekt 1 ist der Vorgänger mit festen Schritten statt eines Agenten: Anfrage per Formular oder Mail, Extraktion der Angaben mit KI, Prüfumfang aus dem Katalog, Angebotsentwurf und Speicherung. Die Entwicklung von v0.1 bis v1.1 steht in der [CHANGELOG.md](CHANGELOG.md).

## Aufbau des Repositorys

| Datei oder Ordner | Inhalt |
| --- | --- |
| `Dokumentation Prüfanfragen-Agent (Projekt 2).pdf` | Dokumentation von Projekt 2: Architektur, Tools, Guardrails, Evaluation, Setup, bekannte Einschränkungen |
| `Compliance-Bewertung Prüfanfragen-Agent (Projekt 2).pdf` | Einstufung nach EU AI Act, Maßnahmen, Datenschutz-Einschätzung |
| `Architektur-Blueprint_Woche8.pdf` | Architektur-Entscheidung für Projekt 2 |
| `Projekt2_Testtabelle.xlsx` | Alle Testfälle und Testläufe von Projekt 2 mit Auswertung je Prompt-Version |
| `TESTPROTOKOLL.md` | Zusammenfassung aller Testfälle und Testläufe von Projekt 2 |
| `system_prompt_v1.md` bis `system_prompt_v3_6.md` | System Prompts von Projekt 2, jede Version mit Changelog |
| `Workflows/` | n8n-Exporte beider Projekte (siehe unten) |
| `SQL/` | Tabellen `leistungskatalog`, `anfragen` und `logs` anlegen und den Katalog füllen |
| `Tests/` | Testanfragen (`testanfragen.json`), Langtext für T08 und der Performance-Vergleich aus Projekt 1 |
| `CHANGELOG.md`, `version.txt` | Versionen und Änderungen, automatisch gepflegt |
| `COMMIT_KONVENTIONEN.md` | Regeln für Commit-Nachrichten und den Release-Ablauf |

### Workflows

| Datei | Name in n8n | Projekt |
| --- | --- | --- |
| `04_Agent_Pruefanfrage.json` | 04_Agent_Pruefanfrage | 2 (Agent) |
| `06_SUB_Angebot_berechnen.json` | 06_SUB_Angebot_berechnen | 2 (Preisrechnung ohne KI) |
| `error-alert_v2.json` | 03_ERROR_Alert | 1 und 2 (Error-Workflow) |
| `angebot-workflow_v1.1.json` | 01_Pruefanfrage_Hauptworkflow | 1 |
| `sub-speichern-melden_v2.json` | 02_SUB_Speichern_Melden | 1 |

Ältere Versionen (`_v0.1` bis `_v1.0`, `_v1`) bleiben zum Nachvollziehen im Ordner.

## Projekt 2 einrichten

Die ausführliche Anleitung steht in der Dokumentation. Kurz:

1. In Supabase `SQL/00_create_tables.sql` und danach `SQL/01_seed_leistungskatalog.sql` ausführen.
2. In n8n die Credentials für Supabase, OpenRouter, Resend und IMAP anlegen.
3. `06_SUB_Angebot_berechnen.json` importieren und veröffentlichen, dann `error-alert_v2.json` und `04_Agent_Pruefanfrage.json` importieren.
4. In `04_Agent_Pruefanfrage` den Error-Workflow `03_ERROR_Alert` eintragen und die Platzhalter-Adresse `ihre-adresse@example.com` durch die Adresse des Mitarbeiters ersetzen.

In den Exporten stehen keine Zugangsdaten, nur die Namen der Credentials.

## Versionierung

Das Repository nutzt Conventional Commits und Release Please. Aus Nachrichten wie `feat:`, `fix:` oder `docs:` entstehen automatisch Versionsnummer und Changelog. Details stehen in der [COMMIT_KONVENTIONEN.md](COMMIT_KONVENTIONEN.md).

## Hinweis

Das ist ein Kursprojekt. Firmen, Personen und Adressen in den Testdaten sind erfunden. Die Compliance-Bewertung ist meine Einschätzung und keine Rechtsberatung.
