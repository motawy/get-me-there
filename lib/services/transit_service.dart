import 'networking.dart';
import 'package:intl/intl.dart';

const ipAddress = "118.138.10.31";
const transitURL = 'https://$ipAddress:3000/api/transit/getMeThere';

class TransitService {
  Future<dynamic> getTransitInfo(depLat, depLon, arrLat, arrLon) async {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-ddTkk%3Amm%3Ass').format(time);
    print("FORMATTED DATE: " + formattedDate);
    Map body = {
      "dep_lat": depLat,
      "dep_lon": depLon,
      "arr_lat": arrLat,
      "arr_lon": arrLon,
      "time": formattedDate
    };

    NetWorkHelper netWorkHelper = NetWorkHelper(transitURL, body);
    var transitData;
    try {
      transitData = await netWorkHelper.getData();
    } catch (e) {
      print("Error caught: " + e.toString());
    }
    return transitData;
  }
}
