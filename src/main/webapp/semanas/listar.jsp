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
%>

<!DOCTYPE html>

<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        Unidad <%= unidad %> | MiPortafolio
    </title>

    <link
        rel="stylesheet"
        href="../css/style.css">

</head>

<body>

<main class="page">

<section class="section">

    <!-- =====================================================
         ENCABEZADO
         ===================================================== -->

    <div class="section-head">

        <div>

            <p class="eyebrow">
                ARQUITECTURA DE SOFTWARE
            </p>

            <h1>
                Unidad <%= unidad %>
            </h1>

            <p>
                Semanas, trabajos e infografías de la unidad.
            </p>

        </div>

        <a
            class="btn"
            href="../unidades/listar.jsp">

            ← Unidades

        </a>

    </div>


    <!-- =====================================================
         SEMANAS
         ===================================================== -->

    <div class="semanas-lista">

        <% for (int semana = 1; semana <= 4; semana++) { %>

            <article
                class="semana-item"
                data-unidad="<%= unidad %>"
                data-semana="<%= semana %>">


                <!-- =================================================
                     CABECERA DE SEMANA
                     ================================================= -->

                <div class="semana-header">

                    <div>

                        <span class="unidad-label">
                            UNIDAD <%= unidad %>
                        </span>

                        <h2>
                            Semana <%= semana %>
                        </h2>

                    </div>

                </div>


                <!-- =================================================
                     TRABAJOS
                     ================================================= -->

                <section class="material-section trabajo-section">

                    <div class="material-header">

                        <div>

                            <span class="material-icon">
                                📚
                            </span>

                            <div>

                                <h3>
                                    Trabajos
                                </h3>

                                <p>
                                    Documento PDF de la semana.
                                </p>

                            </div>

                        </div>


                        <!-- SUBIR TRABAJO -->

                        <label
                            class="btn semana-btn-upload admin-only"
                            hidden>

                            + Subir PDF

                            <input
                                type="file"
                                hidden
                                accept=".pdf,application/pdf"
                                data-upload-input>

                        </label>

                    </div>


                    <!-- =================================================
                         ESTADO DEL TRABAJO
                         ================================================= -->

                    <div class="archivo-item">

                        <div class="archivo-info">

                            <span
                                class="archivo-status"
                                data-status>

                                Sin trabajo

                            </span>

                        </div>


                        <div class="archivo-actions">

                            <!-- VER -->

                            <a
                                class="btn btn-small"
                                data-view
                                target="_blank"
                                rel="noopener"
                                hidden>

                                👁 Ver

                            </a>


                            <!-- DESCARGAR -->

                            <a
                                class="btn btn-small"
                                data-download
                                hidden>

                                ↓ Descargar

                            </a>


                            <!-- ELIMINAR -->

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


                <!-- =================================================
                     INFOGRAFÍAS
                     ================================================= -->

                <section class="material-section infografias-section">

                    <div class="material-header">

                        <div>

                            <span class="material-icon">
                                🖼️
                            </span>

                            <div>

                                <h3>
                                    Infografías
                                </h3>

                                <p>
                                    Imágenes JPG, JPEG o PNG de la semana.
                                </p>

                            </div>

                        </div>

                    </div>


                    <!-- =================================================
                         GRID DE INFOGRAFÍAS
                         ================================================= -->

                    <div
                        class="info-grid"
                        data-info-grid>


                        <!-- =================================================
                             INFOGRAFÍA 1
                             ================================================= -->

                        <article
                            class="info-card"
                            data-unidad="<%= unidad %>"
                            data-semana="<%= semana %>"
                            data-slot="1">

                            <div class="info-preview">

                                <img
                                    data-thumb-img
                                    alt="Infografía 1"
                                    hidden>

                                <span data-empty-text>
                                    Sin infografía
                                </span>

                            </div>


                            <div class="info-card-footer">

                                <span>
                                    Infografía 1
                                </span>


                                <div class="info-actions">

                                    <label
                                        class="btn btn-small admin-only"
                                        hidden>

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

                                        ↓

                                    </a>


                                    <button
                                        type="button"
                                        class="btn btn-small btn-danger admin-only"
                                        data-delete
                                        hidden>

                                        ×

                                    </button>

                                </div>

                            </div>

                        </article>


                        <!-- =================================================
                             INFOGRAFÍA 2
                             ================================================= -->

                        <article
                            class="info-card"
                            data-unidad="<%= unidad %>"
                            data-semana="<%= semana %>"
                            data-slot="2">

                            <div class="info-preview">

                                <img
                                    data-thumb-img
                                    alt="Infografía 2"
                                    hidden>

                                <span data-empty-text>
                                    Sin infografía
                                </span>

                            </div>


                            <div class="info-card-footer">

                                <span>
                                    Infografía 2
                                </span>


                                <div class="info-actions">

                                    <label
                                        class="btn btn-small admin-only"
                                        hidden>

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

                                        ↓

                                    </a>


                                    <button
                                        type="button"
                                        class="btn btn-small btn-danger admin-only"
                                        data-delete
                                        hidden>

                                        ×

                                    </button>

                                </div>

                            </div>

                        </article>


                        <!-- =================================================
                             INFOGRAFÍA 3
                             ================================================= -->

                        <article
                            class="info-card"
                            data-unidad="<%= unidad %>"
                            data-semana="<%= semana %>"
                            data-slot="3">

                            <div class="info-preview">

                                <img
                                    data-thumb-img
                                    alt="Infografía 3"
                                    hidden>

                                <span data-empty-text>
                                    Sin infografía
                                </span>

                            </div>


                            <div class="info-card-footer">

                                <span>
                                    Infografía 3
                                </span>


                                <div class="info-actions">

                                    <label
                                        class="btn btn-small admin-only"
                                        hidden>

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

                                        ↓

                                    </a>


                                    <button
                                        type="button"
                                        class="btn btn-small btn-danger admin-only"
                                        data-delete
                                        hidden>

                                        ×

                                    </button>

                                </div>

                            </div>

                        </article>


                        <!-- =================================================
                             INFOGRAFÍA 4
                             ================================================= -->

                        <article
                            class="info-card"
                            data-unidad="<%= unidad %>"
                            data-semana="<%= semana %>"
                            data-slot="4">

                            <div class="info-preview">

                                <img
                                    data-thumb-img
                                    alt="Infografía 4"
                                    hidden>

                                <span data-empty-text>
                                    Sin infografía
                                </span>

                            </div>


                            <div class="info-card-footer">

                                <span>
                                    Infografía 4
                                </span>


                                <div class="info-actions">

                                    <label
                                        class="btn btn-small admin-only"
                                        hidden>

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

                                        ↓

                                    </a>


                                    <button
                                        type="button"
                                        class="btn btn-small btn-danger admin-only"
                                        data-delete
                                        hidden>

                                        ×

                                    </button>

                                </div>

                            </div>

                        </article>


                    </div>

                </section>

            </article>

        <% } %>

    </div>

</section>

</main>


<!-- =============================================================
     VISOR DE ARCHIVOS
     ============================================================= -->

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
            class="archivo-viewer-close">

            ×

        </button>


        <div
            id="archivoViewerContent"
            class="archivo-viewer-content">
        </div>

    </div>

</div>


<script src="../js/main.js"></script>

</body>

</html>
