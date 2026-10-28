<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String unidadParam = request.getParameter("unidad");
int unidad = 1;

try {
    if (unidadParam != null) {
        unidad = Integer.parseInt(unidadParam);
    }
} catch (NumberFormatException ignored) {
    unidad = 1;
}

if (unidad < 1 || unidad > 4) {
    unidad = 1;
}

int semanaInicio = ((unidad - 1) * 4) + 1;
int semanaFin = semanaInicio + 3;

String tituloUnidad = "";
String descripcionUnidad = "";

switch (unidad) {
    case 1:
        tituloUnidad =
            "Fundamentos de la Arquitectura de Software y Estándares Internacionales";
        descripcionUnidad =
            "Conceptos fundamentales, principios, atributos de calidad, estilos, patrones y documentación de la arquitectura de software.";
        break;

    case 2:
        tituloUnidad =
            "Modelado de la Arquitectura de Software mediante Programación Orientada a Objetos";
        descripcionUnidad =
            "Principios de POO, modelado UML, diseño de componentes, capas y validación del modelo arquitectónico.";
        break;

    case 3:
        tituloUnidad =
            "Comunicación e Integración de Arquitecturas de Software";
        descripcionUnidad =
            "Comunicación entre componentes, integración de sistemas, APIs, servicios web, interfaces y transmisión de datos.";
        break;

    case 4:
        tituloUnidad =
            "Frameworks y Estándares para la Implementación de Arquitecturas de Software";
        descripcionUnidad =
            "Frameworks, estándares, buenas prácticas, implementación, evaluación y optimización de arquitecturas de software.";
        break;
}
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Unidad <%= unidad %> | MiPortafolio</title>

    <style>
        /* =====================================================
           1. VARIABLES Y DISEÑO GENERAL
           ===================================================== */

        :root {
            color-scheme: dark;

            --mp-bg: #0a0f0c;
            --mp-panel: #121812;
            --mp-card: #171f18;

            --mp-border: #263127;
            --mp-border-hover: #40503d;

            --mp-text: #eaf2ea;
            --mp-secondary: #b9c4bc;
            --mp-muted: #8b978e;

            --mp-green: #93d500;
            --mp-green-light: #c4f36a;

            --mp-red: #ff4630;
        }

        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
            min-width: 0;
        }

        body.miportafolio-unidad {
            margin: 0;
            min-width: 0;
            min-height: 100vh;

            color: var(--mp-text) !important;

            background:
                radial-gradient(
                    circle at 15% 10%,
                    rgba(147, 213, 0, 0.08),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 85% 85%,
                    rgba(147, 213, 0, 0.035),
                    transparent 30%
                ),
                var(--mp-bg) !important;

            font-family: "Segoe UI", Arial, sans-serif;
        }

        body.miportafolio-unidad .page {
            width: 100%;
            max-width: 1250px;
            min-width: 0;
            margin: 0 auto;
            padding: 60px 25px 80px;

            color: var(--mp-text) !important;
        }

        body.miportafolio-unidad .page *,
        body.miportafolio-unidad .archivo-viewer * {
            box-sizing: border-box;
        }

        body.miportafolio-unidad .section {
            width: 100%;
            min-width: 0;
        }

        body.miportafolio-unidad h1,
        body.miportafolio-unidad h2,
        body.miportafolio-unidad h3,
        body.miportafolio-unidad p {
            overflow-wrap: anywhere;
        }

        body.miportafolio-unidad [hidden] {
            display: none !important;
        }

        /* =====================================================
           2. ENCABEZADO DE UNIDAD
           ===================================================== */

        .section-head {
            margin-bottom: 35px;
        }

        .eyebrow {
            margin: 0 0 12px;

            color: var(--mp-green) !important;

            font-size: 12px;
            font-weight: 900;
            letter-spacing: 3px;
        }

        .section-head h1 {
            margin: 0 0 15px;

            color: var(--mp-text) !important;

            font-size: clamp(36px, 6vw, 62px);
            line-height: 1;
            font-weight: 900;

            text-transform: uppercase;
            letter-spacing: -2px;
        }

        .unidad-titulo {
            max-width: 950px;
            margin: 0 0 12px;

            color: var(--mp-secondary) !important;

            font-size: 22px;
            font-weight: 700;
            line-height: 1.4;
        }

        .unidad-descripcion {
            max-width: 850px;
            margin: 0;

            color: var(--mp-muted) !important;

            font-size: 15px;
            line-height: 1.7;
        }

        /* =====================================================
           3. BOTÓN VOLVER
           ===================================================== */

        body.miportafolio-unidad a.btn-back,
        body.miportafolio-unidad a.btn-back:visited {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;

            margin-top: 22px;
            padding: 11px 18px;

            border: 1px solid var(--mp-border) !important;
            border-radius: 8px;

            color: var(--mp-secondary) !important;
            background: var(--mp-panel) !important;

            text-decoration: none !important;

            font-size: 13px;
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;

            transition: 0.2s ease;
        }

        body.miportafolio-unidad a.btn-back:hover {
            color: var(--mp-green) !important;

            border-color: var(--mp-green) !important;
            background: var(--mp-card) !important;

            transform: translateX(-3px);
        }

        /* =====================================================
           4. LISTA DE SEMANAS
           ===================================================== */

        .semanas-lista {
            display: flex;
            flex-direction: column;
            gap: 25px;
            min-width: 0;
        }

        .semana-item {
            width: 100%;
            min-width: 0;
            overflow: hidden;

            border: 1px solid var(--mp-border) !important;
            border-radius: 16px;

            background: linear-gradient(
                145deg,
                #121812,
                #0d120e
            ) !important;

            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.30);

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease;
        }

        .semana-item:hover {
            border-color: var(--mp-border-hover) !important;
            box-shadow: 0 18px 45px rgba(0, 0, 0, 0.40);
        }

        .semana-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;

            padding: 22px 25px;

            border-bottom: 1px solid var(--mp-border);

            background: rgba(23, 31, 24, 0.75) !important;
        }

        .semana-header-info {
            min-width: 0;
        }

        .semana-numero {
            display: block;
            margin-bottom: 6px;

            color: var(--mp-green) !important;

            font-size: 12px;
            font-weight: 900;
            letter-spacing: 2px;
        }

        .semana-header h2 {
            margin: 0;

            color: var(--mp-text) !important;

            font-size: 25px;
            font-weight: 900;
            line-height: 1.3;

            text-transform: uppercase;
        }

        .semana-descripcion {
            padding: 20px 25px;

            border-bottom: 1px solid var(--mp-border);

            color: var(--mp-muted) !important;

            font-size: 14px;
            line-height: 1.7;
        }

        /* =====================================================
           5. SECCIONES DE MATERIAL
           ===================================================== */

        .material-section {
            min-width: 0;
            padding: 25px;
        }

        .material-section + .material-section {
            border-top: 1px solid var(--mp-border);
        }

        .material-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 14px;

            margin-bottom: 20px;
        }

        .material-header > div:first-child {
            display: flex;
            align-items: center;
            gap: 14px;
            min-width: 0;
        }

        .material-icon {
            display: flex;
            align-items: center;
            justify-content: center;

            flex: 0 0 42px;
            width: 42px;
            height: 42px;

            border: 1px solid var(--mp-green);
            border-radius: 10px;

            color: var(--mp-green) !important;
            background: rgba(147, 213, 0, 0.08) !important;

            font-size: 18px;
        }

        .material-header h3 {
            margin: 0;

            color: var(--mp-text) !important;

            font-size: 18px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .material-header p {
            margin: 4px 0 0;

            color: var(--mp-muted) !important;

            font-size: 13px;
            line-height: 1.6;
        }

        /* =====================================================
           6. BOTONES PROFESIONALES
           ===================================================== */

        body.miportafolio-unidad .archivo-actions,
        body.miportafolio-unidad .info-actions,
        body.miportafolio-unidad .enlace-card-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 9px;
            min-width: 0;
        }

        body.miportafolio-unidad a.btn,
        body.miportafolio-unidad a.btn:visited,
        body.miportafolio-unidad button.btn,
        body.miportafolio-unidad label.btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;

            min-height: 36px;
            max-width: 100%;
            padding: 9px 13px;

            border: 1px solid #344334 !important;
            border-radius: 8px;

            color: #dce6dc !important;
            background: #111711 !important;

            font-family: "Segoe UI", Arial, sans-serif;
            font-size: 12px;
            font-weight: 800;
            line-height: 1.3;

            text-align: center;
            text-decoration: none !important;
            white-space: normal;

            cursor: pointer;

            transition:
                background 0.2s ease,
                border-color 0.2s ease,
                color 0.2s ease,
                transform 0.2s ease,
                box-shadow 0.2s ease;
        }

        body.miportafolio-unidad .btn-small {
            min-height: 34px;
            padding: 8px 11px;
            font-size: 11px;
        }

        /* Botón VER */

        body.miportafolio-unidad a.btn[data-view],
        body.miportafolio-unidad a.btn[data-view]:visited {
            color: #b9e879 !important;

            background: rgba(147, 213, 0, 0.06) !important;

            border-color: rgba(147, 213, 0, 0.35) !important;
        }

        body.miportafolio-unidad a.btn[data-view]:hover {
            color: #0a0f0c !important;
            background: var(--mp-green) !important;
            border-color: var(--mp-green) !important;

            box-shadow: 0 4px 16px rgba(147, 213, 0, 0.16);

            transform: translateY(-2px);
        }

        /* Botón DESCARGAR */

        body.miportafolio-unidad a.btn[data-download],
        body.miportafolio-unidad a.btn[data-download]:visited {
            color: #0a0f0c !important;

            background: var(--mp-green) !important;

            border-color: var(--mp-green) !important;
        }

        body.miportafolio-unidad a.btn[data-download]:hover {
            color: #0a0f0c !important;
            background: var(--mp-green-light) !important;
            border-color: var(--mp-green-light) !important;

            box-shadow: 0 4px 16px rgba(147, 213, 0, 0.20);

            transform: translateY(-2px);
        }

        /* Botón SUBIR */

        body.miportafolio-unidad label.btn.admin-only {
            color: #c8ef8a !important;

            background: rgba(147, 213, 0, 0.08) !important;

            border: 1px dashed rgba(147, 213, 0, 0.55) !important;
        }

        body.miportafolio-unidad label.btn.admin-only:hover {
            color: #0a0f0c !important;

            background: var(--mp-green) !important;

            border-color: var(--mp-green) !important;
            border-style: solid !important;
        }

        /* Botón ELIMINAR */

        body.miportafolio-unidad button.btn-danger {
            color: #ff897d !important;

            background: rgba(255, 70, 48, 0.07) !important;

            border-color: rgba(255, 70, 48, 0.35) !important;
        }

        body.miportafolio-unidad button.btn-danger:hover {
            color: #ffffff !important;

            background: #c93425 !important;

            border-color: var(--mp-red) !important;

            transform: translateY(-1px);
        }

        body.miportafolio-unidad .btn:focus-visible {
            outline: 2px solid var(--mp-green) !important;
            outline-offset: 3px;
        }

        body.miportafolio-unidad .btn[hidden],
        body.miportafolio-unidad .admin-only[hidden] {
            display: none !important;
        }

       /* =========================================================
   DISEÑO DE TRABAJOS PDF
   ========================================================= */

.trabajos-lista {
    display: flex;
    flex-direction: column;
    gap: 14px;
    width: 100%;
    min-width: 0;
    margin-top: 18px;
}

.trabajos-lista .trabajo-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 18px;

    width: 100%;
    min-width: 0;
    padding: 18px;

    border: 1px solid #263127 !important;
    border-radius: 12px;

    background: #171f18 !important;
    color: #eaf2ea !important;

    transition:
        border-color .2s ease,
        background .2s ease,
        transform .2s ease;
}

.trabajos-lista .trabajo-item:hover {
    border-color: #40503d !important;
    background: #1a241b !important;
}

.trabajos-lista .trabajo-item .archivo-info {
    display: flex;
    align-items: center;
    gap: 14px;

    flex: 1 1 220px;
    min-width: 0;
}

.trabajos-lista .trabajo-icono {
    flex-shrink: 0;
}

.trabajos-lista .trabajo-detalles {
    display: flex;
    flex-direction: column;
    gap: 6px;
    min-width: 0;
}

.trabajos-lista .trabajo-nombre {
    color: #eaf2ea !important;
    font-size: 14px;
    font-weight: 800;
    line-height: 1.5;
    overflow-wrap: anywhere;
}

.trabajos-lista .archivo-status {
    color: #93d500 !important;
    font-size: 12px;
}

.trabajos-lista .archivo-actions {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    flex-wrap: wrap;
    gap: 9px;
    min-width: 0;
}

/* BOTÓN VER */

.trabajos-lista a[data-view],
.trabajos-lista a[data-view]:visited {
    color: #b9e879 !important;
    background: rgba(147, 213, 0, .06) !important;
    border: 1px solid rgba(147, 213, 0, .45) !important;
}

.trabajos-lista a[data-view]:hover {
    color: #0a0f0c !important;
    background: #93d500 !important;
    border-color: #93d500 !important;
}

/* BOTÓN DESCARGAR */

.trabajos-lista a[data-download],
.trabajos-lista a[data-download]:visited {
    color: #0a0f0c !important;
    background: #93d500 !important;
    border: 1px solid #93d500 !important;
}

.trabajos-lista a[data-download]:hover {
    color: #0a0f0c !important;
    background: #c4f36a !important;
    border-color: #c4f36a !important;
}

/* BOTÓN ELIMINAR */

.trabajos-lista button[data-delete] {
    color: #ff897d !important;
    background: rgba(255, 70, 48, .07) !important;
    border: 1px solid rgba(255, 70, 48, .4) !important;
}

.trabajos-lista button[data-delete]:hover {
    color: #ffffff !important;
    background: #c93425 !important;
    border-color: #ff4630 !important;
}

/* TRANSICIONES Y FOCO */

.trabajos-lista .btn {
    transition:
        color .2s ease,
        background .2s ease,
        border-color .2s ease,
        transform .2s ease;
}

.trabajos-lista .btn:hover {
    transform: translateY(-2px);
}

.trabajos-lista .btn:focus-visible {
    outline: 2px solid #93d500;
    outline-offset: 3px;
}

/* MENSAJE DE LISTA VACÍA */

.trabajos-lista .trabajos-vacio {
    margin: 0;
    padding: 16px;

    border: 1px dashed #344334;
    border-radius: 10px;

    color: #8b978e !important;
    background: #101610 !important;

    font-size: 13px;
    line-height: 1.6;
}

/* ADAPTACIÓN MÓVIL */

@media (max-width: 600px) {

    .trabajos-lista .trabajo-item {
        align-items: flex-start;
        flex-direction: column;
        gap: 14px;
        padding: 15px;
    }

    .trabajos-lista .trabajo-item .archivo-info {
        width: 100%;
        flex-basis: auto;
    }

    .trabajos-lista .archivo-actions {
        justify-content: flex-start;
        width: 100%;
    }
}
        /* =====================================================
           8. INFOGRAFÍAS
           ===================================================== */

        .info-grid {
            display: grid;

            grid-template-columns: repeat(4, minmax(0, 1fr));

            gap: 15px;
            min-width: 0;
        }

        .info-card {
            min-width: 0;
            overflow: hidden;

            border: 1px solid var(--mp-border) !important;
            border-radius: 12px;

            background: var(--mp-card) !important;

            transition:
                border-color 0.2s ease,
                transform 0.2s ease;
        }

        .info-card:hover {
            border-color: #4c6e12 !important;
            transform: translateY(-3px);
        }

        .info-preview {
            position: relative;

            display: flex;
            align-items: center;
            justify-content: center;

            min-width: 0;
            min-height: 170px;

            overflow: hidden;

            border-bottom: 1px solid var(--mp-border);

            background: var(--mp-bg) !important;
        }

        .info-preview img {
            display: block;

            width: 100%;
            height: 170px;
            max-width: 100%;

            object-fit: cover;
        }

        .info-preview [data-empty-text] {
            padding: 20px;

            color: #59645c !important;

            text-align: center;
            font-size: 13px;
        }

        .info-card-footer {
            min-width: 0;
            padding: 15px;
        }

        .info-card-footer > span {
            display: block;
            margin-bottom: 10px;

            color: var(--mp-text) !important;

            font-size: 14px;
            font-weight: 800;
        }

        .info-actions {
            margin-top: 10px;
        }

        body.miportafolio-unidad .info-actions button[data-delete] {
            width: 34px;
            min-width: 34px;
            padding: 0;

            font-size: 17px;
        }

        /* =====================================================
           9. ENLACES DEL PROYECTO
           ===================================================== */

        .enlace-count {
            flex: 0 0 auto;

            padding: 6px 10px;

            border: 1px solid #344334;
            border-radius: 999px;

            color: var(--mp-green) !important;
            background: rgba(147, 213, 0, 0.07) !important;

            font-size: 11px;
            font-weight: 800;
        }

        .enlace-form {
            display: grid;

            grid-template-columns: repeat(2, minmax(0, 1fr));

            gap: 14px;
            min-width: 0;

            margin-bottom: 18px;
            padding: 18px;

            border: 1px solid var(--mp-border);
            border-radius: 12px;

            background: #111711 !important;
        }

        .enlace-field {
            display: flex;
            flex-direction: column;
            gap: 7px;

            min-width: 0;

            color: var(--mp-secondary) !important;

            font-size: 12px;
            font-weight: 800;
        }

        .enlace-field-wide,
        .enlace-form-actions {
            grid-column: 1 / -1;
        }

        body.miportafolio-unidad .enlace-field input {
            display: block;

            width: 100%;
            min-width: 0;
            padding: 11px 12px;

            border: 1px solid #344334 !important;
            border-radius: 7px;

            outline: none;

            color: var(--mp-text) !important;
            background: var(--mp-bg) !important;

            font-family: inherit;
            font-size: 13px;
            font-weight: 500;
        }

        body.miportafolio-unidad .enlace-field input::placeholder {
            color: #59645c !important;
        }

        body.miportafolio-unidad .enlace-field input:focus {
            border-color: var(--mp-green) !important;

            box-shadow: 0 0 0 3px rgba(147, 213, 0, 0.10);
        }

        .enlace-form-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .enlace-feedback {
            flex: 1 1 180px;
            min-width: 0;

            margin: 0;

            color: var(--mp-muted) !important;

            font-size: 12px;
            line-height: 1.5;
        }

        .enlaces-lista {
            display: grid;
            grid-template-columns: minmax(0, 1fr);
            gap: 12px;

            min-width: 0;
        }

        .enlaces-vacio {
            margin: 0;
            padding: 16px;

            border: 1px dashed #344334;
            border-radius: 10px;

            color: var(--mp-muted) !important;

            font-size: 13px;
            line-height: 1.6;
        }

        .enlace-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;

            min-width: 0;
            padding: 16px;

            border: 1px solid var(--mp-border) !important;
            border-radius: 11px;

            background: var(--mp-card) !important;
        }

        .enlace-card-info {
            flex: 1 1 auto;
            min-width: 0;
        }

        .enlace-card-title {
            margin: 0 0 6px;

            color: var(--mp-text) !important;

            font-size: 14px;
            font-weight: 800;
        }

        body.miportafolio-unidad a.enlace-url,
        body.miportafolio-unidad a.enlace-url:visited {
            display: inline-block;

            max-width: 100%;

            color: var(--mp-green) !important;

            font-size: 12px;
            line-height: 1.6;

            overflow-wrap: anywhere;

            text-decoration: none !important;
        }

        body.miportafolio-unidad a.enlace-url:hover {
            color: var(--mp-green-light) !important;
            text-decoration: underline !important;
        }

        .enlace-card-description {
            margin: 6px 0 0;

            color: var(--mp-muted) !important;

            font-size: 12px;
            line-height: 1.6;
        }

        .enlace-card-actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;

            flex: 0 0 auto;
            flex-wrap: wrap;
            gap: 8px;
        }

        /* =====================================================
           10. VISOR DE ARCHIVOS
           ===================================================== */

        #archivoViewer {
            position: fixed;
            inset: 0;

            z-index: 9999;

            display: none;
            align-items: center;
            justify-content: center;

            padding: 25px;

            background: rgba(0, 0, 0, 0.88) !important;
        }

        #archivoViewer[aria-hidden="false"] {
            display: flex;
        }

        .archivo-viewer-overlay {
            position: absolute;
            inset: 0;
        }

        .archivo-viewer-panel {
            position: relative;
            z-index: 2;

            display: flex;
            align-items: center;
            justify-content: center;

            width: min(1200px, 95vw);
            height: min(90vh, 900px);

            padding: 50px 20px 20px;

            border: 1px solid var(--mp-border);
            border-radius: 14px;

            background: #0d120e !important;

            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.60);
        }

        .archivo-viewer-content {
            display: flex;
            align-items: center;
            justify-content: center;

            width: 100%;
            height: 100%;

            overflow: hidden;
        }

        .archivo-viewer-image {
            max-width: 100%;
            max-height: 100%;

            object-fit: contain;

            border-radius: 8px;
        }

        .archivo-viewer-pdf {
            width: 100%;
            height: 100%;

            border: none;
            border-radius: 8px;

            background: #ffffff;
        }

        .archivo-viewer-close {
            position: absolute;

            top: 12px;
            right: 15px;

            z-index: 3;

            display: flex;
            align-items: center;
            justify-content: center;

            width: 38px;
            height: 38px;

            border: 1px solid var(--mp-border) !important;
            border-radius: 8px;

            color: var(--mp-secondary) !important;
            background: var(--mp-panel) !important;

            cursor: pointer;

            font-size: 25px;
            line-height: 1;
        }

        .archivo-viewer-close:hover {
            color: var(--mp-red) !important;
            border-color: var(--mp-red) !important;
        }

        body.viewer-open {
            overflow: hidden;
        }

        /* =====================================================
           11. ZOOM DE IMÁGENES
           ===================================================== */

        .zoom-stage {
            position: relative;

            display: flex;
            align-items: center;
            justify-content: center;

            width: 100%;
            height: 100%;

            overflow: hidden;
            touch-action: none;

            cursor: zoom-in;
        }

        .zoom-stage.is-zoomed {
            cursor: grab;
        }

        .zoom-stage.is-dragging {
            cursor: grabbing;
        }

        .zoom-stage img {
            max-width: 100%;
            max-height: 100%;

            object-fit: contain;

            user-select: none;
            -webkit-user-drag: none;

            transform-origin: center center;
            will-change: transform;
        }

        .zoom-toolbar {
            position: absolute;

            top: 10px;
            left: 10px;

            z-index: 5;

            display: flex;
            gap: 6px;

            padding: 6px;

            border: 1px solid var(--mp-border);
            border-radius: 10px;

            background: rgba(18, 24, 18, 0.92) !important;
        }

        .zoom-toolbar button {
            min-width: 36px;
            height: 34px;
            padding: 0 10px;

            border: 1px solid var(--mp-border) !important;
            border-radius: 7px;

            color: var(--mp-secondary) !important;
            background: var(--mp-bg) !important;

            cursor: pointer;

            font-size: 15px;
            font-weight: 800;
        }

        .zoom-toolbar button:hover {
            color: var(--mp-green) !important;
            border-color: var(--mp-green) !important;
        }

        .zoom-toolbar .zoom-level {
            display: flex;
            align-items: center;
            justify-content: center;

            min-width: 48px;

            color: var(--mp-muted) !important;

            font-size: 12px;
            font-weight: 800;
        }

        /* =====================================================
           12. DISEÑO RESPONSIVE
           ===================================================== */

        @media (max-width: 950px) {
            .info-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 700px) {
            body.miportafolio-unidad .page {
                padding: 40px 15px 60px;
            }

            .semana-header {
                padding: 20px;
            }

            .semana-header h2 {
                font-size: 21px;
            }

            .material-section {
                padding: 20px;
            }

            .archivo-item {
                align-items: flex-start;
                flex-direction: column;
            }

            .admin-only {
                margin-left: 0;
            }

            .info-grid {
                grid-template-columns: minmax(0, 1fr);
            }

            .enlace-form {
                grid-template-columns: minmax(0, 1fr);
                padding: 15px;
            }

            .enlace-field-wide,
            .enlace-form-actions {
                grid-column: auto;
            }

            .enlace-card {
                align-items: flex-start;
                flex-direction: column;
            }

            .enlace-card-actions {
                width: 100%;
                justify-content: flex-start;
            }

            .archivo-viewer-panel {
                width: 100%;
                height: 90vh;
                padding: 50px 12px 12px;
            }
        }

        @media (max-width: 480px) {
            .section-head h1 {
                font-size: 38px;
            }

            .unidad-titulo {
                font-size: 18px;
            }

            .material-header {
                align-items: flex-start;
            }

            .material-header > div:first-child {
                align-items: flex-start;
            }

            .semana-descripcion {
                padding: 18px 20px;
            }

            .material-section {
                padding: 18px;
            }

            .archivo-actions,
            .info-actions {
                gap: 7px;
            }
        }
    </style>
</head>

<body class="miportafolio-unidad">

<main class="page">
    <section class="section">

        <!-- ENCABEZADO -->

        <div class="section-head">

            <p class="eyebrow">ARQUITECTURA DE SOFTWARE</p>

            <h1>Unidad <%= unidad %></h1>

            <p class="unidad-titulo"><%= tituloUnidad %></p>

            <p class="unidad-descripcion"><%= descripcionUnidad %></p>

            <a class="btn-back" href="../unidades/listar.jsp">
                ← Volver a unidades
            </a>

        </div>

        <!-- SEMANAS -->

        <div class="semanas-lista">

<%
for (int semana = semanaInicio; semana <= semanaFin; semana++) {

    String tituloSemana = "";
    String descripcionSemana = "";

    switch (semana) {
        case 1:
            tituloSemana = "Introducción a la Arquitectura de Software";
            descripcionSemana = "Conceptos, objetivos e importancia de la arquitectura de software.";
            break;

        case 2:
            tituloSemana = "Principios, Atributos de Calidad y Estándares Internacionales";
            descripcionSemana = "Calidad y sostenibilidad del proyecto según estándares internacionales.";
            break;

        case 3:
            tituloSemana = "Estilos y Patrones Arquitectónicos";
            descripcionSemana = "Comparación de estilos y selección del patrón más adecuado.";
            break;

        case 4:
            tituloSemana = "Documentación y Representación Arquitectónica";
            descripcionSemana = "Modelos, diagramas y buenas prácticas de documentación.";
            break;

        case 5:
            tituloSemana = "Principios de POO aplicados a la Arquitectura";
            descripcionSemana = "Abstracción, encapsulamiento, herencia y polimorfismo.";
            break;

        case 6:
            tituloSemana = "Modelado Arquitectónico con UML";
            descripcionSemana = "Diagramas de casos de uso, clases y paquetes.";
            break;

        case 7:
            tituloSemana = "Diseño de Componentes y Capas de la Arquitectura";
            descripcionSemana = "Responsabilidades, cohesión y bajo acoplamiento.";
            break;

        case 8:
            tituloSemana = "Elaboración y Validación del Modelo Arquitectónico";
            descripcionSemana = "Artefactos de modelado y sustento técnico de las decisiones.";
            break;

        case 9:
            tituloSemana = "Fundamentos de la Comunicación entre Arquitecturas";
            descripcionSemana = "Mecanismos, protocolos y flujos de información entre componentes.";
            break;

        case 10:
            tituloSemana = "Métodos y Tecnologías para la Integración de Sistemas";
            descripcionSemana = "Servicios web, APIs y mensajería para integrar aplicaciones.";
            break;

        case 11:
            tituloSemana = "Diseño de Interfaces y Transmisión de Datos";
            descripcionSemana = "Interoperabilidad y modelado de servicios entre componentes.";
            break;

        case 12:
            tituloSemana = "Implementación y Validación de la Comunicación Arquitectónica";
            descripcionSemana = "Pruebas de integridad, disponibilidad y eficiencia de la integración.";
            break;

        case 13:
            tituloSemana = "Fundamentos de Frameworks de Arquitectura de Software";
            descripcionSemana = "Características, ventajas y ámbitos de aplicación de los principales frameworks.";
            break;

        case 14:
            tituloSemana = "Normas y Buenas Prácticas en Arquitectura de Software";
            descripcionSemana = "Calidad, interoperabilidad, seguridad y rendimiento del proyecto.";
            break;

        case 15:
            tituloSemana = "Implementación de la Arquitectura utilizando Frameworks";
            descripcionSemana = "Componentes, patrones de diseño y mecanismos de comunicación.";
            break;

        case 16:
            tituloSemana = "Evaluación y Optimización de la Arquitectura de Software";
            descripcionSemana = "Métricas de calidad y mejoras finales sobre lo implementado.";
            break;
    }

    int cantidadInfografias = 4;

    switch (semana) {
        case 1:
            cantidadInfografias = 7;
            break;
        case 2:
            cantidadInfografias = 4;
            break;
        case 3:
            cantidadInfografias = 1;
            break;
        case 4:
            cantidadInfografias = 5;
            break;
        default:
            cantidadInfografias = 4;
            break;
    }
%>

            <article
                class="semana-item"
                data-unidad="<%= unidad %>"
                data-semana="<%= semana %>">

                <!-- CABECERA -->

                <div class="semana-header">

                    <div class="semana-header-info">

                        <span class="semana-numero">
                            SEMANA <%= String.format("%02d", semana) %>
                        </span>

                        <h2><%= tituloSemana %></h2>

                    </div>

                </div>

                <!-- DESCRIPCIÓN -->

                <div class="semana-descripcion">
                    <%= descripcionSemana %>
                </div>

                <!-- =============================================
                     TRABAJOS PDF
                     main.js controla su visibilidad
                     ============================================= -->

                <section
                    class="material-section trabajo-section"
                    hidden>

                    <div class="material-header">

                        <div>
                            <span class="material-icon">📚</span>

                            <div>
                                <h3>Trabajos</h3>
                                <p>Documento PDF de la semana.</p>
                            </div>
                        </div>

                        <label class="btn btn-small admin-only" hidden>
                            + Subir PDF

                            <input
                                type="file"
                                hidden
                                accept=".pdf,application/pdf"
                                data-upload-input>
                        </label>

                    </div>

                    <div class="archivo-item">

                        <div class="archivo-info">

                            <span class="archivo-status" data-status>
                                Sin trabajo
                            </span>

                        </div>

                        <div class="archivo-actions">

                            <a
                                class="btn btn-small"
                                data-view
                                target="_blank"
                                rel="noopener"
                                hidden>
                                👁 Ver
                            </a>

                            <a
                                class="btn btn-small"
                                data-download
                                hidden>
                                ↓ Descargar
                            </a>

                            <button
                                type="button"
                                class="btn btn-small btn-danger admin-only"
                                data-delete
                                hidden>
                                Eliminar
                            </button>

                        </div>

                    </div>

                </section>

                <!-- =============================================
                     INFOGRAFÍAS
                     ============================================= -->

                <section class="material-section infografias-section">

                    <div class="material-header">

                        <div>
                            <span class="material-icon">🖼️</span>

                            <div>
                                <h3>Infografías</h3>
                                <p>Imágenes JPG, JPEG o PNG de la semana.</p>
                            </div>
                        </div>

                    </div>

                    <div class="info-grid" data-info-grid>

<%
    for (int slot = 1; slot <= cantidadInfografias; slot++) {
%>

                        <article
                            class="info-card"
                            data-unidad="<%= unidad %>"
                            data-semana="<%= semana %>"
                            data-slot="<%= slot %>">

                            <div class="info-preview">

                                <img
                                    data-thumb-img
                                    alt="Infografía <%= slot %>"
                                    hidden>

                                <span data-empty-text>
                                    Sin infografía
                                </span>

                            </div>

                            <div class="info-card-footer">

                                <span>Infografía <%= slot %></span>

                                <div class="info-actions">

                                    <label class="btn btn-small admin-only" hidden>
                                        + Subir

                                        <input
                                            type="file"
                                            hidden
                                            accept=".jpg,.jpeg,.png,image/jpeg,image/png"
                                            data-upload-input>
                                    </label>

                                    <a
                                        class="btn btn-small"
                                        data-view
                                        target="_blank"
                                        rel="noopener"
                                        hidden>
                                        👁 Ver
                                    </a>

                                    <a
                                        class="btn btn-small"
                                        data-download
                                        hidden>
                                        ↓ Descargar
                                    </a>

                                    <button
                                        type="button"
                                        class="btn btn-small btn-danger admin-only"
                                        data-delete
                                        hidden
                                        aria-label="Eliminar infografía <%= slot %>">
                                        ×
                                    </button>

                                </div>

                            </div>

                        </article>

<%
    }
%>

                    </div>

                </section>

                <!-- =============================================
                     ENLACES DEL PROYECTO
                     ============================================= -->

                <section
                    class="material-section enlaces-section"
                    data-enlaces-section>

                    <div class="material-header">

                        <div>
                            <span class="material-icon">🔗</span>

                            <div>
                                <h3>Enlaces del proyecto</h3>

                                <p>
                                    Repositorios, prototipos, documentos y demostraciones.
                                </p>
                            </div>
                        </div>

                        <span class="enlace-count" data-enlace-count>
                            0 enlaces
                        </span>

                    </div>

                    <form
                        class="enlace-form admin-only"
                        data-enlace-form
                        hidden>

                        <label class="enlace-field">
                            Nombre del enlace

                            <input
                                type="text"
                                data-enlace-titulo
                                maxlength="100"
                                placeholder="Ej. Prototipo en Figma"
                                required>
                        </label>

                        <label class="enlace-field">
                            URL del proyecto

                            <input
                                type="url"
                                data-enlace-url
                                maxlength="1500"
                                placeholder="https://..."
                                autocomplete="url"
                                required>
                        </label>

                        <label class="enlace-field enlace-field-wide">
                            Descripción opcional

                            <input
                                type="text"
                                data-enlace-descripcion
                                maxlength="180"
                                placeholder="Describe brevemente el enlace">
                        </label>

                        <div class="enlace-form-actions">

                            <button type="submit" class="btn btn-small">
                                + Guardar enlace
                            </button>

                            <p
                                class="enlace-feedback"
                                data-enlace-feedback
                                role="status"
                                aria-live="polite">
                            </p>

                        </div>

                    </form>

                    <div class="enlaces-lista" data-enlaces-lista>

                        <p class="enlaces-vacio" data-enlaces-vacio>
                            Todavía no se han agregado enlaces para esta semana.
                        </p>

                    </div>

                </section>

            </article>

<%
}
%>

        </div>
    </section>
</main>

<!-- =============================================
     VISOR DE ARCHIVOS
     ============================================= -->

<div
    id="archivoViewer"
    class="archivo-viewer"
    hidden
    aria-hidden="true">

    <div class="archivo-viewer-overlay"></div>

    <div
        class="archivo-viewer-panel"
        role="dialog"
        aria-modal="true"
        aria-label="Visualizador de archivo">

        <button
            type="button"
            id="archivoViewerClose"
            class="archivo-viewer-close"
            aria-label="Cerrar visor">
            ×
        </button>

        <div
            id="archivoViewerContent"
            class="archivo-viewer-content">
        </div>

    </div>

</div>

<!-- =============================================
     SCRIPT EXISTENTE DE GESTIÓN DE ARCHIVOS
     ============================================= -->

<script src="../js/main.js?v=3"></script>

<script>
/* =========================================================
   A. GESTIÓN DE ENLACES POR UNIDAD Y SEMANA
   ========================================================= */

(() => {
    "use strict";

    const PREFIJO = "miportafolio_enlaces_v1";

    function obtenerClave(semanaElemento) {
        return PREFIJO
            + "_"
            + semanaElemento.dataset.unidad
            + "_"
            + semanaElemento.dataset.semana;
    }

    function obtenerURLSegura(valor) {
        try {
            const url = new URL(valor.trim());

            if (url.protocol !== "https:" && url.protocol !== "http:") {
                return null;
            }

            return url.href;
        } catch (error) {
            return null;
        }
    }

    function leerEnlaces(clave) {
        try {
            const datos = JSON.parse(
                localStorage.getItem(clave) || "[]"
            );

            return Array.isArray(datos) ? datos : [];
        } catch (error) {
            console.error("Error al leer los enlaces:", error);
            return [];
        }
    }

    function guardarEnlaces(clave, enlaces) {
        try {
            localStorage.setItem(clave, JSON.stringify(enlaces));
            return true;
        } catch (error) {
            console.error("Error al guardar los enlaces:", error);
            return false;
        }
    }

    function crearElemento(etiqueta, clase, texto) {
        const elemento = document.createElement(etiqueta);

        if (clase) {
            elemento.className = clase;
        }

        if (texto !== undefined) {
            elemento.textContent = texto;
        }

        return elemento;
    }

    function esAdministrador(semanaElemento) {
        return Array.from(
            semanaElemento.querySelectorAll(".admin-only")
        ).some(elemento => !elemento.hidden);
    }

    function inicializarEnlaces(semanaElemento) {
        const formulario = semanaElemento.querySelector(
            "[data-enlace-form]"
        );

        const lista = semanaElemento.querySelector(
            "[data-enlaces-lista]"
        );

        const contador = semanaElemento.querySelector(
            "[data-enlace-count]"
        );

        if (!formulario || !lista || !contador) {
            return;
        }

        const clave = obtenerClave(semanaElemento);

        const campoTitulo = formulario.querySelector(
            "[data-enlace-titulo]"
        );

        const campoURL = formulario.querySelector(
            "[data-enlace-url]"
        );

        const campoDescripcion = formulario.querySelector(
            "[data-enlace-descripcion]"
        );

        const mensaje = formulario.querySelector(
            "[data-enlace-feedback]"
        );

        function renderizar() {
            const enlaces = leerEnlaces(clave);
            const administrador = esAdministrador(semanaElemento);

            contador.textContent =
                enlaces.length
                + (enlaces.length === 1 ? " enlace" : " enlaces");

            lista.replaceChildren();

            if (enlaces.length === 0) {
                lista.appendChild(
                    crearElemento(
                        "p",
                        "enlaces-vacio",
                        "Todavía no se han agregado enlaces para esta semana."
                    )
                );

                return;
            }

            enlaces.forEach(enlace => {
                const tarjeta = crearElemento(
                    "article",
                    "enlace-card"
                );

                const informacion = crearElemento(
                    "div",
                    "enlace-card-info"
                );

                const titulo = crearElemento(
                    "h4",
                    "enlace-card-title",
                    enlace.titulo
                );

                informacion.appendChild(titulo);

                const enlaceURL = crearElemento(
                    "a",
                    "enlace-url",
                    enlace.url
                );

                enlaceURL.href = enlace.url;
                enlaceURL.target = "_blank";
                enlaceURL.rel = "noopener noreferrer";

                informacion.appendChild(enlaceURL);

                if (enlace.descripcion) {
                    informacion.appendChild(
                        crearElemento(
                            "p",
                            "enlace-card-description",
                            enlace.descripcion
                        )
                    );
                }

                const acciones = crearElemento(
                    "div",
                    "enlace-card-actions"
                );

                const botonAbrir = crearElemento(
                    "a",
                    "btn btn-small",
                    "↗ Abrir"
                );

                botonAbrir.href = enlace.url;
                botonAbrir.target = "_blank";
                botonAbrir.rel = "noopener noreferrer";

                acciones.appendChild(botonAbrir);

                const botonEliminar = crearElemento(
                    "button",
                    "btn btn-small btn-danger admin-only",
                    "Eliminar"
                );

                botonEliminar.type = "button";
                botonEliminar.hidden = !administrador;

                botonEliminar.addEventListener("click", () => {
                    const confirmar = window.confirm(
                        "¿Deseas eliminar este enlace?"
                    );

                    if (!confirmar) {
                        return;
                    }

                    const actualizados = leerEnlaces(clave).filter(
                        elemento => elemento.id !== enlace.id
                    );

                    if (!guardarEnlaces(clave, actualizados)) {
                        alert("No se pudo eliminar el enlace.");
                        return;
                    }

                    renderizar();
                });

                acciones.appendChild(botonEliminar);

                tarjeta.appendChild(informacion);
                tarjeta.appendChild(acciones);

                lista.appendChild(tarjeta);
            });
        }

        formulario.addEventListener("submit", evento => {
            evento.preventDefault();

            const titulo = campoTitulo.value.trim();
            const url = obtenerURLSegura(campoURL.value);
            const descripcion = campoDescripcion.value.trim();

            mensaje.textContent = "";

            if (!titulo) {
                mensaje.textContent = "Escribe el nombre del enlace.";
                campoTitulo.focus();
                return;
            }

            if (!url) {
                mensaje.textContent =
                    "Ingresa una URL válida con http:// o https://.";

                campoURL.focus();
                return;
            }

            const enlaces = leerEnlaces(clave);

            enlaces.push({
                id: Date.now().toString(36)
                    + Math.random().toString(36).slice(2, 8),
                titulo: titulo,
                url: url,
                descripcion: descripcion
            });

            if (!guardarEnlaces(clave, enlaces)) {
                mensaje.textContent =
                    "No se pudo guardar. Revisa el almacenamiento del navegador.";

                return;
            }

            formulario.reset();

            mensaje.textContent = "Enlace agregado correctamente.";

            renderizar();
        });

        renderizar();

        return renderizar;
    }

    /* =====================================================
       B. OCULTAR INFOGRAFÍAS VACÍAS PARA VISITANTES
       ===================================================== */

    function actualizarInfografias(semanaElemento) {
        const seccion = semanaElemento.querySelector(
            ".infografias-section"
        );

        if (!seccion) {
            return;
        }

        const administrador = esAdministrador(semanaElemento);

        const tarjetas = seccion.querySelectorAll(".info-card");

        let cantidadPublicada = 0;

        tarjetas.forEach(tarjeta => {
            const imagen = tarjeta.querySelector(
                "img[data-thumb-img]"
            );

            const tieneImagen =
                imagen !== null
                && !imagen.hidden
                && Boolean(imagen.getAttribute("src"));

            if (tieneImagen) {
                cantidadPublicada++;
            }

            const ocultarTarjeta =
                !administrador && !tieneImagen;

            if (tarjeta.hidden !== ocultarTarjeta) {
                tarjeta.hidden = ocultarTarjeta;
            }
        });

        /*
         * Los visitantes no necesitan ver la sección si
         * todavía no hay infografías publicadas.
         *
         * El administrador conserva los espacios para subir
         * imágenes nuevas.
         */

        const ocultarSeccion =
            !administrador && cantidadPublicada === 0;

        if (seccion.hidden !== ocultarSeccion) {
            seccion.hidden = ocultarSeccion;
        }
    }

    /* =====================================================
       C. INICIALIZAR TODAS LAS SEMANAS
       ===================================================== */

    function iniciar() {
        document.querySelectorAll(".semana-item").forEach(
            semanaElemento => {
                const renderizarEnlaces =
                    inicializarEnlaces(semanaElemento);

                actualizarInfografias(semanaElemento);

                /*
                 * main.js controla la subida, eliminación y
                 * visibilidad de los archivos.
                 *
                 * Este observador detecta cambios en los
                 * atributos de imágenes y controles admin.
                 * No observa cambios de contenido de la lista
                 * de enlaces para evitar renderizaciones
                 * repetitivas.
                 */

                const observador = new MutationObserver(() => {
                    actualizarInfografias(semanaElemento);

                    if (renderizarEnlaces) {
                        renderizarEnlaces();
                    }
                });

                observador.observe(semanaElemento, {
                    subtree: true,
                    attributes: true,
                    attributeFilter: ["hidden", "src"]
                });

                semanaElemento.querySelectorAll(
                    ".info-card img[data-thumb-img]"
                ).forEach(imagen => {
                    imagen.addEventListener(
                        "load",
                        () => actualizarInfografias(semanaElemento)
                    );

                    imagen.addEventListener(
                        "error",
                        () => actualizarInfografias(semanaElemento)
                    );
                });
            }
        );
    }

    if (document.readyState === "loading") {
        document.addEventListener(
            "DOMContentLoaded",
            iniciar,
            { once: true }
        );
    } else {
        iniciar();
    }
})();
</script>

</body>
</html>
