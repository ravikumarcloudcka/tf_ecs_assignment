resource "aws_iam_service_linked_role" "IAMServiceLinkedRole" {
    aws_service_name = "ecs.amazonaws.com"
    description = ""
}

resource "aws_iam_role" "IAMRole" {
    path = "/"
    name = "ecsTaskExecutionRole"
    assume_role_policy = "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Sid\":\"\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ecs-tasks.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/CloudWatchFullAccess", "arn:aws:iam::aws:policy/AmazonECS_FullAccess"]
    max_session_duration = 3600
}
