<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#080b08">
    <title>Unidades | MiPortafolio</title>

    <style>
        :root {
            --bg: #080b08;
            --panel: rgba(13, 18, 14, .88);
            --panel-strong: #101710;
            --line: rgba(196, 220, 194, .13);
            --text: #f3f6f1;
            --muted: #a5afa5;
            --green: #93d500;
            --green-bright: #b5ff16;
            --red: #ff4630;
            --steel: #78847a;
            --radius: 18px;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        body {
            min-height: 100vh;
            overflow-x: hidden;
            color: var(--text);
            font-family: "Segoe UI", Arial, sans-serif;
            background: #080b08;
            isolation: isolate;
        }

        body::before {
            content: "";
            position: fixed;
            inset: 0;
            z-index: -2;
            background:
                linear-gradient(90deg, rgba(5,8,5,.96) 0%, rgba(5,8,5,.83) 48%, rgba(5,8,5,.68) 100%),
                linear-gradient(0deg, rgba(5,8,5,.82), rgba(5,8,5,.25)),
                url("../images/moto-circuito-unidad.png") center 42% / cover no-repeat;
            transform: scale(1.015);
        }

        body::after {
            content: "";
            position: fixed;
            inset: 0;
            z-index: -1;
            pointer-events: none;
            opacity: .22;
            background-image:
                linear-gradient(rgba(255,255,255,.045) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,.045) 1px, transparent 1px);
            background-size: 54px 54px;
            mask-image: linear-gradient(to bottom, black, transparent 88%);
        }

        a { color: inherit; }
        .page {
            width: min(1200px, calc(100% - 48px));
            margin: 0 auto;
            padding: 42px 0 86px;
            position: relative;
        }

        .topline {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            padding-bottom: 18px;
            margin-bottom: 76px;
            border-bottom: 1px solid var(--line);
        }
        .brand {
            display: inline-flex;
            align-items: center;
            gap: 11px;
            color: #eaf0e8;
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 2.2px;
            text-transform: uppercase;
        }
        .brand-mark {
            display: grid;
            place-items: center;
            width: 31px;
            height: 31px;
            color: #0a0d08;
            background: var(--green);
            border-radius: 8px 2px 8px 2px;
            font-size: 15px;
            font-weight: 1000;
            box-shadow: 0 0 22px rgba(147,213,0,.2);
        }
        .topline-label {
            color: #9ba69b;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .section-head {
            max-width: 790px;
            margin-bottom: 43px;
        }
        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 11px;
            margin-bottom: 19px;
            color: var(--green);
            font-size: 11px;
            font-weight: 900;
            letter-spacing: 3px;
            text-transform: uppercase;
        }
        .eyebrow::before {
            content: "";
            width: 34px;
            height: 2px;
            background: var(--green);
            box-shadow: 0 0 12px rgba(147,213,0,.7);
        }
        .section-head h1 {
            margin-bottom: 18px;
            font-size: clamp(52px, 8vw, 88px);
            line-height: .88;
            font-weight: 1000;
            letter-spacing: -4px;
            text-transform: uppercase;
            text-shadow: 0 8px 35px rgba(0,0,0,.4);
        }
        .section-head h1 span {
            color: var(--green);
            text-shadow: 0 0 28px rgba(147,213,0,.18);
        }
        .section-head > p:not(.eyebrow) {
            max-width: 620px;
            color: #b4beb4;
            font-size: 15px;
            line-height: 1.8;
        }
        .head-meta {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 24px;
            color: #8f9a90;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 1.8px;
            text-transform: uppercase;
        }
        .head-meta::before {
            content: "";
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: var(--red);
            box-shadow: 0 0 12px rgba(255,70,48,.75);
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-top: 27px;
            padding: 12px 17px;
            border: 1px solid rgba(190,210,190,.2);
            border-radius: 8px;
            color: #dce4db;
            background: rgba(12,17,12,.72);
            text-decoration: none;
            font-size: 11px;
            font-weight: 900;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            transition: .22s ease;
            backdrop-filter: blur(10px);
        }
        .btn-back span { color: var(--green); font-size: 17px; line-height: 10px; }
        .btn-back:hover {
            color: var(--green-bright);
            border-color: rgba(147,213,0,.7);
            background: rgba(147,213,0,.08);
            transform: translateX(-4px);
        }

        .grid-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 17px;
        }
        .grid-heading h2 {
            color: #e8eee6;
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 2.2px;
            text-transform: uppercase;
        }
        .grid-heading span {
            color: #849084;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 1.4px;
        }
        .unidad-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 17px;
        }
        .unidad-card {
            min-height: 252px;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 29px 30px 25px;
            overflow: hidden;
            isolation: isolate;
            border: 1px solid var(--line);
            border-radius: var(--radius);
            color: var(--text);
            background:
                linear-gradient(135deg, rgba(22,31,22,.92), rgba(8,12,9,.9)),
                var(--panel);
            text-decoration: none;
            box-shadow: 0 18px 45px rgba(0,0,0,.2);
            backdrop-filter: blur(13px);
            transition: transform .28s ease, border-color .28s ease, box-shadow .28s ease, background .28s ease;
        }
        .unidad-card::before {
            content: "";
            position: absolute;
            z-index: -1;
            width: 190px;
            height: 190px;
            top: -85px;
            right: -62px;
            border: 1px solid rgba(147,213,0,.17);
            border-radius: 50%;
            box-shadow: 0 0 0 22px rgba(147,213,0,.025), 0 0 0 48px rgba(147,213,0,.018);
            transition: transform .4s ease, border-color .3s ease;
        }
        .unidad-card::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 3px;
            height: 100%;
            background: linear-gradient(var(--green), transparent 85%);
            opacity: .75;
            transition: width .25s ease, opacity .25s ease;
        }
        .card-top {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            margin-bottom: 29px;
        }
        .unidad-numero {
            color: var(--green);
            font-size: 12px;
            font-weight: 1000;
            letter-spacing: 2.5px;
        }
        .unidad-numero span {
            margin-left: 5px;
            color: #829082;
            font-size: 9px;
            letter-spacing: 1.6px;
        }
        .card-index {
            color: rgba(223,235,220,.22);
            font-size: 11px;
            font-weight: 900;
            letter-spacing: 1px;
        }
        .unidad-card h2 {
            max-width: 520px;
            margin-bottom: 11px;
            color: #f0f4ee;
            font-size: clamp(21px, 2.5vw, 27px);
            line-height: 1.08;
            font-weight: 950;
            letter-spacing: -.7px;
            text-transform: uppercase;
        }
        .unidad-card p {
            max-width: 500px;
            color: #a5b0a5;
            font-size: 13px;
            line-height: 1.7;
        }
        .unidad-link {
            display: inline-flex;
            align-items: center;
            gap: 11px;
            margin-top: auto;
            padding-top: 23px;
            color: #d9e2d7;
            font-size: 10px;
            font-weight: 950;
            letter-spacing: 1.8px;
            text-transform: uppercase;
            transition: color .2s ease;
        }
        .unidad-link span {
            display: grid;
            place-items: center;
            width: 25px;
            height: 25px;
            border: 1px solid rgba(147,213,0,.45);
            border-radius: 50%;
            color: var(--green);
            font-size: 15px;
            transition: transform .25s ease, color .25s ease, background .25s ease;
        }
        .unidad-card:hover {
            transform: translateY(-6px);
            border-color: rgba(147,213,0,.52);
            box-shadow: 0 24px 55px rgba(0,0,0,.4), 0 0 28px rgba(147,213,0,.07);
            background: linear-gradient(135deg, rgba(25,37,21,.96), rgba(8,13,9,.94));
        }
        .unidad-card:hover::before { transform: scale(1.18) rotate(12deg); border-color: rgba(147,213,0,.35); }
        .unidad-card:hover::after { width: 5px; opacity: 1; }
        .unidad-card:hover .unidad-link { color: var(--green-bright); }
        .unidad-card:hover .unidad-link span {
            transform: translateX(4px);
            color: #0a0d08;
            background: var(--green);
        }
        .unidad-card:focus-visible, .btn-back:focus-visible {
            outline: 2px solid var(--green-bright);
            outline-offset: 4px;
        }

        .footer-note {
            display: flex;
            justify-content: space-between;
            gap: 16px;
            margin-top: 27px;
            padding-top: 17px;
            border-top: 1px solid var(--line);
            color: #7f8b80;
            font-size: 9px;
            font-weight: 800;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }
        .footer-note strong { color: #a9b4a8; font-weight: 900; }

        @media (max-width: 760px) {
            .page { width: min(100% - 32px, 620px); padding-top: 25px; }
            .topline { margin-bottom: 54px; }
            .topline-label { display: none; }
            .section-head { margin-bottom: 34px; }
            .section-head h1 { letter-spacing: -2.8px; }
            .unidad-grid { grid-template-columns: 1fr; }
            .unidad-card { min-height: 225px; }
            body::before {
                background:
                    linear-gradient(90deg, rgba(5,8,5,.94), rgba(5,8,5,.82)),
                    linear-gradient(0deg, rgba(5,8,5,.75), rgba(5,8,5,.3)),
                    url("../images/moto-circuito-unidad.png") 62% center / cover no-repeat;
            }
        }
        @media (max-width: 480px) {
            .page { width: calc(100% - 24px); padding: 20px 0 55px; }
            .topline { margin-bottom: 43px; }
            .brand { font-size: 10px; letter-spacing: 1.6px; }
            .section-head h1 { font-size: 54px; }
            .section-head > p:not(.eyebrow) { font-size: 13px; }
            .head-meta { font-size: 9px; letter-spacing: 1.2px; }
            .unidad-card { min-height: 220px; padding: 24px 22px 21px; border-radius: 14px; }
            .unidad-card h2 { font-size: 22px; }
            .footer-note { flex-direction: column; gap: 8px; }
            .grid-heading span { font-size: 8px; }
        }
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { scroll-behavior: auto !important; transition-duration: .01ms !important; }
        }
    </style>
</head>

<body>
<main class="page">
    <div class="topline">
        <div class="brand">
            <span class="brand-mark">M</span>
            <span>MiPortafolio</span>
        </div>
        <div class="topline-label">Ingeniería · Arquitectura de software</div>
    </div>

    <section class="section">
        <header class="section-head">
            <p class="eyebrow">Arquitectura de software</p>
            <h1>Mis <span>unidades</span></h1>
            <p>
                Explora el contenido académico organizado por unidades.
                Selecciona una sección para acceder a sus semanas, trabajos e infografías del curso.
            </p>
            <div class="head-meta">Contenido académico · Ciclo de aprendizaje</div>
            <a href="../index.jsp" class="btn-back">
                <span>←</span> Volver al inicio
            </a>
        </header>

        <div class="grid-heading">
            <h2>Ruta de aprendizaje</h2>
            <span>04 unidades disponibles</span>
        </div>

        <div class="unidad-grid">
            <a href="../semanas/listar.jsp?unidad=1" class="unidad-card">
                <div class="card-top">
                    <div class="unidad-numero">01 <span>/ UNIDAD</span></div>
                    <div class="card-index">01 — 04</div>
                </div>
                <h2>Fundamentos</h2>
                <p>Fundamentos de la Arquitectura de Software y Estándares Internacionales.</p>
                <div class="unidad-link">Ver semanas <span>→</span></div>
            </a>

            <a href="../semanas/listar.jsp?unidad=2" class="unidad-card">
                <div class="card-top">
                    <div class="unidad-numero">02 <span>/ UNIDAD</span></div>
                    <div class="card-index">02 — 04</div>
                </div>
                <h2>Modelado</h2>
                <p>Modelado de la Arquitectura de Software mediante Programación Orientada a Objetos.</p>
                <div class="unidad-link">Ver semanas <span>→</span></div>
            </a>

            <a href="../semanas/listar.jsp?unidad=3" class="unidad-card">
                <div class="card-top">
                    <div class="unidad-numero">03 <span>/ UNIDAD</span></div>
                    <div class="card-index">03 — 04</div>
                </div>
                <h2>Comunicación e Integración</h2>
                <p>Comunicación e Integración de Arquitecturas de Software.</p>
                <div class="unidad-link">Ver semanas <span>→</span></div>
            </a>

            <a href="../semanas/listar.jsp?unidad=4" class="unidad-card">
                <div class="card-top">
                    <div class="unidad-numero">04 <span>/ UNIDAD</span></div>
                    <div class="card-index">04 — 04</div>
                </div>
                <h2>Frameworks e Implementación</h2>
                <p>Frameworks y Estándares para la Implementación de Arquitecturas de Software.</p>
                <div class="unidad-link">Ver semanas <span>→</span></div>
            </a>
        </div>

        <div class="footer-note">
            <span><strong>MiPortafolio</strong> · Archivo académico</span>
            <span>Arquitectura de software · 2026</span>
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
