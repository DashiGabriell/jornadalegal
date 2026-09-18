-- Tabela de respostas do diagnóstico de jornada (DashiTecnology)
-- Projeto Supabase: gdcaxslhskxzcrbejxxo

create table if not exists public.diagnostico_jornada (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  empresa text not null,
  nome text not null,
  cargo text not null,
  controle text,
  auditor text,
  cruzamento text,
  divergencia text,
  banco text,
  cct_quem text,
  reclamacao text,
  maior_dor text,
  respostas jsonb not null default '{}'::jsonb,
  finished_at timestamptz,
  user_agent text,
  origem text default 'diagnostico-jornada'
);

alter table public.diagnostico_jornada enable row level security;

drop policy if exists service_role_full_access_diagnostico_jornada on public.diagnostico_jornada;
create policy service_role_full_access_diagnostico_jornada
  on public.diagnostico_jornada
  for all
  to service_role
  using (true)
  with check (true);

grant all on table public.diagnostico_jornada to service_role;
grant select, update on table public.diagnostico_jornada to authenticated;

alter table public.diagnostico_jornada add column if not exists status text not null default 'novo';
alter table public.diagnostico_jornada add column if not exists notas text;
alter table public.diagnostico_jornada add column if not exists updated_at timestamptz not null default now();

drop policy if exists authenticated_select_diagnostico_jornada on public.diagnostico_jornada;
create policy authenticated_select_diagnostico_jornada
  on public.diagnostico_jornada for select to authenticated using (true);

drop policy if exists authenticated_update_diagnostico_jornada on public.diagnostico_jornada;
create policy authenticated_update_diagnostico_jornada
  on public.diagnostico_jornada for update to authenticated using (true) with check (true);
