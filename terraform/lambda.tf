resource "aws_lambda_function" "cloudwatch_enhanced" {
  filename         = "${path.module}/../lambda_function.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  memory_size      = var.lambda_memory_size
  timeout          = var.lambda_timeout
  source_code_hash = filebase64sha256("${path.module}/../lambda_function.zip")

  environment {
    variables = {
      WEATHER_API_KEY = data.aws_ssm_parameter.weather_api_key.value
    }
  }
}

data "aws_ssm_parameter" "weather_api_key" {
  name            = "/cloudwatch-enhanced/weather_api_key"
  with_decryption = true
}