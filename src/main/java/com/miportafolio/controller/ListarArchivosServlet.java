
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
 * Servlet para consultar los archivos del portafolio.
 *
 * Estructura:
 *
 * UNIDAD
 *   └── SEMANA
 *        ├── TRABAJOS
 *        │    └── PDF
 *        │
 *        └── INFOGRAFÍAS
 *             └── JPG / JPEG / PNG
 *
 * Endpoints:
 *
 * GET /api/archivos
 *      → todos los trabajos.
 *
 * GET /api/archivos?unidad=1&semana=1
 *      → todos los archivos de la Semana 1 de la Unidad 1,
 *        incluyendo trabajos e infografías.
 *
 * GET /api/archivos?unidad=1&semana=1&tipo=infografia
 *      → solamente las infografías de esa semana.
 *
 * GET /api/archivos?tipo=infografia
 *      → todas las infografías del sistema.
 *
 * La lectura es pública.
 * Las operaciones de subida y eliminación requieren sesión.
 */
@WebServlet("/api/archivos")
public class ListarArchivosServlet extends HttpServlet {

    private final ArchivoDAO archivoDAO = new ArchivoDAO();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp
    ) throws ServletException, IOException {

        String tipo = req.getParameter("tipo");
        String unidadParam = req.getParameter("unidad");
        String semanaParam = req.getParameter("semana");

        try {

            List<Archivo> resultado;

            /*
             * Caso 1:
             * Se especificó unidad y semana.
             */
            if (unidadParam != null && semanaParam != null) {

                int unidad = Integer.parseInt(unidadParam);
                int semana = Integer.parseInt(semanaParam);

                /*
                 * Si se solicita específicamente infografía,
                 * solamente devolvemos las infografías de esa semana.
                 */
                if (Archivo.TIPO_INFOGRAFIA.equals(tipo)) {

                    resultado = archivoDAO.buscarInfografiasPorSemana(
                            unidad,
                            semana
                    );

                /*
                 * Si no se especifica tipo, devolvemos todo:
                 * trabajos + infografías.
                 */
                } else {

                    resultado = archivoDAO.buscarPorUnidadSemana(
                            unidad,
                            semana
                    );
                }

            /*
             * Caso 2:
             * Se solicitaron todas las infografías.
             */
            } else if (Archivo.TIPO_INFOGRAFIA.equals(tipo)) {

                resultado = archivoDAO.listarInfografias();

            /*
             * Caso 3:
             * No se especificaron filtros.
             * Devolvemos todos los trabajos.
             */
            } else {

                resultado = archivoDAO.listarTodosLosTrabajos();
            }

            /*
             * Convertimos los objetos Archivo a JSON.
             */
            JSONArray arr = new JSONArray();

            for (Archivo archivo : resultado) {
                arr.put(archivo.aJsonPublico());
            }

            /*
             * Construimos la respuesta.
             */
            JSONObject data = new JSONObject();

            data.put("ok", true);
            data.put("archivos", arr);

            JsonRespuesta.ok(resp, data);

        } catch (NumberFormatException e) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "unidad y semana deben ser números."
            );

        } catch (ArchivoDAO.DAOException e) {

            JsonRespuesta.error(
                    resp,
                    HttpServletResponse.SC_BAD_GATEWAY,
                    e.getMessage()
            );
        }
    }
}
