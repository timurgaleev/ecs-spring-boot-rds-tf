output "alb_hostname" {
  value = "${aws_alb.main.dns_name}"
}
output "mysql_endpoint" {
  value = "${aws_db_instance.mysql.address}"
}
