resource "aws_internet_gateway" "VPCInternetGateway" {
    tags = { "name" = "zoominfo-ig" }
    vpc_id = "${aws_vpc.ZIVPC.id}"
}
