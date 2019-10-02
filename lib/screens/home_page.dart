import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get_me_there/models/transit_model.dart';
import 'package:get_me_there/models/user_location.dart';
import 'package:get_me_there/screens/transit_steps.dart';
import 'package:get_me_there/services/transit_service.dart';
import 'package:get_me_there/widget/fancy_button.dart';
import 'package:get_me_there/widget/top_part.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;
import 'package:get_me_there/services/weather.dart';
import 'package:get_me_there/widget/weather_carousel.dart';
import 'package:get_me_there/utilities/constants.dart';
import 'package:get_me_there/services/location_service.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  final locationWeather;
  final hourlyWeather;
  HomePage({this.locationWeather, this.hourlyWeather});

  @override
  _HomePageState createState() => _HomePageState();
}

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class _HomePageState extends State<HomePage> {
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  double currentLat;
  double currentLon;
  WeatherService weatherService = WeatherService();
  bool _showValidationError = false;
  bool _isOptionSelected = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  List<LatLng> polylineCoordinates = [];
  GoogleMapController googleMapController;
  Uuid uuid = Uuid();
  String searchAddress;
  List<Connection> transitConnections = List<Connection>();
  List<Sec> _selectedSection = List<Sec>();
  TransitService transitService = TransitService();

  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  UserLocation _currentLocation;
  LatLng _destinationCoord;
  int flexTop = 2;
  int flexMap = 4;
  int flexBottom = 2;

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
      weatherIcon = weatherService.getWeatherIcon(condition);
      weatherMessage = weatherService.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.height < 800) {
      flexTop = 2;
      flexMap = 3;
      flexBottom = 1;
    } else {
      flexTop = 2;
      flexMap = 4;
      flexBottom = 2;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            TopPart(),
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: flexTop,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: WeatherCarousel(
                              weatherList: widget.hourlyWeather,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: flexMap,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          FractionallySizedBox(
                            alignment: Alignment.topCenter,
                            heightFactor: 0.8,
                            child: _currentLocation == null
                                ? Container(
                                    alignment: Alignment.center,
                                    child: SpinKitRipple(
                                      color: kGMTprimary,
                                      size: 60,
                                    ),
                                  )
                                : GoogleMap(
                                    myLocationButtonEnabled: true,
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            _currentLocation.latitude,
                                            _currentLocation.longitude),
                                        zoom: 14.0),
                                    onMapCreated: onMapCreated,
                                    compassEnabled: true,
                                    scrollGesturesEnabled: true,
                                    zoomGesturesEnabled: true,
                                    myLocationEnabled: true,
                                    markers: markers == null
                                        ? null
                                        : Set<Marker>.of(markers.values),
                                    polylines: polylines == null
                                        ? null
                                        : Set<Polyline>.of(polylines.values),
                                  ),
                          ),
                          _isOptionSelected
                              ? Positioned(
                                  bottom: 90,
                                  left: 10,
                                  child: FancyButton(
                                    label: "Go",
                                    icon: Icon(
                                      Icons.directions,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // Go to details page!
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return TransitSteps(
                                              position: _currentLocation,
                                              sections: _selectedSection,
                                              markers: markers,
                                              polylines: polylines,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : SizedBox(),
                          FractionallySizedBox(
                            heightFactor: 1 - 0.8,
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: _buildTextField(
                                  "Enter destination", destinationController),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: flexBottom,
                      child: transitConnections.length == 0
                          ? SizedBox(
                              child: Text("Results will be displayed here.."))
                          : ListView.builder(
                              itemCount: transitConnections.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 100.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: kGMTwhite,
                                      onPressed: () {
                                        _isOptionSelected = true;
                                        _selectedSection =
                                            transitConnections[index]
                                                .sections
                                                .sec;
                                        _onOptionPressed(_selectedSection);
                                      },
                                      elevation: 4,
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: kGMTprimary,
                                          width: 4.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 300,
                                            height: 60,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  transitConnections[index]
                                                      .sections
                                                      .sec
                                                      .length,
                                              itemBuilder: (context, i) {
                                                return SizedBox(
                                                  width: 30,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      _convertModeOfTransport(
                                                        transitConnections[
                                                                index]
                                                            .sections
                                                            .sec[i]
                                                            .mode,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          _parseCustomDuration(
                                                                  transitConnections[
                                                                          index]
                                                                      .sections
                                                                      .sec[i]
                                                                      .journey
                                                                      .duration)
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      Text(
                                                        "min",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                _parseCustomDuration(
                                                        transitConnections[
                                                                index]
                                                            .duration)
                                                    .toString(),
                                                style: kButtonTextStyle,
                                              ),
                                              Text("min")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body2,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(width: 4),
          ),
          labelText: label,
          errorText: _showValidationError ? "Invalid address" : null,
          contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        onTap: () async {
          // show input autocomplete with selected mode
          // then get the Prediction selected
          Prediction p = await PlacesAutocomplete.show(
              context: context, apiKey: kGoogleApiKey);
          displayPrediction(p);
        },
      ),
    );
  }

  _setInitialPosition() async {
    _currentLocation = await LocationService().getCurrentLocation();
    setState(() {});
//    var location = loc.Location();
//    location.onLocationChanged().listen((loc.LocationData currentLocation) {
//      _currentLocation.latitude = currentLocation.latitude;
//      _currentLocation.longitude = currentLocation.longitude;
//    });
  }

  Future<List<Address>> displayPrediction(Prediction p) async {
    transitConnections = new List<Connection>();
    markers = {};
    polylines = {};
    _isOptionSelected = false;
    destinationController.text = "";
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      //var placeId = p.placeId;

      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      searchAddress = p.description;
      _destinationCoord = LatLng(lat, lng);
      // Write address on the controller
      destinationController.text = searchAddress;
      // Move map towards the address
      _addMarkerToAddress(searchAddress);
      _moveMapToAddress(_destinationCoord, 15);
      // Show the options
      var transitData = await transitService.getTransitInfo(
          _currentLocation.latitude,
          _currentLocation.longitude,
          _destinationCoord.latitude,
          _destinationCoord.longitude);
      // Show different time for the selected option
      _decodeTransitData(transitData);
      setState(() {});
      return await Geocoder.local.findAddressesFromQuery(p.description);
    }
    return null;
  }

  _moveMapToAddress(LatLng point, double zoom) {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: zoom),
      ),
    );
  }

  _addMarkerToAddress(String address) {
    var markerIdVal = uuid.v4();
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: _destinationCoord,
      infoWindow: InfoWindow(title: address, snippet: '*'),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  _decodeTransitData(var transitData) {
    // Grab the part needed from result
    TransitModel transitModel = TransitModel.fromJson(transitData);
    Res res = transitModel.res;
    for (Connection conn in res.connections.connection) {
      // Grab all connections for the trip
      transitConnections.add(conn);
    }
  }

  int _parseCustomDuration(String duration) {
    int finalD = 0;
    if (duration.startsWith("PT")) {
      duration = duration.substring(2);
    }
    if (duration.contains("H")) {
      if (duration.endsWith("M")) {
        duration = duration.substring(0, duration.length - 1);
        var d1 = duration.split("H");
        finalD += int.parse(d1[0]) * 60 + int.parse(d1[1]);
      }

      if (duration.endsWith("S")) {
        duration = duration.substring(0, duration.length - 1);
        var d1 = duration.split("H");
        finalD += int.parse(d1[0]) * 60;
        var d2 = d1[1].split("M");
        finalD += int.parse(d2[0]);
      }
    } else if (duration.contains("M")) {
      if (duration.endsWith("S")) {
        duration = duration.substring(0, duration.length - 1);
        var d = duration.split("M");
        finalD += int.parse(d[0]);
      } else {
        duration = duration.substring(0, duration.length - 1);
        finalD += int.parse(duration);
      }
    }
    return finalD;
  }

  Icon _convertModeOfTransport(int mode) {
    double size = 30;
    switch (mode) {
      case 0:
      case 2:
      case 3:
      case 4:
        return Icon(
          Icons.directions_subway,
          size: size,
          color: Colors.blueAccent,
        );
      case 5:
        return Icon(
          Icons.directions_bus,
          size: size,
          color: Colors.deepOrangeAccent,
        );
      case 6:
        return Icon(
          Icons.directions_boat,
          size: size,
          color: Colors.teal,
        );
      case 7:
        return Icon(
          Icons.directions_subway,
          size: size,
          color: Colors.blueAccent,
        );
      case 8:
        return Icon(
          Icons.directions_railway,
          size: size,
          color: Colors.lightGreen,
        );
      case 20:
        return Icon(
          Icons.directions_walk,
          size: size,
          color: Colors.black54,
        );
      default:
        return null;
    }
  }

  _addPolyLine() {
    var polyIdVal = uuid.v4();
    PolylineId id = PolylineId(polyIdVal);
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blueAccent, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _onOptionPressed(values) {
    polylines = {};
    polylineCoordinates = new List<LatLng>();
    for (Sec sec in values) {
      Dep dep = sec.dep;
      Arr arr = sec.arr;
      // Grab departure coordinates
      if (dep.stn == null) {
        polylineCoordinates.add(LatLng(dep.addr.y, dep.addr.x));
      } else if (dep.addr == null) {
        polylineCoordinates.add(LatLng(dep.stn.y, dep.stn.x));
      }

      // Grab all stops in not walking
      if (sec.journey.stop != null) {
        print("GRABBING STOPS");
        for (Stop stop in sec.journey.stop) {
          polylineCoordinates.add(LatLng(stop.stn.y, stop.stn.x));
        }
      }

      // Grab departure coordinates
      if (arr.stn == null) {
        polylineCoordinates.add(LatLng(arr.addr.y, arr.addr.x));
      } else if (arr.addr == null) {
        polylineCoordinates.add(LatLng(arr.stn.y, arr.stn.x));
      }
    }
    _animateCameraToShowTransit();
    _addPolyLine();
  }

  _animateCameraToShowTransit() {
    googleMapController.animateCamera(
      CameraUpdate.zoomTo(13.0),
    );
  }
}
