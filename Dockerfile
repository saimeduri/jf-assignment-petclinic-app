FROM maven:3.8.4-openjdk-17-slim AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn package -DskipTests

FROM openjdk:17-alpine

COPY --from=build /app/target/*.jar /petclinic.jar

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/petclinic.jar"]

