output "alb_hostname" {
  value = "${aws_alb.main.dns_name}"
}
output "endpoint" {
  value = "${aws_db_instance.mysql.endpoint}"
}
