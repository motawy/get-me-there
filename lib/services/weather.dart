import 'networking.dart';
import 'location_service.dart';

const locationWeatherURL = 'https://0.0.0.0:3000/api/weather/updateCondition';
const hourlyWeatherURL = 'https://0.0.0.0:3000/api/weather/hourlyCondition';

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

  Future<dynamic> getHourlyWeather() async {
    var userLocation = await LocationService().getCurrentLocation();
    Map body = {"lat": userLocation.latitude, "lon": userLocation.longitude};
    NetWorkHelper netWorkHelper = NetWorkHelper(hourlyWeatherURL, body);
    var hourlyWeatherData;
    try {
      hourlyWeatherData = await netWorkHelper.getData();
    } catch (e) {
      print("Error caught: " + e.toString());
    }
    return hourlyWeatherData;
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
