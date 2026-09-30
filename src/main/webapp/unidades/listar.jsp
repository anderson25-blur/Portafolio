<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Unidades | MiPortafolio</title>

    <style>
        :root {
            --bg: #070907;
            --bg-soft: #0d110e;
            --panel: #111611;
            --panel-hover: #171d17;
            --border: #263127;
            --text: #f1f5f1;
            --muted: #9da89f;
            --green: #93d500;
            --green-soft: rgba(147, 213, 0, .12);
            --red: #ff4630;
            --steel: #6f7972;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            color: var(--text);

            background:
                radial-gradient(
                    circle at 15% 10%,
                    rgba(147, 213, 0, .07),
                    transparent 28%
                ),
                radial-gradient(
                    circle at 85% 80%,
                    rgba(255, 70, 48, .045),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #060806 0%,
                    #0a0d0a 50%,
                    #070907 100%
                );

            overflow-x: hidden;
        }

        body::before {
            content: "";
            position: fixed;
            inset: 0;
            pointer-events: none;
            opacity: .035;

            background-image:
                linear-gradient(
                    rgba(255,255,255,.08) 1px,
                    transparent 1px
                ),
                linear-gradient(
                    90deg,
                    rgba(255,255,255,.08) 1px,
                    transparent 1px
                );

            background-size: 45px 45px;
        }

        .page {
            width: min(1180px, calc(100% - 40px));
            margin: 0 auto;
            padding: 70px 0 90px;
            position: relative;
            z-index: 1;
        }

        .section {
            width: 100%;
        }

        /* =========================
           ENCABEZADO
           ========================= */

        .section-head {
            margin-bottom: 42px;
            max-width: 900px;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 10px;

            margin-bottom: 14px;

            color: var(--green);
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 2.5px;
            text-transform: uppercase;
        }

        .eyebrow::before {
            content: "";
            width: 28px;
            height: 2px;
            background: var(--green);
            box-shadow: 0 0 10px rgba(147, 213, 0, .5);
        }

        .section-head h1 {
            margin-bottom: 12px;

            font-size: clamp(38px, 6vw, 64px);
            line-height: .95;
            font-weight: 900;
            letter-spacing: -2px;
            text-transform: uppercase;
        }

        .section-head > p:not(.eyebrow) {
            max-width: 720px;

            color: var(--muted);
            font-size: 16px;
            line-height: 1.7;
        }

        /* =========================
           BOTÓN VOLVER
           ========================= */

        .btn-back {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;

            margin-top: 24px;
            padding: 11px 18px;

            border: 1px solid var(--border);
            border-radius: 8px;

            color: #b9c4bc;
            background: #121812;

            text-decoration: none;

            font-size: 13px;
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;

            transition: all .2s ease;
        }

        .btn-back:hover {
            color: var(--green);
            border-color: var(--green);
            background: #171f18;

            transform: translateX(-3px);

            box-shadow:
                0 8px 20px rgba(147, 213, 0, .12);
        }

        /* =========================
           GRID DE UNIDADES
           ========================= */

        .unidad-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 20px;
        }

        .unidad-card {
            position: relative;
            display: block;

            min-height: 250px;
            padding: 30px;

            overflow: hidden;

            border: 1px solid var(--border);
            border-radius: 14px;

            color: var(--text);
            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.025),
                    rgba(255,255,255,.005)
                ),
                var(--panel);

            text-decoration: none;

            transition:
                transform .25s ease,
                border-color .25s ease,
                background .25s ease,
                box-shadow .25s ease;
        }

        .unidad-card::before {
            content: "";

            position: absolute;
            left: 0;
            top: 0;

            width: 4px;
            height: 100%;

            background: var(--green);

            transform: scaleY(0);
            transform-origin: top;

            transition: transform .25s ease;
        }

        .unidad-card::after {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            right: -80px;
            bottom: -90px;

            border: 1px solid rgba(147, 213, 0, .08);
            border-radius: 50%;

            transition: transform .3s ease;
        }

        .unidad-card:hover {
            transform: translateY(-6px);

            border-color: rgba(147, 213, 0, .55);

            background:
                linear-gradient(
                    145deg,
                    rgba(147, 213, 0, .055),
                    rgba(255,255,255,.01)
                ),
                var(--panel-hover);

            box-shadow:
                0 18px 45px rgba(0,0,0,.35),
                0 0 25px rgba(147, 213, 0, .06);
        }

        .unidad-card:hover::before {
            transform: scaleY(1);
        }

        .unidad-card:hover::after {
            transform: scale(1.2);
        }

        /* =========================
           NUMERO
           ========================= */

        .unidad-numero {
            position: relative;
            z-index: 1;

            margin-bottom: 22px;

            color: var(--green);

            font-size: 14px;
            font-weight: 900;
            letter-spacing: 2px;
        }

        .unidad-numero span {
            color: var(--steel);
            margin-left: 5px;
        }

        /* =========================
           TITULO
           ========================= */

        .unidad-card h2 {
            position: relative;
            z-index: 1;

            max-width: 600px;

            margin-bottom: 14px;

            font-size: 25px;
            line-height: 1.15;
            font-weight: 900;

            text-transform: uppercase;
            letter-spacing: -.4px;
        }

        .unidad-card p {
            position: relative;
            z-index: 1;

            max-width: 570px;

            color: var(--muted);

            font-size: 14px;
            line-height: 1.65;
        }

        /* =========================
           INDICADOR
           ========================= */

        .unidad-link {
            position: relative;
            z-index: 1;

            display: inline-flex;
            align-items: center;
            gap: 9px;

            margin-top: 24px;

            color: #cbd3cd;

            font-size: 12px;
            font-weight: 900;
            letter-spacing: 1.4px;
            text-transform: uppercase;

            transition: color .2s ease;
        }

        .unidad-link span {
            color: var(--green);
            font-size: 17px;

            transition: transform .2s ease;
        }

        .unidad-card:hover .unidad-link {
            color: var(--green);
        }

        .unidad-card:hover .unidad-link span {
            transform: translateX(5px);
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 800px) {

            .page {
                width: min(100% - 28px, 700px);
                padding-top: 45px;
            }

            .unidad-grid {
                grid-template-columns: 1fr;
            }

            .unidad-card {
                min-height: 220px;
                padding: 25px;
            }

            .section-head h1 {
                font-size: 44px;
            }
        }

        @media (max-width: 480px) {

            .page {
                width: calc(100% - 22px);
                padding: 35px 0 60px;
            }

            .section-head {
                margin-bottom: 30px;
            }

            .section-head h1 {
                font-size: 38px;
                letter-spacing: -1.5px;
            }

            .section-head > p:not(.eyebrow) {
                font-size: 14px;
            }

            .unidad-card {
                min-height: 210px;
                padding: 22px;
                border-radius: 11px;
            }

            .unidad-card h2 {
                font-size: 21px;
            }
        }
    </style>
</head>

<body>

<main class="page">

    <section class="section">

        <div class="section-head">

            <p class="eyebrow">
                ARQUITECTURA DE SOFTWARE
            </p>

            <h1>
                Unidades
            </h1>

            <p>
                Selecciona una unidad para consultar sus semanas,
                trabajos e infografías correspondientes al curso.
            </p>

            <a href="../index.jsp" class="btn-back">
                ← Volver al inicio
            </a>

        </div>


        <div class="unidad-grid">

            <!-- =========================
                 UNIDAD 01
                 ========================= -->

            <a
                href="../semanas/listar.jsp?unidad=1"
                class="unidad-card"
            >

                <div class="unidad-numero">
                    01 <span>/ UNIDAD</span>
                </div>

                <h2>
                    Fundamentos
                </h2>

                <p>
                    Fundamentos de la Arquitectura de Software
                    y Estándares Internacionales.
                </p>

                <div class="unidad-link">
                    Ver semanas
                    <span>→</span>
                </div>

            </a>


            <!-- =========================
                 UNIDAD 02
                 ========================= -->

            <a
                href="../semanas/listar.jsp?unidad=2"
                class="unidad-card"
            >

                <div class="unidad-numero">
                    02 <span>/ UNIDAD</span>
                </div>

                <h2>
                    Modelado
                </h2>

                <p>
                    Modelado de la Arquitectura de Software
                    mediante Programación Orientada a Objetos.
                </p>

                <div class="unidad-link">
                    Ver semanas
                    <span>→</span>
                </div>

            </a>


            <!-- =========================
                 UNIDAD 03
                 ========================= -->

            <a
                href="../semanas/listar.jsp?unidad=3"
                class="unidad-card"
            >

                <div class="unidad-numero">
                    03 <span>/ UNIDAD</span>
                </div>

                <h2>
                    Comunicación e Integración
                </h2>

                <p>
                    Comunicación e Integración de Arquitecturas
                    de Software.
                </p>

                <div class="unidad-link">
                    Ver semanas
                    <span>→</span>
                </div>

            </a>


            <!-- =========================
                 UNIDAD 04
                 ========================= -->

            <a
                href="../semanas/listar.jsp?unidad=4"
                class="unidad-card"
            >

                <div class="unidad-numero">
                    04 <span>/ UNIDAD</span>
                </div>

                <h2>
                    Frameworks e Implementación
                </h2>

                <p>
                    Frameworks y Estándares para la Implementación
                    de Arquitecturas de Software.
                </p>

                <div class="unidad-link">
                    Ver semanas
                    <span>→</span>
                </div>

            </a>

        </div>

    </section>

</main>
<script>
    const CONTEXTO = '<%= request.getContextPath() %>';

    async function verificarSesion() {
        try {
            const respuesta = await fetch(CONTEXTO + '/api/sesion', {
                method: 'GET',
                credentials: 'same-origin',
                cache: 'no-store'
            });

            if (!respuesta.ok) {
                return;
            }

            const data = await respuesta.json();

            console.log('Sesión actual:', data);

            // Guardamos el estado para que otras páginas puedan utilizarlo
            window.sesionActual = {
                autenticado: data.autenticado === true,
                esAdmin: data.rol === 'admin',
                email: data.email || null,
                rol: data.rol || null
            };

        } catch (error) {
            console.error('Error al consultar la sesión:', error);

            window.sesionActual = {
                autenticado: false,
                esAdmin: false,
                email: null,
                rol: null
            };
        }
    }

    document.addEventListener('DOMContentLoaded', verificarSesion);
</script>
</body>
</html>
