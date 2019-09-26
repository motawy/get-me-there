import 'package:flutter/material.dart';
import 'package:get_me_there/models/transit_model.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class RouteDetails extends StatelessWidget {
  final List<Connection> transit;
  RouteDetails({this.transit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Route Details"),
      ),
      body: SafeArea(
        child: Container(
          child: null,
        ),
      ),
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: _createTimeline,
      itemCount: transit.length,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);



  TimelineModel _createTimeline(BuildContext context, int i) {
    final connection = transit[i];
    final sec = connection.sections.sec;

    sectionTimelineModel(TimelinePosition position) => Timeline.builder(
        itemBuilder: _createSectionTimeLine,
        itemCount: sec.length,
        physics: position == TimelinePosition.Left
            ? ClampingScrollPhysics()
            : BouncingScrollPhysics(),
        position: position);
    return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                connection.sections.sec
                const SizedBox(
                  height: 8.0,
                ),
                Text(doodle.time, style: textTheme.caption),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  doodle.name,
                  style: textTheme.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        position:
        i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }

  _createSectionTimeLine(BuildContext context, int i){

  }
}
