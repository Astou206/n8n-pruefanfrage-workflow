# Commit-Konventionen und Release-Ablauf

Dieses Repository nutzt [Conventional Commits](https://www.conventionalcommits.org/de/) und Release Please. Aus den Commit-Nachrichten entstehen automatisch die Versionsnummer und die Einträge in der `CHANGELOG.md`.

## Aufbau einer Commit-Nachricht

```
<typ>: <kurze Beschreibung auf Deutsch>
```

Der Typ bleibt englisch, weil die Automatik ihn daran erkennt. Die Beschreibung schreibst du auf Deutsch, sie erscheint genau so im Changelog.

| Typ | Wofür | Abschnitt im Changelog | Version |
| --- | --- | --- | --- |
| `feat` | neue Funktion | Neue Funktionen | MINOR (1.1.0 → 1.2.0) |
| `fix` | Fehlerbehebung | Fehlerbehebungen | PATCH (1.1.0 → 1.1.1) |
| `perf` | schneller oder günstiger | Performance | PATCH |
| `refactor`, `build`, `ci` | Umbau ohne neue Funktion, Workflow-Technik | Technische Änderungen | PATCH |
| `docs` | Dokumentation, README | Dokumentation | PATCH |
| `test` | Testfälle, Testdaten | Tests | PATCH |
| `revert` | Änderung zurücknehmen | Rücknahmen | PATCH |
| `chore` | Aufräumen, Kleinkram | erscheint nicht | kein Release |

**Breaking Change:** Ein Ausrufezeichen nach dem Typ, zum Beispiel `feat!: Agent ersetzt den festen Workflow`. Das erhöht die Hauptversion (1.x → 2.0.0) und erscheint im Changelog unter der Überschrift „⚠ BREAKING CHANGES“. Diese Überschrift ist in Release Please fest auf Englisch vorgegeben.

## Beispiele aus diesem Projekt

```
feat: Tool angebot_speichern im Agenten ergänzt
fix: Gesamtpreis bei mehreren Märkten wird wieder angezeigt
docs: Setup-Anleitung für Google-Gemini-Embeddings ergänzt
test: Adversarial-Tests A2 bis A5 hinzugefügt
refactor: Preisberechnung in Sub-Workflow verlagert
chore: Alte Workflow-Exporte entfernt
```

## In der GitHub-Weboberfläche

Beim Hochladen oder Bearbeiten von Dateien steht unter „Commit changes“ ein Feld für die Nachricht. Ersetze den Vorschlag „Add files via upload“ durch eine Nachricht im Format oben. Wenn du einen Pull Request mit „Squash and merge“ zusammenführst, zählt der Titel des Pull Requests, also auch diesen im Format oben schreiben.

## Ablauf eines Releases

1. Du committest Änderungen mit passenden Nachrichten auf `main`.
2. Release Please öffnet oder aktualisiert einen Pull Request „chore(main): release x.y.z“ mit neuer Versionsnummer und den Changelog-Einträgen.
3. Du prüfst den Pull Request. Solange er offen ist, passiert nichts weiter.
4. Erst wenn du ihn mergst, entstehen der Versionstag (zum Beispiel `v1.2.0`) und der GitHub Release.

Bestehende Versionen bis v1.1 sind von Hand im Changelog dokumentiert und bleiben unverändert. Release Please setzt mit Version 1.1.0 an und fügt neue Einträge oberhalb davon ein.
