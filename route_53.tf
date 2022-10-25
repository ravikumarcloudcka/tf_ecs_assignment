resource "aws_route53_zone" "Route53HostedZone" {
    name = "zoominfo.test"
    vpc {
    	vpc_id = "${aws_vpc.ZIVPC.id}"
    }
    lifecycle {
    	ignore_changes = [vpc]
    }
}

resource "aws_route53_record" "Route53RecordSet3" {
    name = "service2.zoominfo.test."
    type = "CNAME"
    ttl = 300
    records = [
        "${aws_lb.ElasticLoadBalancingV2LoadBalancer2.dns_name}"
    ]
    zone_id = "${aws_route53_zone.Route53HostedZone.zone_id}"
}
