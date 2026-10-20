-- Ejecutar en Supabase > SQL Editor DESPUÉS de crear las dos cuentas de usuario.
-- SUSTITUIR los dos correos por los de vuestra pareja antes de ejecutar.
-- No habilitar registros públicos en Authentication > Providers > Email.

create table if not exists public.allowed_couple_users (
  email text primary key,
  created_at timestamptz not null default now()
);

insert into public.allowed_couple_users(email) values
  ('sonrisadepuma@gmail.com'),
  ('albmart15@gmail.com')
on conflict (email) do nothing;

create table if not exists public.couple_state (
  id integer primary key check (id = 1),
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
insert into public.couple_state (id, data) values (1, '{}'::jsonb) on conflict (id) do nothing;

alter table public.allowed_couple_users enable row level security;
alter table public.couple_state enable row level security;

-- El navegador NO puede leer ni editar la lista de cuentas admitidas.
revoke all on public.allowed_couple_users from anon, authenticated;
revoke all on public.couple_state from anon;
grant select, update on public.couple_state to authenticated;

-- Requiere sesión y correo verificado, incluido en lista de acceso.
create or replace function public.is_parejapp_member()
returns boolean language sql stable security definer
set search_path = ''
as $$
 select exists (
   select 1 from public.allowed_couple_users a
   join auth.users u on u.id = auth.uid()
   where lower(a.email)=lower(u.email)
     and u.email_confirmed_at is not null
 );
$$;
revoke all on function public.is_parejapp_member() from public, anon;
grant execute on function public.is_parejapp_member() to authenticated;

drop policy if exists pareja_read on public.couple_state;
drop policy if exists pareja_update on public.couple_state;
create policy pareja_read on public.couple_state for select to authenticated using (public.is_parejapp_member());
create policy pareja_update on public.couple_state for update to authenticated
 using (public.is_parejapp_member()) with check (public.is_parejapp_member());

-- Activar realtime para sincronizar en dos móviles (se puede activar también en Dashboard).
do $$ begin
  alter publication supabase_realtime add table public.couple_state;
exception when duplicate_object then null;
end $$;
