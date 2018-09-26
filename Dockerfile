FROM openjdk:8-jdk-alpine
ARG project_jar
ARG version
VOLUME /tmp
EXPOSE 8080
ARG JAR_FILE=${project_jar}-${version}.jar
ARG JAR_FILE_BUILD=target/${JAR_FILE}
ADD ${JAR_FILE_BUILD}  /${JAR_FILE}
<<<<<<< HEAD
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar", "/${JAR_FILE}"]
=======
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar", "/${JAR_FILE}"]
>>>>>>> in file docker changes for variable
