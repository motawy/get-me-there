import 'package:geolocator/geolocator.dart';

class LocationService {
  double latitude;
  double longitude;
  List<Placemark> placeMark;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      placeMark = await Geolocator().placemarkFromPosition(position);
    } on Exception catch (e) {
      print(e);
    }
  }
}
