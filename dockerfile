FROM ubuntu: 24.04.1

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven git -y && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Jaya1728/spring-petclinic.git /spring-petclinic

WORKDIR /spring-petclinic

RUN mvn clean package

RUN ls -l target/


CMD ["java", "-jar", "target/spring-petclinic-2.7.3.jar"]

