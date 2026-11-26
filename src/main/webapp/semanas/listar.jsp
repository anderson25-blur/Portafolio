<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String unidadParam = request.getParameter("unidad");
int unidad = 1;

try {
    if (unidadParam != null) {
        unidad = Integer.parseInt(unidadParam);
    }
} catch (NumberFormatException ignored) {
    unidad = 1;
}

if (unidad < 1 || unidad > 4) {
    unidad = 1;
}

int semanaInicio = ((unidad - 1) * 4) + 1;
int semanaFin = semanaInicio + 3;

String tituloUnidad = "";
String descripcionUnidad = "";

switch (unidad) {
    case 1:
        tituloUnidad =
            "Fundamentos de la Arquitectura de Software y Estándares Internacionales";
        descripcionUnidad =
            "Conceptos fundamentales, principios, atributos de calidad, estilos, patrones y documentación de la arquitectura de software.";
        break;

    case 2:
        tituloUnidad =
            "Modelado de la Arquitectura de Software mediante Programación Orientada a Objetos";
        descripcionUnidad =
            "Principios de POO, modelado UML, diseño de componentes, capas y validación del modelo arquitectónico.";
        break;

    case 3:
        tituloUnidad =
            "Comunicación e Integración de Arquitecturas de Software";
        descripcionUnidad =
            "Comunicación entre componentes, integración de sistemas, APIs, servicios web, interfaces y transmisión de datos.";
        break;

    case 4:
        tituloUnidad =
            "Frameworks y Estándares para la Implementación de Arquitecturas de Software";
        descripcionUnidad =
            "Frameworks, estándares, buenas prácticas, implementación, evaluación y optimización de arquitecturas de software.";
        break;
}
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Unidad <%= unidad %> | MiPortafolio</title>

    <style>

/* =========================================================
   MIPORTAFOLIO | UNIDAD / SEMANAS — RACE EDITION
   Estilos encapsulados: solo afectan esta página.
   ========================================================= */
:root{
  color-scheme:dark;
  --mp-bg:#070b0a;
  --mp-panel:rgba(12,18,16,.88);
  --mp-card:rgba(17,26,21,.86);
  --mp-border:rgba(175,220,183,.15);
  --mp-border-hot:rgba(151,224,27,.55);
  --mp-text:#f1f7f1;
  --mp-secondary:#c2cec5;
  --mp-muted:#8b9b90;
  --mp-green:#a6e22e;
  --mp-green-bright:#c8ff52;
  --mp-red:#ff513f;
  --mp-shadow:0 24px 70px rgba(0,0,0,.42);
}
*,*::before,*::after{box-sizing:border-box}
html{scroll-behavior:smooth;min-width:320px;scroll-padding-top:24px}
body.miportafolio-unidad{
  position:relative;isolation:isolate;margin:0;min-width:320px;min-height:100vh;
  overflow-x:hidden;color:var(--mp-text)!important;
  background:#070b0a!important;
  font-family:Inter,"Segoe UI",Roboto,Arial,sans-serif;
  font-size:15px;line-height:1.6;
}
body.miportafolio-unidad::before{
  content:"";position:fixed;inset:0;z-index:-2;pointer-events:none;
  background:
    linear-gradient(90deg,rgba(4,8,7,.94) 0%,rgba(4,8,7,.80) 38%,rgba(4,8,7,.43) 72%,rgba(4,8,7,.70) 100%),
    linear-gradient(180deg,rgba(4,8,7,.12) 0%,rgba(4,8,7,.48) 42%,#070b0a 100%),
    url('../images/moto-circuito-unidad.png') center 22%/cover no-repeat;
  transform:scale(1.015);
}
body.miportafolio-unidad::after{
  content:"";position:fixed;inset:0;z-index:-1;pointer-events:none;opacity:.22;
  background-image:linear-gradient(rgba(174,224,168,.055) 1px,transparent 1px),linear-gradient(90deg,rgba(174,224,168,.055) 1px,transparent 1px);
  background-size:64px 64px;
  mask-image:linear-gradient(to bottom,black,transparent 78%);
}
body.miportafolio-unidad .page{
  position:relative;width:min(100% - 48px,1440px);min-width:0;margin:0 auto;
  padding:64px 0 100px;color:var(--mp-text)!important;
}
body.miportafolio-unidad .page *,
body.miportafolio-unidad .archivo-viewer *{box-sizing:border-box}
body.miportafolio-unidad .section{width:100%;min-width:0}
body.miportafolio-unidad h1,body.miportafolio-unidad h2,body.miportafolio-unidad h3,
body.miportafolio-unidad p{overflow-wrap:anywhere}
body.miportafolio-unidad [hidden]{display:none!important}

/* HERO / CABECERA */
.section-head{
  position:relative;overflow:hidden;margin:0 0 42px;padding:clamp(28px,5vw,62px);
  border:1px solid rgba(190,235,191,.20);border-radius:26px;
  background:linear-gradient(115deg,rgba(8,14,11,.96),rgba(8,15,12,.79) 58%,rgba(12,26,15,.55));
  box-shadow:var(--mp-shadow),inset 0 1px rgba(255,255,255,.06);
  backdrop-filter:blur(16px);
}
.section-head::before{
  content:"";position:absolute;top:0;left:0;width:5px;height:100%;
  background:linear-gradient(180deg,var(--mp-green-bright),var(--mp-green),transparent);
  box-shadow:0 0 28px rgba(166,226,46,.55);
}
.section-head::after{
  content:"";position:absolute;right:-65px;top:-110px;width:340px;height:340px;
  border:1px solid rgba(166,226,46,.14);border-radius:50%;
  box-shadow:0 0 0 28px rgba(166,226,46,.025),0 0 0 58px rgba(166,226,46,.02);
  pointer-events:none;
}
.eyebrow{
  position:relative;z-index:1;display:flex;align-items:center;gap:12px;margin:0 0 18px;
  color:var(--mp-green-bright)!important;font-size:11px;font-weight:900;letter-spacing:3.5px;
}
.eyebrow::before{content:"";width:28px;height:2px;background:var(--mp-green)}
.section-head h1{
  position:relative;z-index:1;margin:0 0 18px;color:#fff!important;
  font-size:clamp(52px,8vw,104px);font-weight:1000;line-height:.88;
  letter-spacing:-.075em;text-transform:uppercase;
  text-shadow:0 8px 35px rgba(0,0,0,.55);
}
.unidad-titulo{
  position:relative;z-index:1;max-width:950px;margin:0 0 12px;
  color:#e2eddf!important;font-size:clamp(19px,2.2vw,27px);font-weight:800;line-height:1.28;
  letter-spacing:-.025em;
}
.unidad-descripcion{
  position:relative;z-index:1;max-width:760px;margin:0;
  color:#aab9ad!important;font-size:15px;line-height:1.8;
}
a.btn-back,a.btn-back:visited{
  position:relative;z-index:1;display:inline-flex;align-items:center;gap:10px;
  margin-top:28px;padding:12px 18px;border:1px solid rgba(166,226,46,.38)!important;
  border-radius:999px;color:#d9f7aa!important;
  background:rgba(166,226,46,.08)!important;text-decoration:none!important;
  font-size:11px;font-weight:900;letter-spacing:1.3px;text-transform:uppercase;
  transition:.25s ease;
}
a.btn-back:hover{transform:translateX(-4px);color:#081006!important;background:var(--mp-green)!important;box-shadow:0 8px 28px rgba(166,226,46,.2)}

/* LISTA / TARJETAS DE SEMANA */
.semanas-lista{display:flex;flex-direction:column;gap:26px;min-width:0}
.semana-item{
  position:relative;width:100%;min-width:0;overflow:hidden;
  border:1px solid var(--mp-border)!important;border-radius:20px;
  background:linear-gradient(135deg,rgba(17,25,20,.94),rgba(8,13,11,.91))!important;
  box-shadow:0 18px 55px rgba(0,0,0,.30),inset 0 1px rgba(255,255,255,.035);
  backdrop-filter:blur(14px);
  transition:border-color .28s ease,transform .28s ease,box-shadow .28s ease;
}
.semana-item::before{
  content:"";position:absolute;top:0;left:0;width:100%;height:2px;
  background:linear-gradient(90deg,var(--mp-green),rgba(166,226,46,.08) 58%,transparent);
  opacity:.75;
}
.semana-item:hover{border-color:var(--mp-border-hot)!important;transform:translateY(-3px);box-shadow:0 25px 65px rgba(0,0,0,.42),0 0 35px rgba(166,226,46,.055)}
.semana-header{
  position:relative;display:flex;align-items:center;justify-content:space-between;gap:20px;
  padding:27px 30px;border-bottom:1px solid rgba(190,235,191,.10);
  background:linear-gradient(100deg,rgba(166,226,46,.075),transparent 65%)!important;
}
.semana-header-info{min-width:0}
.semana-numero{
  display:inline-flex;align-items:center;gap:9px;margin-bottom:9px;color:var(--mp-green-bright)!important;
  font-size:10px;font-weight:950;letter-spacing:3px;
}
.semana-numero::before{content:"";width:7px;height:7px;border-radius:50%;background:var(--mp-green);box-shadow:0 0 12px var(--mp-green)}
.semana-header h2{
  margin:0;color:#f3f8f1!important;font-size:clamp(20px,2.5vw,29px);
  font-weight:900;line-height:1.2;letter-spacing:-.035em;text-transform:none;
}
.semana-descripcion{
  padding:17px 30px;border-bottom:1px solid rgba(190,235,191,.09);
  color:#9eada2!important;font-size:13px;line-height:1.75;
}

/* SECCIONES INTERNAS */
.material-section{min-width:0;padding:28px 30px}
.material-section+.material-section{border-top:1px solid rgba(190,235,191,.10)}
.material-header{
  display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:15px;margin-bottom:22px;
}
.material-header>div:first-child{display:flex;align-items:center;gap:15px;min-width:0}
.material-icon{
  display:grid;place-items:center;flex:0 0 48px;width:48px;height:48px;
  border:1px solid rgba(166,226,46,.38);border-radius:14px;
  color:var(--mp-green-bright)!important;
  background:linear-gradient(145deg,rgba(166,226,46,.17),rgba(166,226,46,.035))!important;
  box-shadow:inset 0 1px rgba(255,255,255,.07),0 8px 25px rgba(0,0,0,.18);
  font-size:21px;
}
.material-header h3{margin:0;color:#edf5eb!important;font-size:16px;font-weight:950;letter-spacing:.04em;text-transform:uppercase}
.material-header p{margin:4px 0 0;color:#829287!important;font-size:12px;line-height:1.6}
.enlace-count{
  padding:7px 12px;border:1px solid rgba(166,226,46,.28);border-radius:999px;
  color:var(--mp-green-bright)!important;background:rgba(166,226,46,.07)!important;
  font-size:10px;font-weight:900;letter-spacing:.8px;
}

/* BOTONES */
.archivo-actions,.info-actions,.enlace-card-actions{display:flex;align-items:center;flex-wrap:wrap;gap:9px;min-width:0}
body.miportafolio-unidad a.btn,body.miportafolio-unidad a.btn:visited,
body.miportafolio-unidad button.btn,body.miportafolio-unidad label.btn{
  display:inline-flex;align-items:center;justify-content:center;gap:8px;min-height:38px;max-width:100%;
  padding:10px 15px;border:1px solid rgba(190,220,192,.18)!important;border-radius:9px;
  color:#dce8dc!important;background:rgba(255,255,255,.045)!important;
  font-family:inherit;font-size:10px;font-weight:900;line-height:1.2;letter-spacing:.8px;
  text-align:center;text-decoration:none!important;white-space:normal;cursor:pointer;
  transition:transform .2s ease,background .2s ease,border-color .2s ease,color .2s ease,box-shadow .2s ease;
}
body.miportafolio-unidad .btn-small{min-height:34px;padding:8px 12px;font-size:10px}
body.miportafolio-unidad a.btn[data-view],body.miportafolio-unidad a.btn[data-view]:visited{
  color:#d4f79d!important;background:rgba(166,226,46,.075)!important;border-color:rgba(166,226,46,.32)!important;
}
body.miportafolio-unidad a.btn[data-view]:hover{color:#091006!important;background:var(--mp-green)!important;border-color:var(--mp-green)!important;box-shadow:0 7px 22px rgba(166,226,46,.2);transform:translateY(-2px)}
body.miportafolio-unidad a.btn[data-download],body.miportafolio-unidad a.btn[data-download]:visited{
  color:#101609!important;background:linear-gradient(135deg,#c8ff52,#91d51e)!important;border-color:#b6ed43!important;
  box-shadow:0 5px 18px rgba(166,226,46,.12);
}
body.miportafolio-unidad a.btn[data-download]:hover{transform:translateY(-2px);box-shadow:0 9px 25px rgba(166,226,46,.28);filter:brightness(1.08)}
body.miportafolio-unidad label.btn.admin-only{color:#d6f7a6!important;background:rgba(166,226,46,.06)!important;border:1px dashed rgba(166,226,46,.5)!important}
body.miportafolio-unidad label.btn.admin-only:hover{color:#0a1005!important;background:var(--mp-green)!important;border-style:solid!important}
body.miportafolio-unidad button.btn-danger{color:#ffaaa1!important;background:rgba(255,81,63,.075)!important;border-color:rgba(255,81,63,.34)!important}
body.miportafolio-unidad button.btn-danger:hover{color:#fff!important;background:#c93425!important;border-color:var(--mp-red)!important;transform:translateY(-2px)}
body.miportafolio-unidad .btn:focus-visible{outline:2px solid var(--mp-green)!important;outline-offset:3px}
body.miportafolio-unidad .btn[hidden],body.miportafolio-unidad .admin-only[hidden]{display:none!important}

/* TRABAJOS PDF */
.trabajos-lista{display:flex;flex-direction:column;gap:12px;width:100%;min-width:0;margin-top:18px}
.trabajos-lista .trabajo-item{
  display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:18px;
  width:100%;min-width:0;padding:18px 20px;border:1px solid rgba(190,220,192,.13)!important;border-radius:13px;
  background:linear-gradient(110deg,rgba(255,255,255,.045),rgba(255,255,255,.018))!important;color:var(--mp-text)!important;
  transition:.2s ease;
}
.trabajos-lista .trabajo-item:hover{border-color:rgba(166,226,46,.32)!important;background:rgba(166,226,46,.045)!important}
.trabajos-lista .trabajo-item .archivo-info{display:flex;align-items:center;gap:14px;flex:1 1 220px;min-width:0}
.trabajos-lista .trabajo-icono{flex-shrink:0}
.trabajos-lista .trabajo-detalles{display:flex;flex-direction:column;gap:6px;min-width:0}
.trabajos-lista .trabajo-nombre{color:#eaf2ea!important;font-size:13px;font-weight:850;line-height:1.5;overflow-wrap:anywhere}
.trabajos-lista .archivo-status{color:var(--mp-green-bright)!important;font-size:11px}
.trabajos-lista .archivo-actions{display:flex;align-items:center;justify-content:flex-end;flex-wrap:wrap;gap:9px;min-width:0}
.trabajos-lista a[data-view],.trabajos-lista a[data-view]:visited{color:#d4f79d!important;background:rgba(166,226,46,.075)!important;border:1px solid rgba(166,226,46,.32)!important}
.trabajos-lista a[data-view]:hover{color:#091006!important;background:var(--mp-green)!important}
.trabajos-lista a[data-download],.trabajos-lista a[data-download]:visited{color:#101609!important;background:var(--mp-green)!important;border:1px solid var(--mp-green)!important}
.trabajos-lista button[data-delete]{color:#ffaaa1!important;background:rgba(255,81,63,.075)!important;border:1px solid rgba(255,81,63,.34)!important}
.trabajos-lista button[data-delete]:hover{color:#fff!important;background:#c93425!important;border-color:var(--mp-red)!important}
.trabajos-lista .trabajos-vacio{margin:0;padding:16px;border:1px dashed rgba(190,220,192,.2);border-radius:10px;color:#89978c!important;background:rgba(0,0,0,.16)!important;font-size:12px;line-height:1.6}

/* INFOGRAFÍAS */
.info-grid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:16px;min-width:0}
.info-card{
  min-width:0;overflow:hidden;border:1px solid rgba(190,220,192,.15)!important;border-radius:14px;
  background:linear-gradient(150deg,rgba(28,39,31,.94),rgba(12,18,14,.96))!important;
  box-shadow:0 10px 28px rgba(0,0,0,.18);transition:transform .25s ease,border-color .25s ease,box-shadow .25s ease;
}
.info-card:hover{border-color:rgba(166,226,46,.5)!important;transform:translateY(-5px);box-shadow:0 18px 38px rgba(0,0,0,.32),0 0 24px rgba(166,226,46,.06)}
.info-preview{
  position:relative;display:flex;align-items:center;justify-content:center;min-width:0;min-height:190px;overflow:hidden;
  border-bottom:1px solid rgba(190,220,192,.12);
  background:radial-gradient(ellipse at 50% 35%,rgba(166,226,46,.11),transparent 62%),#0a100c!important;
}
.info-preview::after{content:"";position:absolute;inset:0;pointer-events:none;background:linear-gradient(180deg,transparent 65%,rgba(0,0,0,.3))}
.info-preview img{display:block;width:100%;height:190px;max-width:100%;object-fit:cover;transition:transform .45s ease}
.info-card:hover .info-preview img{transform:scale(1.045)}
.info-preview [data-empty-text]{padding:20px;color:#758378!important;text-align:center;font-size:11px;font-weight:800;letter-spacing:1px;text-transform:uppercase}
.info-card-footer{min-width:0;padding:15px}
.info-card-footer>span{display:block;margin-bottom:12px;color:#eaf2ea!important;font-size:12px;font-weight:900;letter-spacing:.5px}
.info-actions{margin-top:10px}
body.miportafolio-unidad .info-actions button[data-delete]{width:34px;min-width:34px;padding:0;font-size:16px}

/* ENLACES */
.enlace-form{
  display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:14px;min-width:0;margin-bottom:18px;padding:20px;
  border:1px solid rgba(190,220,192,.14);border-radius:14px;background:rgba(4,9,6,.42)!important;
}
.enlace-field{display:flex;flex-direction:column;gap:7px;min-width:0;color:#c4d1c6!important;font-size:11px;font-weight:850;letter-spacing:.4px}
.enlace-field-wide,.enlace-form-actions{grid-column:1/-1}
body.miportafolio-unidad .enlace-field input{
  display:block;width:100%;min-width:0;padding:12px 14px;border:1px solid rgba(190,220,192,.18)!important;border-radius:9px;
  outline:none;color:var(--mp-text)!important;background:rgba(3,8,5,.72)!important;font-family:inherit;font-size:12px;font-weight:500;
  transition:border-color .2s ease,box-shadow .2s ease;
}
body.miportafolio-unidad .enlace-field input::placeholder{color:#657469!important}
body.miportafolio-unidad .enlace-field input:focus{border-color:var(--mp-green)!important;box-shadow:0 0 0 3px rgba(166,226,46,.11)}
.enlace-form-actions{display:flex;align-items:center;flex-wrap:wrap;gap:10px}
.enlace-feedback{flex:1 1 180px;min-width:0;margin:0;color:#9baa9e!important;font-size:11px;line-height:1.5}
.enlaces-lista{display:grid;grid-template-columns:minmax(0,1fr);gap:12px;min-width:0}
.enlaces-vacio{margin:0;padding:17px;border:1px dashed rgba(190,220,192,.2);border-radius:11px;color:#91a095!important;font-size:12px;line-height:1.6}
.enlace-card{display:flex;align-items:center;justify-content:space-between;gap:16px;min-width:0;padding:17px;border:1px solid rgba(190,220,192,.14)!important;border-radius:12px;background:rgba(255,255,255,.035)!important;transition:border-color .2s ease,background .2s ease}
.enlace-card:hover{border-color:rgba(166,226,46,.35)!important;background:rgba(166,226,46,.035)!important}
.enlace-card-info{flex:1 1 auto;min-width:0}
.enlace-card-title{margin:0 0 6px;color:#eff7ed!important;font-size:13px;font-weight:900}
body.miportafolio-unidad a.enlace-url,body.miportafolio-unidad a.enlace-url:visited{display:inline-block;max-width:100%;color:var(--mp-green-bright)!important;font-size:11px;line-height:1.6;overflow-wrap:anywhere;text-decoration:none!important}
body.miportafolio-unidad a.enlace-url:hover{color:#e2ffb0!important;text-decoration:underline!important}
.enlace-card-description{margin:6px 0 0;color:#91a095!important;font-size:11px;line-height:1.6}
.enlace-card-actions{display:flex;align-items:center;justify-content:flex-end;flex:0 0 auto;flex-wrap:wrap;gap:8px}

/* VISOR */
#archivoViewer{position:fixed;inset:0;z-index:9999;display:none;align-items:center;justify-content:center;padding:22px;background:rgba(0,0,0,.9)!important;backdrop-filter:blur(12px)}
#archivoViewer[aria-hidden="false"]{display:flex}
.archivo-viewer-overlay{position:absolute;inset:0}
.archivo-viewer-panel{position:relative;z-index:2;display:flex;align-items:center;justify-content:center;width:min(1200px,95vw);height:min(90vh,900px);padding:52px 20px 20px;border:1px solid rgba(166,226,46,.25);border-radius:17px;background:#080e0a!important;box-shadow:0 30px 100px rgba(0,0,0,.7)}
.archivo-viewer-content{display:flex;align-items:center;justify-content:center;width:100%;height:100%;overflow:hidden}
.archivo-viewer-image{max-width:100%;max-height:100%;object-fit:contain;border-radius:8px}
.archivo-viewer-pdf{width:100%;height:100%;border:0;border-radius:8px;background:#fff}
.archivo-viewer-close{position:absolute;top:12px;right:14px;z-index:3;display:grid;place-items:center;width:38px;height:38px;border:1px solid rgba(190,220,192,.2)!important;border-radius:10px;color:#d6e2d7!important;background:#121b15!important;cursor:pointer;font-size:24px;line-height:1}
.archivo-viewer-close:hover{color:var(--mp-red)!important;border-color:var(--mp-red)!important}
body.viewer-open{overflow:hidden}
.zoom-stage{position:relative;display:flex;align-items:center;justify-content:center;width:100%;height:100%;overflow:hidden;touch-action:none;cursor:zoom-in}
.zoom-stage.is-zoomed{cursor:grab}.zoom-stage.is-dragging{cursor:grabbing}
.zoom-stage img{max-width:100%;max-height:100%;object-fit:contain;user-select:none;-webkit-user-drag:none;transform-origin:center center;will-change:transform}
.zoom-toolbar{position:absolute;top:10px;left:10px;z-index:5;display:flex;gap:6px;padding:6px;border:1px solid rgba(190,220,192,.16);border-radius:10px;background:rgba(10,16,12,.94)!important}
.zoom-toolbar button{min-width:36px;height:34px;padding:0 10px;border:1px solid rgba(190,220,192,.16)!important;border-radius:7px;color:#c7d4c9!important;background:#101811!important;cursor:pointer;font-size:14px;font-weight:850}
.zoom-toolbar button:hover{color:var(--mp-green-bright)!important;border-color:var(--mp-green)!important}
.zoom-toolbar .zoom-level{display:flex;align-items:center;justify-content:center;min-width:48px;color:#91a095!important;font-size:11px;font-weight:850}

/* RESPONSIVE */
@media(max-width:1050px){.info-grid{grid-template-columns:repeat(3,minmax(0,1fr))}.section-head h1{font-size:clamp(50px,9vw,82px)}}
@media(max-width:760px){
  body.miportafolio-unidad .page{width:min(100% - 30px,1440px);padding:28px 0 65px}
  .section-head{padding:30px 24px;border-radius:19px;margin-bottom:26px}
  .section-head h1{font-size:clamp(48px,13vw,72px)}
  .semana-header{padding:22px}
  .semana-descripcion{padding:15px 22px}
  .material-section{padding:22px}
  .info-grid{grid-template-columns:repeat(2,minmax(0,1fr))}
  .info-preview,.info-preview img{height:170px;min-height:170px}
  .archivo-item{align-items:flex-start;flex-direction:column}
  .admin-only{margin-left:0}
  .enlace-form{grid-template-columns:minmax(0,1fr);padding:16px}
  .enlace-field-wide,.enlace-form-actions{grid-column:auto}
  .enlace-card{align-items:flex-start;flex-direction:column}
  .enlace-card-actions{width:100%;justify-content:flex-start}
  .archivo-viewer-panel{width:100%;height:90vh;padding:50px 12px 12px}
}
@media(max-width:480px){
  .section-head{padding:27px 19px}
  .section-head h1{font-size:48px}
  .unidad-titulo{font-size:18px}
  .material-header{align-items:flex-start}
  .material-header>div:first-child{align-items:flex-start}
  .semana-header h2{font-size:20px}
  .material-section{padding:18px}
  .semana-descripcion{padding:14px 18px}
  .info-grid{grid-template-columns:minmax(0,1fr)}
  .info-preview,.info-preview img{height:210px;min-height:210px}
  .trabajos-lista .trabajo-item{align-items:flex-start;flex-direction:column;padding:15px}
  .trabajos-lista .archivo-actions{justify-content:flex-start;width:100%}
  .archivo-actions,.info-actions{gap:7px}
}
@media(prefers-reduced-motion:reduce){
  *,*::before,*::after{scroll-behavior:auto!important;transition:none!important;animation:none!important}
}

    </style>
</head>

<body class="miportafolio-unidad">

<main class="page">
    <section class="section">

        <!-- ENCABEZADO -->

        <div class="section-head">

            <p class="eyebrow">ARQUITECTURA DE SOFTWARE</p>

            <h1>Unidad <%= unidad %></h1>

            <p class="unidad-titulo"><%= tituloUnidad %></p>

            <p class="unidad-descripcion"><%= descripcionUnidad %></p>

            <a class="btn-back" href="../unidades/listar.jsp">
                ← Volver a unidades
            </a>

        </div>

        <!-- SEMANAS -->

        <div class="semanas-lista">

<%
for (int semana = semanaInicio; semana <= semanaFin; semana++) {

    String tituloSemana = "";
    String descripcionSemana = "";

    switch (semana) {
        case 1:
            tituloSemana = "Introducción a la Arquitectura de Software";
            descripcionSemana = "Conceptos, objetivos e importancia de la arquitectura de software.";
            break;

        case 2:
            tituloSemana = "Principios, Atributos de Calidad y Estándares Internacionales";
            descripcionSemana = "Calidad y sostenibilidad del proyecto según estándares internacionales.";
            break;

        case 3:
            tituloSemana = "Estilos y Patrones Arquitectónicos";
            descripcionSemana = "Comparación de estilos y selección del patrón más adecuado.";
            break;

        case 4:
            tituloSemana = "Documentación y Representación Arquitectónica";
            descripcionSemana = "Modelos, diagramas y buenas prácticas de documentación.";
            break;

        case 5:
            tituloSemana = "Principios de POO aplicados a la Arquitectura";
            descripcionSemana = "Abstracción, encapsulamiento, herencia y polimorfismo.";
            break;

        case 6:
            tituloSemana = "Modelado Arquitectónico con UML";
            descripcionSemana = "Diagramas de casos de uso, clases y paquetes.";
            break;

        case 7:
            tituloSemana = "Diseño de Componentes y Capas de la Arquitectura";
            descripcionSemana = "Responsabilidades, cohesión y bajo acoplamiento.";
            break;

        case 8:
            tituloSemana = "Elaboración y Validación del Modelo Arquitectónico";
            descripcionSemana = "Artefactos de modelado y sustento técnico de las decisiones.";
            break;

        case 9:
            tituloSemana = "Fundamentos de la Comunicación entre Arquitecturas";
            descripcionSemana = "Mecanismos, protocolos y flujos de información entre componentes.";
            break;

        case 10:
            tituloSemana = "Métodos y Tecnologías para la Integración de Sistemas";
            descripcionSemana = "Servicios web, APIs y mensajería para integrar aplicaciones.";
            break;

        case 11:
            tituloSemana = "Diseño de Interfaces y Transmisión de Datos";
            descripcionSemana = "Interoperabilidad y modelado de servicios entre componentes.";
            break;

        case 12:
            tituloSemana = "Implementación y Validación de la Comunicación Arquitectónica";
            descripcionSemana = "Pruebas de integridad, disponibilidad y eficiencia de la integración.";
            break;

        case 13:
            tituloSemana = "Fundamentos de Frameworks de Arquitectura de Software";
            descripcionSemana = "Características, ventajas y ámbitos de aplicación de los principales frameworks.";
            break;

        case 14:
            tituloSemana = "Normas y Buenas Prácticas en Arquitectura de Software";
            descripcionSemana = "Calidad, interoperabilidad, seguridad y rendimiento del proyecto.";
            break;

        case 15:
            tituloSemana = "Implementación de la Arquitectura utilizando Frameworks";
            descripcionSemana = "Componentes, patrones de diseño y mecanismos de comunicación.";
            break;

        case 16:
            tituloSemana = "Evaluación y Optimización de la Arquitectura de Software";
            descripcionSemana = "Métricas de calidad y mejoras finales sobre lo implementado.";
            break;
    }

    /*
     * Cantidad de espacios (slots) de infografía por semana.
     * main.js usa este mismo número (data-max-infografias)
     * para validar el slot al subir.
     */
    int cantidadInfografias;

    switch (semana) {
        case 1:
            cantidadInfografias = 7;
            break;
        case 2:
            cantidadInfografias = 4;
            break;
        case 3:
            cantidadInfografias = 1;
            break;
        case 4:
            cantidadInfografias = 5;
            break;
        default:
            cantidadInfografias = 30;
            break;
    }
%>

            <article
                class="semana-item"
                data-unidad="<%= unidad %>"
                data-semana="<%= semana %>"
                data-max-infografias="<%= cantidadInfografias %>">

                <!-- CABECERA -->

                <div class="semana-header">

                    <div class="semana-header-info">

                        <span class="semana-numero">
                            SEMANA <%= String.format("%02d", semana) %>
                        </span>

                        <h2><%= tituloSemana %></h2>

                    </div>

                </div>

                <!-- DESCRIPCIÓN -->

                <div class="semana-descripcion">
                    <%= descripcionSemana %>
                </div>

                <!-- =============================================
                     TRABAJOS PDF
                     main.js controla su visibilidad
                     ============================================= -->

                <section
                    class="material-section trabajo-section"
                    hidden>

                    <div class="material-header">

                        <div>
                            <span class="material-icon">📚</span>

                            <div>
                                <h3>Trabajos</h3>
                                <p>Documentos PDF de la semana.</p>
                            </div>
                        </div>

                        <label class="btn btn-small admin-only" hidden>
                            + Subir PDF

                            <input
                                type="file"
                                hidden
                                accept=".pdf,application/pdf"
                                data-upload-input>
                        </label>

                    </div>

                    <!-- Fila base: main.js la oculta y crea la lista real -->
                    <div class="archivo-item">

                        <div class="archivo-info">

                            <span class="archivo-status" data-status>
                                Sin trabajo
                            </span>

                        </div>

                        <div class="archivo-actions">

                            <a
                                class="btn btn-small"
                                data-view
                                target="_blank"
                                rel="noopener"
                                hidden>
                                👁 Ver
                            </a>

                            <a
                                class="btn btn-small"
                                data-download
                                hidden>
                                ↓ Descargar
                            </a>

                            <button
                                type="button"
                                class="btn btn-small btn-danger admin-only"
                                data-delete
                                hidden>
                                Eliminar
                            </button>

                        </div>

                    </div>

                </section>

                <!-- =============================================
                     INFOGRAFÍAS
                     ============================================= -->

                <section class="material-section infografias-section">

                    <div class="material-header">

                        <div>
                            <span class="material-icon">🖼️</span>

                            <div>
                                <h3>Infografías</h3>
                                <p>Imágenes JPG, JPEG o PNG de la semana.</p>
                            </div>
                        </div>

                    </div>

                    <div class="info-grid" data-info-grid>

<%
    for (int slot = 1; slot <= cantidadInfografias; slot++) {
%>

                        <article
                            class="info-card"
                            data-unidad="<%= unidad %>"
                            data-semana="<%= semana %>"
                            data-slot="<%= slot %>">

                            <div class="info-preview">

                                <img
                                    data-thumb-img
                                    alt="Infografía <%= slot %>"
                                    hidden>

                                <span data-empty-text>
                                    Sin infografía
                                </span>

                            </div>

                            <div class="info-card-footer">

                                <span>Infografía <%= slot %></span>

                                <div class="info-actions">

                                    <label class="btn btn-small admin-only" hidden>
                                        + Subir

                                        <input
                                            type="file"
                                            hidden
                                            accept=".jpg,.jpeg,.png,image/jpeg,image/png"
                                            data-upload-input>
                                    </label>

                                    <a
                                        class="btn btn-small"
                                        data-view
                                        target="_blank"
                                        rel="noopener"
                                        hidden>
                                        👁 Ver
                                    </a>

                                    <a
                                        class="btn btn-small"
                                        data-download
                                        hidden>
                                        ↓ Descargar
                                    </a>

                                    <button
                                        type="button"
                                        class="btn btn-small btn-danger admin-only"
                                        data-delete
                                        hidden
                                        aria-label="Eliminar infografía <%= slot %>">
                                        ×
                                    </button>

                                </div>

                            </div>

                        </article>

<%
    }
%>

                    </div>

                </section>

                <!-- =============================================
                     ENLACES DEL PROYECTO
                     ============================================= -->

                <section
                    class="material-section enlaces-section"
                    data-enlaces-section>

                    <div class="material-header">

                        <div>
                            <span class="material-icon">🔗</span>

                            <div>
                                <h3>Enlaces del proyecto</h3>

                                <p>
                                    Repositorios, prototipos, documentos y demostraciones.
                                </p>
                            </div>
                        </div>

                        <span class="enlace-count" data-enlace-count>
                            0 enlaces
                        </span>

                    </div>

                    <form
                        class="enlace-form admin-only"
                        data-enlace-form
                        hidden>

                        <label class="enlace-field">
                            Nombre del enlace

                            <input
                                type="text"
                                data-enlace-titulo
                                maxlength="100"
                                placeholder="Ej. Prototipo en Figma"
                                required>
                        </label>

                        <label class="enlace-field">
                            URL del proyecto

                            <input
                                type="url"
                                data-enlace-url
                                maxlength="1500"
                                placeholder="https://..."
                                autocomplete="url"
                                required>
                        </label>

                        <label class="enlace-field enlace-field-wide">
                            Descripción opcional

                            <input
                                type="text"
                                data-enlace-descripcion
                                maxlength="180"
                                placeholder="Describe brevemente el enlace">
                        </label>

                        <div class="enlace-form-actions">

                            <button type="submit" class="btn btn-small">
                                + Guardar enlace
                            </button>

                            <p
                                class="enlace-feedback"
                                data-enlace-feedback
                                role="status"
                                aria-live="polite">
                            </p>

                        </div>

                    </form>

                    <div class="enlaces-lista" data-enlaces-lista>

                        <p class="enlaces-vacio" data-enlaces-vacio>
                            Todavía no se han agregado enlaces para esta semana.
                        </p>

                    </div>

                </section>

            </article>

<%
}
%>

        </div>
    </section>
</main>

<!-- =============================================
     VISOR DE ARCHIVOS
     ============================================= -->

<div
    id="archivoViewer"
    class="archivo-viewer"
    hidden
    aria-hidden="true">

    <div class="archivo-viewer-overlay"></div>

    <div
        class="archivo-viewer-panel"
        role="dialog"
        aria-modal="true"
        aria-label="Visualizador de archivo">

        <button
            type="button"
            id="archivoViewerClose"
            class="archivo-viewer-close"
            aria-label="Cerrar visor">
            ×
        </button>

        <div
            id="archivoViewerContent"
            class="archivo-viewer-content">
        </div>

    </div>

</div>

<!-- =============================================
     SCRIPT PRINCIPAL
     La marca de tiempo evita que el navegador use
     una versión vieja guardada en caché.
     Cuando termines de probar, puedes cambiarla por
     un número fijo, por ejemplo ?v=10
     ============================================= -->

<script src="../js/main.js?v=<%= System.currentTimeMillis() %>"></script>

<script>
/* =========================================================
   GESTIÓN DE ENLACES POR UNIDAD Y SEMANA
   (se guardan en localStorage: solo se ven en este navegador)
   ========================================================= */

(() => {
    "use strict";

    const PREFIJO = "miportafolio_enlaces_v1";

    function obtenerClave(semanaElemento) {
        return PREFIJO
            + "_"
            + semanaElemento.dataset.unidad
            + "_"
            + semanaElemento.dataset.semana;
    }

    function obtenerURLSegura(valor) {
        try {
            const url = new URL(valor.trim());

            if (url.protocol !== "https:" && url.protocol !== "http:") {
                return null;
            }

            return url.href;
        } catch (error) {
            return null;
        }
    }

    function leerEnlaces(clave) {
        try {
            const datos = JSON.parse(
                localStorage.getItem(clave) || "[]"
            );

            return Array.isArray(datos) ? datos : [];
        } catch (error) {
            console.error("Error al leer los enlaces:", error);
            return [];
        }
    }

    function guardarEnlaces(clave, enlaces) {
        try {
            localStorage.setItem(clave, JSON.stringify(enlaces));
            return true;
        } catch (error) {
            console.error("Error al guardar los enlaces:", error);
            return false;
        }
    }

    function crearElemento(etiqueta, clase, texto) {
        const elemento = document.createElement(etiqueta);

        if (clase) {
            elemento.className = clase;
        }

        if (texto !== undefined) {
            elemento.textContent = texto;
        }

        return elemento;
    }

    /*
     * El formulario de enlaces es admin-only: si main.js lo
     * muestra, el usuario es administrador.
     */
    function esAdministrador(formulario) {
        return !formulario.hidden;
    }

    function inicializarEnlaces(semanaElemento) {
        const formulario = semanaElemento.querySelector(
            "[data-enlace-form]"
        );

        const lista = semanaElemento.querySelector(
            "[data-enlaces-lista]"
        );

        const contador = semanaElemento.querySelector(
            "[data-enlace-count]"
        );

        if (!formulario || !lista || !contador) {
            return;
        }

        const clave = obtenerClave(semanaElemento);

        const campoTitulo = formulario.querySelector(
            "[data-enlace-titulo]"
        );

        const campoURL = formulario.querySelector(
            "[data-enlace-url]"
        );

        const campoDescripcion = formulario.querySelector(
            "[data-enlace-descripcion]"
        );

        const mensaje = formulario.querySelector(
            "[data-enlace-feedback]"
        );

        function renderizar() {
            const enlaces = leerEnlaces(clave);
            const administrador = esAdministrador(formulario);

            contador.textContent =
                enlaces.length
                + (enlaces.length === 1 ? " enlace" : " enlaces");

            lista.replaceChildren();

            if (enlaces.length === 0) {
                lista.appendChild(
                    crearElemento(
                        "p",
                        "enlaces-vacio",
                        "Todavía no se han agregado enlaces para esta semana."
                    )
                );

                return;
            }

            enlaces.forEach(enlace => {
                const tarjeta = crearElemento("article", "enlace-card");

                const informacion = crearElemento(
                    "div",
                    "enlace-card-info"
                );

                informacion.appendChild(
                    crearElemento(
                        "h4",
                        "enlace-card-title",
                        enlace.titulo
                    )
                );

                const enlaceURL = crearElemento(
                    "a",
                    "enlace-url",
                    enlace.url
                );

                enlaceURL.href = enlace.url;
                enlaceURL.target = "_blank";
                enlaceURL.rel = "noopener noreferrer";

                informacion.appendChild(enlaceURL);

                if (enlace.descripcion) {
                    informacion.appendChild(
                        crearElemento(
                            "p",
                            "enlace-card-description",
                            enlace.descripcion
                        )
                    );
                }

                const acciones = crearElemento(
                    "div",
                    "enlace-card-actions"
                );

                const botonAbrir = crearElemento(
                    "a",
                    "btn btn-small",
                    "↗ Abrir"
                );

                botonAbrir.href = enlace.url;
                botonAbrir.target = "_blank";
                botonAbrir.rel = "noopener noreferrer";

                acciones.appendChild(botonAbrir);

                /* Solo el administrador ve el botón Eliminar. */

                if (administrador) {
                    const botonEliminar = crearElemento(
                        "button",
                        "btn btn-small btn-danger",
                        "Eliminar"
                    );

                    botonEliminar.type = "button";

                    botonEliminar.addEventListener("click", () => {
                        if (!window.confirm("¿Deseas eliminar este enlace?")) {
                            return;
                        }

                        const actualizados = leerEnlaces(clave).filter(
                            elemento => elemento.id !== enlace.id
                        );

                        if (!guardarEnlaces(clave, actualizados)) {
                            alert("No se pudo eliminar el enlace.");
                            return;
                        }

                        renderizar();
                    });

                    acciones.appendChild(botonEliminar);
                }

                tarjeta.appendChild(informacion);
                tarjeta.appendChild(acciones);

                lista.appendChild(tarjeta);
            });
        }

        formulario.addEventListener("submit", evento => {
            evento.preventDefault();

            const titulo = campoTitulo.value.trim();
            const url = obtenerURLSegura(campoURL.value);
            const descripcion = campoDescripcion.value.trim();

            mensaje.textContent = "";

            if (!titulo) {
                mensaje.textContent = "Escribe el nombre del enlace.";
                campoTitulo.focus();
                return;
            }

            if (!url) {
                mensaje.textContent =
                    "Ingresa una URL válida con http:// o https://.";

                campoURL.focus();
                return;
            }

            const enlaces = leerEnlaces(clave);

            enlaces.push({
                id: Date.now().toString(36)
                    + Math.random().toString(36).slice(2, 8),
                titulo: titulo,
                url: url,
                descripcion: descripcion
            });

            if (!guardarEnlaces(clave, enlaces)) {
                mensaje.textContent =
                    "No se pudo guardar. Revisa el almacenamiento del navegador.";

                return;
            }

            formulario.reset();

            mensaje.textContent = "Enlace agregado correctamente.";

            renderizar();
        });

        /*
         * Cuando main.js muestra u oculta el formulario
         * (inicio o cierre de sesión), volvemos a pintar
         * la lista para mostrar u ocultar "Eliminar".
         */

        new MutationObserver(renderizar).observe(formulario, {
            attributes: true,
            attributeFilter: ["hidden"]
        });

        renderizar();
    }

    function iniciar() {
        document
            .querySelectorAll(".semana-item")
            .forEach(inicializarEnlaces);
    }

    if (document.readyState === "loading") {
        document.addEventListener(
            "DOMContentLoaded",
            iniciar,
            { once: true }
        );
    } else {
        iniciar();
    }
})();
</script>

</body>
</html>
