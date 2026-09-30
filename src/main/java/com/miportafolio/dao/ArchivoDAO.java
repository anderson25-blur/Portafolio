package com.miportafolio.dao;

import com.miportafolio.config.HttpClientProvider;
import com.miportafolio.config.SupabaseConfig;
import com.miportafolio.model.Archivo;
import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Acceso a datos de la tabla `archivo` en la base Postgres de Supabase,
 * hablando directo con su API REST autogenerada (PostgREST) en /rest/v1/archivo.
 *
 * Se usa la service_role key porque esta clase solo se llama desde servlets
 * del servidor (nunca se expone al navegador).
 *
 * Ver sql/schema.sql para la definición de la tabla.
 */
public class ArchivoDAO {

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private static final String TABLA = "/archivo";

    private final SupabaseConfig config;
    private final OkHttpClient http;

    public ArchivoDAO() {
        this.config = SupabaseConfig.get();
        this.http = HttpClientProvider.client();
    }

    /** Inserta una fila nueva y devuelve el registro creado (con su id generado). */
    public Archivo insertar(Archivo archivo) throws DAOException {
        JSONObject body = new JSONObject();
        body.put("unidad", archivo.getUnidad());
        body.put("semana", archivo.getSemana());
        body.put("slot", archivo.getSlot());
        body.put("tipo", archivo.getTipo());
        body.put("nombre_original", archivo.getNombreOriginal());
        body.put("ruta_storage", archivo.getRutaStorage());
        body.put("tamano_bytes", archivo.getTamanoBytes());
        body.put("subido_por", archivo.getSubidoPor());

        Request request = new Request.Builder()
                .url(config.restEndpoint(TABLA))
                .addHeader("apikey", config.getServiceRoleKey())
                .addHeader("Authorization", "Bearer " + config.getServiceRoleKey())
                .addHeader("Content-Type", "application/json")
                .addHeader("Prefer", "return=representation")
                .post(RequestBody.create(body.toString(), JSON))
                .build();

        try (Response response = http.newCall(request).execute()) {
            String raw = response.body() != null ? response.body().string() : "[]";
            if (!response.isSuccessful()) {
                throw new DAOException("No se pudo guardar el registro del archivo: " + raw);
            }
            JSONArray arr = new JSONArray(raw);
            if (arr.isEmpty()) {
                throw new DAOException("Supabase no devolvió el registro insertado.");
            }
            return Archivo.desdeJson(arr.getJSONObject(0));
        } catch (IOException e) {
            throw new DAOException("Error de red guardando el archivo: " + e.getMessage());
        }
    }

    /**
 * Busca todos los archivos de una unidad y semana,
 * incluyendo trabajos e infografías.
 */
    public List<Archivo> buscarPorUnidadSemana(int unidad, int semana) throws DAOException {
        HttpUrl url = HttpUrl.parse(config.restEndpoint(TABLA)).newBuilder()
                .addQueryParameter("select", "*")
                .addQueryParameter("unidad", "eq." + unidad)
                .addQueryParameter("semana", "eq." + semana)
                .addQueryParameter("order", "tipo.asc,slot.asc,creado_en.desc")
                .build();

        return listar(url);
    }

    /** Devuelve todas las infografías, ordenadas por slot. */
    public List<Archivo> listarInfografias() throws DAOException {
        HttpUrl url = HttpUrl.parse(config.restEndpoint(TABLA)).newBuilder()
                .addQueryParameter("select", "*")
                .addQueryParameter("tipo", "eq." + Archivo.TIPO_INFOGRAFIA)
                .addQueryParameter("order", "slot.asc")
                .build();
        return listar(url);
    }

    /** Devuelve todos los trabajos de todas las semanas (para pintar el estado inicial de golpe). */
    public List<Archivo> listarTodosLosTrabajos() throws DAOException {
        HttpUrl url = HttpUrl.parse(config.restEndpoint(TABLA)).newBuilder()
                .addQueryParameter("select", "*")
                .addQueryParameter("tipo", "eq." + Archivo.TIPO_TRABAJO)
                .addQueryParameter("order", "unidad.asc,semana.asc,creado_en.desc")
                .build();
        return listar(url);
    }

    public Archivo buscarPorId(String id) throws DAOException {
        HttpUrl url = HttpUrl.parse(config.restEndpoint(TABLA)).newBuilder()
                .addQueryParameter("select", "*")
                .addQueryParameter("id", "eq." + id)
                .build();
        List<Archivo> resultado = listar(url);
        return resultado.isEmpty() ? null : resultado.get(0);
    }

    public void eliminar(String id) throws DAOException {
        HttpUrl url = HttpUrl.parse(config.restEndpoint(TABLA)).newBuilder()
                .addQueryParameter("id", "eq." + id)
                .build();

        Request request = new Request.Builder()
                .url(url)
                .addHeader("apikey", config.getServiceRoleKey())
                .addHeader("Authorization", "Bearer " + config.getServiceRoleKey())
                .delete()
                .build();

        try (Response response = http.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                String raw = response.body() != null ? response.body().string() : "";
                throw new DAOException("No se pudo eliminar el registro del archivo: " + raw);
            }
        } catch (IOException e) {
            throw new DAOException("Error de red eliminando el archivo: " + e.getMessage());
        }
    }

    private List<Archivo> listar(HttpUrl url) throws DAOException {
        Request request = new Request.Builder()
                .url(url)
                .addHeader("apikey", config.getServiceRoleKey())
                .addHeader("Authorization", "Bearer " + config.getServiceRoleKey())
                .get()
                .build();

        try (Response response = http.newCall(request).execute()) {
            String raw = response.body() != null ? response.body().string() : "[]";
            if (!response.isSuccessful()) {
                throw new DAOException("No se pudo consultar Supabase: " + raw);
            }
            JSONArray arr = new JSONArray(raw);
            List<Archivo> resultado = new ArrayList<>();
            for (int i = 0; i < arr.length(); i++) {
                resultado.add(Archivo.desdeJson(arr.getJSONObject(i)));
            }
            return resultado;
        } catch (IOException e) {
            throw new DAOException("Error de red consultando Supabase: " + e.getMessage());
        }
    }

    /** Excepción de negocio para fallas de acceso a datos (config, red, respuesta de Supabase). */
    public static class DAOException extends Exception {
        public DAOException(String message) {
            super(message);
        }
    }
}
