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

/**
 * POST /api/archivos/subir  (multipart/form-data)
 * Campos esperados:
 *   - archivo   (file, obligatorio)
 *   - tipo      "trabajo" | "infografia"
 *   - unidad    (solo si tipo=trabajo)
 *   - semana    (solo si tipo=trabajo)
 *   - slot      (solo si tipo=infografia, 1..3)
 *
 * Protegido por AdminFilter: solo el admin logueado puede llegar hasta acá.
 * Límite: 25 MB por archivo (ver @MultipartConfig).
 */
@WebServlet("/api/archivos/subir")
@MultipartConfig(
        maxFileSize = 1024L * 1024 * 25,      // 25 MB por archivo
        maxRequestSize = 1024L * 1024 * 30,
        fileSizeThreshold = 1024 * 512
)
public class SubirArchivoServlet extends HttpServlet {

    private final StorageService storageService = new StorageService();
    private final ArchivoDAO archivoDAO = new ArchivoDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tipo = req.getParameter("tipo");
        if (!Archivo.TIPO_TRABAJO.equals(tipo) && !Archivo.TIPO_INFOGRAFIA.equals(tipo)) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_REQUEST, "tipo debe ser 'trabajo' o 'infografia'.");
            return;
        }

        Part filePart = req.getPart("archivo");
        if (filePart == null || filePart.getSize() == 0) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_REQUEST, "Falta el archivo a subir.");
            return;
        }

        Integer unidad = null, semana = null, slot = null;
        String carpeta;

        try {
            if (Archivo.TIPO_TRABAJO.equals(tipo)) {
                unidad = Integer.parseInt(req.getParameter("unidad"));
                semana = Integer.parseInt(req.getParameter("semana"));
                carpeta = "unidad-" + unidad + "/semana-" + String.format("%02d", semana);
            } else {
                slot = Integer.parseInt(req.getParameter("slot"));
                carpeta = "infografias";
            }
        } catch (NumberFormatException e) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_REQUEST, "unidad/semana/slot deben ser números.");
            return;
        }

        String nombreOriginal = obtenerNombreArchivo(filePart);
        byte[] contenido;
        try (InputStream in = filePart.getInputStream()) {
            contenido = in.readAllBytes();
        }

        HttpSession session = req.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario"); // no-null: pasó por AdminFilter

        try {
            String path = storageService.subir(contenido, nombreOriginal, filePart.getContentType(), carpeta);

            Archivo archivo = new Archivo();
            archivo.setUnidad(unidad);
            archivo.setSemana(semana);
            archivo.setSlot(slot);
            archivo.setTipo(tipo);
            archivo.setNombreOriginal(nombreOriginal);
            archivo.setRutaStorage(path);
            archivo.setTamanoBytes(contenido.length);
            archivo.setSubidoPor(usuario.getEmail());

            Archivo guardado = archivoDAO.insertar(archivo);
            JsonRespuesta.ok(resp, wrap(guardado));

        } catch (StorageService.StorageException | ArchivoDAO.DAOException e) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_GATEWAY, e.getMessage());
        }
    }

    private org.json.JSONObject wrap(Archivo a) {
        org.json.JSONObject o = new org.json.JSONObject();
        o.put("ok", true);
        o.put("archivo", a.aJsonPublico());
        return o;
    }

    private String obtenerNombreArchivo(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return "archivo";
        for (String token : header.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                String nombre = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                return nombre.isBlank() ? "archivo" : nombre;
            }
        }
        return "archivo";
    }
}
