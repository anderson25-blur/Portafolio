package com.miportafolio.model;

import org.json.JSONObject;

import java.io.Serializable;

/**
 * Representa una fila de la tabla `archivo` en Supabase (ver sql/schema.sql).
 * Se usa tanto para trabajos de semana (tipo = "trabajo") como para
 * infografías (tipo = "infografia").
 */
public class Archivo implements Serializable {

    public static final String TIPO_TRABAJO = "trabajo";
    public static final String TIPO_INFOGRAFIA = "infografia";

    private String id;
    private Integer unidad;   // 1-4, null para infografías
    private Integer semana;   // 1-16, null para infografías
    private Integer slot;     // posición de la infografía (1,2,3...), null para trabajos
    private String tipo;      // "trabajo" | "infografia"
    private String nombreOriginal;
    private String rutaStorage; // path dentro del bucket de Supabase Storage
    private long tamanoBytes;
    private String subidoPor;   // email de quien lo subió
    private String creadoEn;    // timestamp ISO que devuelve Supabase

    public Archivo() {
    }

    public static Archivo desdeJson(JSONObject json) {
        Archivo a = new Archivo();
        a.id = json.optString("id", null);
        a.unidad = json.isNull("unidad") ? null : json.optInt("unidad");
        a.semana = json.isNull("semana") ? null : json.optInt("semana");
        a.slot = json.isNull("slot") ? null : json.optInt("slot");
        a.tipo = json.optString("tipo", null);
        a.nombreOriginal = json.optString("nombre_original", null);
        a.rutaStorage = json.optString("ruta_storage", null);
        a.tamanoBytes = json.optLong("tamano_bytes", 0L);
        a.subidoPor = json.optString("subido_por", null);
        a.creadoEn = json.optString("creado_en", null);
        return a;
    }

    public JSONObject aJsonPublico() {
        JSONObject o = new JSONObject();
        o.put("id", id);
        o.put("unidad", unidad);
        o.put("semana", semana);
        o.put("slot", slot);
        o.put("tipo", tipo);
        o.put("nombreOriginal", nombreOriginal);
        o.put("tamanoBytes", tamanoBytes);
        o.put("subidoPor", subidoPor);
        o.put("creadoEn", creadoEn);
        return o;
    }

    // --- getters / setters ---

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public Integer getUnidad() { return unidad; }
    public void setUnidad(Integer unidad) { this.unidad = unidad; }

    public Integer getSemana() { return semana; }
    public void setSemana(Integer semana) { this.semana = semana; }

    public Integer getSlot() { return slot; }
    public void setSlot(Integer slot) { this.slot = slot; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getNombreOriginal() { return nombreOriginal; }
    public void setNombreOriginal(String nombreOriginal) { this.nombreOriginal = nombreOriginal; }

    public String getRutaStorage() { return rutaStorage; }
    public void setRutaStorage(String rutaStorage) { this.rutaStorage = rutaStorage; }

    public long getTamanoBytes() { return tamanoBytes; }
    public void setTamanoBytes(long tamanoBytes) { this.tamanoBytes = tamanoBytes; }

    public String getSubidoPor() { return subidoPor; }
    public void setSubidoPor(String subidoPor) { this.subidoPor = subidoPor; }

    public String getCreadoEn() { return creadoEn; }
    public void setCreadoEn(String creadoEn) { this.creadoEn = creadoEn; }
}
