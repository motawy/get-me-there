import 'package:flutter/material.dart';
import 'package:get_me_there/services/weather.dart';
import 'package:get_me_there/utilities/constants.dart';

class WeatherCarousel extends StatefulWidget {
  @override
  _WeatherCarouselState createState() => _WeatherCarouselState();
}

class _WeatherCarouselState extends State<WeatherCarousel> {
  List<Weather> weatherList = List<Weather>();

  @override
  void initState() {
    getHourlyWeather();
    super.initState();
  }

  void getHourlyWeather() async {
    dynamic weatherJSON = await WeatherModel().getHourlyWeather();
    int count = 0;
    for (var item in weatherJSON["list"]) {
      Weather weather = Weather();
      weather.temperature = item['main']['temp'].toDouble();
      weather.time = TimeOfDay.fromDateTime(DateTime.parse(item['dt_txt']));
      weather.weatherIcon =
          WeatherModel().getWeatherIcon(item['weather'][0]['id']);
      weatherList.add(weather);
      count++;
      if (count == 10) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 120.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 100.0,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Card(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          weatherList[index].weatherIcon,
                          style: kConditionTextStyle,
                        ),
                        Text(weatherList[index].temperature.toStringAsFixed(0) +
                            "°"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(weatherList[index].time.hour.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
