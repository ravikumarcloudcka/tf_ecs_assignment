resource "aws_nat_gateway" "VPCNatGateway" {
    subnet_id = "${aws_subnet.Subnet1-Public.id}"
    tags = { "name" = "nat-gw" }
    allocation_id = "${aws_eip.NATGWEIP.id}"
}
