from dotenv import load_dotenv
import os
import requests
import boto3

def get_weather_data(city):
    load_dotenv()
    api_key = os.getenv('WEATHER_API_KEY')
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        'q': city,
        'appid': api_key,
        'units': 'metric'
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        data = response.json()
        
        weather = {
            'city': data['name'],
            'temperature': data['main']['temp'],
            'humidity_percent': data['main']['humidity'],
            'description': data['weather'][0]['description'],
            'elapsed_time': response.elapsed.total_seconds() * 1000,
        }
        return weather
    else:
        return None
    
# Function to push metrics to CloudWatch
def push_cloudwatch_metrics(city, temperature_celsius, humidity_percent, elapsed_time):
    cloudwatch = boto3.client('cloudwatch')
    
    # Push custom metrics to CloudWatch
    cloudwatch.put_metric_data(
        Namespace='WeatherMetrics',
        MetricData=[
            {
                'MetricName': 'Temperature',
                'Dimensions': [
                    {
                        'Name': 'City',
                        'Value': city
                    },
                ],
                'Value': temperature_celsius,
                'Unit': 'None'
            },
            {
                'MetricName': 'Humidity',
                'Dimensions': [
                    {
                        'Name': 'City',
                        'Value': city
                    },
                ],
                'Value': humidity_percent,
                'Unit': 'None'
            },
            {
                'MetricName': 'APIResponseTime',
                'Dimensions': [{'Name': 'City', 'Value': city}],
                'Unit': 'Milliseconds',
                'Value': elapsed_time
            }
        ]
    )
    print(f"Metrics pushed to CloudWatch for {city}: Temperature={temperature_celsius}, Humidity={humidity_percent}")    