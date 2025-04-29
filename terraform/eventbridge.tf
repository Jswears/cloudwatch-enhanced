resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "${var.lambda_function_name}-schedule"
  description         = "Scheduled rule to trigger Lambda function"
  schedule_expression = "rate(15 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "${var.lambda_function_name}-target"
  arn       = aws_lambda_function.cloudwatch_enhanced.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "${var.lambda_function_name}-allow-eventbridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudwatch_enhanced.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
  depends_on    = [aws_cloudwatch_event_target.lambda_target]
}
    