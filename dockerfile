# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy the project files
COPY . .

# Build the project and skip tests in the Docker build (tests will run in Jenkins)
RUN mvn clean package -DskipTests

# Stage 2: Use lightweight JRE to run the app
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8090

ENTRYPOINT ["java", "-jar", "app.jar"]
