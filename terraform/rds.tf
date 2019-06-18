/**
 * RDS instance
 */
resource "aws_db_instance" "mysql" {
  identifier                = "${var.project}-${var.environment}"
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7.22"
  instance_class            = "db.t2.micro"
  name                      = "${var.db_name}"
  username                  = "${var.db_username}"
  password                  = "${aws_ssm_parameter.secret.value}"
  port                      = "${var.db_port}"
  publicly_accessible       = false
  security_group_names      = []
  vpc_security_group_ids    = ["${aws_security_group.mysql.id}"]
  db_subnet_group_name      = "${aws_db_subnet_group.mysql.id}"
  parameter_group_name      = "${aws_db_parameter_group.mysql.name}"
  multi_az                  = false
  backup_retention_period   = 0
  backup_window             = "05:20-05:50"
  maintenance_window        = "sun:04:00-sun:04:30"
  final_snapshot_identifier = "${var.project}-${var.environment}-final"
  skip_final_snapshot       = true

  tags = {
    Name  = "${var.project}-${var.environment}"
    Group = "${var.project}"
  }
}

resource "aws_ssm_parameter" "secret" {
  name        = "/${var.environment}/database/password/master"
  description = "The parameter description"
  type        = "SecureString"
  value       = "${var.database_master_password}"

  tags = {
    environment = "${var.environment}"
  }
}

/**
 * Parameter group for MySQL
 */
resource "aws_db_parameter_group" "mysql" {
  name        = "${var.project}-${var.environment}-pg"
  family      = "mysql5.7"
  description = "RDS parameter group for ${var.project}"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

/**
 * Subnet group for RDS
 */
resource "aws_db_subnet_group" "mysql" {
  name        = "${var.project}-${var.environment}"
  description = "${var.project} group of subnets"
  #subnet_ids  = concat("${aws_subnet.private.*.id}", "${aws_subnet.public.*.id}")
  subnet_ids  = "${aws_subnet.private.*.id}"
  tags = {
    Name = "${var.project} DB subnet group"
  }
}
