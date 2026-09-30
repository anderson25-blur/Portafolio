package com.miportafolio.controller;

import com.miportafolio.dao.ArchivoDAO;
import com.miportafolio.model.Archivo;
import com.miportafolio.model.Usuario;
import com.miportafolio.service.StorageService;
import com.miportafolio.util.JsonRespuesta;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;

@WebServlet("/api/archivos/subir")
@MultipartConfig(
        maxFileSize = 1024L * 1024 * 25,
        maxRequestSize = 1024L * 1024 * 30,
        fileSizeThreshold = 1024 * 512
)
public class SubirArchivoServlet extends HttpServlet {

    private final StorageService storageService = new StorageService();
    private final ArchivoDAO archivoDAO = new ArchivoDAO();

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp
    ) throws ServletException, IOException {

        // =========================================================
        // 1. VALIDAR TIPO
        // =========================================================

        String tipo = req.getParameter("tipo");

        if (!Archivo.TIPO_TRABAJO.equals(tipo)
                && !Archivo.TIPO_INFOGRAFIA.equals(tipo)) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "tipo debe ser 'trabajo' o 'infografia'."
            );
            return;
        }

        // =========================================================
        // 2. VALIDAR ARCHIVO
        // =========================================================

        Part filePart = req.getPart("archivo");

        if (filePart == null || filePart.getSize() == 0) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Falta el archivo a subir."
            );
            return;
        }

        // =========================================================
        // 3. VALIDAR UNIDAD, SEMANA Y SLOT
        // =========================================================

        Integer unidad;
        Integer semana;
        Integer slot = null;

        try {

            String unidadParam = req.getParameter("unidad");
            String semanaParam = req.getParameter("semana");

            if (unidadParam == null || unidadParam.isBlank()
                    || semanaParam == null || semanaParam.isBlank()) {

                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "unidad y semana son obligatorios."
                );
                return;
            }

            unidad = Integer.parseInt(unidadParam);
            semana = Integer.parseInt(semanaParam);

            // -------------------------
            // UNIDAD
            // -------------------------

            if (unidad < 1 || unidad > 4) {

                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "La unidad debe estar entre 1 y 4."
                );
                return;
            }

            // -------------------------
            // SEMANA
            // -------------------------

            if (semana < 1 || semana > 16) {

                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "La semana debe estar entre 1 y 16."
                );
                return;
            }

            // -------------------------
            // SLOT PARA INFOGRAFÍAS
            // -------------------------

            if (Archivo.TIPO_INFOGRAFIA.equals(tipo)) {

                String slotParam = req.getParameter("slot");

                if (slotParam == null || slotParam.isBlank()) {

                    JsonRespuesta.error(
                            resp,
                            HttpServletResponse.SC_BAD_REQUEST,
                            "slot es obligatorio para una infografía."
                    );
                    return;
                }

                slot = Integer.parseInt(slotParam);

                // Ahora se permiten hasta 7 infografías por semana
                if (slot < 1 || slot > 7) {

                    JsonRespuesta.error(
                            resp,
                            HttpServletResponse.SC_BAD_REQUEST,
                            "El slot debe estar entre 1 y 7."
                    );
                    return;
                }
            }

        } catch (NumberFormatException e) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "unidad, semana y slot deben ser números."
            );
            return;
        }

        // =========================================================
        // 4. LIMPIAR NOMBRE Y OBTENER EXTENSIÓN
        // =========================================================

        String nombreOriginal = filePart.getSubmittedFileName();

        nombreOriginal = limpiarNombreArchivo(nombreOriginal);

        String extension = obtenerExtension(nombreOriginal);

        // =========================================================
        // 5. VALIDAR FORMATO
        // =========================================================

        if (Archivo.TIPO_TRABAJO.equals(tipo)) {

            // Los trabajos son solamente PDF

            if (!"pdf".equals(extension)) {

                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Los trabajos deben estar en formato PDF."
                );
                return;
            }

        } else {

            // Las infografías pueden ser JPG, JPEG o PNG

            if (!"jpg".equals(extension)
                    && !"jpeg".equals(extension)
                    && !"png".equals(extension)) {

                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Las infografías deben estar en JPG, JPEG o PNG."
                );
                return;
            }
        }

        // =========================================================
        // 6. LEER ARCHIVO
        // =========================================================

        byte[] contenido;

        try (InputStream in = filePart.getInputStream()) {

            contenido = in.readAllBytes();

        }

        if (contenido.length == 0) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "El archivo está vacío."
            );
            return;
        }

        // =========================================================
        // 7. VALIDAR SESIÓN
        // =========================================================

        HttpSession session = req.getSession(false);

        if (session == null) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_UNAUTHORIZED,
                    "La sesión ha expirado."
            );
            return;
        }

        Usuario usuario =
                (Usuario) session.getAttribute("usuario");

        if (usuario == null) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_UNAUTHORIZED,
                    "No hay un usuario autenticado."
            );
            return;
        }

        // =========================================================
        // 8. VALIDAR ADMINISTRADOR
        // =========================================================

        if (!usuario.esAdmin()) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_FORBIDDEN,
                    "No tienes permisos de administrador para subir archivos."
            );
            return;
        }

        // =========================================================
        // 9. DEFINIR CARPETA EN SUPABASE STORAGE
        // =========================================================

        String carpeta =
                "unidad-" + unidad +
                "/semana-" + String.format("%02d", semana);

        // =========================================================
        // 10. SUBIR A STORAGE Y REGISTRAR EN BASE DE DATOS
        // =========================================================

        try {

            String path = storageService.subir(
                    contenido,
                    nombreOriginal,
                    filePart.getContentType(),
                    carpeta
            );

            // Crear registro del archivo
            Archivo archivo = new Archivo();

            archivo.setUnidad(unidad);
            archivo.setSemana(semana);
            archivo.setSlot(slot);
            archivo.setTipo(tipo);
            archivo.setNombreOriginal(nombreOriginal);
            archivo.setRutaStorage(path);
            archivo.setTamanoBytes(contenido.length);
            archivo.setSubidoPor(usuario.getEmail());

            // Guardar registro en Supabase
            Archivo guardado = archivoDAO.insertar(archivo);

            JsonRespuesta.ok(
                    resp,
                    wrap(guardado)
            );

        } catch (
                StorageService.StorageException
                        | ArchivoDAO.DAOException e
        ) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_GATEWAY,
                    e.getMessage()
            );
        }
    }

    // =============================================================
    // ENVOLVER RESPUESTA JSON
    // =============================================================

    private org.json.JSONObject wrap(Archivo archivo) {

        org.json.JSONObject json =
                new org.json.JSONObject();

        json.put("ok", true);
        json.put("archivo", archivo.aJsonPublico());

        return json;
    }

    // =============================================================
    // LIMPIAR NOMBRE DEL ARCHIVO
    // =============================================================

    private String limpiarNombreArchivo(String nombre) {

        if (nombre == null || nombre.isBlank()) {
            return "archivo";
        }

        nombre = nombre.replace("\\", "/");

        int ultimaBarra =
                nombre.lastIndexOf('/');

        if (ultimaBarra >= 0) {

            nombre =
                    nombre.substring(ultimaBarra + 1);
        }

        nombre =
                nombre.replaceAll(
                        "[\\r\\n\\t]",
                        "_"
                );

        return nombre.isBlank()
                ? "archivo"
                : nombre;
    }

    // =============================================================
    // OBTENER EXTENSIÓN
    // =============================================================

    private String obtenerExtension(String nombre) {

        if (nombre == null) {
            return "";
        }

        int punto =
                nombre.lastIndexOf('.');

        if (punto < 0
                || punto == nombre.length() - 1) {

            return "";
        }

        return nombre
                .substring(punto + 1)
                .toLowerCase(Locale.ROOT);
    }
}
