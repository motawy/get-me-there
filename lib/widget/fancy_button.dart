import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  FancyButton({@required this.onPressed});
  final GestureTapCallback onPressed;

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
          children: const <Widget>[
            Icon(
              Icons.done,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Done",
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
