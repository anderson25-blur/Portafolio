# Arquitectura de Software — Portafolio académico

Portafolio web para el curso de Arquitectura de Software: 4 unidades, 16 semanas
(4 por unidad), infografías, subida/descarga de trabajos y acceso de administrador
vía Supabase. Diseño de moto deportiva nocturna: negro grafito, cian neón, verde
pista y ámbar (bokeh de luces de calle), paneles angulares tipo carenado — el
mismo lenguaje visual se repite en botones, tarjetas y controles.

## Estado actual — Fase 1 (diseño) + Fase 2 (backend) completas

**Visual**
- Pantalla de carga (tacómetro que llena, luego revela la página).
- Encabezado (HUD) con chip de sesión y botón de logout.
- Hero con la foto de la moto: zoom continuo lento + parallax al mover el mouse,
  luces flotantes (bokeh).
- Sección **Unidades**: 4 tarjetas en acordeón, cada una con sus 4 semanas reales
  (nombre y breve descripción tomados del sílabo), con estado "Sin trabajo" /
  "Subido: archivo.pdf", botón de descarga y (si eres admin) subir/eliminar.
- Sección **Infografías**: 3 tarjetas con miniatura real (si es imagen), descarga
  y (si eres admin) subir/eliminar.
- Modal de ingreso con manejo de errores reales del backend.

**Backend (`com.miportafolio`)**
- `config/SupabaseConfig` — lee URL y keys desde `application.properties` o
  variables de entorno.
- `config/HttpClientProvider` — cliente OkHttp compartido.
- `model/Usuario`, `model/Archivo`.
- `service/AuthService` — login/logout contra Supabase Auth (GoTrue REST).
- `service/StorageService` — sube, firma URLs de descarga y elimina en
  Supabase Storage.
- `dao/ArchivoDAO` — CRUD de la tabla `archivo` vía PostgREST.
- `filter/AdminFilter` — protege subir/eliminar (solo admin).
- `controller/*Servlet` — `LoginServlet`, `LogoutServlet`, `SesionServlet`,
  `ListarArchivosServlet`, `SubirArchivoServlet`, `DescargarArchivoServlet`,
  `EliminarArchivoServlet`. Todos registrados solos vía `@WebServlet`.
- `sql/schema.sql` — script para crear la tabla `archivo` en Supabase.

### Endpoints

| Método | Ruta                        | Quién puede usarlo | Qué hace |
|--------|-----------------------------|---------------------|----------|
| GET    | `/api/sesion`               | cualquiera          | Dice si hay sesión activa y el rol |
| POST   | `/api/login`                | cualquiera          | `{email, password}` → inicia sesión |
| POST   | `/api/logout`               | cualquiera          | Cierra la sesión |
| GET    | `/api/archivos`             | cualquiera          | Lista trabajos (o filtra por `unidad`/`semana`/`tipo=infografia`) |
| GET    | `/api/archivos/descargar?id=` | cualquiera        | Redirige a una URL firmada de descarga |
| POST   | `/api/archivos/subir`       | solo admin          | multipart: `archivo`, `tipo`, `unidad`+`semana` o `slot` |
| POST   | `/api/archivos/eliminar?id=`| solo admin          | Borra el archivo (Storage + tabla) |

## Puesta en marcha (Supabase)

1. Crea un proyecto en [supabase.com](https://supabase.com).
2. **SQL Editor** → pega y ejecuta `sql/schema.sql` (crea la tabla `archivo`).
3. **Storage** → crea un bucket privado llamado `trabajos` (o el nombre que
   pongas en `supabase.storageBucket`).
4. **Authentication → Users → Add user** → crea tu usuario admin. Ábrelo y en
   *User Metadata* pon `{ "rol": "admin" }`. Cualquier otro usuario sin ese
   metadata entra como "visitante" (ve y descarga, pero no sube ni borra).
5. **Project Settings → API** → copia `Project URL`, `anon` key y
   `service_role` key.
6. Complétalas en `src/main/resources/application.properties`
   (o como variables de entorno `SUPABASE_URL`, `SUPABASE_ANON_KEY`,
   `SUPABASE_SERVICE_ROLE_KEY`, `SUPABASE_STORAGE_BUCKET` en Render/Docker).

## Cómo correrlo en local

### Opción A — Maven + Tomcat instalado
```bash
mvn clean package
# copia target/MiPortafolio.war a la carpeta webapps/ de tu Tomcat
```

### Opción B — Docker (recomendado, no necesitas instalar nada)
```bash
docker build -t mi-portafolio .
docker run -p 8080:8080 \
  -e SUPABASE_URL=https://tuproyecto.supabase.co \
  -e SUPABASE_ANON_KEY=tu_anon_key \
  -e SUPABASE_SERVICE_ROLE_KEY=tu_service_role_key \
  mi-portafolio
```
Abre `http://localhost:8080`.

## Pendiente (siguientes fases, opcional)

1. **Páginas propias por semana**: hoy cada semana sube/descarga un solo
   archivo; si luego quieres una página individual por semana con más
   contenido, se arma sobre esta misma base (`ArchivoDAO` ya soporta varios
   archivos por semana).
2. **Bot de ayuda**: widget flotante con preguntas frecuentes predefinidas.
3. **Despliegue**: GitHub → Docker → Render, con las variables de entorno de
   arriba configuradas en el dashboard de Render.

## Estructura

```
MiPortafolio/
├── pom.xml
├── Dockerfile
├── sql/schema.sql
├── src/main/java/com/miportafolio/
│   ├── config/     (SupabaseConfig, HttpClientProvider)
│   ├── controller/ (servlets: sesión, login, logout, archivos)
│   ├── dao/        (ArchivoDAO)
│   ├── filter/     (AdminFilter)
│   ├── model/      (Archivo, Usuario)
│   └── service/    (AuthService, StorageService)
├── src/main/resources/application.properties
└── src/main/webapp/
    ├── index.jsp
    ├── css/style.css
    ├── js/main.js
    └── WEB-INF/web.xml
```

## Personalizar

- **Nombre / ciclo**: edita el texto en `src/main/webapp/index.jsp` dentro de
  `.hero-sub`.
- **Colores**: todos los tonos están centralizados como variables al inicio de
  `css/style.css` (`--bg`, `--lime`, `--cyan`, `--steel`, `--redline`…).
- **Mensajes de la barra de carga**: arreglo `stages` en `js/main.js`.
