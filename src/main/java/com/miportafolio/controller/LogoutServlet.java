package com.miportafolio.controller;

import com.miportafolio.model.Usuario;
import com.miportafolio.service.AuthService;
import com.miportafolio.util.JsonRespuesta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/** POST /api/logout — cierra la sesión actual (si la hay). */
@WebServlet("/api/logout")
public class LogoutServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (usuario != null) {
                authService.cerrarSesion(usuario.getAccessToken());
            }
            session.invalidate();
        }
        JsonRespuesta.ok(resp);
    }
}
