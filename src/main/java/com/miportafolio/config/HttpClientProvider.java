package com.miportafolio.config;

import okhttp3.OkHttpClient;

import java.util.concurrent.TimeUnit;

/**
 * Un unico OkHttpClient para toda la aplicacion (recomendado por OkHttp: reusa
 * el pool de conexiones en vez de crear un cliente nuevo por cada request).
 */
public final class HttpClientProvider {

    private static final OkHttpClient CLIENT = new OkHttpClient.Builder()
            .connectTimeout(10, TimeUnit.SECONDS)
            .readTimeout(30, TimeUnit.SECONDS)
            .writeTimeout(30, TimeUnit.SECONDS)
            .build();

    private HttpClientProvider() {
    }

    public static OkHttpClient client() {
        return CLIENT;
    }
}
