FROM openjdk:17-jdk-slim
COPY target/order-service.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
