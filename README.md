# CI/CD spring application linked MySQL through jenkins pipeline to AWS cloud

The first thing we’ll do is specify the provider. This can be done in different ways but here we’re telling Terraform our provider is AWS and that it can find our credentials in $HOME/.aws/credentials which is the default location for AWS credentials on Mac and Linux.

To get the minimal amount of high availability, we’ll deploy our ECS cluster to run on at least two Availability Zones (AZs). The load balancer also needs at least 2 public subnets in different AZs.

For this tutorial we’re going to be listening for HTTP requests on port 80, however I think it goes without saying that if you’re using this in production - listen for HTTPS over port 443. You can use AWS certificate manager (ACM) to provision and manage certificates.

Time to run
`terraform init terraform/`
This gets it all set up and ready to apply.

Finally, run
`terraform apply terraform/`
to get this bad boy deployed! It will refresh state for all your resources and show you what will be created/removed/updated.

When it spits out your load balancer url, go ahead and visit it at port :8080 and you should see the JSON returned from the initial block in your deployed into ECR app.

## What you'll need
- Docker 
- Jenkins
`Install required plugins (if not already installed)`
[Pipeline](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin)
[Docker Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/CloudBees+Docker+Pipeline+Plugin)
[Amazon ECR Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Amazon+ECR)
- AWS ECS
- AWS RDS
- AWS VPC
- AWS ERC
- AWS ALB
- Terraform

## Stack
- AWS
- Docker
- Docker-Compose
- Java
- Spring Boot
- MySQL
- Tomcat
- Maven

You can check the log by
~~~
Open http://[your DNS name]:8080 in your browser.
