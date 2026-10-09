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
   - Visualización de PDF e imágenes
   - Descarga de archivos
   ============================================================ */


/* ============================================================
   CONFIGURACIÓN API
   ============================================================ */

function obtenerContextPath() {

    const script = document.querySelector(
        'script[src*="/js/main.js"]'
    );

    if (script) {

        const src = new URL(
            script.getAttribute('src'),
            window.location.href
        );

        const partes = src.pathname.split('/');

        /*
         * main.js normalmente estará en:
         *
         * /MiPortafolio/js/main.js
         *
         * Quitamos:
         *
         * /js/main.js
         *
         * y conservamos:
         *
         * /MiPortafolio
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

    sesion:
        CONTEXT_PATH + '/api/sesion',

    login:
        CONTEXT_PATH + '/api/login',

    logout:
        CONTEXT_PATH + '/api/logout',

    archivos:
        CONTEXT_PATH + '/api/archivos',

    subir:
        CONTEXT_PATH + '/api/archivos/subir',

    ver:
        CONTEXT_PATH + '/api/archivos/ver',

    descargar:
        CONTEXT_PATH + '/api/archivos/descargar',

    eliminar:
        CONTEXT_PATH + '/api/archivos/eliminar'

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

document.addEventListener(
    'DOMContentLoaded',
    () => {

        runLoadingSequence();

        setupHeroParallax();

        setupUserModal();

        setupUnidadAccordion();

        setupAdminHandlers();

        setupArchivoViewer();

        iniciarSesionYEstado();

        setupHeroCarousel();

    }
);


/* ============================================================
   PANTALLA DE CARGA
   ============================================================ */

function runLoadingSequence() {

    const loader =
        document.getElementById('loader');

    /*
     * No todas las páginas tienen loader.
     */

    if (!loader) return;


    const gaugeFill =
        document.getElementById('gaugeFill');

    const percentEl =
        document.getElementById('loaderPercent');

    const statusEl =
        document.getElementById('loaderStatus');

    const barFill =
        document.getElementById('loaderBarFill');

    const site =
        document.getElementById('site');


    const CIRCUMFERENCE = 552.9;


    const reduceMotion =
        window.matchMedia(
            '(prefers-reduced-motion: reduce)'
        ).matches;


    const stages = [

        {
            at: 0,
            text: 'Encendiendo motor…'
        },

        {
            at: 28,
            text: 'Compilando arquitectura…'
        },

        {
            at: 60,
            text: 'Cargando unidades…'
        },

        {
            at: 90,
            text: 'Listo.'
        }

    ];


    let progress = 0;


    const duration =
        reduceMotion
            ? 200
            : 2200;


    const start =
        performance.now();


    function frame(now) {

        const elapsed =
            now - start;


        progress =
            Math.min(
                100,
                Math.round(
                    (elapsed / duration) * 100
                )
            );


        if (gaugeFill) {

            gaugeFill.style.strokeDashoffset =
                String(
                    CIRCUMFERENCE *
                    (1 - progress / 100)
                );

        }


        if (percentEl) {

            percentEl.textContent =
                String(progress);

        }


        if (barFill) {

            barFill.style.width =
                progress + '%';

        }


        if (statusEl) {

            const stage =
                [...stages]
                    .reverse()
                    .find(
                        s => progress >= s.at
                    );


            if (stage) {

                statusEl.textContent =
                    stage.text;

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

            loader.classList.add(
                'is-done'
            );


            if (site) {

                site.removeAttribute(
                    'aria-hidden'
                );


                site.classList.add(
                    'is-revealed'
                );

            }


            const heading =
                document.querySelector(
                    '.hero h1'
                );


            if (heading) {

                heading.setAttribute(
                    'tabindex',
                    '-1'
                );


                heading.focus({
                    preventScroll: true
                });

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

    const frame =
        document.querySelector(
            '.hero-media-frame'
        );


    const img =
        frame
            ? frame.querySelector('img')
            : null;


    if (!frame || !img) return;


    if (
        window.matchMedia(
            '(prefers-reduced-motion: reduce)'
        ).matches
    ) {

        return;

    }


    if (
        window.matchMedia(
            '(hover: none)'
        ).matches
    ) {

        return;

    }


    frame.addEventListener(
        'mousemove',
        (e) => {

            const rect =
                frame.getBoundingClientRect();


            const x =
                (e.clientX - rect.left) /
                rect.width - 0.5;


            const y =
                (e.clientY - rect.top) /
                rect.height - 0.5;


            img.style.transform =
                `scale(1.12) translate(${x * -14}px, ${y * -10}px)`;

        }
    );


    frame.addEventListener(
        'mouseleave',
        () => {

            img.style.transform = '';

        }
    );

}


/* ============================================================
   ACORDEÓN DE UNIDADES
   ============================================================ */

function setupUnidadAccordion() {

    document
        .querySelectorAll('.unidad-toggle')
        .forEach((btn) => {

            btn.addEventListener(
                'click',
                () => {

                    const card =
                        btn.closest(
                            '.unidad-card'
                        );


                    if (!card) return;


                    const isOpen =
                        card.classList.toggle(
                            'is-open'
                        );


                    btn.setAttribute(
                        'aria-expanded',
                        String(isOpen)
                    );

                }
            );

        });

}


/* ============================================================
   MODAL DE LOGIN
   ============================================================ */

function setupUserModal() {

    const userBtn =
        document.getElementById('userBtn');


    const overlay =
        document.getElementById('loginModal');


    const closeBtn =
        document.getElementById('loginClose');


    const form =
        document.getElementById('loginForm');


    const submitBtn =
        document.getElementById('loginSubmit');


    const errorEl =
        document.getElementById('loginError');


    const logoutBtn =
        document.getElementById('logoutBtn');


    if (
        !userBtn ||
        !overlay ||
        !form
    ) {

        return;

    }


    const open = () => {

        hideError();


        overlay.classList.add(
            'is-open'
        );


        const firstField =
            overlay.querySelector(
                'input'
            );


        if (firstField) {

            firstField.focus();

        }

    };


    const close = () => {

        overlay.classList.remove(
            'is-open'
        );

    };


    const showError = (msg) => {

        if (!errorEl) return;


        errorEl.textContent =
            msg;


        errorEl.hidden = false;

    };


    const hideError = () => {

        if (!errorEl) return;


        errorEl.hidden = true;


        errorEl.textContent = '';

    };


    userBtn.addEventListener(
        'click',
        open
    );


    closeBtn?.addEventListener(
        'click',
        close
    );


    overlay.addEventListener(
        'click',
        (e) => {

            if (
                e.target === overlay
            ) {

                close();

            }

        }
    );


    document.addEventListener(
        'keydown',
        (e) => {

            if (e.key === 'Escape') {

                close();

            }

        }
    );


    form.addEventListener(
        'submit',
        async (e) => {

            e.preventDefault();


            hideError();


            if (submitBtn) {

                submitBtn.disabled = true;

                submitBtn.textContent =
                    'Ingresando…';

            }


            const email =
                document
                    .getElementById('email')
                    ?.value
                    .trim() || '';


            const password =
                document
                    .getElementById('password')
                    ?.value || '';


            try {

                const res =
                    await fetch(
                        API.login,
                        {
                            method: 'POST',

                            headers: {
                                'Content-Type':
                                    'application/json'
                            },

                            body:
                                JSON.stringify({
                                    email,
                                    password
                                })
                        }
                    );


                const data =
                    await res.json();


                if (
                    !res.ok ||
                    !data.ok
                ) {

                    showError(
                        data.error ||
                        'No se pudo iniciar sesión.'
                    );

                    return;

                }


                /*
                 * =================================================
                 * SESIÓN CORRECTA
                 * =================================================
                 *
                 * La condición de administrador se basa
                 * exclusivamente en el rol enviado por el servidor.
                 */

                sesionActual = {

                    autenticado: true,

                    email:
                        data.email || email,

                    rol:
                        data.rol || null,

                    esAdmin:
                        data.rol === 'admin'

                };


                console.log(
                    'Sesión iniciada:',
                    sesionActual
                );


                aplicarEstadoSesion();


                close();


                form.reset();


                await cargarEstadoArchivos();

            } catch (err) {

                console.error(
                    'Error de login:',
                    err
                );


                showError(
                    'No se pudo conectar con el servidor.'
                );

            } finally {

                if (submitBtn) {

                    submitBtn.disabled = false;

                    submitBtn.textContent =
                        'Ingresar';

                }

            }

        }
    );


    if (logoutBtn) {

        logoutBtn.addEventListener(
            'click',
            async () => {

                logoutBtn.disabled = true;


                try {

                    await fetch(
                        API.logout,
                        {
                            method: 'POST'
                        }
                    );

                } catch (err) {

                    console.error(
                        'Error cerrando sesión:',
                        err
                    );

                }


                /*
                 * =================================================
                 * LIMPIAR SESIÓN
                 * =================================================
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

            }
        );

    }

}


/* ============================================================
   SESIÓN
   ============================================================ */

async function iniciarSesionYEstado() {

    try {

        const res =
            await fetch(
                API.sesion
            );


        const data =
            await res.json();


        /*
         * =====================================================
         * LA API /api/sesion NO ENVÍA "ok"
         * =====================================================
         *
         * La respuesta real es:
         *
         * {
         *     "autenticado": true,
         *     "esAdmin": true,
         *     "email": "...",
         *     "rol": "admin"
         * }
         *
         * Por eso NO debemos comprobar data.ok.
         */


        if (!res.ok) {

            throw new Error(
                data.error ||
                'No se pudo consultar la sesión.'
            );

        }


        sesionActual = {

            autenticado:
                data.autenticado === true,

            email:
                data.email || null,

            rol:
                data.rol || null,

            esAdmin:
                data.esAdmin === true ||
                data.rol === 'admin'

        };


        console.log(
            'Estado de sesión:',
            sesionActual
        );


    } catch (err) {

        console.error(
            'No se pudo consultar la sesión:',
            err
        );


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

    const site =
        document.getElementById('site');


    const chip =
        document.getElementById('hudChip');


    const userBtn =
        document.getElementById('userBtn');


    const logoutBtn =
        document.getElementById('logoutBtn');


    /* ========================================================
       VERIFICAR ADMINISTRADOR
       ======================================================== */

    const esAdministrador =
        sesionActual.autenticado === true &&
        sesionActual.esAdmin === true;


    /* ========================================================
       ESTADO GENERAL DEL SITIO
       ======================================================== */

    if (site) {

        site.classList.toggle(
            'is-admin',
            esAdministrador
        );

    }


    /* ========================================================
       ELEMENTOS SOLO PARA ADMINISTRADOR
       ======================================================== */

    document
        .querySelectorAll('.admin-only')
        .forEach((el) => {

            if (esAdministrador) {

                /*
                 * =================================================
                 * ADMINISTRADOR
                 * =================================================
                 *
                 * Mostramos el elemento.
                 */

                el.hidden = false;


                /*
                 * Eliminamos cualquier display:none
                 * aplicado anteriormente por JavaScript.
                 */

                el.style.removeProperty(
                    'display'
                );

            } else {

                /*
                 * =================================================
                 * INVITADO / USUARIO NORMAL
                 * =================================================
                 *
                 * Ocultamos completamente el elemento.
                 */

                el.hidden = true;


                /*
                 * IMPORTANTE:
                 *
                 * .btn utiliza:
                 *
                 * display: inline-flex;
                 *
                 * Por eso hidden por sí solo puede ser
                 * sobrescrito por CSS.
                 *
                 * Usamos !important para garantizar
                 * que el botón desaparezca.
                 */

                el.style.setProperty(
                    'display',
                    'none',
                    'important'
                );

            }

        });


    /* ========================================================
       USUARIO AUTENTICADO
       ======================================================== */

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

    /* ========================================================
       USUARIO NO AUTENTICADO
       ======================================================== */

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
   ESTADO DE ARCHIVOS
   ============================================================ */

async function cargarEstadoArchivos() {

    /*
     * Solamente cargamos archivos si la página
     * contiene semanas.
     */

    const semanas =
        document.querySelectorAll(
            '.semana-item'
        );


    if (!semanas.length) {

        return;

    }


    await cargarArchivosPorSemana();

}


/* ============================================================
   CARGAR ARCHIVOS POR UNIDAD + SEMANA
   ============================================================ */

async function cargarArchivosPorSemana() {

    const semanas =
        document.querySelectorAll(
            '.semana-item'
        );


    /*
     * Cada semana realiza una consulta:
     *
     * /api/archivos?unidad=1&semana=1
     *
     * Esto devuelve trabajos e infografías
     * pertenecientes exclusivamente a esa semana.
     */

    await Promise.all(

        [...semanas].map(
            async (semanaItem) => {

                const unidad =
                    semanaItem.dataset.unidad;


                const semana =
                    semanaItem.dataset.semana;


                if (
                    !unidad ||
                    !semana
                ) {

                    return;

                }


                try {

                    const url =
                        API.archivos +
                        '?unidad=' +
                        encodeURIComponent(
                            unidad
                        ) +
                        '&semana=' +
                        encodeURIComponent(
                            semana
                        );


                    const res =
                        await fetch(url);


                    const data =
                        await res.json();


                    if (
                        !res.ok ||
                        !data.ok
                    ) {

                        console.error(
                            `Error cargando Unidad ${unidad}, Semana ${semana}:`,
                            data.error
                        );

                        return;

                    }


                    const archivos =
                        Array.isArray(
                            data.archivos
                        )
                            ? data.archivos
                            : [];


                    const trabajos =
                        archivos.filter(
                            a =>
                                a.tipo === 'trabajo'
                        );


                    const infografias =
                        archivos.filter(
                            a =>
                                a.tipo === 'infografia'
                        );


                    /*
                     * Para trabajos mostramos
                     * el más reciente.
                     *
                     * El DAO ya los devuelve
                     * ordenados por creado_en desc.
                     */

                    const trabajo =
                        trabajos.length
                            ? trabajos[0]
                            : null;


                    pintarTrabajo(
                        semanaItem,
                        trabajo
                    );


                    /*
                     * Las infografías se relacionan
                     * mediante su slot.
                     */

                    const porSlot =
                        new Map();


                    infografias.forEach(
                        (archivo) => {

                            if (
                                archivo.slot != null
                            ) {

                                porSlot.set(
                                    Number(
                                        archivo.slot
                                    ),
                                    archivo
                                );

                            }

                        }
                    );


                    semanaItem
                        .querySelectorAll(
                            '.info-card'
                        )
                        .forEach(
                            (card) => {

                                const slot =
                                    Number(
                                        card.dataset.slot
                                    );


                                pintarInfografia(
                                    card,
                                    porSlot.get(slot) ||
                                    null
                                );

                            }
                        );

                } catch (err) {

                    console.error(
                        `No se pudo cargar la Semana ${semana} de la Unidad ${unidad}:`,
                        err
                    );

                }

            }
        )

    );

}


function pintarTrabajo(
    semanaItem,
    archivo
) {

    const trabajoSection =
        semanaItem.querySelector('.trabajo-section');

    if (!trabajoSection) return;

    const status =
        trabajoSection.querySelector('[data-status]');

    const view =
        trabajoSection.querySelector('[data-view]');

    const download =
        trabajoSection.querySelector('[data-download]');

    const del =
        trabajoSection.querySelector('[data-delete]');

    const esAdmin =
        sesionActual.autenticado === true &&
        sesionActual.esAdmin === true;

    /*
     * Visible solo si hay trabajo, o si es admin.
     */
    trabajoSection.hidden = !(archivo || esAdmin);

    if (archivo) {

        if (status) {
            status.textContent =
                'Subido: ' + truncar(archivo.nombreOriginal, 40);
            status.classList.add('is-uploaded');
        }

        if (view) {
            view.href = construirUrlVer(archivo.id);
            view.hidden = false;
        }

        if (download) {
            download.href = construirUrlDescargar(archivo.id);
            download.hidden = false;
        }

        if (del) {
            del.dataset.id = archivo.id;

            if (esAdmin) {
                del.hidden = false;
                del.style.removeProperty('display');
            } else {
                del.hidden = true;
                del.style.setProperty('display', 'none', 'important');
            }
        }

    } else {

        if (status) {
            status.textContent = 'Sin trabajo';
            status.classList.remove('is-uploaded');
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
    }
}


        /* ====================================================
           ELIMINAR — SOLO ADMIN
           ==================================================== */

        if (del) {

            del.dataset.id =
                archivo.id;


            if (
                sesionActual.autenticado === true &&
                sesionActual.esAdmin === true
            ) {

                del.hidden = false;

                del.style.removeProperty(
                    'display'
                );

            } else {

                del.hidden = true;

                del.style.setProperty(
                    'display',
                    'none',
                    'important'
                );

            }

        }

    } else {

        if (status) {

            status.textContent =
                'Sin trabajo';


            status.classList.remove(
                'is-uploaded'
            );

        }


        if (view) {

            view.hidden = true;

            view.removeAttribute(
                'href'
            );

        }


        if (download) {

            download.hidden = true;

            download.removeAttribute(
                'href'
            );

        }


        if (del) {

            del.hidden = true;

            del.style.setProperty(
                'display',
                'none',
                'important'
            );

            delete del.dataset.id;

        }

    }

}


/* ============================================================
   CARGAR / PINTAR INFOGRAFÍA
   ============================================================ */

function pintarInfografia(
    card,
    archivo
) {

    const img =
        card.querySelector(
            '[data-thumb-img]'
        );


    const emptyText =
        card.querySelector(
            '[data-empty-text]'
        );


    const view =
        card.querySelector(
            '[data-view]'
        );


    const download =
        card.querySelector(
            '[data-download]'
        );


    const del =
        card.querySelector(
            '[data-delete]'
        );


    if (archivo) {

        const viewUrl =
            construirUrlVer(
                archivo.id
            );


        const downloadUrl =
            construirUrlDescargar(
                archivo.id
            );


        /*
         * Si es imagen, la mostramos
         * directamente como miniatura.
         */

        if (
            img &&
            esImagen(
                archivo.nombreOriginal
            )
        ) {

            img.src =
                viewUrl;


            img.alt =
                archivo.nombreOriginal ||
                'Infografía';


            img.hidden = false;


            /*
             * Si la imagen no puede cargarse,
             * mostramos el estado vacío.
             */

            img.onerror = () => {

                img.hidden = true;


                img.removeAttribute(
                    'src'
                );


                if (emptyText) {

                    emptyText.textContent =
                        'No se pudo visualizar la imagen.';

                }

            };

        } else if (img) {

            img.hidden = true;


            img.removeAttribute(
                'src'
            );

        }


        if (emptyText) {

            emptyText.textContent =
                archivo.nombreOriginal ||
                'Infografía';

        }


        if (view) {

            view.href =
                viewUrl;


            view.hidden = false;

        }


        if (download) {

            download.href =
                downloadUrl;


            download.hidden = false;

        }


        /* ====================================================
           ELIMINAR — SOLO ADMIN
           ==================================================== */

        if (del) {

            del.dataset.id =
                archivo.id;


            if (
                sesionActual.autenticado === true &&
                sesionActual.esAdmin === true
            ) {

                del.hidden = false;

                del.style.removeProperty(
                    'display'
                );

            } else {

                del.hidden = true;

                del.style.setProperty(
                    'display',
                    'none',
                    'important'
                );

            }

        }

    } else {

        if (img) {

            img.hidden = true;


            img.removeAttribute(
                'src'
            );

        }


        if (emptyText) {

            emptyText.textContent =
                'Sin infografía';

        }


        if (view) {

            view.hidden = true;


            view.removeAttribute(
                'href'
            );

        }


        if (download) {

            download.hidden = true;


            download.removeAttribute(
                'href'
            );

        }


        if (del) {

            del.hidden = true;


            del.style.setProperty(
                'display',
                'none',
                'important'
            );


            delete del.dataset.id;

        }

    }

}


/* ============================================================
   URL PARA VISUALIZAR
   ============================================================ */

function construirUrlVer(id) {

    return API.ver +
        '?id=' +
        encodeURIComponent(id);

}


/* ============================================================
   URL PARA DESCARGAR
   ============================================================ */

function construirUrlDescargar(id) {

    return API.descargar +
        '?id=' +
        encodeURIComponent(id);

}


/* ============================================================
   VALIDACIÓN DE IMÁGENES
   ============================================================ */

function esImagen(nombre) {

    return /\.(png|jpe?g)$/i.test(
        nombre || ''
    );

}


/* ============================================================
   VALIDACIÓN PDF
   ============================================================ */

function esPDF(nombre) {

    return /\.pdf$/i.test(
        nombre || ''
    );

}


/* ============================================================
   TRUNCAR TEXTO
   ============================================================ */

function truncar(
    texto,
    max
) {

    if (!texto) return '';


    return texto.length > max
        ? texto.slice(
            0,
            max - 1
        ) + '…'
        : texto;

}


/* ============================================================
   ADMIN — SUBIR / ELIMINAR
   ============================================================ */

function setupAdminHandlers() {

    /*
     * ========================================================
     * SUBIDA
     * ========================================================
     */

    document.addEventListener(
        'change',
        (e) => {

            const input =
                e.target.closest(
                    '[data-upload-input]'
                );


            if (
                !input ||
                !input.files ||
                !input.files[0]
            ) {

                return;

            }


            manejarSubida(input);

        }
    );


    /*
     * ========================================================
     * ELIMINACIÓN
     * ========================================================
     */

    document.addEventListener(
        'click',
        (e) => {

            const btn =
                e.target.closest(
                    '[data-delete]'
                );


            if (!btn) {

                return;

            }


            /*
             * Si está oculto, nunca procesamos
             * el botón.
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

        }
    );

}


/* ============================================================
   SUBIR ARCHIVO
   ============================================================ */

async function manejarSubida(input) {

    const file =
        input.files && input.files[0];


    if (!file) {
        return;
    }


    /* ========================================================
       VERIFICAR SESIÓN DE ADMINISTRADOR
       ======================================================== */

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


    /* ========================================================
       LOCALIZAR ELEMENTOS
       ======================================================== */

    const infoCard =
        input.closest('.info-card');


    const semanaItem =
        input.closest('.semana-item');


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
         * directamente en .info-card.
         *
         * Ejemplo:
         *
         * data-unidad="1"
         * data-semana="1"
         * data-slot="1"
         */

        unidad =
            infoCard.dataset.unidad ||
            null;


        semana =
            infoCard.dataset.semana ||
            null;


        slot =
            infoCard.dataset.slot ||
            null;


        /*
         * Respaldo:
         *
         * Si .info-card no tiene unidad o semana,
         * buscamos los datos en .semana-item.
         */

        if (
            (!unidad || !semana) &&
            semanaItem
        ) {

            unidad =
                unidad ||
                semanaItem.dataset.unidad ||
                null;


            semana =
                semana ||
                semanaItem.dataset.semana ||
                null;

        }


        console.log(
            'INFOGRAFÍA:',
            {
                unidad,
                semana,
                slot,
                archivo: file.name
            }
        );


        /* ====================================================
           VALIDAR DATOS
           ==================================================== */

        const unidadNumero =
            Number(unidad);


        const semanaNumero =
            Number(semana);


        const slotNumero =
            Number(slot);


        if (
            !Number.isInteger(unidadNumero) ||
            unidadNumero < 1 ||
            unidadNumero > 4
        ) {

            console.error(
                'Unidad inválida:',
                unidad
            );


            alert(
                'La unidad de la infografía no es válida.'
            );


            input.value = '';

            return;
        }


        if (
            !Number.isInteger(semanaNumero) ||
            semanaNumero < 1 ||
            semanaNumero > 16
        ) {

            console.error(
                'Semana inválida:',
                semana
            );


            alert(
                'La semana de la infografía no es válida.'
            );


            input.value = '';

            return;
        }


        if (
            !Number.isInteger(slotNumero) ||
            slotNumero < 1 ||
            slotNumero > 7
        ) {

            console.error(
                'Slot inválido:',
                slot
            );


            alert(
                'El número de infografía debe estar entre 1 y 7.'
            );


            input.value = '';

            return;
        }


        /*
         * Normalizamos los valores.
         */

        unidad =
            unidadNumero;


        semana =
            semanaNumero;


        slot =
            slotNumero;


        /* ====================================================
           VALIDAR EXTENSIÓN
           ==================================================== */

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


        unidad =
            semanaItem.dataset.unidad ||
            null;


        semana =
            semanaItem.dataset.semana ||
            null;


        console.log(
            'TRABAJO:',
            {
                unidad,
                semana,
                archivo: file.name
            }
        );


        /* ====================================================
           VALIDAR DATOS
           ==================================================== */

        const unidadNumero =
            Number(unidad);


        const semanaNumero =
            Number(semana);


        if (
            !Number.isInteger(unidadNumero) ||
            unidadNumero < 1 ||
            unidadNumero > 4
        ) {

            console.error(
                'Unidad inválida:',
                unidad
            );


            alert(
                'La unidad del trabajo no es válida.'
            );


            input.value = '';

            return;
        }


        if (
            !Number.isInteger(semanaNumero) ||
            semanaNumero < 1 ||
            semanaNumero > 16
        ) {

            console.error(
                'Semana inválida:',
                semana
            );


            alert(
                'La semana del trabajo no es válida.'
            );


            input.value = '';

            return;
        }


        /*
         * Normalizamos los valores.
         */

        unidad =
            unidadNumero;


        semana =
            semanaNumero;


        /* ====================================================
           VALIDAR PDF
           ==================================================== */

        if (!esPDF(file.name)) {

            alert(
                'El trabajo debe estar en formato PDF.'
            );


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


    /* ========================================================
       FORM DATA
       ======================================================== */

    const formData =
        new FormData();


    formData.append(
        'archivo',
        file
    );


    formData.append(
        'tipo',
        tipo
    );


    formData.append(
        'unidad',
        String(unidad)
    );


    formData.append(
        'semana',
        String(semana)
    );


    if (
        tipo === 'infografia'
    ) {

        formData.append(
            'slot',
            String(slot)
        );

    }


    /* ========================================================
       INDICADOR DE CARGA
       ======================================================== */

    const label =
        input.closest('label');


    if (label) {

        label.classList.add(
            'is-loading'
        );

    }


    try {

        console.log(
            'Enviando archivo:',
            {
                tipo,
                unidad,
                semana,
                slot,
                nombre: file.name,
                tamano: file.size
            }
        );


        /* ====================================================
           ENVIAR AL SERVIDOR
           ==================================================== */

        const res =
            await fetch(
                API.subir,
                {
                    method: 'POST',
                    body: formData
                }
            );


        /* ====================================================
           LEER RESPUESTA
           ==================================================== */

        const data =
            await res.json();


        console.log(
            'Respuesta del servidor:',
            {
                status: res.status,
                data
            }
        );


        /* ====================================================
           ERROR
           ==================================================== */

        if (
            !res.ok ||
            !data.ok
        ) {

            alert(
                data.error ||
                'No se pudo subir el archivo.'
            );

            return;
        }


        /* ====================================================
           SUBIDA CORRECTA
           ==================================================== */

        alert(
            tipo === 'infografia'
                ? 'Infografía subida correctamente.'
                : 'Trabajo subido correctamente.'
        );


        /*
         * Volvemos a consultar los archivos.
         *
         * Esto actualiza:
         *
         * - nombre del archivo
         * - miniatura
         * - VER
         * - DESCARGAR
         * - ELIMINAR
         */

        await cargarEstadoArchivos();

    } catch (err) {

        console.error(
            'Error subiendo archivo:',
            err
        );


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

            label.classList.remove(
                'is-loading'
            );

        }

    }

}


/* ============================================================
   ELIMINAR ARCHIVO
   ============================================================ */

async function manejarEliminacion(btn) {

    /*
     * ========================================================
     * SEGURIDAD DEL FRONTEND
     * ========================================================
     */

    if (
        sesionActual.autenticado !== true ||
        sesionActual.esAdmin !== true
    ) {

        return;

    }


    const id =
        btn.dataset.id;


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

        const res =
            await fetch(
                API.eliminar +
                '?id=' +
                encodeURIComponent(
                    id
                ),
                {
                    method: 'POST'
                }
            );


        const data =
            await res.json();

        if (
            !res.ok ||
            !data.ok
        ) {

            alert(
                data.error ||
                'No se pudo eliminar el archivo.'
            );
            return;

        }


        /*
         * Volvemos a consultar todos los archivos
         * para actualizar inmediatamente la interfaz.
         */

        await cargarEstadoArchivos();

    } catch (err) {

        console.error(
            'Error eliminando archivo:',
            err
        );
        alert(
            'No se pudo conectar con el servidor para eliminar el archivo.'
        );

    } finally {

        btn.disabled = false;

    }

}


function setupArchivoViewer() {

    const viewer =
        document.getElementById('archivoViewer');

    const content =
        document.getElementById('archivoViewerContent');

    const closeBtn =
        document.getElementById('archivoViewerClose');

    const overlay =
        viewer
            ? viewer.querySelector('.archivo-viewer-overlay')
            : null;

    if (!viewer || !content) return;

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

            levelEl.textContent =
                Math.round(scale * 100) + '%';

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

        if (tipo === 'imagen') {

            content.appendChild(
                crearVisorImagen(url, nombre)
            );

        } else {

            const iframe = document.createElement('iframe');
            iframe.src = url;
            iframe.title = nombre || 'Documento PDF';
            iframe.className = 'archivo-viewer-pdf';
            content.appendChild(iframe);
        }

        viewer.hidden = false;
        viewer.setAttribute('aria-hidden', 'false');
        document.body.classList.add('viewer-open');

        if (closeBtn) closeBtn.focus();
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

        if (!btn || btn.hidden || !btn.href) return;

        e.preventDefault();

        const card = btn.closest('.info-card');

        let nombre = 'Archivo';
        let tipo = 'pdf';

        if (card) {

            const img = card.querySelector('[data-thumb-img]');

            if (img && !img.hidden && img.src) {
                tipo = 'imagen';
            }

            const emptyText = card.querySelector('[data-empty-text]');

            if (emptyText) {
                nombre = emptyText.textContent || 'Infografía';
            }

        } else {

            const semanaItem = btn.closest('.semana-item');

            const status = semanaItem
                ? semanaItem.querySelector('[data-status]')
                : null;

            if (status) {
                nombre = status.textContent.replace('Subido: ', '');
            }
        }

        abrir(btn.href, tipo, nombre);
    });
}
/* ============================================================
   CARRUSEL HERO
   ============================================================ */

function setupHeroCarousel() {

    const slides =
        document.querySelectorAll(
            '.hero-slide'
        );

    const dots =
        document.querySelectorAll(
            '.hero-dot'
        );

    const prev =
        document.getElementById(
            'heroPrev'
        );

    const next =
        document.getElementById(
            'heroNext'
        );


    if (!slides.length) return;
    let current = 0;
    let timer = null;
    function mostrarSlide(index) {

        current =
            (index + slides.length) %
            slides.length;


        slides.forEach(
            (slide, i) => {

                slide.classList.toggle(
                    'is-active',
                    i === current
                );

            }
        );


        dots.forEach(
            (dot, i) => {

                dot.classList.toggle(
                    'is-active',
                    i === current
                );


                dot.setAttribute(
                    'aria-current',
                    i === current
                        ? 'true'
                        : 'false'
                );

            }
        );

    }


    function iniciarAutoPlay() {

        clearInterval(timer);


        timer =
            setInterval(
                () => {

                    mostrarSlide(
                        current + 1
                    );

                },
                5000
            );

    }


    prev?.addEventListener(
        'click',
        () => {

            mostrarSlide(
                current - 1
            );


            iniciarAutoPlay();

        }
    );


    next?.addEventListener(
        'click',
        () => {

            mostrarSlide(
                current + 1
            );


            iniciarAutoPlay();

        }
    );


    dots.forEach(
        (dot, index) => {

            dot.addEventListener(
                'click',
                () => {

                    mostrarSlide(
                        index
                    );


                    iniciarAutoPlay();

                }
            );

        }
    );


    mostrarSlide(0);


    iniciarAutoPlay();

}
