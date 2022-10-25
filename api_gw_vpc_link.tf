resource "aws_apigatewayv2_vpc_link" "ApiGatewayV2VpcLink" {
    name = "access_to_lb_from_api_gw"
    security_group_ids = [
        "${aws_security_group.Lb-SecurityGroup.id}"
    ]
    subnet_ids = [
        "${aws_subnet.Subnet2-Private.id}",
        "${aws_subnet.Subnet3-Private.id}"
    ]
}

resource "aws_apigatewayv2_api" "ApiGatewayV2Api" {
    name          = "zoominfo_api"
    api_key_selection_expression = "$request.header.x-api-key"
    protocol_type = "HTTP"
    route_selection_expression = "$request.method $request.path"
}

resource "aws_apigatewayv2_stage" "ApiGatewayV2Stage" {
    name = "$default"
    api_id = "${aws_apigatewayv2_api.ApiGatewayV2Api.id}"
    default_route_settings {
        detailed_metrics_enabled = false
        throttling_burst_limit = 5000
        throttling_rate_limit = 150000
    }
    auto_deploy = true
}

resource "aws_apigatewayv2_route" "ApiGatewayV2Route" {
    api_id = "${aws_apigatewayv2_api.ApiGatewayV2Api.id}"
    api_key_required = false
    authorization_type = "NONE"
    route_key = "GET /"
    target = "integrations/${aws_apigatewayv2_integration.ApiGatewayV2Integration.id}"
}

resource "aws_apigatewayv2_integration" "ApiGatewayV2Integration" {
    api_id = "${aws_apigatewayv2_api.ApiGatewayV2Api.id}"
    connection_type = "VPC_LINK"
    connection_id      = "${aws_apigatewayv2_vpc_link.ApiGatewayV2VpcLink.id}"
    integration_method = "ANY"
    integration_type = "HTTP_PROXY"
    integration_uri = "${aws_lb_listener.ElasticLoadBalancingV2Listener.arn}"
    timeout_milliseconds = 30000
    payload_format_version = "1.0"
}
