# CloudWatch Enhanced Weather Metrics

This project collects weather data for a specified city using the OpenWeatherMap API and pushes custom metrics (temperature, humidity, API response time) to AWS CloudWatch. It also sets up CloudWatch alarms and sends notifications via SNS when certain thresholds are exceeded.

# Table of Contents

- [CloudWatch Enhanced Weather Metrics](#cloudwatch-enhanced-weather-metrics)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Architecture Diagram](#architecture-diagram)
  - [Features](#features)
  - [Project Structure](#project-structure)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [Requirements](#requirements)
  - [License](#license)

## Prerequisites

- AWS account with permissions for Lambda, CloudWatch, SNS, and IAM
- OpenWeatherMap API key (sign up for free at [OpenWeatherMap](https://openweathermap.org/api))
- Terraform >= 1.0
- Python 3.13 for Lambda runtime
- AWS CLI configured with your credentials

## Architecture Diagram

![Architecture Diagram](architecture_diagram.png)

## Features

- AWS Lambda function (Python) to fetch weather data and push metrics
- CloudWatch custom metrics: Temperature, Humidity, API Response Time
- CloudWatch alarm for high temperature in Hamburg
- SNS email notifications for alerts
- Infrastructure as Code with Terraform
- EventBridge rule to trigger Lambda function every 15 minutes
- The temperature threshold is set to 10 degrees Celsius for demonstration purposes. You can change it in the `terraform/variables.tf` file.

## Project Structure

- `lambda_function/` - Lambda source code and requirements
- `terraform/` - Terraform scripts for AWS resources

## Setup

1. **Clone the repository**
2. **Set up environment variables**

   - Create a `.env` file with your OpenWeatherMap API key if want to test locally:
   - Remove line 4 from `lambda_function/utils.py`
   - Uncomment line 5-6 from `lambda_function/utils.py`

   ```
   WEATHER_API_KEY=your_api_key_here
   ```

3. **Install dependencies**
   - For Lambda: see `lambda_function/requirements.txt`
   - For local testing: create a virtual environment and install dependencies:
     ```sh
     python3 -m venv venv
     source venv/bin/activate
     pip install -r lambda_function/requirements.txt
     ```
4. **Deploy Lambda Function**

   - Package and upload the Lambda function code as and the modules in `lambda_function.zip`
   - Create a zip file of the Lambda function code:
     ```sh
       mkdir package
       cd package
       pip install -r ../lambda_function/requirements.txt -t .
       cp ../lambda_function/*.py .
       zip -r ../lambda_function.zip .
       cd ..
       rm -rf package
     ```
   - The lambda function will be deployed using Terraform, so you don't need to upload the zip file manually.

5. **Deploy Infrastructure**
   - Initialize and apply Terraform in the `terraform/` directory:
     ```sh
     terraform init
     terraform apply
     ```
   - (Optional) You can use `terraform fmt` to format the Terraform files.
   - (Optional) You can use `terraform validate` to validate the Terraform files.
   - (Optional) You can use `terraform plan` to see the changes that will be applied.
     -You can use `terraform destroy` to remove all resources created by Terraform.

## Usage

- The Lambda function is triggered every 15 minutes by EventBridge.
- Weather metrics for Hamburg are pushed to CloudWatch.
- If the temperature exceeds the configured threshold, an SNS email alert is sent.

## Configuration

- Change the city or thresholds in the Lambda code or Terraform files as needed. in the `lambda_function/main.py` file, change city_name to the desired city.
- Update the email address for alerts in `terraform/variables.tf`.

## Requirements

- AWS account with permissions for Lambda, CloudWatch, SNS, and IAM
- Terraform >= 1.0
- Python 3.13 for Lambda runtime

## License

MIT License
