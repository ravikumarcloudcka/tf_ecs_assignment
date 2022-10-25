resource "aws_subnet" "Subnet1-Public" {
    availability_zone = "ap-south-1a"
    cidr_block = "172.20.0.0/25"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "Subnet2-Private" {
    availability_zone = "ap-south-1b"
    cidr_block = "172.20.4.128/25"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "Subnet3-Private" {
    availability_zone = "ap-south-1a"
    cidr_block = "172.20.4.0/25"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "Subnet4-Public" {
    availability_zone = "ap-south-1b"
    cidr_block = "172.20.0.128/25"
    vpc_id = "${aws_vpc.ZIVPC.id}"
    map_public_ip_on_launch = false
}
