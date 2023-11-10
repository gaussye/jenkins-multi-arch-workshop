FROM maven:3.5-jdk-8-alpine as build 
WORKDIR /app
COPY src/ /app/src
COPY pom.xml /app/pom.xml
RUN ls -la /app
RUN mvn clean package -Dmaven.test.skip=true

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/demo-V1024.jar /app
CMD ["java -jar demo-V1024.jar"]
