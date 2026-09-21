package com.miportafolio.util;

import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;

/** Helper chico para que todos los servlets respondan JSON de forma consistente. */
public final class JsonRespuesta {

    private JsonRespuesta() {
    }

    public static void ok(HttpServletResponse resp, JSONObject data) throws IOException {
        enviar(resp, HttpServletResponse.SC_OK, data);
    }

    public static void ok(HttpServletResponse resp) throws IOException {
        JSONObject o = new JSONObject();
        o.put("ok", true);
        enviar(resp, HttpServletResponse.SC_OK, o);
    }

    public static void error(HttpServletResponse resp, int status, String mensaje) throws IOException {
        JSONObject o = new JSONObject();
        o.put("ok", false);
        o.put("error", mensaje);
        enviar(resp, status, o);
    }

    private static void enviar(HttpServletResponse resp, int status, JSONObject body) throws IOException {
        resp.setStatus(status);
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write(body.toString());
        resp.getWriter().flush();
    }
}
