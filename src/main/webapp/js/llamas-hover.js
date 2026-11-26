/* MiPortafolio — llamaradas al entrar con el cursor */
(() => {
  "use strict";
  const reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  const fine = window.matchMedia("(pointer: fine)").matches;
  if (reduce || !fine) return;

  const selector = [
    ".btn", ".hero-cta", ".theme-btn", ".hud-user", ".semana-btn",
    ".hero-carousel-btn", ".unidad-card", ".about-card", ".info-card",
    ".semana-item", ".enlace-card", ".trabajos-lista .trabajo-item",
    ".btn-back", ".modal-submit"
  ].join(",");

  function createBurst(target, event) {
    const rect = target.getBoundingClientRect();
    if (!rect.width || !rect.height) return;

    let layer = target.querySelector(":scope > .moto-flame-burst");
    if (!layer) {
      layer = document.createElement("span");
      layer.className = "moto-flame-burst";
      layer.setAttribute("aria-hidden", "true");
      target.appendChild(layer);
    }
    layer.replaceChildren();

    const px = Math.max(5, Math.min(95, (event.clientX - rect.left) / rect.width * 100));
    const py = Math.max(38, Math.min(95, (event.clientY - rect.top) / rect.height * 100));

    for (let i = 0; i < 8; i++) {
      const flame = document.createElement("i");
      flame.className = "moto-flame";
      flame.style.setProperty("--fx", `${Math.max(0, Math.min(96, px + Math.random() * 26 - 13))}%`);
      flame.style.setProperty("--fy", `${Math.max(34, Math.min(96, py + Math.random() * 18 - 9))}%`);
      flame.style.setProperty("--fw", `${8 + Math.random() * 13}px`);
      flame.style.setProperty("--fh", `${20 + Math.random() * 25}px`);
      flame.style.setProperty("--fdelay", `${Math.random() * .13}s`);
      flame.style.setProperty("--fdx", `${Math.random() * 34 - 17}px`);
      flame.style.setProperty("--fr", `${Math.random() * 38 - 19}deg`);
      layer.appendChild(flame);
    }
    window.setTimeout(() => {
      if (layer.isConnected) layer.replaceChildren();
    }, 1150);
  }

  document.addEventListener("pointerover", (event) => {
    const target = event.target instanceof Element ? event.target.closest(selector) : null;
    if (!target || target.contains(event.relatedTarget)) return;
    createBurst(target, event);
  }, { passive: true });
})();