package com.miportafolio.controller;

import com.miportafolio.model.Usuario;
import com.miportafolio.util.JsonRespuesta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.IOException;

/**
 * GET /api/sesion
 * El frontend lo llama al cargar la página para saber si mostrar el HUD
 * de administrador (subir/eliminar) o el de visitante normal.
 */
@WebServlet("/api/sesion")
public class SesionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Usuario usuario = session == null ? null : (Usuario) session.getAttribute("usuario");

        JSONObject data = new JSONObject();
        if (usuario == null) {
            data.put("autenticado", false);
        } else {
            data.put("autenticado", true);
            data.put("email", usuario.getEmail());
            data.put("rol", usuario.getRol());
            data.put("esAdmin", usuario.esAdmin());
        }
        JsonRespuesta.ok(resp, data);
    }
}
