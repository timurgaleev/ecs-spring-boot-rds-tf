# Set up cloudwatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "sb_log_group" {
  name              = "/ecs/sb-app"
  retention_in_days = 30

  tags = {
    Name = "sb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "sb_log_stream" {
  name           = "sb-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.sb_log_group.name}"
}
