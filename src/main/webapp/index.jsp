
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

        <a href="#sobre-mi">
          Sobre mí
        </a>

        <!-- Las infografías ahora se gestionan dentro de cada semana -->
        <a href="unidades/listar.jsp">
          Unidades del ciclo
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
            href="#sobre-mi"
            class="hero-cta">
            Conóceme
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
    <!-- ===================== SOBRE MÍ ===================== -->
<section id="sobre-mi" class="about-section">

  <div class="section-head">

    <h2>
      Sobre mí
    </h2>

    <p>
      Estudiante de Ingeniería de Sistemas · UPLA
    </p>

  </div>


  <div class="about-grid">

    <!-- PERFIL -->
    <article class="about-card about-main">

      <div class="about-number">
        01
      </div>

      <div class="about-content">

        <span class="about-label">
          PERFIL ACADÉMICO
        </span>

        <h3>
          Anderson Mayta
        </h3>

        <p>
          Soy estudiante de Ingeniería de Sistemas en la
          Universidad Peruana Los Andes (UPLA). Actualmente
          desarrollo mi formación académica enfocándome en
          arquitectura de software, desarrollo de sistemas,
          bases de datos y tecnologías orientadas a la
          construcción de soluciones digitales.
        </p>

        <p>
          Este portafolio reúne los principales trabajos,
          actividades e infografías desarrollados durante el
          curso de Arquitectura de Software, organizados por
          unidades y semanas para facilitar su consulta.
        </p>

      </div>

    </article>


    <!-- FORMACIÓN -->
    <article class="about-card">

      <div class="about-number">
        02
      </div>

      <div class="about-content">

        <span class="about-label">
          FORMACIÓN
        </span>

        <h3>
          Ingeniería de Sistemas
        </h3>

        <p>
          Universidad Peruana Los Andes
        </p>

        <div class="about-tags">

          <span>
            Ingeniería de Sistemas
          </span>

          <span>
            Arquitectura de Software
          </span>

          <span>
            Desarrollo Web
          </span>

        </div>

      </div>

    </article>


    <!-- INTERESES -->
    <article class="about-card">

      <div class="about-number">
        03
      </div>

      <div class="about-content">

        <span class="about-label">
          ÁREAS DE INTERÉS
        </span>

        <h3>
          Tecnología y desarrollo
        </h3>

        <p>
          Mis principales intereses están relacionados con
          la investigación, ciberseguridad, bases de datos,
          desarrollo de software y arquitectura de sistemas.
        </p>

        <div class="about-tags">

          <span>
            Ciberseguridad
          </span>

          <span>
            Bases de datos
          </span>

          <span>
            Software
          </span>

        </div>

      </div>

    </article>


    <!-- OBJETIVO -->
    <article class="about-card">

      <div class="about-number">
        04
      </div>

      <div class="about-content">

        <span class="about-label">
          OBJETIVO
        </span>

        <h3>
          Seguir desarrollándome
        </h3>

        <p>
          Busco fortalecer mis conocimientos técnicos y
          desarrollar soluciones que integren tecnología,
          diseño y buenas prácticas de ingeniería de software.
        </p>

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
