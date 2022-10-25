resource "aws_cloudwatch_log_group" "LogsLogGroup" {
    name = "/ecs/project_svc1"
}

resource "aws_cloudwatch_log_group" "LogsLogGroup2" {
    name = "/ecs/project_svc2"
}
