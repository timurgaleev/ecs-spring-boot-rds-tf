# CI/CD spring application linked MySQL(RDS) via Jenkins pipeline to AWS cloud(ECS)

In **Jenkins** (Install required plugins (if not already installed))
- [Pipeline](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin)
- [Docker Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/CloudBees+Docker+Pipeline+Plugin)
- [Amazon ECR Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Amazon+ECR)

1. Add AWS Credentials to Jenkins
From the home screen, hit the Credentials link in the left-side bar.
2. Determine where you want to put your credentials. If unsure, go into the Global credentials. You may want to do some reading on credential management for a production/widespread use.
3. Click the Add Credentials link in the left-side navigation.
4. For Kind, select AWS Credentials.
5. Enter the Access ID and Secret Access Key for the AWS user that has access to the ECR repository.
6. In the Advanced button, specify an ID that will make sense to you (so you don’t have to remember a randomly generated UUID). 

**Terraform**
The first thing we’ll do is specify the provider. This can be done in different ways but here we’re telling Terraform our provider is AWS and that it can find our credentials in `$HOME/.aws/credentials` which is the default location for AWS credentials on Mac and Linux.

To get the minimal amount of high availability, we’ll deploy our ECS cluster to run on at least two Availability Zones (AZs). The load balancer also needs at least 2 public subnets in different AZs.

Initial command
`terraform init terraform/`
This gets it all set up and ready to apply.

Finally, run
`terraform apply terraform/`
to get this bad boy deployed! It will refresh state for all your resources and show you what will be created/removed/updated.

When it spits out your load balancer url, go ahead and visit it at port :8080 and you should see the JSON returned from the initial block in your deployed into ECR app.

In this example, wherever it says `sb` is my application name.

## To run locally
**Note**: I was unable to run new versions of spring-cloud-aws locally. It seems it tries always to perform some autoconfiguration assuming it is deployed on AWS, and as long as it doesn't find a valid instance id, it raises an exception and stops. 

Some configurations are required in your AWS account for this sample to work. Additionally, we need an IAM user with access key and programmatic access to AWS API so that we can access AWS resources from our development machine.

## Create an IAM User
- Enable programmatic access
- Generate an access key for the user
- Give the user the following permissions:  ** AmazonRDSFullAccess

## To run on EC2
**Create an IAM role**
Create an IAM role with the following properties:

- EC2 role (i.e., a role to be attached to EC2 instances)
- Policies: ** AmazonRDSFullAccess
## Create an EC2 instance - if you want to create instance in AWS
It has been tested with an instance with the following properties:

- AMI: Ubuntu 18.04
- Type: t2.micro
- Storage: 20Gb
- Security group: choose or create one with ports 22 and 8080 opened
- Attach the IAM role created previously

## What you'll need
- Docker 
- Jenkins 
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
