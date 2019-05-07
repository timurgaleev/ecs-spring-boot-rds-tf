FROM openjdk:8

MAINTAINER timur_galeev@outlook.com
 
RUN apk update

RUN unzip packer_1.2.4_linux_amd64.zip
RUN unzip terraform_0.11.7_linux_amd64.zip

RUN mv packer /usr/local/bin/packer
RUN mv terraform /usr/local/bin/terraform

RUN rm packer_1.2.4_linux_amd64.zip
RUN rm terraform_0.11.7_linux_amd64.zip

VOLUME /tmp
EXPOSE 8080
ADD target/aksisapp-1.0-SNAPSHOT.jar aksisapp.jar
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/aksisapp.jar"]

RUN apk update && apk upgrade && \
 apk add — no-cache bash git openssh
