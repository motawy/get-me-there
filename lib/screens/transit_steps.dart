import 'package:flutter/material.dart';
import 'package:get_me_there/models/transit_model.dart';
import 'package:get_me_there/models/user_location.dart';
import 'package:get_me_there/utilities/constants.dart';
import 'package:get_me_there/widget/fancy_button.dart';
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
  bool isTransitOver = false;

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
    setState(() {});
    return Scaffold(
      backgroundColor: kGMTlight,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Transit steps",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            myLocationButtonEnabled: false,
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
                        heightFactor: 0.4,
                        widthFactor: 0.9,
                        alignment: Alignment.topCenter,
                        child: Card(
                          color: Colors.white,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(width: 4, color: kGMTprimary),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _convertModeOfTransport(sec[index].mode),
                                    Card(
                                      color: kGMTprimary,
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          sec[index].dep.transport.name,
                                          style: TextStyle(
                                              color: kGMTlight,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.pin_drop,
                                      color: Colors.deepOrange,
                                      size: 28,
                                    ),
                                    Text(_convertDistance(
                                        sec[index].journey.distance)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.timer,
                                      color: kGMTprimaryLight,
                                      size: 28,
                                    ),
                                    Text(
                                      _parseCustomDuration(
                                                  sec[index].journey.duration)
                                              .toString() +
                                          " min",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        height: 16,
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
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Stops",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            "Frequency",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            sec[index]
                                                .journey
                                                .stop
                                                .length
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            sec[index].dep.freq == null
                                                ? "Data not available"
                                                : sec[index]
                                                    .dep
                                                    .freq
                                                    .max
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : FractionallySizedBox(
                        heightFactor: 0.26,
                        widthFactor: 0.9,
                        alignment: Alignment.topCenter,
                        child: Card(
                          color: Colors.white,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(width: 4, color: kGMTprimary),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _convertModeOfTransport(sec[index].mode),
                                    Card(
                                      color: kGMTprimary,
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          "Walk",
                                          style: TextStyle(
                                              color: kGMTlight,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.pin_drop,
                                      color: Colors.deepOrange,
                                      size: 28,
                                    ),
                                    Text(
                                      _convertDistance(
                                          sec[index].journey.distance),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.timer,
                                      color: kGMTprimaryLight,
                                      size: 28,
                                    ),
                                    Text(
                                      _parseCustomDuration(
                                                  sec[index].journey.duration)
                                              .toString() +
                                          " min",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "To",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              index == sec.length - 1
                                                  ? Text(
                                                      "Destination",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      _cutStopName(sec[index]
                                                          .arr
                                                          .stn
                                                          .name),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: isTransitOver
                                      ? FancyButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          label: "Done",
                                          icon: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ),
                                        )
                                      : SizedBox(),
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
                if (index == 0) {
                  isTransitOver = false;
                  stepPosition =
                      LatLng(sec[index].dep.addr.y, sec[index].dep.addr.x);
                } else if (index == sec.length - 1) {
                  isTransitOver = true;
                  stepPosition =
                      LatLng(sec[index].dep.stn.y, sec[index].dep.stn.x);
                } else {
                  isTransitOver = false;
                  stepPosition =
                      LatLng(sec[index].dep.stn.y, sec[index].dep.stn.x);
                }

                _controller.animateCamera(
                  CameraUpdate.newLatLng(stepPosition),
                );
              },
              pagination: SwiperPagination(),
              control: SwiperControl(),
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

  String _convertDistance(int distance) {
    if (distance.toString().length > 3) {
      return (distance / 1000).toStringAsFixed(1) + " KM";
    } else
      return distance.toString() + " M";
  }
}
