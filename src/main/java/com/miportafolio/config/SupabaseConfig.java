package com.miportafolio.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Carga la configuracion de Supabase.
 *
 * Orden de prioridad (el primero que exista gana):
 *   1. Variable de entorno (asi se despliega en Render / Docker en produccion).
 *   2. src/main/resources/application.properties (para correr en local).
 *
 * Nunca se debe subir a GitHub un application.properties con las keys reales:
 * en local, cada quien pone sus propias credenciales de su proyecto Supabase.
 */
public final class SupabaseConfig {

    private static final SupabaseConfig INSTANCE = new SupabaseConfig();

    private final String url;
    private final String anonKey;
    private final String serviceRoleKey;
    private final String storageBucket;

    private SupabaseConfig() {
        Properties props = new Properties();
        try (InputStream in = SupabaseConfig.class
                .getClassLoader()
                .getResourceAsStream("application.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (IOException e) {
            System.err.println("[SupabaseConfig] No se pudo leer application.properties: " + e.getMessage());
        }

        this.url = firstNonBlank(System.getenv("SUPABASE_URL"), props.getProperty("supabase.url"));
        this.anonKey = firstNonBlank(System.getenv("SUPABASE_ANON_KEY"), props.getProperty("supabase.anonKey"));
        this.serviceRoleKey = firstNonBlank(System.getenv("SUPABASE_SERVICE_ROLE_KEY"), props.getProperty("supabase.serviceRoleKey"));
        String bucket = firstNonBlank(System.getenv("SUPABASE_STORAGE_BUCKET"), props.getProperty("supabase.storageBucket"));
        this.storageBucket = (bucket == null || bucket.isBlank()) ? "trabajos" : bucket;

        if (isBlank(this.url) || isBlank(this.anonKey) || isBlank(this.serviceRoleKey)) {
            System.err.println("[SupabaseConfig] AVISO: faltan credenciales de Supabase. " +
                    "Define supabase.url / supabase.anonKey / supabase.serviceRoleKey en " +
                    "application.properties, o las variables de entorno SUPABASE_URL / " +
                    "SUPABASE_ANON_KEY / SUPABASE_SERVICE_ROLE_KEY. El login y la subida de " +
                    "archivos no van a funcionar hasta que esto se configure.");
        }
    }

    public static SupabaseConfig get() {
        return INSTANCE;
    }

    /** URL base del proyecto Supabase, ej: https://xxxx.supabase.co (sin slash final). */
    public String getUrl() {
        return url == null ? "" : stripTrailingSlash(url);
    }

    /** Clave publica (anon). Se usa solo para el intercambio de credenciales en el login. */
    public String getAnonKey() {
        return anonKey;
    }

    /** Clave privada (service_role). Solo se usa desde el servidor, nunca se envia al navegador. */
    public String getServiceRoleKey() {
        return serviceRoleKey;
    }

    public String getStorageBucket() {
        return storageBucket;
    }

    public boolean isConfigured() {
        return !isBlank(url) && !isBlank(anonKey) && !isBlank(serviceRoleKey);
    }

    public String authEndpoint(String path) {
        return getUrl() + "/auth/v1" + path;
    }

    public String restEndpoint(String path) {
        return getUrl() + "/rest/v1" + path;
    }

    public String storageEndpoint(String path) {
        return getUrl() + "/storage/v1" + path;
    }

    private static String stripTrailingSlash(String s) {
        return s.endsWith("/") ? s.substring(0, s.length() - 1) : s;
    }

    private static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    private static String firstNonBlank(String a, String b) {
        if (a != null && !a.isBlank()) return a;
        if (b != null && !b.isBlank()) return b;
        return null;
    }
}
