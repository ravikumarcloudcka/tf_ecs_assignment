resource "aws_route_table" "RouteTable-Public" {
    vpc_id = "${aws_vpc.ZIVPC.id}"
    tags = { "name" = "zoominfo-route-table" }
}

resource "aws_route_table" "RouteTable-Private" {
    vpc_id = "${aws_vpc.ZIVPC.id}"
    tags = { "name" = "zoominfo-route-table" }
}

resource "aws_route" "Route1-private" {
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.VPCNatGateway.id}"
    route_table_id = "${aws_route_table.RouteTable-Private.id}"
}

resource "aws_route" "Route2-public" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.VPCInternetGateway.id}"
    route_table_id = "${aws_route_table.RouteTable-Public.id}"
}

resource "aws_route_table_association" "SubnetRouteTableAssociation-Public1" {
    route_table_id = "${aws_route_table.RouteTable-Public.id}"
    subnet_id = "${aws_subnet.Subnet1-Public.id}"
}

resource "aws_route_table_association" "SubnetRouteTableAssociation-Public2" {
    route_table_id = "${aws_route_table.RouteTable-Public.id}"
    subnet_id = "${aws_subnet.Subnet4-Public.id}"
}

resource "aws_route_table_association" "SubnetRouteTableAssociation-Private1" {
    route_table_id = "${aws_route_table.RouteTable-Private.id}"
    subnet_id = "${aws_subnet.Subnet2-Private.id}"
}

resource "aws_route_table_association" "SubnetRouteTableAssociation-Private2" {
    route_table_id = "${aws_route_table.RouteTable-Private.id}"
    subnet_id = "${aws_subnet.Subnet3-Private.id}"
}
