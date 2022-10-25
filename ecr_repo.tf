resource "aws_ecr_repository" "ECRRepository-svc1" {
    name = "service2"
}

resource "aws_ecr_repository" "ECRRepository-svc2" {
    name = "service1"
}
