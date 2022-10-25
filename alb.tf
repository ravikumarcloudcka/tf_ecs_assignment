resource "aws_lb" "ElasticLoadBalancingV2LoadBalancer2" {
    name = "svc2-lb"
    internal = true
    load_balancer_type = "application"
    subnets = [
        "${aws_subnet.Subnet2-Private.id}",
        "${aws_subnet.Subnet3-Private.id}"
    ]
    security_groups = [
        "${aws_security_group.Lb-SecurityGroup.id}"
    ]
    ip_address_type = "ipv4"
    access_logs {
        enabled = false
        bucket = ""
        prefix = ""
    }
    idle_timeout = "60"
    enable_deletion_protection = "false"
    enable_http2 = "true"
}

resource "aws_lb" "ElasticLoadBalancingV2LoadBalancer1" {
    name = "svc1-lb"
    internal = true
    load_balancer_type = "application"
    subnets = [
        "${aws_subnet.Subnet2-Private.id}",
        "${aws_subnet.Subnet3-Private.id}"
    ]
    security_groups = [
        "${aws_security_group.Lb-SecurityGroup.id}"
    ]
    ip_address_type = "ipv4"
    access_logs {
        enabled = false
        bucket = ""
        prefix = ""
    }
    idle_timeout = "60"
    enable_deletion_protection = "false"
    enable_http2 = "true"
}

resource "aws_lb_listener" "ElasticLoadBalancingV2Listener" {
    load_balancer_arn = "${aws_lb.ElasticLoadBalancingV2LoadBalancer1.id}"
    port = 80
    protocol = "HTTP"
    default_action {
        target_group_arn = "${aws_lb_target_group.ElasticLoadBalancingV2TargetGroup.id}"
        type = "forward"
    }
}

resource "aws_lb_listener" "ElasticLoadBalancingV2Listener2" {
    load_balancer_arn = "${aws_lb.ElasticLoadBalancingV2LoadBalancer2.id}"
    port = 80
    protocol = "HTTP"
    default_action {
        target_group_arn = "${aws_lb_target_group.ElasticLoadBalancingV2TargetGroup2.id}"
        type = "forward"
    }
}

resource "aws_lb_target_group" "ElasticLoadBalancingV2TargetGroup" {
    health_check {
        interval = 30
        path = "/"
        port = "8080"
        protocol = "HTTP"
        timeout = 5
        unhealthy_threshold = 2
        healthy_threshold = 5
        matcher = "200"
    }
    port = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    name = "ecs-assign-service1"
}

resource "aws_lb_target_group" "ElasticLoadBalancingV2TargetGroup2" {
    health_check {
        interval = 30
        path = "/"
        port = "9090"
        protocol = "HTTP"
        timeout = 5
        unhealthy_threshold = 2
        healthy_threshold = 5
        matcher = "200"
    }
    port = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    name = "ecs-assign-service2"
}
