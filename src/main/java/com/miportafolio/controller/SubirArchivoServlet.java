package com.miportafolio.controller;

import com.miportafolio.dao.ArchivoDAO;
import com.miportafolio.model.Archivo;
import com.miportafolio.model.Usuario;
import com.miportafolio.service.StorageService;
import com.miportafolio.util.JsonRespuesta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;

/**

* POST /api/archivos/subir
*
* Campos esperados:
*
* archivo   -> archivo obligatorio
* tipo      -> "trabajo" | "infografia"
* unidad    -> 1..4
* semana    -> 1..16
* slot      -> 1..4 para infografías
*
* Estructura lógica:
*
* UNIDAD
* └── SEMANA
* ```
     ├── TRABAJO
  ```
* ```
     │    └── PDF
  ```
* ```
     │
  ```
* ```
     └── INFOGRAFÍAS
  ```
* ```
          ├── SLOT 1
  ```
* ```
          ├── SLOT 2
  ```
* ```
          ├── SLOT 3
  ```
* ```
          └── SLOT 4
  ```
*
* Protegido por AdminFilter.
*
* Límite:
* 25 MB por archivo.
  */
  @WebServlet("/api/archivos/subir")
  @MultipartConfig(
  maxFileSize = 1024L * 1024 * 25,
  maxRequestSize = 1024L * 1024 * 30,
  fileSizeThreshold = 1024 * 512
  )
  public class SubirArchivoServlet extends HttpServlet {

  private final StorageService storageService =
  new StorageService();

  private final ArchivoDAO archivoDAO =
  new ArchivoDAO();

  @Override
  protected void doPost(
  HttpServletRequest req,
  HttpServletResponse resp
  ) throws ServletException, IOException {

  ```
   /* =====================================================
      TIPO
      ===================================================== */

   String tipo =
           req.getParameter("tipo");


   if (
           !Archivo.TIPO_TRABAJO.equals(tipo) &&
           !Archivo.TIPO_INFOGRAFIA.equals(tipo)
   ) {

       JsonRespuesta.error(
               resp,
               HttpServletResponse.SC_BAD_REQUEST,
               "tipo debe ser 'trabajo' o 'infografia'."
       );

       return;
   }


   /* =====================================================
      ARCHIVO
      ===================================================== */

   Part filePart =
           req.getPart("archivo");


   if (
           filePart == null ||
           filePart.getSize() == 0
   ) {

       JsonRespuesta.error(
               resp,
               HttpServletResponse.SC_BAD_REQUEST,
               "Falta el archivo a subir."
       );

       return;
   }


   /* =====================================================
      DATOS DE CLASIFICACIÓN
      ===================================================== */

   Integer unidad = null;

   Integer semana = null;

   Integer slot = null;


   try {

       /*
        * Tanto trabajos como infografías
        * pertenecen a una unidad y una semana.
        */

       String unidadParam =
               req.getParameter("unidad");

       String semanaParam =
               req.getParameter("semana");


       if (
               unidadParam == null ||
               semanaParam == null ||
               unidadParam.isBlank() ||
               semanaParam.isBlank()
       ) {

           JsonRespuesta.error(
                   resp,
                   HttpServletResponse.SC_BAD_REQUEST,
                   "unidad y semana son obligatorios."
           );

           return;
       }


       unidad =
               Integer.parseInt(
                       unidadParam
               );


       semana =
               Integer.parseInt(
                       semanaParam
               );


       /* =================================================
          RANGOS
          ================================================= */

       if (
               unidad < 1 ||
               unidad > 4
       ) {

           JsonRespuesta.error(
                   resp,
                   HttpServletResponse.SC_BAD_REQUEST,
                   "La unidad debe estar entre 1 y 4."
           );

           return;
       }


       if (
               semana < 1 ||
               semana > 16
       ) {

           JsonRespuesta.error(
                   resp,
                   HttpServletResponse.SC_BAD_REQUEST,
                   "La semana debe estar entre 1 y 16."
           );

           return;
       }


       /* =================================================
          SLOT DE INFOGRAFÍA
          ================================================= */

       if (
               Archivo.TIPO_INFOGRAFIA.equals(tipo)
       ) {

           String slotParam =
                   req.getParameter("slot");


           if (
                   slotParam == null ||
                   slotParam.isBlank()
           ) {

               JsonRespuesta.error(
                       resp,
                       HttpServletResponse.SC_BAD_REQUEST,
                       "slot es obligatorio para una infografía."
               );

               return;
           }


           slot =
                   Integer.parseInt(
                           slotParam
                   );


           if (
                   slot < 1 ||
                   slot > 4
           ) {

               JsonRespuesta.error(
                       resp,
                       HttpServletResponse.SC_BAD_REQUEST,
                       "El slot de la infografía debe estar entre 1 y 4."
               );

               return;
           }

       }


   } catch (NumberFormatException e) {

       JsonRespuesta.error(
               resp,
               HttpServletResponse.SC_BAD_REQUEST,
               "unidad, semana y slot deben ser números."
       );

       return;

   }


   /* =====================================================
      NOMBRE ORIGINAL
      ===================================================== */

   String nombreOriginal =
           obtenerNombreArchivo(
                   filePart
           );


   /*
    * Evitamos nombres extraños provenientes
    * de rutas del sistema cliente.
    */

   nombreOriginal =
           limpiarNombreArchivo(
                   nombreOriginal
           );


   /* =====================================================
      EXTENSIÓN
      ===================================================== */

   String extension =
           obtenerExtension(
                   nombreOriginal
           );


   /* =====================================================
      VALIDACIÓN DEL FORMATO
      ===================================================== */

   if (
           Archivo.TIPO_TRABAJO.equals(tipo)
   ) {

       if (
               !"pdf".equals(extension)
       ) {

           JsonRespuesta.error(
                   resp,
                   HttpServletResponse.SC_BAD_REQUEST,
                   "Los trabajos deben estar en formato PDF."
           );

           return;
       }

   } else {

       if (
               !"jpg".equals(extension) &&
               !"jpeg".equals(extension) &&
               !"png".equals(extension)
       ) {

           JsonRespuesta.error(
                   resp,
                   HttpServletResponse.SC_BAD_REQUEST,
                   "Las infografías deben estar en formato JPG, JPEG o PNG."
           );

           return;
       }

   }


   /* =====================================================
      CONTENIDO
      ===================================================== */

   byte[] contenido;


   try (
           InputStream in =
                   filePart.getInputStream()
   ) {

       contenido =
               in.readAllBytes();

   }


   if (
           contenido.length == 0
   ) {

       JsonRespuesta.error(
               resp,
               HttpServletResponse.SC_BAD_REQUEST,
               "El archivo está vacío."
       );

       return;
   }


   /* =====================================================
      SESIÓN
      ===================================================== */

   HttpSession session =
           req.getSession(false);


   if (session == null) {

       JsonRespuesta.error(
               resp,
               HttpServletResponse.SC_UNAUTHORIZED,
               "La sesión ha expirado."
       );

       return;
   }


   Usuario usuario =
           (Usuario) session.getAttribute(
                   "usuario"
           );


   if (usuario == null) {

       JsonRespuesta.error(
               resp,
               HttpServletResponse.SC_UNAUTHORIZED,
               "No hay un usuario autenticado."
       );

       return;
   }


   /* =====================================================
      CARPETA DE STORAGE
      ===================================================== */

   String carpeta =
           "unidad-" +
           unidad +
           "/semana-" +
           String.format(
                   "%02d",
                   semana
           );


   /*
    * Ahora trabajos e infografías pertenecen
    * físicamente a su unidad y semana.
    *
    * Ejemplo:
    *
    * unidad-1/semana-01/
    *
    *   trabajo.pdf
    *
    *   infografia-1.jpg
    *   infografia-2.png
    *
    * etc.
    *
    * StorageService se encarga de generar
    * el nombre final del archivo.
    */


   /* =====================================================
      SUBIR A SUPABASE STORAGE
      ===================================================== */

   try {

       String path =
               storageService.subir(
                       contenido,
                       nombreOriginal,
                       filePart.getContentType(),
                       carpeta
               );


       /* =================================================
          CREAR REGISTRO
          ================================================= */

       Archivo archivo =
               new Archivo();


       archivo.setUnidad(
               unidad
       );


       archivo.setSemana(
               semana
       );


       archivo.setSlot(
               slot
       );


       archivo.setTipo(
               tipo
       );


       archivo.setNombreOriginal(
               nombreOriginal
       );


       archivo.setRutaStorage(
               path
       );


       archivo.setTamanoBytes(
               contenido.length
       );


       archivo.setSubidoPor(
               usuario.getEmail()
       );


       /* =================================================
          GUARDAR EN SUPABASE DATABASE
          ================================================= */

       Archivo guardado =
               archivoDAO.insertar(
                       archivo
               );


       JsonRespuesta.ok(
               resp,
               wrap(guardado)
       );


   } catch (
           StorageService.StorageException |
           ArchivoDAO.DAOException e
   ) {

       JsonRespuesta.error(
               resp,
               HttpServletResponse.SC_BAD_GATEWAY,
               e.getMessage()
       );

   }
  ```

  }

  /* ========================================================
  RESPUESTA
  ======================================================== */

  private org.json.JSONObject wrap(
  Archivo archivo
  ) {

  ```
   org.json.JSONObject o =
           new org.json.JSONObject();


   o.put(
           "ok",
           true
   );


   o.put(
           "archivo",
           archivo.aJsonPublico()
   );


   return o;
  ```

  }

  /* ========================================================
  OBTENER NOMBRE DEL ARCHIVO
  ======================================================== */

  private String obtenerNombreArchivo(
  Part part
  ) {

  ```
   String header =
           part.getHeader(
                   "content-disposition"
           );


   if (
           header == null
   ) {

       return "archivo";

   }


   for (
           String token :
           header.split(";")
   ) {

       token =
               token.trim();


       if (
               token.startsWith(
                       "filename"
               )
       ) {

           String nombre =
                   token.substring(
                           token.indexOf('=') + 1
                   )
                   .trim()
                   .replace(
                           "\"",
                           ""
                   );


           if (
                   !nombre.isBlank()
           ) {

               return nombre;

           }

       }

   }


   return "archivo";
  ```

  }

  /* ========================================================
  LIMPIAR NOMBRE
  ======================================================== */

  private String limpiarNombreArchivo(
  String nombre
  ) {

  ```
   if (
           nombre == null ||
           nombre.isBlank()
   ) {

       return "archivo";

   }


   /*
    * Evita rutas como:
    *
    * C:\Users\...
    *
    * o:
    *
    * ../../archivo.pdf
    */

   nombre =
           nombre.replace(
                   "\\",
                   "/"
           );


   int ultimaBarra =
           nombre.lastIndexOf('/');


   if (
           ultimaBarra >= 0
   ) {

       nombre =
               nombre.substring(
                       ultimaBarra + 1
               );

   }


   /*
    * Evitamos caracteres de control.
    */

   nombre =
           nombre.replaceAll(
                   "[\\r\\n\\t]",
                   "_"
           );


   return nombre.isBlank()
           ? "archivo"
           : nombre;
  ```

  }

  /* ========================================================
  OBTENER EXTENSIÓN
  ======================================================== */

  private String obtenerExtension(
  String nombre
  ) {

  ```
   if (
           nombre == null
   ) {

       return "";

   }


   int punto =
           nombre.lastIndexOf('.');


   if (
           punto < 0 ||
           punto == nombre.length() - 1
   ) {

       return "";

   }


   return nombre
           .substring(
                   punto + 1
           )
           .toLowerCase(
                   Locale.ROOT
           );
  ```

  }

}
