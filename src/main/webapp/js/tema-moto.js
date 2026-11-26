/* MiPortafolio — selector de tema Día/Noche */
(() => {
  "use strict";
  const root = document.documentElement;
  const buttons = [...document.querySelectorAll("[data-theme-choice]")];
  const themes = ["day", "night"];

  function applyTheme(theme) {
    const selected = themes.includes(theme) ? theme : "night";
    root.dataset.theme = selected;
    root.style.colorScheme = selected === "day" ? "light" : "dark";
    buttons.forEach((button) => {
      button.setAttribute("aria-pressed", String(button.dataset.themeChoice === selected));
    });
    try { localStorage.setItem("miportafolio-theme", selected); } catch (_) {}
  }

  let initial = "night";
  try {
    const saved = localStorage.getItem("miportafolio-theme");
    if (themes.includes(saved)) initial = saved;
  } catch (_) {}

  applyTheme(initial);
  buttons.forEach((button) => {
    button.addEventListener("click", () => applyTheme(button.dataset.themeChoice));
  });
})();