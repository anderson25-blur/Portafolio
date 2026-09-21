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
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;

/**
 * POST /api/login
 * body: {"email": "...", "password": "..."}
 *
 * Si las credenciales son válidas, guarda al Usuario en la HttpSession y
 * responde con sus datos públicos (nunca el access token, ese se queda en
 * el servidor).
 */
@WebServlet("/api/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        JSONObject body;
        try {
            body = leerJson(req);
        } catch (Exception e) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_REQUEST, "Cuerpo de la petición inválido.");
            return;
        }

        String email = body.optString("email", "");
        String password = body.optString("password", "");

        try {
            Usuario usuario = authService.iniciarSesion(email, password);

            HttpSession session = req.getSession(true);
            session.setAttribute("usuario", usuario);
            session.setMaxInactiveInterval(60 * 60 * 4); // 4 horas

            JSONObject data = new JSONObject();
            data.put("ok", true);
            data.put("email", usuario.getEmail());
            data.put("rol", usuario.getRol());
            JsonRespuesta.ok(resp, data);

        } catch (AuthService.AuthException e) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_UNAUTHORIZED, e.getMessage());
        }
    }

    private JSONObject leerJson(HttpServletRequest req) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        String raw = sb.toString();
        return new JSONObject(raw.isBlank() ? "{}" : raw);
    }
}
