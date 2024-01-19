FROM maven:3.5-jdk-8-alpine as build 
WORKDIR /app
COPY src/ /app/src
COPY pom.xml /app/pom.xml
VOLUME /home/jenkins/agent/.m2 ~/.m2
RUN mvn clean package -Dmaven.test.skip=true
RUN ls ~/.m2/repository


FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/demo-V1024.jar /app
CMD ["java -jar demo-V1024.jar"]
