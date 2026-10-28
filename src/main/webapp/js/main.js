/* ============================================================
   ARQUITECTURA — Portafolio académico
   ============================================================

   Funciones:

   - Loader
   - Hero / parallax / carrusel
   - Login y sesión
   - Trabajos por unidad + semana
   - Infografías por unidad + semana + slot
   - Subida de archivos
   - Eliminación de archivos
   - Visualización de PDF e imágenes (con zoom en imágenes)
   - Descarga de archivos
   ============================================================ */


/* ============================================================
   CONFIGURACIÓN API
   ============================================================ */

function obtenerContextPath() {

    const script = document.querySelector('script[src*="/js/main.js"]');

    if (script) {

        const src = new URL(script.getAttribute('src'), window.location.href);

        const partes = src.pathname.split('/');

        /*
         * main.js normalmente estará en:
         *   /MiPortafolio/js/main.js
         * Quitamos /js/main.js y conservamos /MiPortafolio
         */

        if (partes.length >= 3) {

            partes.pop(); // main.js
            partes.pop(); // js

            return partes.join('/') || '';
        }
    }

    return '';
}


const CONTEXT_PATH = obtenerContextPath();


const API = {

    sesion: CONTEXT_PATH + '/api/sesion',

    login: CONTEXT_PATH + '/api/login',

    logout: CONTEXT_PATH + '/api/logout',

    archivos: CONTEXT_PATH + '/api/archivos',

    subir: CONTEXT_PATH + '/api/archivos/subir',

    ver: CONTEXT_PATH + '/api/archivos/ver',

    descargar: CONTEXT_PATH + '/api/archivos/descargar',

    eliminar: CONTEXT_PATH + '/api/archivos/eliminar'

};


/* ============================================================
   ESTADO DE SESIÓN
   ============================================================ */

let sesionActual = {

    autenticado: false,

    esAdmin: false,

    email: null,

    rol: null

};


/* ============================================================
   INICIALIZACIÓN
   ============================================================ */

document.addEventListener('DOMContentLoaded', () => {

    runLoadingSequence();

    setupHeroParallax();

    setupUserModal();

    setupUnidadAccordion();

    setupAdminHandlers();

    setupArchivoViewer();

    instalarEstilosDinamicosArchivos();

    prepararVistaInicialArchivos();

    iniciarSesionYEstado();

    setupHeroCarousel();

});


/* ============================================================
   PANTALLA DE CARGA
   ============================================================ */

function runLoadingSequence() {

    const loader = document.getElementById('loader');

    /*
     * No todas las páginas tienen loader.
     */

    if (!loader) return;


    const gaugeFill = document.getElementById('gaugeFill');

    const percentEl = document.getElementById('loaderPercent');

    const statusEl = document.getElementById('loaderStatus');

    const barFill = document.getElementById('loaderBarFill');

    const site = document.getElementById('site');


    const CIRCUMFERENCE = 552.9;


    const reduceMotion =
        window.matchMedia('(prefers-reduced-motion: reduce)').matches;


    const stages = [

        { at: 0, text: 'Encendiendo motor…' },

        { at: 28, text: 'Compilando arquitectura…' },

        { at: 60, text: 'Cargando unidades…' },

        { at: 90, text: 'Listo.' }

    ];


    let progress = 0;


    const duration = reduceMotion ? 200 : 2200;


    const start = performance.now();


    function frame(now) {

        const elapsed = now - start;


        progress = Math.min(
            100,
            Math.round((elapsed / duration) * 100)
        );


        if (gaugeFill) {

            gaugeFill.style.strokeDashoffset =
                String(CIRCUMFERENCE * (1 - progress / 100));

        }


        if (percentEl) {

            percentEl.textContent = String(progress);

        }


        if (barFill) {

            barFill.style.width = progress + '%';

        }


        if (statusEl) {

            const stage = [...stages]
                .reverse()
                .find(s => progress >= s.at);

            if (stage) {

                statusEl.textContent = stage.text;

            }

        }


        if (progress < 100) {

            requestAnimationFrame(frame);

        } else {

            finishLoading();

        }

    }


    function finishLoading() {

        setTimeout(() => {

            loader.classList.add('is-done');


            if (site) {

                site.removeAttribute('aria-hidden');

                site.classList.add('is-revealed');

            }


            const heading = document.querySelector('.hero h1');


            if (heading) {

                heading.setAttribute('tabindex', '-1');

                heading.focus({ preventScroll: true });

            }


            loader.addEventListener(
                'transitionend',
                () => loader.remove(),
                { once: true }
            );

        }, 260);

    }


    requestAnimationFrame(frame);

}


/* ============================================================
   HERO — PARALLAX
   ============================================================ */

function setupHeroParallax() {

    const frame = document.querySelector('.hero-media-frame');


    const img = frame ? frame.querySelector('img') : null;


    if (!frame || !img) return;


    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {

        return;

    }


    if (window.matchMedia('(hover: none)').matches) {

        return;

    }


    frame.addEventListener('mousemove', (e) => {

        const rect = frame.getBoundingClientRect();


        const x = (e.clientX - rect.left) / rect.width - 0.5;


        const y = (e.clientY - rect.top) / rect.height - 0.5;


        img.style.transform =
            `scale(1.12) translate(${x * -14}px, ${y * -10}px)`;

    });


    frame.addEventListener('mouseleave', () => {

        img.style.transform = '';

    });

}


/* ============================================================
   ACORDEÓN DE UNIDADES
   ============================================================ */

function setupUnidadAccordion() {

    document
        .querySelectorAll('.unidad-toggle')
        .forEach((btn) => {

            btn.addEventListener('click', () => {

                const card = btn.closest('.unidad-card');


                if (!card) return;


                const isOpen = card.classList.toggle('is-open');


                btn.setAttribute('aria-expanded', String(isOpen));

            });

        });

}


/* ============================================================
   MODAL DE LOGIN
   ============================================================ */

function setupUserModal() {

    const userBtn = document.getElementById('userBtn');

    const overlay = document.getElementById('loginModal');

    const closeBtn = document.getElementById('loginClose');

    const form = document.getElementById('loginForm');

    const submitBtn = document.getElementById('loginSubmit');

    const errorEl = document.getElementById('loginError');

    const logoutBtn = document.getElementById('logoutBtn');


    if (!userBtn || !overlay || !form) {

        return;

    }


    const open = () => {

        hideError();

        overlay.classList.add('is-open');

        const firstField = overlay.querySelector('input');

        if (firstField) {

            firstField.focus();

        }

    };


    const close = () => {

        overlay.classList.remove('is-open');

    };


    const showError = (msg) => {

        if (!errorEl) return;

        errorEl.textContent = msg;

        errorEl.hidden = false;

    };


    const hideError = () => {

        if (!errorEl) return;

        errorEl.hidden = true;

        errorEl.textContent = '';

    };


    userBtn.addEventListener('click', open);


    closeBtn?.addEventListener('click', close);


    overlay.addEventListener('click', (e) => {

        if (e.target === overlay) {

            close();

        }

    });


    document.addEventListener('keydown', (e) => {

        if (e.key === 'Escape') {

            close();

        }

    });


    form.addEventListener('submit', async (e) => {

        e.preventDefault();


        hideError();


        if (submitBtn) {

            submitBtn.disabled = true;

            submitBtn.textContent = 'Ingresando…';

        }


        const email =
            document.getElementById('email')?.value.trim() || '';


        const password =
            document.getElementById('password')?.value || '';


        try {

            const res = await fetch(API.login, {

                method: 'POST',

                headers: {
                    'Content-Type': 'application/json'
                },

                body: JSON.stringify({ email, password })

            });


            const data = await res.json();


            if (!res.ok || !data.ok) {

                showError(
                    data.error || 'No se pudo iniciar sesión.'
                );

                return;

            }


            /*
             * SESIÓN CORRECTA
             * La condición de administrador se basa
             * exclusivamente en el rol enviado por el servidor.
             */

            sesionActual = {

                autenticado: true,

                email: data.email || email,

                rol: data.rol || null,

                esAdmin:
                    data.esAdmin === true ||
                    String(data.rol || '').toLowerCase() === 'admin'

            };


            console.log('Sesión iniciada:', sesionActual);


            aplicarEstadoSesion();


            close();


            form.reset();


            await cargarEstadoArchivos();

        } catch (err) {

            console.error('Error de login:', err);


            showError('No se pudo conectar con el servidor.');

        } finally {

            if (submitBtn) {

                submitBtn.disabled = false;

                submitBtn.textContent = 'Ingresar';

            }

        }

    });


    if (logoutBtn) {

        logoutBtn.addEventListener('click', async () => {

            logoutBtn.disabled = true;


            try {

                await fetch(API.logout, { method: 'POST' });

            } catch (err) {

                console.error('Error cerrando sesión:', err);

            }


            /*
             * LIMPIAR SESIÓN
             */

            sesionActual = {

                autenticado: false,

                esAdmin: false,

                email: null,

                rol: null

            };


            aplicarEstadoSesion();


            await cargarEstadoArchivos();


            logoutBtn.disabled = false;

        });

    }

}


/* ============================================================
   SESIÓN
   ============================================================ */

async function iniciarSesionYEstado() {

    try {

        const res = await fetch(API.sesion);


        const data = await res.json();


        /*
         * LA API /api/sesion NO ENVÍA "ok"
         *
         * La respuesta real es:
         * { "autenticado": true, "esAdmin": true,
         *   "email": "...", "rol": "admin" }
         *
         * Por eso NO debemos comprobar data.ok.
         */

        if (!res.ok) {

            throw new Error(
                data.error || 'No se pudo consultar la sesión.'
            );

        }


        sesionActual = {

            autenticado: data.autenticado === true,

            email: data.email || null,

            rol: data.rol || null,

            esAdmin:
                data.esAdmin === true ||
                String(data.rol || '').toLowerCase() === 'admin'

        };


        console.log('Estado de sesión:', sesionActual);


    } catch (err) {

        console.error('No se pudo consultar la sesión:', err);


        sesionActual = {

            autenticado: false,

            esAdmin: false,

            email: null,

            rol: null

        };

    }


    aplicarEstadoSesion();


    await cargarEstadoArchivos();

}


/* ============================================================
   APLICAR ESTADO DE SESIÓN
   ============================================================ */

function aplicarEstadoSesion() {

    const site = document.getElementById('site');

    const chip = document.getElementById('hudChip');

    const userBtn = document.getElementById('userBtn');

    const logoutBtn = document.getElementById('logoutBtn');


    /* VERIFICAR ADMINISTRADOR */

    const esAdministrador =
        sesionActual.autenticado === true &&
        sesionActual.esAdmin === true;


    /* ESTADO GENERAL DEL SITIO */

    if (site) {

        site.classList.toggle('is-admin', esAdministrador);

    }


    /* ELEMENTOS SOLO PARA ADMINISTRADOR */

    document
        .querySelectorAll('.admin-only')
        .forEach((el) => {

            if (esAdministrador) {

                /*
                 * Un control de eliminación solo se muestra cuando
                 * representa un archivo existente y ya tiene ID.
                 * Evita mostrar botones de borrar en slots vacíos.
                 */
                if (el.matches('[data-delete]') && !el.dataset.id) {
                    el.hidden = true;
                    el.style.setProperty('display', 'none', 'important');
                    return;
                }

                el.hidden = false;

                /*
                 * Eliminamos cualquier display:none
                 * aplicado anteriormente por JavaScript.
                 */

                el.style.removeProperty('display');

            } else {

                el.hidden = true;

                /*
                 * .btn utiliza display:inline-flex, por eso
                 * hidden por sí solo puede ser sobrescrito.
                 * Usamos !important para garantizar
                 * que el botón desaparezca.
                 */

                el.style.setProperty('display', 'none', 'important');

            }

        });


    /* USUARIO AUTENTICADO */

    if (sesionActual.autenticado === true) {

        if (chip) {

            chip.hidden = false;

            chip.textContent =
                esAdministrador
                    ? `Admin · ${sesionActual.email || ''}`
                    : (sesionActual.email || 'Usuario');

        }


        if (userBtn) {

            userBtn.hidden = true;

        }


        if (logoutBtn) {

            logoutBtn.hidden = false;

        }

    }

    /* USUARIO NO AUTENTICADO */

    else {

        if (chip) {

            chip.hidden = true;

        }


        if (userBtn) {

            userBtn.hidden = false;

        }


        if (logoutBtn) {

            logoutBtn.hidden = true;

        }

    }

}


/* ============================================================
   PREPARACIÓN VISUAL DE ARCHIVOS
   - Oculta temporalmente secciones vacías mientras se consulta API.
   - Añade estilos a los elementos de trabajo creados dinámicamente.
   ============================================================ */

function instalarEstilosDinamicosArchivos() {

    if (document.getElementById('main-archivos-dynamic-css')) return;

    const style = document.createElement('style');
    style.id = 'main-archivos-dynamic-css';
    style.textContent = `
        body.miportafolio-unidad .trabajos-lista {
            display: flex;
            flex-direction: column;
            gap: 12px;
            width: 100%;
            min-width: 0;
            margin-top: 14px;
        }

        body.miportafolio-unidad .trabajo-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 14px;
            width: 100%;
            min-width: 0;
        }

        body.miportafolio-unidad .trabajo-item .archivo-info {
            flex: 1 1 220px;
            min-width: 0;
        }

        body.miportafolio-unidad .trabajo-item .archivo-status {
            display: block;
            overflow-wrap: anywhere;
            color: #eaf2ea !important;
            font-weight: 700;
        }

        body.miportafolio-unidad .trabajos-vacio {
            margin: 0;
            padding: 15px;
            border: 1px dashed #344334;
            border-radius: 9px;
            color: #8b978e !important;
            background: rgba(10, 15, 12, .55) !important;
            font-size: 13px;
            line-height: 1.6;
        }

        body.miportafolio-unidad .trabajo-item .archivo-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        body.miportafolio-unidad .trabajo-item a[data-view] {
            color: #b9e879 !important;
            background: rgba(147, 213, 0, .06) !important;
            border-color: rgba(147, 213, 0, .35) !important;
        }

        body.miportafolio-unidad .trabajo-item a[data-download] {
            color: #0a0f0c !important;
            background: #93d500 !important;
            border-color: #93d500 !important;
        }

        body.miportafolio-unidad .trabajo-item button[data-delete] {
            color: #ff897d !important;
            background: rgba(255, 70, 48, .07) !important;
            border-color: rgba(255, 70, 48, .35) !important;
        }

        body.miportafolio-unidad .trabajo-item button[data-delete]:hover {
            color: #fff !important;
            background: #c93425 !important;
            border-color: #ff4630 !important;
        }

        @media (max-width: 600px) {
            body.miportafolio-unidad .trabajo-item {
                align-items: flex-start;
                flex-direction: column;
            }

            body.miportafolio-unidad .trabajo-item .archivo-actions {
                width: 100%;
            }
        }
    `;

    document.head.appendChild(style);
}


function prepararVistaInicialArchivos() {

    document.querySelectorAll('.trabajo-section, .infografias-section')
        .forEach((seccion) => {
            seccion.hidden = true;
            seccion.style.setProperty('display', 'none', 'important');
        });
}


function esAdministradorActual() {
    return sesionActual.autenticado === true &&
        sesionActual.esAdmin === true;
}


function actualizarVisibilidadInfografias(seccion) {

    if (!seccion) return;

    const administrador = esAdministradorActual();
    let hayImagenDisponible = false;

    seccion.querySelectorAll('.info-card').forEach((card) => {
        const img = card.querySelector('[data-thumb-img]');
        const disponible = Boolean(
            img &&
            !img.hidden &&
            img.getAttribute('src') &&
            !img.dataset.loadError
        );

        if (disponible) hayImagenDisponible = true;

        card.hidden = !(administrador || disponible);

        if (card.hidden) {
            card.style.setProperty('display', 'none', 'important');
        } else {
            card.style.removeProperty('display');
        }
    });

    seccion.hidden = !(administrador || hayImagenDisponible);

    if (seccion.hidden) {
        seccion.style.setProperty('display', 'none', 'important');
    } else {
        seccion.style.removeProperty('display');
    }
}


/* ============================================================
   ESTADO DE ARCHIVOS
   ============================================================ */

async function cargarEstadoArchivos() {

    /*
     * Solamente cargamos archivos si la página
     * contiene semanas.
     */

    const semanas = document.querySelectorAll('.semana-item');


    if (!semanas.length) {

        return;

    }


    await cargarArchivosPorSemana();

}


/* ============================================================
   CARGAR ARCHIVOS POR UNIDAD + SEMANA
   - Carga todos los trabajos e infografías.
   - Muestra todos los PDF de cada semana.
   - Oculta infografías vacías para los visitantes.
   - El administrador conserva los espacios para subir archivos.
   ============================================================ */

async function cargarArchivosPorSemana() {

    const semanas = document.querySelectorAll('.semana-item');

    /*
     * Cada semana realiza una consulta:
     * /api/archivos?unidad=1&semana=1
     *
     * Devuelve los trabajos e infografías de esa semana.
     */

    await Promise.all(

        [...semanas].map(async (semanaItem) => {

            const unidad = semanaItem.dataset.unidad;
            const semana = semanaItem.dataset.semana;

            if (!unidad || !semana) {
                return;
            }

            try {

                const url =
                    API.archivos +
                    '?unidad=' + encodeURIComponent(unidad) +
                    '&semana=' + encodeURIComponent(semana);

                const res = await fetch(url);
                const data = await res.json();

                if (!res.ok || !data.ok) {

                    console.error(
                        `Error cargando Unidad ${unidad}, Semana ${semana}:`,
                        data.error
                    );

                    if (esAdministradorActual()) {
                        const trabajosSection = semanaItem.querySelector('.trabajo-section');
                        const infoSection = semanaItem.querySelector('.infografias-section');

                        [trabajosSection, infoSection].forEach((seccion) => {
                            if (seccion) {
                                seccion.hidden = false;
                                seccion.style.removeProperty('display');
                            }
                        });
                    }

                    return;
                }

                const archivos = Array.isArray(data.archivos)
                    ? data.archivos
                    : [];

                // Separar los trabajos y las infografías.
                const trabajos = archivos.filter(
                    archivo => archivo.tipo === 'trabajo'
                );

                const infografias = archivos.filter(
                    archivo => archivo.tipo === 'infografia'
                );

                /*
                 * TRABAJOS PDF
                 *
                 * Mostrar todos los trabajos de la semana.
                 * La función pintarTrabajos() debe estar definida
                 * en el mismo archivo JavaScript.
                 */

                pintarTrabajos(semanaItem, trabajos);

                /*
                 * IDENTIFICAR SI EL USUARIO ES ADMINISTRADOR
                 */

                const esAdmin =
                    sesionActual.autenticado === true &&
                    sesionActual.esAdmin === true;

                /*
                 * ORGANIZAR LAS INFOGRAFÍAS POR SLOT
                 *
                 * Cada infografía se relaciona con su tarjeta
                 * mediante el número de slot.
                 */

                const porSlot = new Map();

                infografias.forEach((archivo) => {

                    if (archivo.slot != null) {

                        porSlot.set(
                            Number(archivo.slot),
                            archivo
                        );
                    }
                });

                /*
                 * OCULTAR LA SECCIÓN DE INFOGRAFÍAS VACÍA
                 *
                 * Visitante:
                 * - Oculta la sección si no tiene infografías.
                 * - Muestra la sección si tiene al menos una.
                 *
                 * Administrador:
                 * - Siempre puede ver la sección para subir archivos.
                 */

                const seccionInfo =
                    semanaItem.querySelector('.infografias-section');

                if (seccionInfo) {

                    const hayInfografias = infografias.length > 0;

                    const mostrarSeccion =
                        hayInfografias || esAdmin;

                    seccionInfo.hidden = !mostrarSeccion;

                    if (mostrarSeccion) {

                        seccionInfo.style.removeProperty('display');

                    } else {

                        seccionInfo.style.setProperty(
                            'display',
                            'none',
                            'important'
                        );
                    }
                }

                /*
                 * OCULTAR LAS TARJETAS DE INFOGRAFÍAS VACÍAS
                 *
                 * Visitante:
                 * - Solo ve las tarjetas que tienen una infografía.
                 *
                 * Administrador:
                 * - Ve todas las tarjetas disponibles para subir
                 *   nuevas infografías.
                 */

                semanaItem
                    .querySelectorAll('.info-card')
                    .forEach((card) => {

                        const slot = Number(card.dataset.slot);

                        const archivo =
                            porSlot.get(slot) || null;

                        // Pintar la infografía o indicar que está vacía.
                        pintarInfografia(card, archivo);

                        const mostrarTarjeta =
                            Boolean(archivo) || esAdmin;

                        card.hidden = !mostrarTarjeta;

                        if (mostrarTarjeta) {

                            card.style.removeProperty('display');

                        } else {

                            card.style.setProperty(
                                'display',
                                'none',
                                'important'
                            );
                        }
                    });

            } catch (err) {

                console.error(
                    `No se pudo cargar la Semana ${semana} de la Unidad ${unidad}:`,
                    err
                );
            }
        })
    );
}


/* ============================================================
   PINTAR TRABAJOS
   - Permite mostrar varios PDF por semana.
   - Oculta la sección si no hay trabajos, excepto para el admin.
   - Permite al administrador eliminar cada PDF.
   ============================================================ */

function pintarTrabajos(semanaItem, trabajos) {

    const trabajoSection = semanaItem.querySelector('.trabajo-section');
    if (!trabajoSection) return;

    const esAdmin = esAdministradorActual();
    const hayTrabajos = Array.isArray(trabajos) && trabajos.length > 0;

    trabajoSection.hidden = !(hayTrabajos || esAdmin);

    if (trabajoSection.hidden) {
        trabajoSection.style.setProperty('display', 'none', 'important');
    } else {
        trabajoSection.style.removeProperty('display');
    }

    // La fila antigua del JSP no se utiliza porque ahora admitimos varios PDF.
    const filaAntigua = trabajoSection.querySelector(':scope > .archivo-item');
    if (filaAntigua) {
        filaAntigua.hidden = true;
        filaAntigua.style.setProperty('display', 'none', 'important');
    }

    // Crear una lista única, colocada debajo de la cabecera (no dentro del flex header).
    let lista = trabajoSection.querySelector('.trabajos-lista');

    if (!lista) {
        lista = document.createElement('div');
        lista.className = 'trabajos-lista';

        const cabecera = trabajoSection.querySelector('.material-header');
        if (cabecera) {
            cabecera.insertAdjacentElement('afterend', lista);
        } else {
            trabajoSection.appendChild(lista);
        }
    }

    lista.replaceChildren();

    // Ocultar controles antiguos de un solo archivo.
    trabajoSection.querySelectorAll(
        ':scope > .archivo-item [data-status], :scope > .archivo-item [data-view], ' +
        ':scope > .archivo-item [data-download], :scope > .archivo-item [data-delete]'
    ).forEach((elemento) => {
        elemento.hidden = true;
        elemento.style.setProperty('display', 'none', 'important');
    });

    if (!hayTrabajos) {
        if (esAdmin) {
            const vacio = document.createElement('p');
            vacio.className = 'trabajos-vacio';
            vacio.textContent = 'Todavía no has subido documentos PDF para esta semana.';
            lista.appendChild(vacio);
        }
        return;
    }

    trabajos.forEach((archivo) => {
        if (!archivo || archivo.id == null) return;

        const fila = document.createElement('div');
        fila.className = 'archivo-item trabajo-item';

        const informacion = document.createElement('div');
        informacion.className = 'archivo-info';

        const nombre = document.createElement('span');
        nombre.className = 'archivo-status is-uploaded';
        nombre.textContent = archivo.nombreOriginal || 'Documento PDF';
        informacion.appendChild(nombre);

        const acciones = document.createElement('div');
        acciones.className = 'archivo-actions';

        const ver = document.createElement('a');
        ver.className = 'btn btn-small';
        ver.href = construirUrlVer(archivo.id);
        ver.dataset.view = '';
        ver.dataset.nombre = archivo.nombreOriginal || 'Documento PDF';
        ver.target = '_blank';
        ver.rel = 'noopener';
        ver.textContent = '👁 Ver';
        ver.setAttribute('aria-label', 'Ver ' + (archivo.nombreOriginal || 'documento PDF'));
        acciones.appendChild(ver);

        const descargar = document.createElement('a');
        descargar.className = 'btn btn-small';
        descargar.href = construirUrlDescargar(archivo.id);
        descargar.dataset.download = '';
        descargar.download = archivo.nombreOriginal || 'documento.pdf';
        descargar.textContent = '↓ Descargar';
        descargar.setAttribute('aria-label', 'Descargar ' + (archivo.nombreOriginal || 'documento PDF'));
        acciones.appendChild(descargar);

        if (esAdmin) {
            const eliminar = document.createElement('button');
            eliminar.type = 'button';
            eliminar.className = 'btn btn-small btn-danger admin-only';
            eliminar.dataset.delete = '';
            eliminar.dataset.id = String(archivo.id);
            eliminar.textContent = '× Eliminar';
            eliminar.setAttribute('aria-label', 'Eliminar ' + (archivo.nombreOriginal || 'documento PDF'));
            acciones.appendChild(eliminar);
        }

        fila.appendChild(informacion);
        fila.appendChild(acciones);
        lista.appendChild(fila);
    });
}


/* ============================================================
   CARGAR / PINTAR INFOGRAFÍA
   ============================================================ */

function pintarInfografia(card, archivo) {

    const img = card.querySelector('[data-thumb-img]');
    const emptyText = card.querySelector('[data-empty-text]');
    const view = card.querySelector('[data-view]');
    const download = card.querySelector('[data-download]');
    const del = card.querySelector('[data-delete]');
    const seccion = card.closest('.infografias-section');
    const administrador = esAdministradorActual();

    if (archivo) {
        const viewUrl = construirUrlVer(archivo.id);
        const downloadUrl = construirUrlDescargar(archivo.id);
        const nombre = archivo.nombreOriginal || 'Infografía';
        const esArchivoImagen = esImagen(nombre);

        if (img) {
            // Quitar el estado de error anterior antes de cargar el archivo actual.
            delete img.dataset.loadError;

            if (esArchivoImagen) {
                img.alt = nombre;
                img.hidden = false;

                // Preparar los callbacks antes de asignar src para evitar carreras.
                img.onload = () => {
                    delete img.dataset.loadError;
                    img.hidden = false;

                    if (emptyText) emptyText.hidden = true;

                    card.hidden = false;
                    card.style.removeProperty('display');
                    actualizarVisibilidadInfografias(seccion);
                };

                img.onerror = () => {
                    img.hidden = true;
                    img.removeAttribute('src');
                    img.dataset.loadError = 'true';

                    if (emptyText) {
                        emptyText.textContent = 'No se pudo cargar la imagen.';
                        emptyText.hidden = false;
                    }

                    // No mostrar enlaces rotos a visitantes; el administrador
                    // puede conservar la tarjeta y eliminar el archivo defectuoso.
                    if (view) {
                        view.hidden = true;
                        view.removeAttribute('href');
                    }

                    if (download) {
                        download.hidden = true;
                        download.removeAttribute('href');
                    }

                    card.hidden = !esAdministradorActual();

                    if (card.hidden) {
                        card.style.setProperty('display', 'none', 'important');
                    } else {
                        card.style.removeProperty('display');
                    }

                    actualizarVisibilidadInfografias(seccion);
                };

                // Evitar asignar otra vez la misma URL si ya está cargándose/cargada.
                if (img.getAttribute('src') !== viewUrl) {
                    img.src = viewUrl;
                } else if (img.complete && img.naturalWidth > 0) {
                    img.hidden = false;
                    if (emptyText) emptyText.hidden = true;
                }

            } else {
                img.hidden = true;
                img.removeAttribute('src');
                img.onload = null;
                img.onerror = null;
            }
        }

        if (emptyText) {
            if (esArchivoImagen) {
                // Se muestra solo si no se puede cargar la miniatura.
                emptyText.textContent = nombre;
                emptyText.hidden = Boolean(img && !img.hidden && !img.dataset.loadError);
            } else {
                emptyText.textContent = nombre;
                emptyText.hidden = false;
            }
        }

        if (view) {
            view.href = viewUrl;
            view.hidden = false;
            view.style.removeProperty('display');
        }

        if (download) {
            download.href = downloadUrl;
            download.download = nombre;
            download.hidden = false;
            download.style.removeProperty('display');
        }

        if (del) {
            del.dataset.id = String(archivo.id);
            del.hidden = !administrador;

            if (administrador) {
                del.style.removeProperty('display');
            } else {
                del.style.setProperty('display', 'none', 'important');
            }
        }

        card.hidden = false;
        card.style.removeProperty('display');

    } else {
        if (img) {
            img.onload = null;
            img.onerror = null;
            img.hidden = true;
            img.removeAttribute('src');
            delete img.dataset.loadError;
        }

        if (emptyText) {
            emptyText.textContent = 'Sin infografía';
            emptyText.hidden = false;
        }

        if (view) {
            view.hidden = true;
            view.removeAttribute('href');
        }

        if (download) {
            download.hidden = true;
            download.removeAttribute('href');
        }

        if (del) {
            del.hidden = true;
            del.style.setProperty('display', 'none', 'important');
            delete del.dataset.id;
        }

        card.hidden = !administrador;

        if (card.hidden) {
            card.style.setProperty('display', 'none', 'important');
        } else {
            card.style.removeProperty('display');
        }
    }
}


/* ============================================================
   URL PARA VISUALIZAR
   ============================================================ */

function construirUrlVer(id) {

    return API.ver + '?id=' + encodeURIComponent(id);

}


/* ============================================================
   URL PARA DESCARGAR
   ============================================================ */

function construirUrlDescargar(id) {

    return API.descargar + '?id=' + encodeURIComponent(id);

}


/* ============================================================
   VALIDACIÓN DE IMÁGENES
   ============================================================ */

function esImagen(nombre) {

    return /\.(png|jpe?g)$/i.test(nombre || '');

}


/* ============================================================
   VALIDACIÓN PDF
   ============================================================ */

function esPDF(nombre) {

    return /\.pdf$/i.test(nombre || '');

}


/* ============================================================
   TRUNCAR TEXTO
   ============================================================ */

function truncar(texto, max) {

    if (!texto) return '';

    return texto.length > max
        ? texto.slice(0, max - 1) + '…'
        : texto;

}


/* ============================================================
   ADMIN — SUBIR / ELIMINAR
   ============================================================ */

function setupAdminHandlers() {

    /* SUBIDA */

    document.addEventListener('change', (e) => {

        const input = e.target.closest('[data-upload-input]');


        if (!input || !input.files || !input.files[0]) {

            return;

        }


        manejarSubida(input);

    });


    /* ELIMINACIÓN */

    document.addEventListener('click', (e) => {

        const btn = e.target.closest('[data-delete]');


        if (!btn) {

            return;

        }


        /*
         * Si está oculto, nunca procesamos el botón.
         */

        if (
            btn.hidden ||
            sesionActual.autenticado !== true ||
            sesionActual.esAdmin !== true ||
            !btn.dataset.id
        ) {

            return;

        }


        manejarEliminacion(btn);

    });

}


/* ============================================================
   SUBIR ARCHIVO
   ============================================================ */

async function manejarSubida(input) {

    const file = input.files && input.files[0];


    if (!file) {
        return;
    }


    /* VERIFICAR SESIÓN DE ADMINISTRADOR */

    if (
        sesionActual.autenticado !== true ||
        sesionActual.esAdmin !== true
    ) {

        alert(
            'Debes iniciar sesión como administrador para subir archivos.'
        );

        input.value = '';

        return;
    }


    /* LOCALIZAR ELEMENTOS */

    const infoCard = input.closest('.info-card');

    const semanaItem = input.closest('.semana-item');


    let tipo = null;
    let unidad = null;
    let semana = null;
    let slot = null;


    /* ========================================================
       INFOGRAFÍA
       ======================================================== */

    if (infoCard) {

        tipo = 'infografia';


        /*
         * La información principal debe estar
         * directamente en .info-card
         * (data-unidad, data-semana, data-slot).
         */

        unidad = infoCard.dataset.unidad || null;

        semana = infoCard.dataset.semana || null;

        slot = infoCard.dataset.slot || null;


        /*
         * Respaldo: si .info-card no tiene unidad o semana,
         * buscamos los datos en .semana-item.
         */

        if ((!unidad || !semana) && semanaItem) {

            unidad = unidad || semanaItem.dataset.unidad || null;

            semana = semana || semanaItem.dataset.semana || null;

        }


        console.log('INFOGRAFÍA:', {
            unidad,
            semana,
            slot,
            archivo: file.name
        });


        /* VALIDAR DATOS */

        const unidadNumero = Number(unidad);

        const semanaNumero = Number(semana);

        const slotNumero = Number(slot);


        if (
            !Number.isInteger(unidadNumero) ||
            unidadNumero < 1 ||
            unidadNumero > 4
        ) {

            console.error('Unidad inválida:', unidad);

            alert('La unidad de la infografía no es válida.');

            input.value = '';

            return;
        }


        if (
            !Number.isInteger(semanaNumero) ||
            semanaNumero < 1 ||
            semanaNumero > 16
        ) {

            console.error('Semana inválida:', semana);

            alert('La semana de la infografía no es válida.');

            input.value = '';

            return;
        }


        if (
            !Number.isInteger(slotNumero) ||
            slotNumero < 1 ||
            slotNumero > 7
        ) {

            console.error('Slot inválido:', slot);

            alert('El número de infografía debe estar entre 1 y 7.');

            input.value = '';

            return;
        }


        /* Normalizamos los valores. */

        unidad = unidadNumero;

        semana = semanaNumero;

        slot = slotNumero;


        /* VALIDAR EXTENSIÓN */

        if (!esImagen(file.name)) {

            alert(
                'Las infografías deben estar en formato JPG, JPEG o PNG.'
            );

            input.value = '';

            return;
        }

    }


    /* ========================================================
       TRABAJO
       ======================================================== */

    else if (semanaItem) {

        tipo = 'trabajo';


        unidad = semanaItem.dataset.unidad || null;

        semana = semanaItem.dataset.semana || null;


        console.log('TRABAJO:', {
            unidad,
            semana,
            archivo: file.name
        });


        /* VALIDAR DATOS */

        const unidadNumero = Number(unidad);

        const semanaNumero = Number(semana);


        if (
            !Number.isInteger(unidadNumero) ||
            unidadNumero < 1 ||
            unidadNumero > 4
        ) {

            console.error('Unidad inválida:', unidad);

            alert('La unidad del trabajo no es válida.');

            input.value = '';

            return;
        }


        if (
            !Number.isInteger(semanaNumero) ||
            semanaNumero < 1 ||
            semanaNumero > 16
        ) {

            console.error('Semana inválida:', semana);

            alert('La semana del trabajo no es válida.');

            input.value = '';

            return;
        }


        /* Normalizamos los valores. */

        unidad = unidadNumero;

        semana = semanaNumero;


        /* VALIDAR PDF */

        if (!esPDF(file.name)) {

            alert('El trabajo debe estar en formato PDF.');

            input.value = '';

            return;
        }

    }


    /* ========================================================
       INPUT NO VÁLIDO
       ======================================================== */

    else {

        console.error(
            'El input de archivo no pertenece a una semana válida:',
            input
        );

        input.value = '';

        return;
    }


    /* FORM DATA */

    const formData = new FormData();


    formData.append('archivo', file);

    formData.append('tipo', tipo);

    formData.append('unidad', String(unidad));

    formData.append('semana', String(semana));


    if (tipo === 'infografia') {

        formData.append('slot', String(slot));

    }


    /* INDICADOR DE CARGA */

    const label = input.closest('label');


    if (label) {

        label.classList.add('is-loading');

    }


    try {

        console.log('Enviando archivo:', {
            tipo,
            unidad,
            semana,
            slot,
            nombre: file.name,
            tamano: file.size
        });


        /* ENVIAR AL SERVIDOR */

        const res = await fetch(API.subir, {

            method: 'POST',

            body: formData

        });


        /* LEER RESPUESTA */

        const data = await res.json();


        console.log('Respuesta del servidor:', {
            status: res.status,
            data
        });


        /* ERROR */

        if (!res.ok || !data.ok) {

            alert(data.error || 'No se pudo subir el archivo.');

            return;
        }


        /* SUBIDA CORRECTA */

        alert(
            tipo === 'infografia'
                ? 'Infografía subida correctamente.'
                : 'Trabajo subido correctamente.'
        );


        /*
         * Volvemos a consultar los archivos.
         * Esto actualiza: nombre, miniatura,
         * VER, DESCARGAR y ELIMINAR.
         */

        await cargarEstadoArchivos();

    } catch (err) {

        console.error('Error subiendo archivo:', err);

        alert(
            'No se pudo conectar con el servidor para subir el archivo.'
        );

    } finally {

        /*
         * Limpiamos el input para permitir
         * seleccionar nuevamente el mismo archivo.
         */

        input.value = '';

        if (label) {

            label.classList.remove('is-loading');

        }

    }

}


/* ============================================================
   ELIMINAR ARCHIVO
   ============================================================ */

async function manejarEliminacion(btn) {

    /* SEGURIDAD DEL FRONTEND */

    if (
        sesionActual.autenticado !== true ||
        sesionActual.esAdmin !== true
    ) {

        return;

    }


    const id = btn.dataset.id;


    if (!id) {

        return;

    }


    if (
        !confirm(
            '¿Eliminar este archivo? Esta acción no se puede deshacer.'
        )
    ) {

        return;

    }


    btn.disabled = true;


    try {

        const res = await fetch(
            API.eliminar + '?id=' + encodeURIComponent(id),
            { method: 'POST' }
        );


        const data = await res.json();


        if (!res.ok || !data.ok) {

            alert(data.error || 'No se pudo eliminar el archivo.');

            return;

        }


        /*
         * Volvemos a consultar todos los archivos
         * para actualizar inmediatamente la interfaz.
         */

        await cargarEstadoArchivos();

    } catch (err) {

        console.error('Error eliminando archivo:', err);

        alert(
            'No se pudo conectar con el servidor para eliminar el archivo.'
        );

    } finally {

        btn.disabled = false;

    }

}


/* ============================================================
   VISOR DE ARCHIVOS
   (NUEVO: imágenes con zoom; PDF sigue igual en iframe)
   ============================================================ */

function setupArchivoViewer() {

    const viewer = document.getElementById('archivoViewer');

    const content = document.getElementById('archivoViewerContent');

    const closeBtn = document.getElementById('archivoViewerClose');

    const overlay =
        viewer
            ? viewer.querySelector('.archivo-viewer-overlay')
            : null;


    /*
     * Si la página no tiene visor,
     * los enlaces VER siguen funcionando normalmente.
     */

    if (!viewer || !content) {

        return;

    }


    function cerrar() {

        viewer.hidden = true;

        viewer.setAttribute('aria-hidden', 'true');

        content.innerHTML = '';

        document.body.classList.remove('viewer-open');

    }


    /* ========================================================
       IMAGEN CON ZOOM
       ======================================================== */

    function crearVisorImagen(url, nombre) {

        const MIN = 1;
        const MAX = 8;

        let scale = 1;
        let x = 0;
        let y = 0;


        const stage = document.createElement('div');

        stage.className = 'zoom-stage';


        const img = document.createElement('img');

        img.src = url;

        img.alt = nombre || 'Infografía';

        img.draggable = false;


        const toolbar = document.createElement('div');

        toolbar.className = 'zoom-toolbar';

        toolbar.innerHTML =
            '<button type="button" data-z="out" aria-label="Alejar">−</button>' +
            '<span class="zoom-level">100%</span>' +
            '<button type="button" data-z="in" aria-label="Acercar">+</button>' +
            '<button type="button" data-z="reset">100%</button>';


        const levelEl = toolbar.querySelector('.zoom-level');


        stage.appendChild(img);

        stage.appendChild(toolbar);


        function aplicar() {

            if (scale <= MIN) {

                scale = MIN;

                x = 0;

                y = 0;

            }


            img.style.transform =
                `translate(${x}px, ${y}px) scale(${scale})`;


            levelEl.textContent = Math.round(scale * 100) + '%';


            stage.classList.toggle('is-zoomed', scale > MIN);

        }


        /*
         * Cambia el zoom manteniendo fijo el punto (cx, cy),
         * medido desde el centro del stage.
         */

        function zoomEn(nuevaEscala, cx, cy) {

            const ns = Math.min(MAX, Math.max(MIN, nuevaEscala));

            const ratio = ns / scale;


            x = cx - (cx - x) * ratio;

            y = cy - (cy - y) * ratio;

            scale = ns;


            aplicar();

        }


        function centroRelativo(clientX, clientY) {

            const r = stage.getBoundingClientRect();

            return {
                x: clientX - (r.left + r.width / 2),
                y: clientY - (r.top + r.height / 2)
            };

        }


        /* Botones */

        toolbar.addEventListener('click', (e) => {

            const b = e.target.closest('[data-z]');

            if (!b) return;

            e.stopPropagation();


            if (b.dataset.z === 'in') zoomEn(scale * 1.4, 0, 0);

            if (b.dataset.z === 'out') zoomEn(scale / 1.4, 0, 0);

            if (b.dataset.z === 'reset') {

                scale = 1;

                aplicar();

            }

        });


        toolbar.addEventListener('pointerdown', (e) => {

            e.stopPropagation();

        });


        /* Rueda del mouse */

        stage.addEventListener('wheel', (e) => {

            e.preventDefault();

            const p = centroRelativo(e.clientX, e.clientY);

            const factor = e.deltaY < 0 ? 1.2 : 1 / 1.2;

            zoomEn(scale * factor, p.x, p.y);

        }, { passive: false });


        /* Doble clic: acercar / restablecer */

        stage.addEventListener('dblclick', (e) => {

            const p = centroRelativo(e.clientX, e.clientY);

            if (scale > MIN) {

                scale = 1;

                aplicar();

            } else {

                zoomEn(2.5, p.x, p.y);

            }

        });


        /* Arrastre (mouse y dedo) + pellizco */

        const punteros = new Map();

        let distanciaInicial = 0;

        let escalaInicial = 1;


        stage.addEventListener('pointerdown', (e) => {

            stage.setPointerCapture(e.pointerId);

            punteros.set(e.pointerId, { x: e.clientX, y: e.clientY });


            if (punteros.size === 2) {

                const [a, b] = [...punteros.values()];

                distanciaInicial = Math.hypot(a.x - b.x, a.y - b.y);

                escalaInicial = scale;

            }


            if (scale > MIN) stage.classList.add('is-dragging');

        });


        stage.addEventListener('pointermove', (e) => {

            const prev = punteros.get(e.pointerId);

            if (!prev) return;


            const actual = { x: e.clientX, y: e.clientY };


            if (punteros.size === 2) {

                punteros.set(e.pointerId, actual);

                const [a, b] = [...punteros.values()];

                const dist = Math.hypot(a.x - b.x, a.y - b.y);


                if (distanciaInicial > 0) {

                    const mid = centroRelativo(
                        (a.x + b.x) / 2,
                        (a.y + b.y) / 2
                    );

                    zoomEn(
                        escalaInicial * (dist / distanciaInicial),
                        mid.x,
                        mid.y
                    );

                }

                return;

            }


            if (scale > MIN) {

                x += actual.x - prev.x;

                y += actual.y - prev.y;

                aplicar();

            }


            punteros.set(e.pointerId, actual);

        });


        function soltar(e) {

            punteros.delete(e.pointerId);

            stage.classList.remove('is-dragging');

            distanciaInicial = 0;

        }


        stage.addEventListener('pointerup', soltar);

        stage.addEventListener('pointercancel', soltar);


        aplicar();


        return stage;

    }


    /* ========================================================
       ABRIR
       ======================================================== */

    function abrir(url, tipo, nombre) {

        content.innerHTML = '';


        /* IMAGEN (con zoom) */

        if (tipo === 'imagen') {

            content.appendChild(crearVisorImagen(url, nombre));

        }

        /* PDF (igual que antes) */

        else {

            const iframe = document.createElement('iframe');

            iframe.src = url;

            iframe.title = nombre || 'Documento PDF';

            iframe.className = 'archivo-viewer-pdf';

            content.appendChild(iframe);

        }


        viewer.hidden = false;

        viewer.setAttribute('aria-hidden', 'false');

        document.body.classList.add('viewer-open');


        if (closeBtn) {

            closeBtn.focus();

        }

    }


    closeBtn?.addEventListener('click', cerrar);

    overlay?.addEventListener('click', cerrar);


    document.addEventListener('keydown', (e) => {

        if (viewer.hidden) return;


        if (e.key === 'Escape') {

            cerrar();

            return;

        }


        const stage = content.querySelector('.zoom-stage');

        if (!stage) return;


        if (e.key === '+' || e.key === '=') {

            stage.querySelector('[data-z="in"]')?.click();

        }

        if (e.key === '-') {

            stage.querySelector('[data-z="out"]')?.click();

        }

        if (e.key === '0') {

            stage.querySelector('[data-z="reset"]')?.click();

        }

    });


    /* ========================================================
       BOTONES "VER"
       ======================================================== */

    document.addEventListener('click', (e) => {

        const btn = e.target.closest('[data-view]');


        if (!btn || btn.hidden || !btn.href) {

            return;

        }


        /*
         * Evitamos que el enlace abra otra página.
         */

        e.preventDefault();


        const card = btn.closest('.info-card');


        let nombre = 'Archivo';

        let tipo = 'pdf';


        /* INFOGRAFÍA */

        if (card) {

            const img = card.querySelector('[data-thumb-img]');


            if (img && !img.hidden && img.src) {

                tipo = 'imagen';

            }


            const emptyText = card.querySelector('[data-empty-text]');


            if (emptyText) {

                nombre = emptyText.textContent || 'Infografía';

            }

        }

        /* TRABAJO */

        else {

            const semanaItem = btn.closest('.semana-item');

            const status =
                semanaItem
                    ? semanaItem.querySelector('[data-status]')
                    : null;


            if (status) {

                nombre =
                   btn.dataset.nombre ||
                   (status ? status.textContent.replace('Subido: ', '') : 'Documento PDF');

            }

            tipo = 'pdf';

        }


        abrir(btn.href, tipo, nombre);

    });

}


/* ============================================================
   CARRUSEL HERO
   ============================================================ */

function setupHeroCarousel() {

    const slides = document.querySelectorAll('.hero-slide');

    const dots = document.querySelectorAll('.hero-dot');

    const prev = document.getElementById('heroPrev');

    const next = document.getElementById('heroNext');


    if (!slides.length) return;


    let current = 0;

    let timer = null;


    function mostrarSlide(index) {

        current = (index + slides.length) % slides.length;


        slides.forEach((slide, i) => {

            slide.classList.toggle('is-active', i === current);

        });


        dots.forEach((dot, i) => {

            dot.classList.toggle('is-active', i === current);

            dot.setAttribute(
                'aria-current',
                i === current ? 'true' : 'false'
            );

        });

    }


    function iniciarAutoPlay() {

        clearInterval(timer);

        timer = setInterval(() => {

            mostrarSlide(current + 1);

        }, 5000);

    }


    prev?.addEventListener('click', () => {

        mostrarSlide(current - 1);

        iniciarAutoPlay();

    });


    next?.addEventListener('click', () => {

        mostrarSlide(current + 1);

        iniciarAutoPlay();

    });


    dots.forEach((dot, index) => {

        dot.addEventListener('click', () => {

            mostrarSlide(index);

            iniciarAutoPlay();

        });

    });


    mostrarSlide(0);

    iniciarAutoPlay();

}
