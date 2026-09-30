package com.miportafolio.controller;

import com.miportafolio.dao.ArchivoDAO;
import com.miportafolio.model.Archivo;
import com.miportafolio.model.Usuario;
import com.miportafolio.service.StorageService;
import com.miportafolio.util.JsonRespuesta;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * POST /api/archivos/eliminar?id=...
 *
 * Solo permite eliminar archivos a usuarios con rol de administrador.
 *
 * Elimina primero el objeto de Storage y después la fila
 * correspondiente en la tabla de archivos.
 */
@WebServlet("/api/archivos/eliminar")
public class EliminarArchivoServlet extends HttpServlet {

    private final ArchivoDAO archivoDAO = new ArchivoDAO();
    private final StorageService storageService = new StorageService();

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp
    ) throws ServletException, IOException {

        // =========================================================
        // 1. VERIFICAR SESIÓN
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

        // =========================================================
        // 2. OBTENER USUARIO
        // =========================================================

        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_UNAUTHORIZED,
                    "No hay un usuario autenticado."
            );
            return;
        }

        // =========================================================
        // 3. VERIFICAR ROL DE ADMINISTRADOR
        // =========================================================

        if (!usuario.esAdmin()) {
            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_FORBIDDEN,
                    "No tienes permisos de administrador para eliminar archivos."
            );
            return;
        }

        // =========================================================
        // 4. OBTENER ID DEL ARCHIVO
        // =========================================================

        String id = req.getParameter("id");

        if (id == null || id.isBlank()) {
            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Falta el parámetro id."
            );
            return;
        }

        // =========================================================
        // 5. BUSCAR ARCHIVO
        // =========================================================

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

            // =====================================================
            // 6. ELIMINAR ARCHIVO DE SUPABASE STORAGE
            // =====================================================

            storageService.eliminar(
                    archivo.getRutaStorage()
            );

            // =====================================================
            // 7. ELIMINAR REGISTRO DE LA BASE DE DATOS
            // =====================================================

            archivoDAO.eliminar(id);

            // =====================================================
            // 8. RESPUESTA EXITOSA
            // =====================================================

            JsonRespuesta.ok(resp);

        } catch (
                ArchivoDAO.DAOException
                | StorageService.StorageException e
        ) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_GATEWAY,
                    e.getMessage()
            );
        }
    }
}
