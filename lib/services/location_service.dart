import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_me_there/models/user_location.dart';

class LocationService extends ChangeNotifier {
  UserLocation _userLocation;
  Location location = Location();

  get userLocation => _userLocation;

  set userLocation(UserLocation location) {
    _userLocation = location;
    notifyListeners();
  }

  Future<UserLocation> getCurrentLocation() async {
    try {
      LocationData position = await location.getLocation();
      _userLocation = UserLocation(
          latitude: position.latitude, longitude: position.longitude);
    } on Exception catch (e) {
      print(e);
    }
    return _userLocation;
  }
}
