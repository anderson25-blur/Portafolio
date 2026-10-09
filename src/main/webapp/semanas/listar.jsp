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
        tituloUnidad = "Fundamentos de la Arquitectura de Software y Estándares Internacionales";
        descripcionUnidad = "Conceptos fundamentales, principios, atributos de calidad, estilos, patrones y documentación de la arquitectura de software.";
        break;
    case 2:
        tituloUnidad = "Modelado de la Arquitectura de Software mediante Programación Orientada a Objetos";
        descripcionUnidad = "Principios de POO, modelado UML, diseño de componentes, capas y validación del modelo arquitectónico.";
        break;
    case 3:
        tituloUnidad = "Comunicación e Integración de Arquitecturas de Software";
        descripcionUnidad = "Comunicación entre componentes, integración de sistemas, APIs, servicios web, interfaces y transmisión de datos.";
        break;
    case 4:
        tituloUnidad = "Frameworks y Estándares para la Implementación de Arquitecturas de Software";
        descripcionUnidad = "Frameworks, estándares, buenas prácticas, implementación, evaluación y optimización de arquitecturas de software.";
        break;
}

String[] titulosSemana = {
    "",
    "Introducción a la Arquitectura de Software",
    "Principios, Atributos de Calidad y Estándares Internacionales",
    "Estilos y Patrones Arquitectónicos",
    "Documentación y Representación Arquitectónica",
    "Principios de POO aplicados a la Arquitectura",
    "Modelado Arquitectónico con UML",
    "Diseño de Componentes y Capas de la Arquitectura",
    "Elaboración y Validación del Modelo Arquitectónico",
    "Fundamentos de la Comunicación entre Arquitecturas",
    "Métodos y Tecnologías para la Integración de Sistemas",
    "Diseño de Interfaces y Transmisión de Datos",
    "Implementación y Validación de la Comunicación Arquitectónica",
    "Fundamentos de Frameworks de Arquitectura de Software",
    "Normas y Buenas Prácticas en Arquitectura de Software",
    "Implementación de la Arquitectura utilizando Frameworks",
    "Evaluación y Optimización de la Arquitectura de Software"
};

String[] descripcionesSemana = {
    "",
    "Conceptos, objetivos e importancia de la arquitectura de software.",
    "Calidad y sostenibilidad del proyecto según estándares internacionales.",
    "Comparación de estilos y selección del patrón más adecuado.",
    "Modelos, diagramas y buenas prácticas de documentación.",
    "Abstracción, encapsulamiento, herencia y polimorfismo.",
    "Diagramas de casos de uso, clases y paquetes.",
    "Responsabilidades, cohesión y bajo acoplamiento.",
    "Artefactos de modelado y sustento técnico de las decisiones.",
    "Mecanismos, protocolos y flujos de información entre componentes.",
    "Servicios web, APIs y mensajería para integrar aplicaciones.",
    "Interoperabilidad y modelado de servicios entre componentes.",
    "Pruebas de integridad, disponibilidad y eficiencia de la integración.",
    "Características, ventajas y ámbitos de aplicación de los principales frameworks.",
    "Calidad, interoperabilidad, seguridad y rendimiento del proyecto.",
    "Componentes, patrones de diseño y mecanismos de comunicación.",
    "Métricas de calidad y mejoras finales sobre lo implementado."
};
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="theme-color" content="#0a0f0c">
<title>Unidad <%= unidad %> | MiPortafolio</title>

<style>
* { box-sizing: border-box; }

html { scroll-behavior: smooth; }

body {
    margin: 0;
    min-height: 100vh;
    background:
        radial-gradient(circle at 15% 10%, rgba(147, 213, 0, .08), transparent 30%),
        radial-gradient(circle at 85% 85%, rgba(34, 224, 255, .05), transparent 30%),
        #0a0f0c;
    color: #eaf2ea;
    font-family: "Segoe UI", Arial, sans-serif;
}

[hidden] { display: none !important; }

.page {
    width: 100%;
    max-width: 1250px;
    margin: 0 auto;
    padding: 60px 25px 80px;
}

.section { width: 100%; }

.section-head { margin-bottom: 35px; }

.eyebrow {
    margin: 0 0 12px;
    color: #93d500;
    font-size: 12px;
    font-weight: 900;
    letter-spacing: 3px;
}

.section-head h1 {
    margin: 0 0 15px;
    color: #eaf2ea;
    font-size: clamp(36px, 6vw, 62px);
    line-height: 1.05;
    font-weight: 900;
    text-transform: uppercase;
    letter-spacing: -2px;
}

.unidad-titulo {
    max-width: 950px;
    margin: 0 0 12px;
    color: #b9c4bc;
    font-size: 22px;
    font-weight: 700;
    line-height: 1.4;
}

.unidad-descripcion {
    max-width: 850px;
    margin: 0;
    color: #8b978e;
    font-size: 15px;
    line-height: 1.7;
}

.btn-back {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    margin-top: 22px;
    padding: 11px 18px;
    border: 1px solid #263127;
    border-radius: 8px;
    color: #b9c4bc;
    background: #121812;
    text-decoration: none;
    font-size: 13px;
    font-weight: 800;
    letter-spacing: 1px;
    text-transform: uppercase;
    transition: color .2s ease, border-color .2s ease, background .2s ease, transform .2s ease;
}

.btn-back:hover {
    color: #93d500;
    border-color: #93d500;
    background: #171f18;
    transform: translateX(-3px);
    box-shadow: 0 8px 20px rgba(147, 213, 0, .12);
}

.semanas-lista {
    display: flex;
    flex-direction: column;
    gap: 25px;
}

.semana-item {
    overflow: hidden;
    border: 1px solid #263127;
    border-radius: 16px;
    background: linear-gradient(145deg, #121812, #0d120e);
    box-shadow: 0 15px 40px rgba(0, 0, 0, .30);
    transition: border-color .2s ease, box-shadow .2s ease;
}

.semana-item:hover {
    border-color: #344334;
    box-shadow: 0 18px 45px rgba(0, 0, 0, .40);
}

.semana-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    padding: 22px 25px;
    border-bottom: 1px solid #263127;
    background: rgba(23, 31, 24, .75);
}

.semana-header-info { min-width: 0; }

.semana-numero {
    display: block;
    margin-bottom: 6px;
    color: #93d500;
    font-size: 12px;
    font-weight: 900;
    letter-spacing: 2px;
}

.semana-header h2 {
    margin: 0;
    color: #eaf2ea;
    font-size: 25px;
    font-weight: 900;
    line-height: 1.25;
    text-transform: uppercase;
}

.semana-descripcion {
    padding: 20px 25px;
    border-bottom: 1px solid #263127;
    color: #8b978e;
    font-size: 14px;
    line-height: 1.7;
}

.material-section { padding: 25px; }
.material-section + .material-section { border-top: 1px solid #263127; }

.material-header {
    display: flex;
    align-items: center;
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
    width: 42px;
    height: 42px;
    flex: 0 0 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #93d500;
    border-radius: 10px;
    color: #93d500;
    background: rgba(147, 213, 0, .08);
    font-size: 18px;
}

.material-header h3 {
    margin: 0;
    color: #eaf2ea;
    font-size: 18px;
    font-weight: 900;
    text-transform: uppercase;
}

.material-header p {
    margin: 4px 0 0;
    color: #8b978e;
    font-size: 13px;
    line-height: 1.5;
}

.archivo-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    padding: 18px;
    border: 1px solid #263127;
    border-radius: 12px;
    background: #171f18;
}

.archivo-info { min-width: 0; }

.archivo-status {
    color: #8b978e;
    font-size: 14px;
    line-height: 1.5;
    overflow-wrap: anywhere;
}

.archivo-status.is-uploaded { color: #93d500; font-weight: 700; }

.archivo-actions, .info-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
}

.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    padding: 9px 13px;
    border: 1px solid #263127;
    border-radius: 7px;
    color: #b9c4bc;
    background: #0a0f0c;
    cursor: pointer;
    text-decoration: none;
    font-family: inherit;
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    transition: color .2s ease, border-color .2s ease, background .2s ease, transform .2s ease;
}

.btn:hover {
    color: #93d500;
    border-color: #93d500;
    background: #121812;
    transform: translateY(-1px);
}

.btn-small { padding: 8px 11px; font-size: 11px; }

.btn-danger:hover { color: #ff4630; border-color: #ff4630; }

.admin-only { margin-left: auto; }
.admin-only[hidden] { display: none !important; }

.admin-only input[type="file"] { display: none; }
.admin-only label, label.btn { cursor: pointer; }

.info-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 15px;
}

.info-card {
    min-width: 0;
    overflow: hidden;
    border: 1px solid #263127;
    border-radius: 12px;
    background: #171f18;
    transition: border-color .2s ease, transform .2s ease;
}

.info-card:hover {
    border-color: #4c6e12;
    transform: translateY(-3px);
}

.info-preview {
    position: relative;
    min-height: 170px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    background: #0a0f0c;
    border-bottom: 1px solid #263127;
}

.info-preview img {
    width: 100%;
    height: 170px;
    display: block;
    object-fit: cover;
}

.info-preview [data-empty-text] {
    padding: 20px;
    color: #59645c;
    text-align: center;
    font-size: 13px;
}

.info-card-footer { padding: 15px; }

.info-card-footer > span {
    display: block;
    margin-bottom: 10px;
    color: #eaf2ea;
    font-size: 14px;
    font-weight: 800;
}

.info-actions { margin-top: 10px; }

#archivoViewer {
    position: fixed;
    inset: 0;
    z-index: 9999;
    display: none;
    align-items: center;
    justify-content: center;
    padding: 25px;
    background: rgba(0, 0, 0, .88);
}

#archivoViewer[aria-hidden="false"]:not([hidden]) { display: flex; }

.archivo-viewer-overlay { position: absolute; inset: 0; }

.archivo-viewer-panel {
    position: relative;
    z-index: 2;
    width: min(1200px, 95vw);
    height: min(90vh, 900px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 50px 20px 20px;
    border: 1px solid #263127;
    border-radius: 14px;
    background: #0d120e;
    box-shadow: 0 25px 80px rgba(0, 0, 0, .60);
}

.archivo-viewer-content {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
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
    background: #fff;
}

.archivo-viewer-close {
    position: absolute;
    top: 12px;
    right: 15px;
    z-index: 3;
    width: 38px;
    height: 38px;
    border: 1px solid #263127;
    border-radius: 8px;
    color: #b9c4bc;
    background: #121812;
    cursor: pointer;
    font-size: 25px;
    line-height: 1;
}

.archivo-viewer-close:hover { color: #ff4630; border-color: #ff4630; background: #171f18; }
body.viewer-open { overflow: hidden; }

/* Estilos disponibles para el zoom, si main.js los utiliza. */
.zoom-stage {
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    touch-action: none;
    cursor: zoom-in;
}

.zoom-stage.is-zoomed { cursor: grab; }
.zoom-stage.is-dragging { cursor: grabbing; }

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
    border: 1px solid #263127;
    border-radius: 10px;
    background: rgba(18, 24, 18, .92);
}

.zoom-toolbar button {
    min-width: 36px;
    height: 34px;
    padding: 0 10px;
    border: 1px solid #263127;
    border-radius: 7px;
    color: #b9c4bc;
    background: #0a0f0c;
    cursor: pointer;
    font-size: 15px;
    font-weight: 800;
}

.zoom-toolbar button:hover { color: #93d500; border-color: #93d500; }

.zoom-toolbar .zoom-level {
    display: flex;
    align-items: center;
    min-width: 48px;
    justify-content: center;
    color: #8b978e;
    font-size: 12px;
    font-weight: 800;
}

@media (max-width: 950px) {
    .info-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}

@media (max-width: 700px) {
    .page { padding: 40px 15px 60px; }
    .semana-header { padding: 20px; }
    .semana-header h2 { font-size: 21px; }
    .material-section { padding: 20px; }
    .archivo-item { flex-direction: column; align-items: flex-start; }
    .admin-only { margin-left: 0; }
    .info-grid { grid-template-columns: 1fr; }
    .archivo-viewer-panel { width: 100%; height: 88vh; padding: 50px 12px 12px; }
}

@media (max-width: 480px) {
    .section-head h1 { font-size: 38px; }
    .unidad-titulo { font-size: 18px; }
    .material-header { align-items: flex-start; }
    .material-header > div:first-child { align-items: flex-start; }
    .semana-header h2 { font-size: 18px; }
}
</style>
</head>

<body>
<main class="page">
<section class="section">

<header class="section-head">
    <p class="eyebrow">ARQUITECTURA DE SOFTWARE</p>
    <h1>Unidad <%= unidad %></h1>
    <p class="unidad-titulo"><%= tituloUnidad %></p>
    <p class="unidad-descripcion"><%= descripcionUnidad %></p>
    <a class="btn-back" href="../unidades/listar.jsp">← Volver a unidades</a>
</header>

<div class="semanas-lista">
<% for (int semana = semanaInicio; semana <= semanaFin; semana++) {
   String tituloSemana = titulosSemana[semana];
   String descripcionSemana = descripcionesSemana[semana];
   int cantidadInfografias = 4;
%>
<article class="semana-item" data-unidad="<%= unidad %>" data-semana="<%= semana %>">

    <div class="semana-header">
        <div class="semana-header-info">
            <span class="semana-numero">SEMANA <%= String.format("%02d", semana) %></span>
            <h2><%= tituloSemana %></h2>
        </div>
    </div>

    <div class="semana-descripcion"><%= descripcionSemana %></div>

    <section class="material-section trabajo-section" hidden>
        <div class="material-header">
            <div>
                <span class="material-icon" aria-hidden="true">📚</span>
                <div>
                    <h3>Trabajos</h3>
                    <p>Documento PDF de la semana.</p>
                </div>
            </div>

            <label class="btn btn-small admin-only" hidden>
                + Subir PDF
                <input type="file" hidden accept=".pdf,application/pdf" data-upload-input>
            </label>
        </div>

        <div class="archivo-item">
            <div class="archivo-info">
                <span class="archivo-status" data-status>Sin trabajo</span>
            </div>
            <div class="archivo-actions">
                <a class="btn btn-small" data-view target="_blank" rel="noopener noreferrer" hidden>👁 Ver</a>
                <a class="btn btn-small" data-download hidden>↓ Descargar</a>
                <button type="button" class="btn btn-small btn-danger admin-only" data-delete hidden>Eliminar</button>
            </div>
        </div>
    </section>

    <section class="material-section infografias-section">
        <div class="material-header">
            <div>
                <span class="material-icon" aria-hidden="true">🖼️</span>
                <div>
                    <h3>Infografías</h3>
                    <p>Imágenes JPG, JPEG o PNG de la semana.</p>
                </div>
            </div>
        </div>

        <div class="info-grid" data-info-grid>
        <% for (int slot = 1; slot <= cantidadInfografias; slot++) { %>
            <article class="info-card"
                     data-unidad="<%= unidad %>"
                     data-semana="<%= semana %>"
                     data-slot="<%= slot %>">
                <div class="info-preview">
                    <img data-thumb-img alt="Vista previa de infografía <%= slot %>" hidden>
                    <span data-empty-text>Sin infografía</span>
                </div>

                <div class="info-card-footer">
                    <span>Infografía <%= slot %></span>
                    <div class="info-actions">
                        <label class="btn btn-small admin-only" hidden>
                            + Subir
                            <input type="file" hidden accept=".jpg,.jpeg,.png,image/jpeg,image/png" data-upload-input>
                        </label>
                        <a class="btn btn-small" data-view target="_blank" rel="noopener noreferrer" hidden>👁 Ver</a>
                        <a class="btn btn-small" data-download hidden>↓ Descargar</a>
                        <button type="button" class="btn btn-small btn-danger admin-only" data-delete hidden aria-label="Eliminar infografía <%= slot %>">×</button>
                    </div>
                </div>
            </article>
        <% } %>
        </div>
    </section>
</article>
<% } %>
</div>
</section>
</main>

<div id="archivoViewer" class="archivo-viewer" hidden aria-hidden="true">
    <div class="archivo-viewer-overlay" data-viewer-overlay></div>
    <div class="archivo-viewer-panel" role="dialog" aria-modal="true" aria-label="Visualizador de archivo">
        <button type="button" id="archivoViewerClose" class="archivo-viewer-close" aria-label="Cerrar visor">×</button>
        <div id="archivoViewerContent" class="archivo-viewer-content"></div>
    </div>
</div>

<script src="../js/main.js?v=4"></script>
</body>
</html>
