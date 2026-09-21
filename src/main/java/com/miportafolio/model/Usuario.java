package com.miportafolio.model;

import java.io.Serializable;

/**
 * Usuario autenticado. Los datos vienen de Supabase Auth (tabla auth.users);
 * esta app no guarda contraseñas propias.
 *
 * El rol se lee de user_metadata.rol (se configura a mano en el dashboard de
 * Supabase, Authentication > Users > editar usuario > User Metadata:
 * { "rol": "admin" }). Si no existe, se asume "visitante".
 */
public class Usuario implements Serializable {

    public static final String ROL_ADMIN = "admin";
    public static final String ROL_VISITANTE = "visitante";

    private final String id;
    private final String email;
    private final String rol;
    private final String accessToken;

    public Usuario(String id, String email, String rol, String accessToken) {
        this.id = id;
        this.email = email;
        this.rol = (rol == null || rol.isBlank()) ? ROL_VISITANTE : rol;
        this.accessToken = accessToken;
    }

    public String getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getRol() {
        return rol;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public boolean esAdmin() {
        return ROL_ADMIN.equalsIgnoreCase(rol);
    }
}
