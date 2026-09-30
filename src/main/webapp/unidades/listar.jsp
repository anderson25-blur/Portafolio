<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

```
<title>Unidades | MiPortafolio</title>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        min-height: 100vh;
        background:
            radial-gradient(circle at 20% 10%, rgba(147, 213, 0, 0.08), transparent 30%),
            radial-gradient(circle at 85% 80%, rgba(34, 224, 255, 0.05), transparent 30%),
            #0a0f0c;
        color: #eaf2ea;
        font-family: "Segoe UI", Arial, sans-serif;
    }

    .page {
        width: 100%;
        max-width: 1250px;
        margin: 0 auto;
        padding: 70px 30px;
    }

    .section {
        width: 100%;
    }

    .section-head {
        margin-bottom: 45px;
    }

    .eyebrow {
        color: #93d500;
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 3px;
        margin-bottom: 12px;
    }

    h1 {
        font-size: clamp(38px, 6vw, 64px);
        line-height: 1;
        margin-bottom: 18px;
        font-weight: 900;
        text-transform: uppercase;
        letter-spacing: -2px;
    }

    .section-head p:not(.eyebrow) {
        color: #8b978e;
        font-size: 17px;
        max-width: 700px;
        line-height: 1.7;
    }

    .unidad-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 24px;
    }

    .unidad-card {
        position: relative;
        min-height: 280px;
        overflow: hidden;
        padding: 32px;
        border: 1px solid #263127;
        border-radius: 18px;
        background:
            linear-gradient(145deg, rgba(23, 31, 24, 0.98), rgba(12, 17, 13, 0.98));
        box-shadow: 0 18px 45px rgba(0, 0, 0, 0.35);
        transition: transform .25s ease, border-color .25s ease, box-shadow .25s ease;
    }

    .unidad-card::before {
        content: "";
        position: absolute;
        width: 180px;
        height: 180px;
        right: -70px;
        top: -70px;
        border-radius: 50%;
        border: 1px solid rgba(147, 213, 0, 0.15);
    }

    .unidad-card::after {
        content: "";
        position: absolute;
        left: 0;
        bottom: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, #93d500, transparent);
        opacity: .7;
    }

    .unidad-card:hover {
        transform: translateY(-7px);
        border-color: #93d500;
        box-shadow: 0 22px 55px rgba(0, 0, 0, 0.5);
    }

    .unidad-number {
        color: #93d500;
        font-size: 54px;
        line-height: 1;
        font-weight: 900;
        opacity: .9;
        margin-bottom: 25px;
        letter-spacing: -3px;
    }

    .unidad-content {
        position: relative;
        z-index: 2;
    }

    .unidad-label {
        display: inline-block;
        color: #8b978e;
        font-size: 12px;
        font-weight: 800;
        letter-spacing: 2px;
        margin-bottom: 8px;
    }

    .unidad-card h2 {
        color: #eaf2ea;
        font-size: 28px;
        margin-bottom: 12px;
        text-transform: uppercase;
    }

    .unidad-card p {
        color: #8b978e;
        line-height: 1.6;
        margin-bottom: 28px;
    }

    .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 12px 20px;
        border: 1px solid #93d500;
        border-radius: 8px;
        color: #0a0f0c;
        background: #93d500;
        text-decoration: none;
        font-weight: 900;
        text-transform: uppercase;
        letter-spacing: 1px;
        font-size: 13px;
        transition: .2s ease;
    }

    .btn:hover {
        background: #b5ef22;
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(147, 213, 0, .2);
    }

    @media (max-width: 800px) {
        .page {
            padding: 45px 18px;
        }

        .unidad-grid {
            grid-template-columns: 1fr;
        }

        .unidad-card {
            min-height: 250px;
        }
    }
</style>
```

</head>

<body>

<main class="page">

```
<section class="section">

    <div class="section-head">
        <p class="eyebrow">ARQUITECTURA DE SOFTWARE</p>

        <h1>Unidades</h1>

        <p>
            Selecciona una unidad para consultar sus semanas,
            trabajos e infografías del curso.
        </p>
    </div>

    <div class="unidad-grid">

        <article class="unidad-card">
            <div class="unidad-number">01</div>

            <div class="unidad-content">
                <span class="unidad-label">UNIDAD 01</span>

                <h2>Fundamentos</h2>

                <p>
                    Conceptos fundamentales de arquitectura de software,
                    principios y bases para el desarrollo de sistemas.
                </p>

                <a class="btn" href="../semanas/listar.jsp?unidad=1">
                    Ver semanas →
                </a>
            </div>
        </article>


        <article class="unidad-card">
            <div class="unidad-number">02</div>

            <div class="unidad-content">
                <span class="unidad-label">UNIDAD 02</span>

                <h2>Modelado</h2>

                <p>
                    Modelado y representación de la arquitectura
                    mediante diferentes vistas y herramientas.
                </p>

                <a class="btn" href="../semanas/listar.jsp?unidad=2">
                    Ver semanas →
                </a>
            </div>
        </article>


        <article class="unidad-card">
            <div class="unidad-number">03</div>

            <div class="unidad-content">
                <span class="unidad-label">UNIDAD 03</span>

                <h2>Diseño</h2>

                <p>
                    Diseño arquitectónico, componentes, patrones
                    y organización de soluciones de software.
                </p>

                <a class="btn" href="../semanas/listar.jsp?unidad=3">
                    Ver semanas →
                </a>
            </div>
        </article>


        <article class="unidad-card">
            <div class="unidad-number">04</div>

            <div class="unidad-content">
                <span class="unidad-label">UNIDAD 04</span>

                <h2>Implementación</h2>

                <p>
                    Aplicación de los conocimientos de arquitectura
                    en el desarrollo y documentación del proyecto.
                </p>

                <a class="btn" href="../semanas/listar.jsp?unidad=4">
                    Ver semanas →
                </a>
            </div>
        </article>

    </div>

</section>
```

</main>

</body>
</html>
