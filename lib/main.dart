import 'package:flutter/material.dart';
import 'package:get_me_there/utilities/cut_corners.dart';
import 'package:get_me_there/utilities/constants.dart';
import 'package:get_me_there/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _appTheme,
      home: LoadingScreen(),
    );
  }
}

final ThemeData _appTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kGMTsecondaryLight,
    primaryColor: kGMTprimary,
    buttonColor: kGMTsecondary,
    scaffoldBackgroundColor: kGMTwhite,
    cardColor: kGMTwhite,
    textSelectionColor: firstColor,
    errorColor: kGMTerror,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kGMTsecondary,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: kGMTlight),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: Colors.black87,
        bodyColor: Colors.black87,
      );
}
