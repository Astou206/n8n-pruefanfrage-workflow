-- Schritt 1: Tabellen anlegen (im Supabase SQL Editor ausführen)
-- Danach 01_seed_leistungskatalog.sql ausführen.

create table leistungskatalog (
  id bigint generated always as identity primary key,
  produktkategorie text not null,
  zielmarkt text not null,
  pruefleistung text not null,
  regelwerk text,
  pruefstunden numeric not null,
  stundensatz_eur numeric not null,
  pauschale_eur numeric default 0
);
create index on leistungskatalog (produktkategorie, zielmarkt);

create table anfragen (
  id uuid primary key default gen_random_uuid(),
  eingang timestamptz default now(),
  firma text,
  ansprechpartner text,
  email text,
  produktkategorie text,
  zielmaerkte text[],
  status text not null,
  angebotssumme_eur numeric,
  fehlende_angaben text[],
  token_kosten_usd numeric,
  laufzeit_s numeric,
  rohtext text,
  angebotstext text
);

create table logs (
  id bigint generated always as identity primary key,
  zeitstempel timestamptz default now(),
  execution_id text,
  schritt text,
  level text check (level in ('INFO', 'WARN', 'ERROR')),
  nachricht text
);

-- Berechtigungen für den API-Zugriff aus n8n (service_role)
grant usage on schema public to service_role;
grant all on table leistungskatalog, anfragen, logs to service_role;
grant usage, select on all sequences in schema public to service_role;
