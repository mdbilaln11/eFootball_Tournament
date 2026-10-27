-- eFootball Tournament Hub: starter Supabase schema
-- Run this entire script in Supabase Dashboard > SQL Editor.
-- IMPORTANT: This starter intentionally allows public result editing for a small private tournament.
-- Anyone who knows the project URL and anon key can change match results. Do not use for sensitive data.

create extension if not exists pgcrypto;

create table if not exists public.matches (
  id uuid primary key default gen_random_uuid(),
  match_date date,
  player1 text not null check (player1 in ('Mishal','Sham','Sanay','Bilal','Najmu','Ali','Shiyas','Shafin','Nihal','Sabith','Anzil','Nafih')),
  player2 text not null check (player2 in ('Mishal','Sham','Sanay','Bilal','Najmu','Ali','Shiyas','Shafin','Nihal','Sabith','Anzil','Nafih')),
  score1 integer not null check (score1 between 0 and 99),
  score2 integer not null check (score2 between 0 and 99),
  note text not null default '',
  created_at timestamptz not null default now(),
  constraint different_players check (player1 <> player2)
);

alter table public.matches enable row level security;

drop policy if exists "Public can view tournament matches" on public.matches;
drop policy if exists "Public can add tournament matches" on public.matches;
drop policy if exists "Public can edit tournament matches" on public.matches;
drop policy if exists "Public can delete tournament matches" on public.matches;

create policy "Public can view tournament matches"
on public.matches for select to anon, authenticated using (true);

create policy "Public can add tournament matches"
on public.matches for insert to anon, authenticated with check (true);

create policy "Public can edit tournament matches"
on public.matches for update to anon, authenticated using (true) with check (true);

create policy "Public can delete tournament matches"
on public.matches for delete to anon, authenticated using (true);

-- Realtime subscription is used to refresh the standings on all connected browsers.
do $$
begin
  alter publication supabase_realtime add table public.matches;
exception when duplicate_object then
  null;
when others then
  -- If the table is already in the publication, this is harmless.
  null;
end $$;
