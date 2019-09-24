import 'package:flutter/material.dart';
import 'package:get_me_there/models/user_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get_me_there/services/weather.dart';
import 'package:get_me_there/weather_carousel.dart';
import 'package:get_me_there/utilities/constants.dart';
import 'package:get_me_there/services/location_service.dart';

class HomePage extends StatefulWidget {
  final locationWeather;

  HomePage({this.locationWeather});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  double currentLat;
  double currentLon;
  WeatherModel weatherModel = WeatherModel();
  bool _showValidationError = false;

  GoogleMapController googleMapController;
  GoogleMap mapRef;

  String searchAddress;

  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  static UserLocation _currentLocation;
  LatLng _lastPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    _setInitialPosition();
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to fetch data';
        cityName = 'this moment.';
        return;
      }
      temperature = (weatherData['main']['temp']).toInt();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      currentLat = weatherData['coord']['lat'];
      currentLon = weatherData['coord']['lon'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          cityName,
                          style: kCityNameTextStyle,
                        ),
                      ),
                    ],
                  ),
                  Container(color: kShrinePink, child: WeatherCarousel()),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Center(
                child: _currentLocation == null
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : GoogleMap(
                        myLocationButtonEnabled: true,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(_currentLocation.latitude,
                                _currentLocation.longitude),
                            zoom: 15.0),
                        onMapCreated: onMapCreated,
                        myLocationEnabled: true,
                      ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 30.0,
                    right: 24.0,
                    left: 24.0,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kShrineBackgroundWhite,
                      ),
                      child: Column(
                        children: <Widget>[
                          _buildTextField(
                              "Enter destination", destinationController),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            child: Text('GET ME THERE'),
                            onPressed: () {
                              print("GET ME THERE");
                            },
                            elevation: 8.0,
                            shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      googleMapController = controller;
    });
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: kShrineBrown),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body2,
        decoration: InputDecoration(
          labelText: label,
          errorText: _showValidationError ? "Invalid address" : null,
        ),
      ),
    );
  }

  void _setInitialPosition() async {
    var userLocation = LocationService();
    _currentLocation = await userLocation.getCurrentLocation();
    //locationController.text = userLocation.placeMark[0].name;

    Location location = Location();
    location.onLocationChanged().listen((LocationData currentLocation) {
      _currentLocation.latitude = currentLocation.latitude;
      _currentLocation.longitude = currentLocation.longitude;
    });
  }
}
