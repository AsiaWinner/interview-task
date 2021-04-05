resource "aws_cloudwatch_metric_alarm" "cpu-high" {
  alarm_name          = "ec2-high-ec2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Maximum"
  threshold           = "50"
  alarm_description   = "This metric monitors for high cpu"
  alarm_actions = [
    aws_autoscaling_policy.scale-up.arn,
  ]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webservers.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu-low" {
  alarm_name          = "ec2-low-ec2"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Maximum"
  threshold           = "49"
  alarm_description   = "This metric monitors ec2 for low cpu"
  alarm_actions = [
    aws_autoscaling_policy.scale-down.arn,
  ]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webservers.name
  }
}
