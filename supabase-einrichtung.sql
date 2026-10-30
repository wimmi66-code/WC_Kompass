-- WC-Kompass: Datenbank einrichten
-- In Supabase: links "SQL Editor" → "New query" → diesen gesamten Text einfügen → "Run"

create table if not exists public.places (
  id          text primary key check (char_length(id) <= 40),
  name        text not null check (char_length(name) between 2 and 80),
  lat         double precision not null check (lat between 47.2 and 55.1),
  lon         double precision not null check (lon between 5.8 and 15.1),
  created_at  timestamptz not null default now()
);

create table if not exists public.ratings (
  id          uuid primary key default gen_random_uuid(),
  place_id    text not null check (char_length(place_id) <= 40),
  sauberkeit  smallint not null check (sauberkeit between 1 and 5),
  zugang      smallint not null check (zugang between 1 and 5),
  gesamt      smallint not null check (gesamt between 1 and 5),
  merkmale    text[] not null default '{}' check (coalesce(array_length(merkmale, 1), 0) <= 12),
  kommentar   text check (char_length(kommentar) <= 300),
  autor       text check (char_length(autor) <= 30),
  created_at  timestamptz not null default now()
);
create index if not exists ratings_place_idx on public.ratings (place_id);

-- Zugriffsregeln: Jeder mit der App darf lesen und neu eintragen, aber nichts ändern oder löschen.
alter table public.places  enable row level security;
alter table public.ratings enable row level security;

drop policy if exists "alle lesen"   on public.places;
drop policy if exists "alle melden"  on public.places;
drop policy if exists "alle lesen"   on public.ratings;
drop policy if exists "alle bewerten" on public.ratings;

create policy "alle lesen"    on public.places  for select to anon using (true);
create policy "alle melden"   on public.places  for insert to anon with check (true);
create policy "alle lesen"    on public.ratings for select to anon using (true);
create policy "alle bewerten" on public.ratings for insert to anon with check (true);

grant usage on schema public to anon;
grant select, insert on public.places, public.ratings to anon;
