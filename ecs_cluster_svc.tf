resource "aws_ecs_cluster" "ECSCluster" {
    name = "assignment"
    setting {
    name  = "containerInsights"
    value = "enabled"
 }
}

resource "aws_ecs_service" "ECSService" {
    name = "service1"
    cluster = "${aws_ecs_cluster.ECSCluster.arn}"
    load_balancer {
        target_group_arn = "${aws_lb_target_group.ElasticLoadBalancingV2TargetGroup.id}"
        container_name = "service1"
        container_port = 8080
    }
    desired_count = 2
    launch_type = "FARGATE"
    platform_version = "LATEST"
    task_definition = "${aws_ecs_task_definition.ECSTaskDefinition2.arn}"
    deployment_maximum_percent = 200
    deployment_minimum_healthy_percent = 100
    network_configuration {
        assign_public_ip = "false"
        security_groups = [
            "${aws_security_group.svc1-SecurityGroup.id}"
        ]
        subnets = [
            "${aws_subnet.Subnet2-Private.id}",
            "${aws_subnet.Subnet3-Private.id}"
        ]
    }
    health_check_grace_period_seconds = 5
    scheduling_strategy = "REPLICA"
}

resource "aws_ecs_service" "ECSService2" {
    name = "service2"
    cluster = "${aws_ecs_cluster.ECSCluster.arn}"
    load_balancer {
        target_group_arn = "${aws_lb_target_group.ElasticLoadBalancingV2TargetGroup2.id}"
        container_name = "service2"
        container_port = 9090
    }
    desired_count = 2
    launch_type = "FARGATE"
    platform_version = "LATEST"
    task_definition = "${aws_ecs_task_definition.ECSTaskDefinition.arn}"
    deployment_maximum_percent = 200
    deployment_minimum_healthy_percent = 100
    network_configuration {
        assign_public_ip = "false"
        security_groups = [
            "${aws_security_group.svc2-SecurityGroup.id}"
        ]
        subnets = [
            "${aws_subnet.Subnet2-Private.id}",
            "${aws_subnet.Subnet3-Private.id}"
        ]
    }
    health_check_grace_period_seconds = 5
    scheduling_strategy = "REPLICA"
}

resource "aws_ecs_task_definition" "ECSTaskDefinition" {
    container_definitions = "[{\"name\":\"service2\",\"image\":\"${aws_ecr_repository.ECRRepository-svc1.repository_url}:latest\",\"cpu\":0,\"memoryReservation\":512,\"portMappings\":[{\"containerPort\":9090,\"hostPort\":9090,\"protocol\":\"tcp\"}],\"essential\":true,\"environment\":[],\"mountPoints\":[],\"volumesFrom\":[],\"logConfiguration\":{\"logDriver\":\"awslogs\",\"options\":{\"awslogs-group\":\"/ecs/project_svc2\",\"awslogs-region\":\"ap-south-1\",\"awslogs-stream-prefix\":\"ecs\"}}}]"
    family = "project_svc2"
    task_role_arn = "${aws_iam_role.IAMRole.arn}"
    execution_role_arn = "${aws_iam_role.IAMRole.arn}"
    network_mode = "awsvpc"
    requires_compatibilities = [
        "FARGATE"
    ]
    cpu = "512"
    memory = "1024"
}

resource "aws_ecs_task_definition" "ECSTaskDefinition2" {
    container_definitions = "[{\"name\":\"service1\",\"image\":\"${aws_ecr_repository.ECRRepository-svc2.repository_url}:latest\",\"cpu\":0,\"memoryReservation\":512,\"portMappings\":[{\"containerPort\":8080,\"hostPort\":8080,\"protocol\":\"tcp\"}],\"essential\":true,\"environment\":[],\"mountPoints\":[],\"volumesFrom\":[],\"logConfiguration\":{\"logDriver\":\"awslogs\",\"options\":{\"awslogs-group\":\"/ecs/project_svc1\",\"awslogs-region\":\"ap-south-1\",\"awslogs-stream-prefix\":\"ecs\"}}}]"
    family = "project_svc1"
    task_role_arn = "${aws_iam_role.IAMRole.arn}"
    execution_role_arn = "${aws_iam_role.IAMRole.arn}"
    network_mode = "awsvpc"
    requires_compatibilities = [
        "FARGATE"
    ]
    cpu = "512"
    memory = "1024"
}
