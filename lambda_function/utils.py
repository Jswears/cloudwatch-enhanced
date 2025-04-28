from dotenv import load_dotenv
import os
import requests

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
    