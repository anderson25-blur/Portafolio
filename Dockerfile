# --- Etapa 1: compilar el WAR con Maven ---
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn -B clean package -DskipTests

# --- Etapa 2: servir con Tomcat ---
FROM tomcat:10.1-jdk17-temurin
# Limpiamos la app de ejemplo de Tomcat y desplegamos la nuestra como ROOT
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/MiPortafolio.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
