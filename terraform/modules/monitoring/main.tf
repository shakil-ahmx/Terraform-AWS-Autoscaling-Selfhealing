resource "aws_sns_topic" "alerts" {
  name         = "${var.name}-cpu"
  display_name = "${var.name}-cpu"
  tags         = var.tags
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.name}-cpu-high"
  alarm_description   = "Average ASG CPU >= ${var.cpu_high_threshold}% - scale up and notify"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_high_threshold
  alarm_actions       = [var.scale_up_policy_arn, aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count = var.enable_scale_down ? 1 : 0

  alarm_name          = "${var.name}-cpu-low"
  alarm_description   = "Average ASG CPU <= ${var.cpu_low_threshold}% for 5 min - scale down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_low_threshold
  alarm_actions       = [var.scale_down_policy_arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  tags = var.tags
}
