variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "cloudwatch-enhanced-function"
}

variable "lambda_handler" {
  description = "The handler for the Lambda function"
  type        = string
  default     = "main.lambda_handler"
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "python3.13"
}

variable "lambda_memory_size" {
  description = "The memory size for the Lambda function"
  type        = number
  default     = 128
}
variable "lambda_timeout" {
  description = "The timeout for the Lambda function"
  type        = number
  default     = 30
}
variable "email_address" {
  description = "The email address to receive alerts"
  type        = string
  default     = "ji.swearssalinas@gmail.com"
}
variable "environment" {
  description = "The environment for the Lambda function"
  type        = string
  default     = "dev"
}
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "weather-alerts"
}
variable "temperature_threshold" {
  description = "The temperature threshold for the alarm"
  type        = number
  default     = 10
}
variable "aws_region" {
  description = "The AWS region to deploy the Lambda function"
  type        = string
  default     = "eu-central-1"
}