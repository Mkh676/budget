-- Archive of imported bank CSV files (applied to the Supabase project on 2026-09-28).
-- Only members of a household can see, add or delete its files.
create table public.household_imports (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references public.households(id) on delete cascade,
  month_id text,
  file_name text not null,
  content text not null,
  imported_count int not null default 0,
  skipped_count int not null default 0,
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now()
);
create index household_imports_household_idx on public.household_imports (household_id, created_at desc);
alter table public.household_imports enable row level security;
create policy "members can view their imports" on public.household_imports for select
  using (household_id in (select household_id from public.household_members where user_id = auth.uid()));
create policy "members can add imports" on public.household_imports for insert
  with check (household_id in (select household_id from public.household_members where user_id = auth.uid()));
create policy "members can delete their imports" on public.household_imports for delete
  using (household_id in (select household_id from public.household_members where user_id = auth.uid()));
