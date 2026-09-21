-- ============================================================
-- MiPortafolio — esquema de base de datos (Supabase / Postgres)
-- Ejecutar esto en: Supabase Dashboard > SQL Editor > New query
-- ============================================================

create extension if not exists "uuid-ossp";

create table if not exists public.archivo (
  id              uuid primary key default uuid_generate_v4(),
  unidad          smallint,                 -- 1..4, null para infografías
  semana          smallint,                 -- 1..16, null para infografías
  slot            smallint,                 -- 1..3, solo para infografías
  tipo            text not null check (tipo in ('trabajo', 'infografia')),
  nombre_original text not null,
  ruta_storage    text not null,            -- path dentro del bucket de Storage
  tamano_bytes    bigint not null default 0,
  subido_por      text,                     -- email de quien lo subió
  creado_en       timestamptz not null default now()
);

create index if not exists archivo_unidad_semana_idx on public.archivo (unidad, semana);
create index if not exists archivo_tipo_idx on public.archivo (tipo);

-- Row Level Security: la tabla la lee/escribe SIEMPRE el backend con la
-- service_role key (que se salta RLS), así que basta con dejar RLS activado
-- y sin políticas para bloquear el acceso directo desde el navegador con
-- la anon key.
alter table public.archivo enable row level security;

-- ============================================================
-- Storage
-- ============================================================
-- 1. Ve a Storage > Create bucket.
-- 2. Nombre: trabajos (o el que hayas puesto en supabase.storageBucket).
-- 3. Marca el bucket como privado (Public: OFF) — el backend genera URLs
--    firmadas temporales para las descargas, así que no hace falta que
--    sea público.

-- ============================================================
-- Usuario administrador
-- ============================================================
-- 1. Ve a Authentication > Users > Add user (crea tu propio usuario admin
--    con tu correo y una contraseña).
-- 2. Ábrelo y en "User Metadata" pon:  { "rol": "admin" }
-- 3. Cualquier otro usuario que crees sin ese metadata se trata como
--    "visitante" (puede ver y descargar, pero no subir ni eliminar).
