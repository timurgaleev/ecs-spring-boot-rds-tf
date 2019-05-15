output "alb_hostname" {
  value = "${aws_alb.main.dns_name}"
}
output "rds_addresses" {
    value = "${aws_db_instance.db_instance.*.address}"
}
