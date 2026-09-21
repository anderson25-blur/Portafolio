# ============================================================
# ETAPA 1 — COMPILAR EL PROYECTO
# ============================================================

FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .

RUN mvn -B dependency:go-offline

COPY src ./src

RUN mvn -B clean package -DskipTests


# ============================================================
# ETAPA 2 — TOMCAT 11
# ============================================================

FROM tomcat:11-jdk17-temurin

# Eliminar aplicaciones de ejemplo de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar nuestro WAR como ROOT
COPY --from=build /app/target/MiPortafolio.war \
     /usr/local/tomcat/webapps/ROOT.war

# Render utilizará la variable PORT
ENV PORT=10000

# Cambiar el puerto de Tomcat al puerto de Render
RUN sed -i 's/port="8080"/port="10000"/' \
    /usr/local/tomcat/conf/server.xml

EXPOSE 10000

CMD ["catalina.sh", "run"]