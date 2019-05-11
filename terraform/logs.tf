# Set up cloudwatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "provectus_log_group" {
  name              = "/ecs/provectus-app"
  retention_in_days = 30

  tags {
    Name = "provectus-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "provectus_log_stream" {
  name           = "provectus-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.provectus_log_group.name}"
}
