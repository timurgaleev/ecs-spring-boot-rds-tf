variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-west-2"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "035898547283.dkr.ecr.us-west-2.amazonaws.com/provectus_app:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8080
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable "ecs_autoscale_role" {
  description = "Role arn for the ecsAutocaleRole"
  default     = "arn:aws:iam::035898547283:role/ecsAutoscaleRole"
}

variable "ecs_task_execution_role" {
  description = "Role arn for the ecsTaskExecutionRole"
  default     = "arn:aws:iam::035898547283:role/ecsTaskExecutionRole"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

# A project name
variable "project" {
  default = "spring-boot-project"
}

# Environment name
variable "environment" {
  default = "production"
}

# User name for RDS
variable "db_username" { 
  default = "superuser"
}

# The DB name in the RDS instance. Note that this cannot contain -'s
variable "db_name" {
  default = "sb_db"
}

variable "db_port" {
  default = "3306"
}

# SSM password
variable "database_master_password" {
  default =  "secret123456789-"
}
