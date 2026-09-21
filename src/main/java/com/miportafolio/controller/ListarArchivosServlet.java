package com.miportafolio.controller;

import com.miportafolio.dao.ArchivoDAO;
import com.miportafolio.model.Archivo;
import com.miportafolio.util.JsonRespuesta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;

/**
 * GET /api/archivos                        → todos los trabajos (para pintar el estado de las 16 semanas de una)
 * GET /api/archivos?unidad=1&semana=2       → trabajos de esa semana puntual
 * GET /api/archivos?tipo=infografia         → las infografías
 *
 * Es de lectura pública: cualquier visitante puede ver qué hay subido y
 * descargarlo. Solo subir/eliminar requieren sesión de admin (ver AdminFilter).
 */
@WebServlet("/api/archivos")
public class ListarArchivosServlet extends HttpServlet {

    private final ArchivoDAO archivoDAO = new ArchivoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tipo = req.getParameter("tipo");
        String unidadParam = req.getParameter("unidad");
        String semanaParam = req.getParameter("semana");

        try {
            List<Archivo> resultado;

            if (Archivo.TIPO_INFOGRAFIA.equals(tipo)) {
                resultado = archivoDAO.listarInfografias();
            } else if (unidadParam != null && semanaParam != null) {
                resultado = archivoDAO.buscarPorSemana(Integer.parseInt(unidadParam), Integer.parseInt(semanaParam));
            } else {
                resultado = archivoDAO.listarTodosLosTrabajos();
            }

            JSONArray arr = new JSONArray();
            for (Archivo a : resultado) {
                arr.put(a.aJsonPublico());
            }
            JSONObject data = new JSONObject();
            data.put("ok", true);
            data.put("archivos", arr);
            JsonRespuesta.ok(resp, data);

        } catch (NumberFormatException e) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_REQUEST, "unidad y semana deben ser números.");
        } catch (ArchivoDAO.DAOException e) {
            JsonRespuesta.error(resp, HttpServletResponse.SC_BAD_GATEWAY, e.getMessage());
        }
    }
}
