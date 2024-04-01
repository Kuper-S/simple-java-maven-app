# Stage 1: Build Maven Project
FROM maven:3.8.4-openjdk-11 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package
# Stage 2 for building the Image
FROM openjdk:11-jre-slim
WORKDIR /app

RUN useradd -r app

USER app

COPY --from=builder /app/target/my-app.jar ./app.jar

# Set image version labels
ARG IMAGE_VERSION=latest
LABEL image.version=$IMAGE_VERSION

CMD ["java", "-jar", "app.jar"]
