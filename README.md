# CI/CD spring application linked MySQL through jenkins pipeline

This pipeline creates an application for checking for an update and if an update happens, the application is packed in a docker container and sent to the server (in this example, the AWS server was used).

## What you'll need
- Docker CE
- Jenkins
- AWS

## Stack
- Docker
- Docker-Compose
- Java
- Spring Boot
- MySQL
- Tomcat
- Maven

You can check the log by
~~~
Open http://localhost:8080 in browser and you should see the message.
