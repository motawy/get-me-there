import 'package:flutter/material.dart';
import 'package:get_me_there/utilities/constants.dart';

class TransitCard extends StatelessWidget {
  final List<String> modes;
  final List<int> durations;
  TransitCard({@required this.modes, @required this.durations});

  final List<Icon> icons = List<Icon>();

  @override
  Widget build(BuildContext context) {
    _convertModesToIcons();

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          color: Colors.blueGrey,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: modes.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          icons[index],
                          Text(
                            durations[index].toString(),
                            style: kSearchHintTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  _convertModesToIcons() {
    for (String mode in modes) {
      switch (mode) {
        case "WALK":
          icons.add(Icon(
            Icons.directions_walk,
            size: 20,
            color: Colors.black,
          ));
          break;
        case "TRAIN":
          icons.add(Icon(Icons.directions_subway,
              size: 20, color: Colors.blueAccent));
          break;
        case "TRAM":
          icons.add(Icon(
            Icons.directions_railway,
            size: 20,
            color: Colors.lightGreen,
          ));
          break;
        case "BUS":
          icons.add(Icon(
            Icons.directions_bus,
            size: 20,
            color: Colors.deepOrangeAccent,
          ));
          break;
        case "FERRY":
          icons.add(Icon(
            Icons.directions_boat,
            size: 20,
            color: Colors.teal,
          ));
          break;
        default:
          break;
      }
    }
  }
}
