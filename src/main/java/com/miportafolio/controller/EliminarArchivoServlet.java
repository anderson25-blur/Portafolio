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
 * POST /api/archivos/eliminar?id=...
 * Protegido por AdminFilter: solo el admin logueado puede borrar.
 * Elimina primero el objeto en Storage y después la fila en la tabla,
 * para no dejar filas "huérfanas" apuntando a un archivo que ya no existe.
 */
@WebServlet("/api/archivos/eliminar")
public class EliminarArchivoServlet extends HttpServlet {

    private final ArchivoDAO archivoDAO = new ArchivoDAO();
    private final StorageService storageService = new StorageService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null || id.isBlank()) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_REQUEST, "Falta el parámetro id.");
            return;
        }

        try {
            Archivo archivo = archivoDAO.buscarPorId(id);
            if (archivo == null) {
                JsonRespuesta.error(resp, HttpServletResponse.SC_NOT_FOUND, "Ese archivo ya no existe.");
                return;
            }
            storageService.eliminar(archivo.getRutaStorage());
            archivoDAO.eliminar(id);
            JsonRespuesta.ok(resp);

        } catch (ArchivoDAO.DAOException | StorageService.StorageException e) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_GATEWAY, e.getMessage());
        }
    }
}
