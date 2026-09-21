package com.miportafolio.service;

import com.miportafolio.config.HttpClientProvider;
import com.miportafolio.config.SupabaseConfig;
import com.miportafolio.model.Usuario;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.json.JSONObject;

import java.io.IOException;

/**
 * Autenticación contra Supabase Auth (GoTrue REST API).
 * No se guarda ninguna contraseña en esta aplicación: Supabase es la única
 * fuente de verdad de credenciales.
 */
public class AuthService {

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    private final SupabaseConfig config;
    private final OkHttpClient http;

    public AuthService() {
        this.config = SupabaseConfig.get();
        this.http = HttpClientProvider.client();
    }

    /**
     * Intenta iniciar sesión con correo y contraseña.
     *
     * @throws AuthException si las credenciales son inválidas o Supabase no está configurado.
     */
    public Usuario iniciarSesion(String email, String password) throws AuthException {
        if (!config.isConfigured()) {
            throw new AuthException("El servidor todavía no tiene configuradas las credenciales de Supabase.");
        }
        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            throw new AuthException("Correo y contraseña son obligatorios.");
        }

        JSONObject body = new JSONObject();
        body.put("email", email.trim());
        body.put("password", password);

        Request request = new Request.Builder()
                .url(config.authEndpoint("/token?grant_type=password"))
                .addHeader("apikey", config.getAnonKey())
                .addHeader("Content-Type", "application/json")
                .post(RequestBody.create(body.toString(), JSON))
                .build();

        try (Response response = http.newCall(request).execute()) {
            String raw = response.body() != null ? response.body().string() : "{}";
            JSONObject json = new JSONObject(raw.isBlank() ? "{}" : raw);

            if (!response.isSuccessful()) {
                String msg = json.optString("error_description",
                        json.optString("msg", "Correo o contraseña incorrectos."));
                throw new AuthException(msg);
            }

            String accessToken = json.optString("access_token", null);
            JSONObject user = json.optJSONObject("user");
            if (accessToken == null || user == null) {
                throw new AuthException("Respuesta inesperada del servidor de autenticación.");
            }

            String id = user.optString("id");
            String correo = user.optString("email");
            String rol = extraerRol(user);

            return new Usuario(id, correo, rol, accessToken);

        } catch (IOException e) {
            throw new AuthException("No se pudo contactar al servidor de autenticación: " + e.getMessage());
        }
    }

    /**
     * Revoca el access token en Supabase (best-effort: si falla, igual se
     * destruye la sesión local desde el LogoutServlet).
     */
    public void cerrarSesion(String accessToken) {
        if (accessToken == null || accessToken.isBlank() || !config.isConfigured()) return;

        Request request = new Request.Builder()
                .url(config.authEndpoint("/logout"))
                .addHeader("apikey", config.getAnonKey())
                .addHeader("Authorization", "Bearer " + accessToken)
                .post(RequestBody.create(new byte[0], null))
                .build();

        try (Response response = http.newCall(request).execute()) {
            // No hace falta revisar el resultado: la sesión del servidor (HttpSession)
            // ya se invalida en LogoutServlet independientemente de esto.
        } catch (IOException ignored) {
        }
    }

    private String extraerRol(JSONObject user) {
        JSONObject metadata = user.optJSONObject("user_metadata");
        if (metadata != null && metadata.has("rol")) {
            return metadata.optString("rol", Usuario.ROL_VISITANTE);
        }
        return Usuario.ROL_VISITANTE;
    }

    /** Excepción de negocio para fallas de autenticación (credenciales, config, red). */
    public static class AuthException extends Exception {
        public AuthException(String message) {
            super(message);
        }
    }
}
