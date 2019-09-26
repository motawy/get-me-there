import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_me_there/models/weather_model.dart';
import 'package:get_me_there/services/weather.dart';
import 'package:get_me_there/utilities/constants.dart';

class WeatherCarousel extends StatefulWidget {
  final List<WeatherModel> weatherList;
  WeatherCarousel({this.weatherList});
  @override
  _WeatherCarouselState createState() => _WeatherCarouselState();
}

class _WeatherCarouselState extends State<WeatherCarousel> {
  var weatherService = WeatherService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 120.0,
        child: widget.weatherList.length == 0
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.black,
                  size: 30.0,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.weatherList.length,
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
                                widget.weatherList[index].weatherIcon,
                                style: kConditionTextStyle,
                              ),
                              Text(widget.weatherList[index].temperature
                                      .toStringAsFixed(0) +
                                  "°"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.weatherList[index].time.hour
                                  .toString()),
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
