resource "aws_vpc" "ZIVPC" {
    cidr_block = "172.20.0.0/21"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = { "name" = "zoominfoi-vpc" }
}
