resource "aws_appautoscaling_target" "ecs_target_svc1" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.ECSCluster.name}/${aws_ecs_service.ECSService.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs-target-policy1" {
  name               = "cpu-auto-scaling"
  service_namespace  = aws_appautoscaling_target.ecs_target_svc1.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_target_svc1.scalable_dimension
  resource_id        = aws_appautoscaling_target.ecs_target_svc1.resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 50
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
