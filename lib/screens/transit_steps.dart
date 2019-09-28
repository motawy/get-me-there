import 'package:flutter/material.dart';
import 'package:get_me_there/models/transit_model.dart';
import 'package:get_me_there/models/user_location.dart';
import 'package:get_me_there/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TransitSteps extends StatefulWidget {
  final UserLocation position;
  final List<Sec> sections;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  TransitSteps({this.position, this.sections, this.markers, this.polylines});

  @override
  _TransitStepsState createState() => _TransitStepsState();
}

class _TransitStepsState extends State<TransitSteps> {
  GoogleMapController _controller;
  List<Sec> sec = List<Sec>();
  LatLng stepPosition;
  bool isTransport = false;

  @override
  void initState() {
    stepPosition = LatLng(widget.position.latitude, widget.position.longitude);
    for (Sec s in widget.sections) {
      sec.add(s);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGMTlight,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Transit steps"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            markers: widget.markers == null
                ? null
                : Set<Marker>.of(widget.markers.values),
            polylines: widget.polylines == null
                ? null
                : Set<Polyline>.of(widget.polylines.values),
            initialCameraPosition:
                CameraPosition(target: stepPosition, zoom: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                sec[index].mode == 20
                    ? isTransport = false
                    : isTransport = true;
                return isTransport
                    ? FractionallySizedBox(
                        heightFactor: 0.3,
                        widthFactor: 0.9,
                        alignment: Alignment.topCenter,
                        child: Card(
                          color: kGMTprimaryLight,
                          shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            _convertModeOfTransport(
                                                sec[index].mode),
                                            Card(
                                              color: kGMTprimary,
                                              child: Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Text(
                                                  sec[index].dep.transport.name,
                                                  style: TextStyle(
                                                      color: kGMTlight,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(sec[index]
                                                .journey
                                                .stop
                                                .length
                                                .toString() +
                                            " stops")
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "From",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      _cutStopName(sec[index].dep.stn.name),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "To",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      _cutStopName(sec[index].arr.stn.name),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(sec[index]
                                              .journey
                                              .distance
                                              .toString() +
                                          " M"),
                                      Text(
                                        _parseCustomDuration(
                                                    sec[index].journey.duration)
                                                .toString() +
                                            " min",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : FractionallySizedBox(
                        heightFactor: 0.3,
                        widthFactor: 0.9,
                        alignment: Alignment.topCenter,
                        child: Card(
                          color: kGMTprimaryLight,
                          shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    _convertModeOfTransport(sec[index].mode),
                                    Card(
                                      color: kGMTprimary,
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          "Walk your ass",
                                          style: TextStyle(
                                              color: kGMTlight,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "To",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      _cutStopName(sec[index].arr.stn.name),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              },
              scrollDirection: Axis.horizontal,
              loop: false,
              itemCount: sec.length,
              index: 0,
              onIndexChanged: (int index) {
                index++;
              },
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController ctrl) {
    _controller = ctrl;
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

  String _cutStopName(String stop) {
    var stopName = stop.split("(");
    return stopName[0];
  }
}