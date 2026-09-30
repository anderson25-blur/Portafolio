-- ============================================================
-- MiPortafolio — esquema de base de datos
-- Supabase / PostgreSQL
-- ============================================================
--
-- Estructura:
--   4 unidades
--   16 semanas
--   Trabajos en PDF
--   Infografías en JPG/JPEG/PNG
--   Hasta 7 infografías por semana
--
-- Ejecutar en:
-- Supabase Dashboard > SQL Editor > New query
-- ============================================================


-- ============================================================
-- EXTENSIONES
-- ============================================================

create extension if not exists "uuid-ossp";


-- ============================================================
-- TABLA: ARCHIVO
-- ============================================================

create table if not exists public.archivo (

  -- Identificador único del archivo
  id uuid primary key default uuid_generate_v4(),

  -- Unidad académica:
  -- 1, 2, 3 o 4
  unidad smallint
    check (unidad between 1 and 4),

  -- Semana global:
  -- 1 hasta 16
  semana smallint
    check (semana between 1 and 16),

  -- Número de infografía:
  -- 1 hasta 7 para infografías.
  -- Debe ser NULL para trabajos.
  slot smallint,

  -- Tipo de archivo
  tipo text not null
    check (tipo in ('trabajo', 'infografia')),

  -- Nombre original del archivo
  nombre_original text not null,

  -- Ruta donde se almacena el archivo en Supabase Storage
  ruta_storage text not null,

  -- Tamaño del archivo en bytes
  tamano_bytes bigint not null default 0,

  -- Correo del usuario que realizó la carga
  subido_por text,

  -- Fecha y hora de creación
  creado_en timestamptz not null default now(),

  -- ==========================================================
  -- REGLAS PARA SLOT
  -- ==========================================================
  --
  -- Trabajo:
  --   slot = NULL
  --
  -- Infografía:
  --   slot = 1..7
  --
  constraint archivo_tipo_slot_check
    check (
      (tipo = 'trabajo' and slot is null)
      or
      (tipo = 'infografia' and slot between 1 and 7)
    )
);


-- ============================================================
-- ÍNDICES
-- ============================================================

create index if not exists archivo_unidad_semana_idx
  on public.archivo (unidad, semana);

create index if not exists archivo_tipo_idx
  on public.archivo (tipo);

create index if not exists archivo_slot_idx
  on public.archivo (unidad, semana, slot);


-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================
--
-- La aplicación NO accede directamente desde el navegador.
--
-- El backend Java utiliza la service_role key de Supabase.
--
-- La service_role:
--   - puede acceder aunque RLS esté activado
--   - permite que el backend controle los permisos
--
-- La anon key del navegador no tendrá políticas para modificar
-- directamente esta tabla.
-- ============================================================

alter table public.archivo enable row level security;


-- ============================================================
-- STORAGE
-- ============================================================
--
-- Crear manualmente en:
--
-- Supabase Dashboard
--   → Storage
--   → Create bucket
--
-- Nombre recomendado:
--
--     archivos
--
-- Configuración:
--
--     Public: OFF
--
-- El bucket debe ser PRIVADO.
--
-- El backend genera URLs firmadas temporalmente para:
--   - visualizar
--   - descargar
--
-- No se debe exponer la service_role key al navegador.
-- ============================================================


-- ============================================================
-- ESTRUCTURA DE STORAGE
-- ============================================================
--
-- Los archivos se organizan aproximadamente así:
--
-- archivos/
-- ├── unidad-1/
-- │   ├── semana-01/
-- │   ├── semana-02/
-- │   ├── semana-03/
-- │   └── semana-04/
-- │
-- ├── unidad-2/
-- │   ├── semana-05/
-- │   ├── semana-06/
-- │   ├── semana-07/
-- │   └── semana-08/
-- │
-- ├── unidad-3/
-- │   ├── semana-09/
-- │   ├── semana-10/
-- │   ├── semana-11/
-- │   └── semana-12/
-- │
-- └── unidad-4/
--     ├── semana-13/
--     ├── semana-14/
--     ├── semana-15/
--     └── semana-16/
--
-- ============================================================


-- ============================================================
-- USUARIO ADMINISTRADOR
-- ============================================================
--
-- El usuario administrador se crea desde:
--
-- Supabase Dashboard
--   → Authentication
--   → Users
--   → Add user
--
-- Después, en User Metadata:
--
-- {
--   "rol": "admin"
-- }
--
-- Los usuarios que no tengan:
--
--     "rol": "admin"
--
-- serán tratados como visitantes.
--
-- VISITANTE:
--   ✓ Ver unidades
--   ✓ Ver semanas
--   ✓ Ver archivos
--   ✓ Visualizar archivos
--   ✓ Descargar archivos
--   ✗ Subir archivos
--   ✗ Eliminar archivos
--
-- ADMIN:
--   ✓ Ver unidades
--   ✓ Ver semanas
--   ✓ Ver archivos
--   ✓ Visualizar archivos
--   ✓ Descargar archivos
--   ✓ Subir trabajos
--   ✓ Subir infografías
--   ✓ Eliminar archivos
--
-- ============================================================
