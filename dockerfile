FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven git && \
    rm -rf /var/lib/apt/lists/*

# Clone the Spring Boot project
RUN git clone https://github.com/Jaya1728/spring-petclinic.git /spring-petclinic

# Set working directory
WORKDIR /spring-petclinic

# Build the Spring Boot application
RUN mvn clean package

# Expose application port
EXPOSE 8090

# Run the Spring Boot application
CMD ["java", "-jar", "target/spring-petclinic-2.7.3.jar"]
