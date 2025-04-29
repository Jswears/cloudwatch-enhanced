from utils import get_weather_data, push_cloudwatch_metrics


def lambda_handler(event, context):
    city_name = event.get('city', 'Hamburg')
    weather_data = get_weather_data(city_name)

    if weather_data:
        city = weather_data['city']
        temperature = weather_data['temperature']
        humidity_percent = weather_data['humidity_percent']
        description = weather_data['description']
        elapsed_time = weather_data['elapsed_time']

        push_cloudwatch_metrics(
            city, temperature, humidity_percent, elapsed_time)

        return {
            'statusCode': 200,
            'body': {
                'city': city,
                'temperature': temperature,
                'humidity_percent': humidity_percent,
                'description': description,
                'elapsed_time': elapsed_time
            }
        }
    else:
        return {
            'statusCode': 500,
            'body': {
                'error': 'Could not retrieve weather data'
            }
        }
