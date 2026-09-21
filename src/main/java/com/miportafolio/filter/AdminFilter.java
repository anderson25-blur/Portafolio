package com.miportafolio.filter;

import com.miportafolio.model.Usuario;
import com.miportafolio.util.JsonRespuesta;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Deja pasar la petición solo si hay una sesión activa con rol "admin".
 * Se aplica a /api/archivos/subir y /api/archivos/eliminar: cualquier
 * visitante puede ver y descargar, pero solo el admin puede subir o borrar.
 */
@WebFilter(urlPatterns = {"/api/archivos/subir", "/api/archivos/eliminar"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        Usuario usuario = session == null ? null : (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            JsonRespuesta.error(response, HttpServletResponse.SC_UNAUTHORIZED, "Debes iniciar sesión.");
            return;
        }
        if (!usuario.esAdmin()) {
            JsonRespuesta.error(response, HttpServletResponse.SC_FORBIDDEN, "Solo el administrador puede hacer esto.");
            return;
        }

        chain.doFilter(req, res);
    }
}
