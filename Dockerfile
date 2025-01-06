FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn 
COPY pom.xml .
COPY src src

RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Cambiamos .jar por .war en la copia
COPY --from=build /workspace/app/target/*.war /app/app.war
RUN ls -l /app
EXPOSE 8080
# Cambiamos .jar por .war en el ENTRYPOINT
ENTRYPOINT ["java", "-jar", "/app/app.war"]