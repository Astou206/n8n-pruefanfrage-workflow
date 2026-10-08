-- Tag 1: Beispiel-Leistungskatalog fuer das n8n-Projekt
-- ACHTUNG: Synthetische Daten. Normzuordnungen, Pruefstunden und Preise
-- sind illustrativ und fachlich NICHT verbindlich.
-- Ausfuehren im Supabase SQL-Editor, NACH dem create-table-Skript aus dem Projektplan.

insert into leistungskatalog
  (produktkategorie, zielmarkt, pruefleistung, regelwerk, pruefstunden, stundensatz_eur, pauschale_eur)
values
  -- Ladestation (Wallbox)
  ('Ladestation', 'EU',     'Elektrische Sicherheit Ladesystem',        'IEC 61851-1',    24, 145, 350),
  ('Ladestation', 'EU',     'EMV-Pruefung Ladestation',                 'IEC 61851-21-2', 16, 145, 0),
  ('Ladestation', 'EU',     'Pruefung technische Dokumentation CE',     'Niederspannungsrichtlinie', 8, 145, 0),
  ('Ladestation', 'USA',    'Sicherheit Ladeeinrichtung',               'UL 2594',        28, 145, 350),
  ('Ladestation', 'USA',    'Personenschutz Ladesystem',                'UL 2231',        12, 145, 0),
  -- HV-Batteriepack
  ('HV-Batteriepack', 'EU',     'Elektrische Sicherheit REESS',         'UN ECE R100',    40, 145, 500),
  ('HV-Batteriepack', 'EU',     'Zellpruefung Leistung und Zuverlaessigkeit', 'IEC 62660', 24, 145, 0),
  ('HV-Batteriepack', 'USA',    'Missbrauchspruefung Batteriesystem',   'SAE J2464',      30, 145, 500),
  ('HV-Batteriepack', 'Global', 'Transportpruefung Lithium-Batterien',  'UN 38.3',        32, 145, 250),
  -- E-Bike-Akku
  ('E-Bike-Akku', 'EU',     'Sicherheit Akku fuer Leichtfahrzeuge',     'EN 50604-1',     20, 145, 300),
  ('E-Bike-Akku', 'USA',    'Sicherheit Akku fuer Leichtfahrzeuge',     'UL 2271',        24, 145, 300),
  ('E-Bike-Akku', 'Global', 'Transportpruefung Lithium-Batterien',      'UN 38.3',        16, 145, 250),
  -- Onboard-Ladegeraet
  ('Onboard-Ladegeraet', 'EU',  'Elektrische Sicherheit Fahrzeug-HV',   'ISO 6469-3',     20, 145, 350),
  ('Onboard-Ladegeraet', 'EU',  'EMV-Pruefung Onboard-Ladegeraet',      'IEC 61851-21-1', 18, 145, 0),
  ('Onboard-Ladegeraet', 'USA', 'Sicherheit Ladesystem-Komponenten',    'UL 2202',        24, 145, 350);

-- Kontrolle: sollte 15 Zeilen liefern
select produktkategorie, zielmarkt, count(*) as leistungen, sum(pruefstunden) as stunden
from leistungskatalog
group by produktkategorie, zielmarkt
order by produktkategorie, zielmarkt;
