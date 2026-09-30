
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Arquitectura de Software — Portafolio</title>
  <meta name="description" content="Portafolio del curso Arquitectura de Software: unidades, semanas e infografías.">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@500;600;700&family=Space+Grotesk:wght@400;500;600&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="css/style.css">
</head>

<body>

  <!-- ===================== PANTALLA DE CARGA ===================== -->
  <div id="loader" class="loader" role="status" aria-live="polite">

    <div class="loader-gauge">
      <svg viewBox="0 0 200 200">
        <circle class="gauge-track" cx="100" cy="100" r="88"></circle>
        <circle class="gauge-fill" id="gaugeFill" cx="100" cy="100" r="88"></circle>
      </svg>

      <div class="loader-mark">
        <svg viewBox="0 0 100 100">
          <path d="M50 8 L92 92 L70 92 L50 52 L30 92 L8 92 Z"/>
        </svg>
      </div>

      <div class="loader-percent">
        <span id="loaderPercent">0</span>%
      </div>
    </div>

    <div class="loader-status" id="loaderStatus">
      Encendiendo motor…
    </div>

    <div class="loader-bar">
      <div class="loader-bar-fill" id="loaderBarFill"></div>
    </div>

  </div>


  <!-- ===================== SITIO PRINCIPAL ===================== -->
  <div id="site" class="site" aria-hidden="true">

    <!-- ===================== HEADER ===================== -->
    <header class="hud">

      <div class="hud-brand">

        <svg class="brand-mark" viewBox="0 0 100 100">
          <path d="M50 8 L92 92 L70 92 L50 52 L30 92 L8 92 Z"/>
        </svg>

        <span class="brand-word">
          Arquitectura <span class="dim">de Software</span>
        </span>

      </div>


      <!-- ===================== NAVEGACIÓN ===================== -->
      <nav class="hud-nav">

        <a href="#unidades">
          Unidades
        </a>

        <!-- Las infografías ahora se gestionan dentro de cada semana -->
        <a href="unidades/listar.jsp">
          Infografías
        </a>

      </nav>


      <!-- ===================== SESIÓN ===================== -->
      <div class="hud-session">

        <span class="hud-chip" id="hudChip" hidden></span>

        <button
          class="hud-user"
          id="userBtn"
          aria-label="Ingresar como administrador">

          <svg
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round">

            <circle cx="12" cy="8" r="4"></circle>
            <path d="M4 21a8 8 0 0 1 16 0"></path>

          </svg>

        </button>


        <button
          class="hud-user hud-logout"
          id="logoutBtn"
          aria-label="Cerrar sesión"
          hidden>

          <svg
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round">

            <path d="M15 4H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8M11 8l4 4-4 4M4 12h11"/>

          </svg>

        </button>

      </div>

    </header>


    <!-- ===================== HERO ===================== -->
    <section class="hero">

      <div
        class="hero-bg-glow"
        aria-hidden="true">
      </div>


      <svg
        class="hero-lines"
        viewBox="0 0 600 520"
        preserveAspectRatio="none"
        aria-hidden="true">

        <line
          x1="-20"
          y1="0"
          x2="380"
          y2="520"
          stroke="var(--cyan)"
          stroke-width="2"
          opacity=".4"/>

        <line
          x1="40"
          y1="0"
          x2="440"
          y2="520"
          stroke="var(--steel)"
          stroke-width="1"
          opacity=".2"/>

        <line
          x1="100"
          y1="0"
          x2="500"
          y2="520"
          stroke="var(--lime)"
          stroke-width="1"
          opacity=".25"/>

      </svg>


      <div class="hero-inner">

        <div class="hero-content">

          <h1>
            Arquitectura<span>de Software</span>
          </h1>

          <p class="hero-sub">
            Portafolio del curso desarrollado por el alumno Anderson Mayta:
            4 unidades, 16 semanas, entregas e infografías en un solo lugar.
          </p>

          <a
            href="#unidades"
            class="hero-cta">
            Ver unidades
          </a>

        </div>


        <!-- ===================== CARRUSEL ===================== -->
        <div class="hero-media">

          <div
            class="hero-carousel"
            id="heroCarousel">


            <!-- IMAGEN 1 -->
            <div class="hero-slide is-active">

              <img
                src="images/moto-hero.jpg"
                alt="Motocicleta deportiva"
                loading="eager">

            </div>


            <!-- IMAGEN 2 -->
            <div class="hero-slide">

              <img
                src="images/6r.jpg"
                alt="Motocicleta deportiva 02"
                loading="lazy">

            </div>


            <!-- IMAGEN 3 -->
            <div class="hero-slide">

              <img
                src="images/h2.jpg"
                alt="Motocicleta deportiva 03"
                loading="lazy">

            </div>


            <!-- IMAGEN 4 -->
            <div class="hero-slide">

              <img
                src="images/kawa 400.jpg"
                alt="Motocicleta deportiva 04"
                loading="lazy">

            </div>


            <!-- IMAGEN 5 -->
            <div class="hero-slide">

              <img
                src="images/kawa.jpg"
                alt="Motocicleta deportiva 05"
                loading="lazy">

            </div>


            <!-- IMAGEN 6 -->
            <div class="hero-slide">

              <img
                src="images/ninja.jpg"
                alt="Motocicleta deportiva 06"
                loading="lazy">

            </div>


            <!-- IMAGEN 7 -->
            <div class="hero-slide">

              <img
                src="images/sha.jpg"
                alt="Motocicleta deportiva 07"
                loading="lazy">

            </div>


            <!-- IMAGEN 8 -->
            <div class="hero-slide">

              <img
                src="images/zh.jpg"
                alt="Motocicleta deportiva 08"
                loading="lazy">

            </div>


            <!-- IMAGEN 9 -->
            <div class="hero-slide">

              <img
                src="images/zx4rr.jpg"
                alt="Motocicleta deportiva 09"
                loading="lazy">

            </div>


            <!-- IMAGEN 10 -->
            <div class="hero-slide">

              <img
                src="images/zx10.avif"
                alt="Motocicleta deportiva 10"
                loading="lazy">

            </div>


            <!-- BOTÓN ANTERIOR -->
            <button
              type="button"
              class="hero-carousel-btn hero-carousel-prev"
              id="heroPrev"
              aria-label="Imagen anterior">

              ‹

            </button>


            <!-- BOTÓN SIGUIENTE -->
            <button
              type="button"
              class="hero-carousel-btn hero-carousel-next"
              id="heroNext"
              aria-label="Imagen siguiente">

              ›

            </button>


            <!-- INDICADORES -->
            <div
              class="hero-carousel-dots"
              id="heroDots">

              <button
                type="button"
                class="hero-dot is-active"
                data-slide="0"
                aria-label="Imagen 1">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="1"
                aria-label="Imagen 2">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="2"
                aria-label="Imagen 3">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="3"
                aria-label="Imagen 4">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="4"
                aria-label="Imagen 5">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="5"
                aria-label="Imagen 6">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="6"
                aria-label="Imagen 7">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="7"
                aria-label="Imagen 8">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="8"
                aria-label="Imagen 9">
              </button>

              <button
                type="button"
                class="hero-dot"
                data-slide="9"
                aria-label="Imagen 10">
              </button>

            </div>


            <div class="hero-media-fade"></div>

          </div>


          <!-- EFECTOS -->
          <div
            class="bokeh b1"
            aria-hidden="true">
          </div>

          <div
            class="bokeh b2"
            aria-hidden="true">
          </div>

          <div
            class="bokeh b3"
            aria-hidden="true">
          </div>

          <div
            class="bokeh b4"
            aria-hidden="true">
          </div>

        </div>

      </div>

    </section>


    <!-- ===================== UNIDADES ===================== -->
    <section id="unidades">

      <div class="section-head">

        <h2>
          Unidades
        </h2>

        <p>
          4 unidades · 16 semanas en total
        </p>

      </div>


      <div class="unidad-grid">


        <!-- =====================================================
             UNIDAD 1
             ===================================================== -->
        <article class="unidad-card">

          <button
            class="unidad-toggle"
            aria-expanded="false"
            aria-controls="panel-u1">

            <span class="unidad-num">
              01
            </span>

            <span class="unidad-heading">

              <h3>
                Fundamentos de la Arquitectura de Software y Estándares Internacionales
              </h3>

              <span class="unidad-meta">

                <span>
                  Semanas 1–4
                </span>

                <span class="unidad-chevron">
                  ▾
                </span>

              </span>

            </span>

          </button>


          <div
            class="unidad-panel-wrap"
            id="panel-u1">

            <div class="unidad-panel">

              <ol class="semana-list">


                <!-- SEMANA 1 -->
                <li
                  class="semana-item"
                  data-unidad="1"
                  data-semana="1">

                  <span class="semana-num">
                    01
                  </span>

                  <span class="semana-info">

                    <h4>
                      Introducción a la Arquitectura de Software
                    </h4>

                    <p>
                      Conceptos, objetivos e importancia de la arquitectura de software.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span
                      class="semana-status"
                      data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 2 -->
                <li
                  class="semana-item"
                  data-unidad="1"
                  data-semana="2">

                  <span class="semana-num">
                    02
                  </span>

                  <span class="semana-info">

                    <h4>
                      Principios, Atributos de Calidad y Estándares Internacionales
                    </h4>

                    <p>
                      Calidad y sostenibilidad del proyecto según estándares internacionales.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 3 -->
                <li
                  class="semana-item"
                  data-unidad="1"
                  data-semana="3">

                  <span class="semana-num">
                    03
                  </span>

                  <span class="semana-info">

                    <h4>
                      Estilos y Patrones Arquitectónicos
                    </h4>

                    <p>
                      Comparación de estilos y selección del patrón más adecuado.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 4 -->
                <li
                  class="semana-item"
                  data-unidad="1"
                  data-semana="4">

                  <span class="semana-num">
                    04
                  </span>

                  <span class="semana-info">

                    <h4>
                      Documentación y Representación Arquitectónica
                    </h4>

                    <p>
                      Modelos, diagramas y buenas prácticas de documentación.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>

              </ol>

            </div>

          </div>

        </article>


        <!-- =====================================================
             UNIDAD 2
             ===================================================== -->
        <article class="unidad-card">

          <button
            class="unidad-toggle"
            aria-expanded="false"
            aria-controls="panel-u2">

            <span class="unidad-num">
              02
            </span>

            <span class="unidad-heading">

              <h3>
                Modelado de la Arquitectura de Software mediante Programación Orientada a Objetos
              </h3>

              <span class="unidad-meta">

                <span>
                  Semanas 5–8
                </span>

                <span class="unidad-chevron">
                  ▾
                </span>

              </span>

            </span>

          </button>


          <div
            class="unidad-panel-wrap"
            id="panel-u2">

            <div class="unidad-panel">

              <ol class="semana-list">


                <!-- SEMANA 5 -->
                <li
                  class="semana-item"
                  data-unidad="2"
                  data-semana="5">

                  <span class="semana-num">05</span>

                  <span class="semana-info">

                    <h4>
                      Principios de POO aplicados a la Arquitectura
                    </h4>

                    <p>
                      Abstracción, encapsulamiento, herencia y polimorfismo.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 6 -->
                <li
                  class="semana-item"
                  data-unidad="2"
                  data-semana="6">

                  <span class="semana-num">06</span>

                  <span class="semana-info">

                    <h4>
                      Modelado Arquitectónico con UML
                    </h4>

                    <p>
                      Diagramas de casos de uso, clases y paquetes.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 7 -->
                <li
                  class="semana-item"
                  data-unidad="2"
                  data-semana="7">

                  <span class="semana-num">07</span>

                  <span class="semana-info">

                    <h4>
                      Diseño de Componentes y Capas de la Arquitectura
                    </h4>

                    <p>
                      Responsabilidades, cohesión y bajo acoplamiento.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 8 -->
                <li
                  class="semana-item"
                  data-unidad="2"
                  data-semana="8">

                  <span class="semana-num">08</span>

                  <span class="semana-info">

                    <h4>
                      Elaboración y Validación del Modelo Arquitectónico
                    </h4>

                    <p>
                      Artefactos de modelado y sustento técnico de las decisiones.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>

              </ol>

            </div>

          </div>

        </article>


        <!-- =====================================================
             UNIDAD 3
             ===================================================== -->
        <article class="unidad-card">

          <button
            class="unidad-toggle"
            aria-expanded="false"
            aria-controls="panel-u3">

            <span class="unidad-num">
              03
            </span>

            <span class="unidad-heading">

              <h3>
                Comunicación e Integración de Arquitecturas de Software
              </h3>

              <span class="unidad-meta">

                <span>
                  Semanas 9–12
                </span>

                <span class="unidad-chevron">
                  ▾
                </span>

              </span>

            </span>

          </button>


          <div
            class="unidad-panel-wrap"
            id="panel-u3">

            <div class="unidad-panel">

              <ol class="semana-list">


                <!-- SEMANA 9 -->
                <li
                  class="semana-item"
                  data-unidad="3"
                  data-semana="9">

                  <span class="semana-num">09</span>

                  <span class="semana-info">

                    <h4>
                      Fundamentos de la Comunicación entre Arquitecturas
                    </h4>

                    <p>
                      Mecanismos, protocolos y flujos de información entre componentes.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 10 -->
                <li
                  class="semana-item"
                  data-unidad="3"
                  data-semana="10">

                  <span class="semana-num">10</span>

                  <span class="semana-info">

                    <h4>
                      Métodos y Tecnologías para la Integración de Sistemas
                    </h4>

                    <p>
                      Servicios web, APIs y mensajería para integrar aplicaciones.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 11 -->
                <li
                  class="semana-item"
                  data-unidad="3"
                  data-semana="11">

                  <span class="semana-num">11</span>

                  <span class="semana-info">

                    <h4>
                      Diseño de Interfaces y Transmisión de Datos
                    </h4>

                    <p>
                      Interoperabilidad y modelado de servicios entre componentes.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 12 -->
                <li
                  class="semana-item"
                  data-unidad="3"
                  data-semana="12">

                  <span class="semana-num">12</span>

                  <span class="semana-info">

                    <h4>
                      Implementación y Validación de la Comunicación Arquitectónica
                    </h4>

                    <p>
                      Pruebas de integridad, disponibilidad y eficiencia de la integración.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>

              </ol>

            </div>

          </div>

        </article>


        <!-- =====================================================
             UNIDAD 4
             ===================================================== -->
        <article class="unidad-card">

          <button
            class="unidad-toggle"
            aria-expanded="false"
            aria-controls="panel-u4">

            <span class="unidad-num">
              04
            </span>

            <span class="unidad-heading">

              <h3>
                Frameworks y Estándares para la Implementación de Arquitecturas de Software
              </h3>

              <span class="unidad-meta">

                <span>
                  Semanas 13–16
                </span>

                <span class="unidad-chevron">
                  ▾
                </span>

              </span>

            </span>

          </button>


          <div
            class="unidad-panel-wrap"
            id="panel-u4">

            <div class="unidad-panel">

              <ol class="semana-list">


                <!-- SEMANA 13 -->
                <li
                  class="semana-item"
                  data-unidad="4"
                  data-semana="13">

                  <span class="semana-num">13</span>

                  <span class="semana-info">

                    <h4>
                      Fundamentos de Frameworks de Arquitectura de Software
                    </h4>

                    <p>
                      Características, ventajas y ámbitos de aplicación de los principales frameworks.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 14 -->
                <li
                  class="semana-item"
                  data-unidad="4"
                  data-semana="14">

                  <span class="semana-num">14</span>

                  <span class="semana-info">

                    <h4>
                      Normas y Buenas Prácticas en Arquitectura de Software
                    </h4>

                    <p>
                      Calidad, interoperabilidad, seguridad y rendimiento del proyecto.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 15 -->
                <li
                  class="semana-item"
                  data-unidad="4"
                  data-semana="15">

                  <span class="semana-num">15</span>

                  <span class="semana-info">

                    <h4>
                      Implementación de la Arquitectura utilizando Frameworks
                    </h4>

                    <p>
                      Componentes, patrones de diseño y mecanismos de comunicación.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>


                <!-- SEMANA 16 -->
                <li
                  class="semana-item"
                  data-unidad="4"
                  data-semana="16">

                  <span class="semana-num">16</span>

                  <span class="semana-info">

                    <h4>
                      Evaluación y Optimización de la Arquitectura de Software
                    </h4>

                    <p>
                      Métricas de calidad y mejoras finales sobre lo implementado.
                    </p>

                  </span>

                  <span class="semana-right">

                    <span class="semana-status" data-status>
                      Sin trabajo
                    </span>

                    <a
                      class="semana-btn semana-btn-download"
                      data-download
                      hidden
                      title="Descargar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 4v11m0 0l-4-4m4 4l4-4M5 20h14"/>

                      </svg>

                    </a>

                    <button
                      type="button"
                      class="semana-btn semana-btn-delete"
                      data-delete
                      hidden
                      title="Eliminar trabajo">

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M4 7h16M9 7V4h6v3m-8 0 1 13h8l1-13"/>

                      </svg>

                    </button>

                    <label
                      class="semana-btn semana-btn-upload admin-only"
                      hidden
                      title="Subir trabajo">

                      <input
                        type="file"
                        accept=".pdf,application/pdf"
                        data-upload-input
                        hidden>

                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M12 20V9m0 0l-4 4m4-4l4 4M5 4h14"/>

                      </svg>

                    </label>

                  </span>

                </li>

              </ol>

            </div>

          </div>

        </article>

      </div>

    </section>


    <!-- ===================== FOOTER ===================== -->
    <footer class="site-footer">

      <p>
        Arquitectura de Software — Portafolio académico.
      </p>

    </footer>

  </div>

  <!-- ===================== MODAL DE INGRESO ===================== -->

  <!-- Envía las credenciales a /api/login, que valida contra Supabase Auth. -->

  <div
    class="modal-overlay"
    id="loginModal">

    <div class="modal">

      <button
        class="modal-close"
        id="loginClose"
        aria-label="Cerrar">

        <svg
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round">

          <path d="M4 4L20 20M20 4L4 20"></path>

        </svg>

      </button>


      <h3>
        Ingresar
      </h3>

      <p class="modal-hint">
        Acceso para administrar el portafolio:
        subir trabajos e infografías.
      </p>

      <p
        class="modal-error"
        id="loginError"
        hidden>
      </p>
      <form id="loginForm">

        <div class="field">

          <label for="email">
            Correo
          </label>

          <input
            type="email"
            id="email"
            name="email"
            placeholder="admin@tudominio.com"
            required>

        </div>
        <div class="field">

          <label for="password">
            Contraseña
          </label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="••••••••"
            required>
        </div>
        <button
          type="submit"
          class="modal-submit"
          id="loginSubmit">
          Ingresar
        </button>
      </form>
    </div>
  </div>


  <!-- ===================== JAVASCRIPT ===================== -->
  <script src="js/main.js?v=2"></script>

</body>
</html>
