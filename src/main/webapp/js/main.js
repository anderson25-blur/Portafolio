// ============================================================
// ARQUITECTURA — Portafolio académico
// Carga inicial + interacciones + integración con el backend
// (login, sesión, subir/descargar/eliminar trabajos e infografías)
// ============================================================

const API = {
  sesion: 'api/sesion',
  login: 'api/login',
  logout: 'api/logout',
  archivos: 'api/archivos',
  subir: 'api/archivos/subir',
  descargar: 'api/archivos/descargar',
  eliminar: 'api/archivos/eliminar',
};

let sesionActual = { autenticado: false, esAdmin: false };

document.addEventListener('DOMContentLoaded', () => {
  runLoadingSequence();
  setupHeroParallax();
  setupUserModal();
  setupUnidadAccordion();
  setupAdminHandlers();
  iniciarSesionYEstado();
});

/* ============================================================
   PANTALLA DE CARGA
   ============================================================ */
function runLoadingSequence() {
  const loader = document.getElementById('loader');
  const gaugeFill = document.getElementById('gaugeFill');
  const percentEl = document.getElementById('loaderPercent');
  const statusEl = document.getElementById('loaderStatus');
  const barFill = document.getElementById('loaderBarFill');
  const site = document.getElementById('site');

  const CIRCUMFERENCE = 552.9;
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  const stages = [
    { at: 0,  text: 'Encendiendo motor…' },
    { at: 28, text: 'Compilando arquitectura…' },
    { at: 60, text: 'Cargando unidades…' },
    { at: 90, text: 'Listo.' },
  ];

  let progress = 0;
  const duration = reduceMotion ? 200 : 2200; // ms
  const start = performance.now();

  function frame(now) {
    const elapsed = now - start;
    progress = Math.min(100, Math.round((elapsed / duration) * 100));

    gaugeFill.style.strokeDashoffset = String(CIRCUMFERENCE * (1 - progress / 100));
    percentEl.textContent = String(progress);
    barFill.style.width = progress + '%';

    const stage = [...stages].reverse().find(s => progress >= s.at);
    if (stage) statusEl.textContent = stage.text;

    if (progress < 100) {
      requestAnimationFrame(frame);
    } else {
      finishLoading();
    }
  }

  function finishLoading() {
    setTimeout(() => {
      loader.classList.add('is-done');
      site.removeAttribute('aria-hidden');
      site.classList.add('is-revealed');
      const heading = document.querySelector('.hero h1');
      if (heading) {
        heading.setAttribute('tabindex', '-1');
        heading.focus({ preventScroll: true });
      }
      loader.addEventListener('transitionend', () => loader.remove(), { once: true });
    }, 260);
  }

  requestAnimationFrame(frame);
}

/* ============================================================
   HERO — un poco de movimiento extra: la moto responde al mouse
   (además del zoom lento continuo que ya trae el CSS)
   ============================================================ */
function setupHeroParallax() {
  const frame = document.querySelector('.hero-media-frame');
  const img = frame ? frame.querySelector('img') : null;
  if (!frame || !img) return;
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  if (window.matchMedia('(hover: none)').matches) return; // sin mouse (touch), no aplica

  frame.addEventListener('mousemove', (e) => {
    const rect = frame.getBoundingClientRect();
    const x = (e.clientX - rect.left) / rect.width - 0.5;  // -0.5 .. 0.5
    const y = (e.clientY - rect.top) / rect.height - 0.5;
    img.style.transform = `scale(1.12) translate(${x * -14}px, ${y * -10}px)`;
  });
  frame.addEventListener('mouseleave', () => {
    img.style.transform = '';
  });
}

/* ============================================================
   ACORDEÓN DE UNIDADES
   ============================================================ */
function setupUnidadAccordion() {
  document.querySelectorAll('.unidad-toggle').forEach((btn) => {
    btn.addEventListener('click', () => {
      const card = btn.closest('.unidad-card');
      const isOpen = card.classList.toggle('is-open');
      btn.setAttribute('aria-expanded', String(isOpen));
    });
  });
}

/* ============================================================
   MODAL DE INGRESO
   ============================================================ */
function setupUserModal() {
  const userBtn = document.getElementById('userBtn');
  const overlay = document.getElementById('loginModal');
  const closeBtn = document.getElementById('loginClose');
  const form = document.getElementById('loginForm');
  const submitBtn = document.getElementById('loginSubmit');
  const errorEl = document.getElementById('loginError');
  const logoutBtn = document.getElementById('logoutBtn');

  if (!userBtn || !overlay) return;

  const open = () => {
    hideError();
    overlay.classList.add('is-open');
    const firstField = overlay.querySelector('input');
    if (firstField) firstField.focus();
  };
  const close = () => overlay.classList.remove('is-open');
  const showError = (msg) => { errorEl.textContent = msg; errorEl.hidden = false; };
  const hideError = () => { errorEl.hidden = true; errorEl.textContent = ''; };

  userBtn.addEventListener('click', open);
  closeBtn.addEventListener('click', close);
  overlay.addEventListener('click', (e) => { if (e.target === overlay) close(); });
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape') close(); });

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    hideError();
    submitBtn.disabled = true;
    submitBtn.textContent = 'Ingresando…';

    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;

    try {
      const res = await fetch(API.login, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password }),
      });
      const data = await res.json();

      if (!res.ok || !data.ok) {
        showError(data.error || 'No se pudo iniciar sesión.');
        return;
      }

      sesionActual = { autenticado: true, email: data.email, rol: data.rol, esAdmin: data.rol === 'admin' };
      aplicarEstadoSesion();
      close();
      form.reset();
      cargarEstadoArchivos();

    } catch (err) {
      showError('No se pudo conectar con el servidor.');
    } finally {
      submitBtn.disabled = false;
      submitBtn.textContent = 'Ingresar';
    }
  });

  if (logoutBtn) {
    logoutBtn.addEventListener('click', async () => {
      logoutBtn.disabled = true;
      try {
        await fetch(API.logout, { method: 'POST' });
      } catch (err) {
        // aunque falle la llamada, igual limpiamos el estado local
      }
      sesionActual = { autenticado: false, esAdmin: false };
      aplicarEstadoSesion();
      cargarEstadoArchivos();
      logoutBtn.disabled = false;
    });
  }
}

/* ============================================================
   SESIÓN — consulta al backend quién está logueado
   ============================================================ */
async function iniciarSesionYEstado() {
  try {
    const res = await fetch(API.sesion);
    const data = await res.json();
    if (data.ok) {
      sesionActual = {
        autenticado: !!data.autenticado,
        email: data.email,
        rol: data.rol,
        esAdmin: !!data.esAdmin,
      };
    }
  } catch (err) {
    sesionActual = { autenticado: false, esAdmin: false };
  }
  aplicarEstadoSesion();
  cargarEstadoArchivos();
}

function aplicarEstadoSesion() {
  const site = document.getElementById('site');
  const chip = document.getElementById('hudChip');
  const userBtn = document.getElementById('userBtn');
  const logoutBtn = document.getElementById('logoutBtn');

  site.classList.toggle('is-admin', sesionActual.esAdmin);

  document.querySelectorAll('.admin-only').forEach((el) => {
    el.hidden = !sesionActual.esAdmin;
  });

  if (sesionActual.autenticado) {
    chip.hidden = false;
    chip.textContent = sesionActual.esAdmin ? `Admin · ${sesionActual.email}` : sesionActual.email;
    userBtn.hidden = true;
    logoutBtn.hidden = false;
  } else {
    chip.hidden = true;
    userBtn.hidden = false;
    logoutBtn.hidden = true;
  }
}

/* ============================================================
   ESTADO DE ARCHIVOS — pinta "Sin trabajo" / "Subido" en cada semana
   y las miniaturas de las infografías
   ============================================================ */
async function cargarEstadoArchivos() {
  await Promise.all([cargarTrabajos(), cargarInfografias()]);
}

async function cargarTrabajos() {
  try {
    const res = await fetch(API.archivos);
    const data = await res.json();
    if (!data.ok) return;

    // El más reciente de cada (unidad, semana) es el que se muestra.
    const porSemana = new Map();
    data.archivos.forEach((a) => {
      const clave = a.unidad + '-' + a.semana;
      if (!porSemana.has(clave)) porSemana.set(clave, a);
    });

    document.querySelectorAll('.semana-item').forEach((li) => {
      const clave = li.dataset.unidad + '-' + li.dataset.semana;
      pintarSemana(li, porSemana.get(clave) || null);
    });
  } catch (err) {
    console.error('No se pudo cargar el estado de los trabajos:', err);
  }
}

function pintarSemana(li, archivo) {
  const status = li.querySelector('[data-status]');
  const download = li.querySelector('[data-download]');
  const del = li.querySelector('[data-delete]');

  if (archivo) {
    status.textContent = 'Subido: ' + truncar(archivo.nombreOriginal, 22);
    status.classList.add('is-uploaded');
    download.href = API.descargar + '?id=' + encodeURIComponent(archivo.id);
    download.hidden = false;
    del.hidden = !sesionActual.esAdmin;
    del.dataset.id = archivo.id;
  } else {
    status.textContent = 'Sin trabajo';
    status.classList.remove('is-uploaded');
    download.hidden = true;
    download.removeAttribute('href');
    del.hidden = true;
    delete del.dataset.id;
  }
}

async function cargarInfografias() {
  try {
    const res = await fetch(API.archivos + '?tipo=infografia');
    const data = await res.json();
    if (!data.ok) return;

    const porSlot = new Map();
    data.archivos.forEach((a) => {
      if (!porSlot.has(a.slot)) porSlot.set(a.slot, a);
    });

    document.querySelectorAll('#infoGrid .info-card').forEach((card) => {
      const slot = Number(card.dataset.slot);
      pintarInfografia(card, porSlot.get(slot) || null);
    });
  } catch (err) {
    console.error('No se pudo cargar las infografías:', err);
  }
}

function pintarInfografia(card, archivo) {
  const img = card.querySelector('[data-thumb-img]');
  const emptyText = card.querySelector('[data-empty-text]');
  const download = card.querySelector('[data-download]');
  const del = card.querySelector('[data-delete]');

  if (archivo) {
    const url = API.descargar + '?id=' + encodeURIComponent(archivo.id);
    if (esImagen(archivo.nombreOriginal)) {
      img.src = url;
      img.hidden = false;
    } else {
      img.hidden = true;
      img.removeAttribute('src');
    }
    emptyText.textContent = archivo.nombreOriginal;
    download.href = url;
    download.hidden = false;
    del.hidden = !sesionActual.esAdmin;
    del.dataset.id = archivo.id;
  } else {
    img.hidden = true;
    img.removeAttribute('src');
    emptyText.textContent = 'Se publicará próximamente.';
    download.hidden = true;
    download.removeAttribute('href');
    del.hidden = true;
    delete del.dataset.id;
  }
}

function esImagen(nombre) {
  return /\.(png|jpe?g|gif|webp|svg)$/i.test(nombre || '');
}

function truncar(texto, max) {
  if (!texto) return '';
  return texto.length > max ? texto.slice(0, max - 1) + '…' : texto;
}

/* ============================================================
   ACCIONES DE ADMIN — subir y eliminar (delegación de eventos,
   funciona también para los elementos ya presentes en el HTML)
   ============================================================ */
function setupAdminHandlers() {
  document.addEventListener('change', (e) => {
    const input = e.target.closest('[data-upload-input]');
    if (!input || !input.files || !input.files[0]) return;
    manejarSubida(input);
  });

  document.addEventListener('click', (e) => {
    const btn = e.target.closest('[data-delete]');
    if (!btn || btn.hidden || !btn.dataset.id) return;
    manejarEliminacion(btn);
  });
}

async function manejarSubida(input) {
  const semanaItem = input.closest('.semana-item');
  const infoCard = input.closest('.info-card');
  const file = input.files[0];

  const formData = new FormData();
  formData.append('archivo', file);

  if (semanaItem) {
    formData.append('tipo', 'trabajo');
    formData.append('unidad', semanaItem.dataset.unidad);
    formData.append('semana', semanaItem.dataset.semana);
  } else if (infoCard) {
    formData.append('tipo', 'infografia');
    formData.append('slot', infoCard.dataset.slot);
  } else {
    return;
  }

  const label = input.closest('.semana-btn-upload');
  if (label) label.classList.add('is-loading');

  try {
    const res = await fetch(API.subir, { method: 'POST', body: formData });
    const data = await res.json();
    if (!data.ok) {
      alert(data.error || 'No se pudo subir el archivo.');
      return;
    }
    await cargarEstadoArchivos();
  } catch (err) {
    alert('No se pudo conectar con el servidor para subir el archivo.');
  } finally {
    input.value = '';
    if (label) label.classList.remove('is-loading');
  }
}

async function manejarEliminacion(btn) {
  if (!confirm('¿Eliminar este archivo? Esta acción no se puede deshacer.')) return;

  btn.disabled = true;
  try {
    const res = await fetch(API.eliminar + '?id=' + encodeURIComponent(btn.dataset.id), { method: 'POST' });
    const data = await res.json();
    if (!data.ok) {
      alert(data.error || 'No se pudo eliminar el archivo.');
      return;
    }
    await cargarEstadoArchivos();
  } catch (err) {
    alert('No se pudo conectar con el servidor para eliminar el archivo.');
  } finally {
    btn.disabled = false;
  }
}
