resource "aws_sns_topic" "weather_alerts" {
  name = "weather-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.weather_alerts.arn
  protocol  = "email"
  endpoint  = var.email_address
}