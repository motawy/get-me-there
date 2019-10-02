import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(fontSize: 50.0, color: kGMTwhite);

const kCityNameTextStyle = TextStyle(fontSize: 30.0, color: kGMTwhite);

const kSearchHintTextStyle = TextStyle(fontSize: 20.0, color: Colors.grey);

const kButtonTextStyle = TextStyle(fontSize: 30.0, color: Colors.black);

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

// Need to hide this
const kGoogleApiKey = "YOUR GOOGLE API KEY";

const kGMTprimary = const Color(0xFF3A6D8C);
const kGMTprimaryLight = const Color(0xFF7EADBF);
const kGMTlight = const Color(0xFFF2F1DF);
const kGMTsecondary = const Color(0xFF8C594D);
const kGMTsecondaryLight = const Color(0xFFBF9775);
const kGMTerror = const Color(0xFFFF0066);
const kGMTwhite = Colors.white;

// Trying different colors
Color firstColor = Color(0xFF7A36DC);
Color secondColor = Color(0xFF7A36DC).withOpacity(0.5);
Color thirdColor = Color(0xFF7A36DC).withOpacity(0.2);
