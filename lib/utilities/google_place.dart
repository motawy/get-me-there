import 'dart:async';
import 'constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:get_me_there/autocomplete_widget.dart';

class GooglePlaces {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Location location;
  GooglePlacesListener _mapScreenState;

  GooglePlaces(this._mapScreenState);

  Future findPlace(BuildContext context) async {
    Prediction p = await showGooglePlacesAutocomplete(
      context: context,
      location: location,
      onError: (res) {
        homeScaffoldKey.currentState
            .showSnackBar(new SnackBar(content: Text(res.errorMessage)));
      },
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      _mapScreenState.selectedLocation(
          lat, lng, detail.result.formattedAddress);
    }
  }

  void updateLocation(double lat, double long) {
    location = Location(lat, long);
  }
}

abstract class GooglePlacesListener {
  selectedLocation(double lat, double long, String address);
}
