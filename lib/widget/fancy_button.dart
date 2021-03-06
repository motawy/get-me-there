import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  FancyButton(
      {@required this.onPressed, @required this.label, @required this.icon});
  final GestureTapCallback onPressed;
  final String label;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 8,
      fillColor: Colors.teal,
      splashColor: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
