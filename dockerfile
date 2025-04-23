# Use an official Maven image to build the app
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Build the project and package the JAR
RUN mvn clean package -DskipTests

# Use a lightweight JRE to run the app
FROM eclipse-temurin:17-jre-alpine

# Set the working directory
WORKDIR /app

# Copy the JAR from the builder stage
COPY --from=build /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Start the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
