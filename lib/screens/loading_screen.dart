import 'package:get_me_there/models/user_location.dart';
import 'package:get_me_there/services/location_service.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import '../services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    dynamic weatherData = await WeatherService().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white30,
          size: 100.0,
        ),
      ),
    );
  }
}
