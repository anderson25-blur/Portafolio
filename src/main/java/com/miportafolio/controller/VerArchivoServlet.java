package com.miportafolio.controller;

import com.miportafolio.dao.ArchivoDAO;
import com.miportafolio.model.Archivo;
import com.miportafolio.service.StorageService;
import com.miportafolio.util.JsonRespuesta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * GET /api/archivos/ver?id=...
 *
 * Permite visualizar un archivo directamente en el navegador.
 *
 * Está pensado principalmente para:
 * - PDF
 * - JPG
 * - JPEG
 * - PNG
 *
 * El archivo permanece almacenado en el bucket privado de Supabase.
 * El servidor solamente genera una URL firmada temporal.
 */
@WebServlet("/api/archivos/ver")
public class VerArchivoServlet extends HttpServlet {

    private final ArchivoDAO archivoDAO = new ArchivoDAO();
    private final StorageService storageService = new StorageService();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp
    ) throws ServletException, IOException {

        String id = req.getParameter("id");

        if (id == null || id.isBlank()) {
            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Falta el parámetro id."
            );
            return;
        }

        try {

            Archivo archivo = archivoDAO.buscarPorId(id);

            if (archivo == null) {
                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_NOT_FOUND,
                        "Ese archivo ya no existe."
                );
                return;
            }

            String tipo = archivo.getTipo();

            if (!Archivo.TIPO_TRABAJO.equals(tipo)
                    && !Archivo.TIPO_INFOGRAFIA.equals(tipo)) {

                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "El tipo de archivo no es válido."
                );
                return;
            }

            String nombre = archivo.getNombreOriginal();

            if (!esVisualizable(nombre, tipo)) {

                JsonRespuesta.error(
                        resp,
                        HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE,
                        "Este tipo de archivo no tiene vista previa."
                );
                return;
            }

            String url = storageService.generarUrlDescarga(
                    archivo.getRutaStorage()
            );

            resp.sendRedirect(url);

        } catch (ArchivoDAO.DAOException
                 | StorageService.StorageException e) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_GATEWAY,
                    e.getMessage()
            );
        }
    }

    private boolean esVisualizable(
            String nombre,
            String tipo
    ) {

        if (nombre == null || nombre.isBlank()) {
            return false;
        }

        String archivo = nombre.toLowerCase();

        if (Archivo.TIPO_TRABAJO.equals(tipo)) {
            return archivo.endsWith(".pdf");
        }

        if (Archivo.TIPO_INFOGRAFIA.equals(tipo)) {
            return archivo.endsWith(".jpg")
                    || archivo.endsWith(".jpeg")
                    || archivo.endsWith(".png");
        }

        return false;
    }
}
