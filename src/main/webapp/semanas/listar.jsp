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
<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        min-height: 100vh;
        background:
            radial-gradient(circle at 15% 10%, rgba(147,213,0,.08), transparent 30%),
            radial-gradient(circle at 85% 85%, rgba(34,224,255,.05), transparent 30%),
            #0a0f0c;
        color: #eaf2ea;
        font-family: "Segoe UI", Arial, sans-serif;
    }

    .page {
        width: 100%;
        max-width: 1250px;
        margin: auto;
        padding: 65px 25px;
    }

    .section {
        width: 100%;
    }

    .section-head {
        margin-bottom: 35px;
    }

    .eyebrow {
        color: #93d500;
        font-size: 12px;
        font-weight: 900;
        letter-spacing: 3px;
        margin-bottom: 12px;
    }

    .section-head h1 {
        margin: 0 0 15px;
        font-size: clamp(38px, 6vw, 62px);
        text-transform: uppercase;
        letter-spacing: -2px;
    }

    .section-head p {
        color: #8b978e;
        line-height: 1.7;
    }

    .section-head .btn-back {
        display: inline-flex;
        margin-top: 20px;
        padding: 10px 16px;
        border: 1px solid #263127;
        border-radius: 8px;
        color: #b9c4bc;
        background: #121812;
        text-decoration: none;
        font-weight: 700;
        transition: .2s;
    }

    .section-head .btn-back:hover {
        color: #93d500;
        border-color: #93d500;
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
        box-shadow: 0 15px 40px rgba(0,0,0,.3);
    }

    .semana-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 20px;
        padding: 22px 25px;
        border-bottom: 1px solid #263127;
        background: rgba(23,31,24,.7);
    }

    .semana-header h2 {
        margin: 0;
        color: #eaf2ea;
        font-size: 25px;
        text-transform: uppercase;
    }

    .semana-header span {
        color: #93d500;
        font-size: 12px;
        font-weight: 900;
        letter-spacing: 2px;
    }

    .material-section {
        padding: 25px;
    }

    .material-section + .material-section {
        border-top: 1px solid #263127;
    }

    .material-header {
        display: flex;
        align-items: center;
        gap: 14px;
        margin-bottom: 20px;
    }

    .material-icon {
        width: 42px;
        height: 42px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #93d500;
        border-radius: 10px;
        color: #93d500;
        font-weight: 900;
        background: rgba(147,213,0,.08);
    }

    .material-header h3 {
        margin: 0;
        color: #eaf2ea;
        text-transform: uppercase;
        font-size: 18px;
    }

    .material-header p {
        margin: 4px 0 0;
        color: #8b978e;
        font-size: 13px;
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

    .archivo-info {
        min-width: 0;
    }

    .archivo-status {
        color: #8b978e;
        font-size: 14px;
    }

    .archivo-actions,
    .info-actions {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .archivo-actions button,
    .info-actions button,
    .archivo-actions a,
    .info-actions a {
        padding: 9px 13px;
        border: 1px solid #263127;
        border-radius: 7px;
        color: #b9c4bc;
        background: #0a0f0c;
        cursor: pointer;
        text-decoration: none;
        font-size: 12px;
        font-weight: 800;
        text-transform: uppercase;
        transition: .2s;
    }

    .archivo-actions button:hover,
    .info-actions button:hover,
    .archivo-actions a:hover,
    .info-actions a:hover {
        color: #93d500;
        border-color: #93d500;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 15px;
    }

    .info-card {
        overflow: hidden;
        border: 1px solid #263127;
        border-radius: 12px;
        background: #171f18;
        transition: .2s;
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

    .info-card-footer {
        padding: 15px;
    }

    .info-card-footer h4 {
        margin: 0 0 10px;
        color: #eaf2ea;
        font-size: 14px;
    }

    .info-actions {
        margin-top: 10px;
    }

    .admin-only {
        margin-left: auto;
    }

    .admin-only input[type="file"] {
        display: none;
    }

    .admin-only label {
        display: inline-flex;
        align-items: center;
        padding: 9px 13px;
        border: 1px solid #93d500;
        border-radius: 7px;
        color: #93d500;
        background: rgba(147,213,0,.06);
        cursor: pointer;
        font-size: 12px;
        font-weight: 900;
        text-transform: uppercase;
    }

    .admin-only label:hover {
        background: rgba(147,213,0,.14);
    }

    [data-delete] {
        display: none;
    }

    #archivoViewer {
        position: fixed;
        inset: 0;
        z-index: 9999;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 25px;
        background: rgba(0,0,0,.88);
    }

    #archivoViewer.open {
        display: flex;
    }

    #archivoViewer iframe,
    #archivoViewer img {
        max-width: 95vw;
        max-height: 90vh;
        border: 1px solid #263127;
        border-radius: 10px;
        background: #0a0f0c;
    }

    @media (max-width: 950px) {
        .info-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 650px) {
        .page {
            padding: 40px 15px;
        }

        .semana-header,
        .archivo-item {
            flex-direction: column;
            align-items: flex-start;
        }

        .admin-only {
            margin-left: 0;
        }

        .info-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
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
