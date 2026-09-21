package com.miportafolio.service;

import com.miportafolio.config.HttpClientProvider;
import com.miportafolio.config.SupabaseConfig;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.UUID;

/**
 * Sube, firma URLs de descarga y elimina archivos en Supabase Storage
 * (bucket privado configurado en supabase.storageBucket).
 *
 * Se usa la service_role key porque esto corre siempre en el servidor
 * (nunca se envía esa key al navegador).
 */
public class StorageService {

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    private final SupabaseConfig config;
    private final OkHttpClient http;

    public StorageService() {
        this.config = SupabaseConfig.get();
        this.http = HttpClientProvider.client();
    }

    /**
     * Sube el archivo al bucket y devuelve el path guardado
     * (ej: "unidad-1/semana-01/1699999999-informe.pdf").
     */
    public String subir(byte[] contenido, String nombreOriginal, String contentType, String carpeta) throws StorageException {
        requireConfigured();

        String nombreSeguro = sanear(nombreOriginal);
        String path = carpeta + "/" + System.currentTimeMillis() + "-" + UUID.randomUUID().toString().substring(0, 8) + "-" + nombreSeguro;

        MediaType tipo = contentType == null ? MediaType.parse("application/octet-stream") : MediaType.parse(contentType);

        Request request = new Request.Builder()
                .url(config.storageEndpoint("/object/" + config.getStorageBucket() + "/" + path))
                .addHeader("apikey", config.getServiceRoleKey())
                .addHeader("Authorization", "Bearer " + config.getServiceRoleKey())
                .post(RequestBody.create(contenido, tipo))
                .build();

        try (Response response = http.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                String raw = response.body() != null ? response.body().string() : "";
                throw new StorageException("No se pudo subir el archivo a Supabase Storage: " + raw);
            }
            return path;
        } catch (IOException e) {
            throw new StorageException("Error de red subiendo el archivo: " + e.getMessage());
        }
    }

    /** Genera una URL firmada temporal (60 min) para descargar un archivo privado. */
    public String generarUrlDescarga(String path) throws StorageException {
        requireConfigured();

        JSONObject body = new JSONObject();
        body.put("expiresIn", 3600);

        Request request = new Request.Builder()
                .url(config.storageEndpoint("/object/sign/" + config.getStorageBucket() + "/" + path))
                .addHeader("apikey", config.getServiceRoleKey())
                .addHeader("Authorization", "Bearer " + config.getServiceRoleKey())
                .addHeader("Content-Type", "application/json")
                .post(RequestBody.create(body.toString(), JSON))
                .build();

        try (Response response = http.newCall(request).execute()) {
            String raw = response.body() != null ? response.body().string() : "{}";
            if (!response.isSuccessful()) {
                throw new StorageException("No se pudo generar el enlace de descarga: " + raw);
            }
            JSONObject json = new JSONObject(raw);
            String signedUrl = json.optString("signedURL", json.optString("signedUrl", null));
            if (signedUrl == null) {
                throw new StorageException("Supabase no devolvió una URL firmada.");
            }
            return config.getUrl() + "/storage/v1" + signedUrl;
        } catch (IOException e) {
            throw new StorageException("Error de red generando el enlace de descarga: " + e.getMessage());
        }
    }

    /** Elimina un archivo del bucket. */
    public void eliminar(String path) throws StorageException {
        requireConfigured();

        JSONObject body = new JSONObject();
        body.put("prefixes", new JSONArray().put(path));

        Request request = new Request.Builder()
                .url(config.storageEndpoint("/object/" + config.getStorageBucket()))
                .addHeader("apikey", config.getServiceRoleKey())
                .addHeader("Authorization", "Bearer " + config.getServiceRoleKey())
                .addHeader("Content-Type", "application/json")
                .delete(RequestBody.create(body.toString(), JSON))
                .build();

        try (Response response = http.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                String raw = response.body() != null ? response.body().string() : "";
                throw new StorageException("No se pudo eliminar el archivo en Supabase Storage: " + raw);
            }
        } catch (IOException e) {
            throw new StorageException("Error de red eliminando el archivo: " + e.getMessage());
        }
    }

    private void requireConfigured() throws StorageException {
        if (!config.isConfigured()) {
            throw new StorageException("El servidor todavía no tiene configuradas las credenciales de Supabase.");
        }
    }

    private String sanear(String nombre) {
        if (nombre == null || nombre.isBlank()) return "archivo";
        String limpio = nombre.trim().replaceAll("[^a-zA-Z0-9._-]", "_");
        return limpio.length() > 120 ? limpio.substring(limpio.length() - 120) : limpio;
    }

    /** Excepción de negocio para fallas de almacenamiento (config, red, respuesta de Supabase). */
    public static class StorageException extends Exception {
        public StorageException(String message) {
            super(message);
        }
    }
}
