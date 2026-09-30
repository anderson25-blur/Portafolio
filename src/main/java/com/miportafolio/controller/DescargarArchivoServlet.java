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
 * GET /api/archivos/descargar?id=...
 *
 * Genera una URL firmada temporal para descargar un archivo
 * almacenado en Supabase Storage.
 *
 * Este endpoint mantiene la descarga separada de la visualización.
 */
@WebServlet("/api/archivos/descargar")
public class DescargarArchivoServlet extends HttpServlet {

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
}
