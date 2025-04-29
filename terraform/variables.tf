variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default = "cloudwatch-enhanced-function"
}

variable "lambda_handler" {
  description = "The handler for the Lambda function"
  type        = string
  default = "main.lambda_handler"
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default = "python3.13"
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