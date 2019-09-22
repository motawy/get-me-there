import 'package:flutter/material.dart';

const kTempTextStyle =
    TextStyle(fontFamily: 'Spartan MB', fontSize: 40.0, color: Colors.black);

const kCityNameTextStyle =
    TextStyle(fontFamily: 'Spartan MB', fontSize: 20.0, color: Colors.black);

const kSearchHintTextStyle =
    TextStyle(fontFamily: 'Spartan MB', fontSize: 20.0, color: Colors.grey);

const kButtonTextStyle =
    TextStyle(fontSize: 30.0, fontFamily: 'Spartan MB', color: Colors.black);

const kConditionTextStyle = TextStyle(
  fontSize: 40.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter city name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide.none),
);

const kGoogleApiKey = "AIzaSyBdYAcKSIYMI8zxBGv9uAJwQF81hqIb-h8";

const kShrinePinkSecondary = const Color(0xFFFEEAE6);
const kShrinePink = const Color(0xFFFEDBD0);
const kShrineBrown = const Color(0xFF442B2D);
const kShrineErrorRed = const Color(0xFFC5032B);
const kShrineWhite = const Color(0xFFFFFBFA);
const kShrineBackgroundWhite = Colors.white;
