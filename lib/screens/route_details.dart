import 'package:flutter/material.dart';
import 'package:get_me_there/models/transit_model.dart';
import 'package:get_me_there/utilities/animated_background.dart';
import 'package:get_me_there/utilities/constants.dart';
import 'package:get_me_there/widget/top_part.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class RouteDetails extends StatefulWidget {
  final List<Sec> sections;
  RouteDetails({this.sections});

  @override
  _RouteDetailsState createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGMTlight,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Route Details"),
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          fit: StackFit.expand,
          children: <Widget>[
            TopPart(),
            AnimatedBackground(controller: _controller),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: timelineModel(TimelinePosition.Left),
            ),
          ],
        ),
      ),
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      controller: _controller,
      itemBuilder: _timelineBuilder,
      itemCount: widget.sections.length,
      physics: BouncingScrollPhysics(),
      position: position);

  TimelineModel _timelineBuilder(BuildContext context, int i) {
    final sec = widget.sections[i];
    return TimelineModel(
      Padding(
        padding: EdgeInsets.all(30.0),
        child: Hero(
          tag: "num$i",
          child: Card(
            elevation: 8,
            color: kGMTlight,
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _convertModeOfTransport(sec.mode),
                  sec.mode != 20
                      ? Text("${sec.journey.stop.length} stops")
                      : SizedBox(),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(_parseCustomDuration(sec.journey.duration).toString() +
                      " min"),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${sec.journey.distance.toString()} M",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      position:
          i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
      isFirst: i == 0,
      isLast: i == widget.sections.length - 1,
      iconBackground: kGMTerror.withAlpha(80),
      icon: i == 0
          ? Icon(Icons.room)
          : (i == widget.sections.length - 1
              ? Icon(Icons.flag)
              : Icon(Icons.arrow_downward)),
    );
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
}
