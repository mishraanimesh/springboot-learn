FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8080
ARG JAR_FILE=target/springboot-learn-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} springboot-learn.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/springboot-learn.jar"]