FROM openjdk:8

MAINTAINER timur_galeev@outlook.com
 
VOLUME /tmp
ADD target/aksisapp-1.0-SNAPSHOT.jar aksisapp.jar
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/aksisapp.jar"]

