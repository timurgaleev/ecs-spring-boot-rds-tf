provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-west-2"
}
data "aws_ami" "sp_app_ami" {
  most_recent = true
filter {
    name   = "name"
    values = ["prod-image*"]
  }
filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
owners = ["684695514035"]
}
resource "aws_launch_configuration" "sp_app_lc" {
  image_id      = "${data.aws_ami.sp_app_ami.id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.sp_app_websg.id}"]
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "sp_app_asg" {
  name                 = "terraform-asg-springboot-app-${aws_launch_configuration.sp_app_lc.name}"
  launch_configuration = "${aws_launch_configuration.sp_app_lc.name}"
  availability_zones = ["${data.aws_availability_zones.allzones.names}"]
  min_size             = 2
  max_size             = 5
load_balancers = ["${aws_elb.elb1.id}"]
  health_check_type = "ELB"
lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "sp_app_websg" {
  name = "security_group_for_sp_app_websg"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "elbsg" {
  name = "security_group_for_elb"
  ingress {
    from_port = 80
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
lifecycle {
    create_before_destroy = true
  }
}
data "aws_availability_zones" "allzones" {}
resource "aws_elb" "elb1" {
  name = "terraform-elb-springboot-app"
  availability_zones = ["${data.aws_availability_zones.allzones.names}"]
  security_groups = ["${aws_security_group.elbsg.id}"]
  
  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:8080/"
      interval = 30
  }
cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400
tags {
    Name = "terraform - elb - springboot-app"
  }
}
