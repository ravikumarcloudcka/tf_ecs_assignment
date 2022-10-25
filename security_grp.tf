resource "aws_security_group" "svc2-SecurityGroup" {
    name = "servic2-sg"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 9090
        protocol = "tcp"
        to_port = 9090
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "svc1-SecurityGroup" {
    name = "servic1-sg"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 8080
        protocol = "tcp"
        to_port = 8080
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}
resource "aws_security_group" "Lb-SecurityGroup" {
    name = "loadbalancer-sg"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}
