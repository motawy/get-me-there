import 'package:flutter/material.dart';
import 'package:get_me_there/models/weather_model.dart';

import 'networking.dart';
import 'location_service.dart';

const ipAddress = "118.138.10.31";
const locationWeatherURL =
    'https://$ipAddress:3000/api/weather/updateCondition';
const hourlyWeatherURL = 'https://$ipAddress:3000/api/weather/hourlyCondition';

class WeatherService {
  Future<dynamic> getLocationWeather() async {
    var userLocation = await LocationService().getCurrentLocation();

    Map body = {"lat": userLocation.latitude, "lon": userLocation.longitude};
    NetWorkHelper netWorkHelper = NetWorkHelper(locationWeatherURL, body);
    var currentWeatherData;
    try {
      currentWeatherData = await netWorkHelper.getData();
    } catch (e) {
      print("Error caught: " + e.toString());
    }
    return currentWeatherData;
  }

  dynamic getHourlyWeather() async {
    var userLocation = await LocationService().getCurrentLocation();
    Map body = {"lat": userLocation.latitude, "lon": userLocation.longitude};
    NetWorkHelper netWorkHelper = NetWorkHelper(hourlyWeatherURL, body);
    var hourlyWeatherData;
    List<WeatherModel> weatherList = List<WeatherModel>();
    try {
      hourlyWeatherData = await netWorkHelper.getData();
      int count = 0;
      WeatherService weatherService = WeatherService();

      for (var item in hourlyWeatherData["list"]) {
        WeatherModel weather = WeatherModel();
        weather.temperature = item['main']['temp'].toDouble();
        weather.time = TimeOfDay.fromDateTime(DateTime.parse(item['dt_txt']));
        weather.weatherIcon =
            weatherService.getWeatherIcon(item['weather'][0]['id']);
        weatherList.add(weather);
        count++;
        if (count == 10) break;
      }
    } catch (e) {
      print("Error caught: " + e.toString());
    }
    return weatherList;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
