resource "aws_cloudwatch_metric_alarm" "high_temperature_alarm" {
  alarm_name          = "${var.lambda_function_name}-high-temperature-alarm"
  alarm_description   = "Alarm when Hamburg temperature exceeds 10°C"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Temperature"
  namespace           = "WeatherMetrics"
  period              = 900
  statistic           = "Average"
  threshold           = var.temperature_threshold
  dimensions = {
    "City" = "Hamburg"
  }
  alarm_actions = [aws_sns_topic.weather_alerts.arn]
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}