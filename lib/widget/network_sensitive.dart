import 'package:flutter/material.dart';
import 'package:get_me_there/utilities/connectivity_status_enum.dart';
import 'package:provider/provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;
  const NetworkSensitive({this.child, this.opacity = 0.5});

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Wifi) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Cellular) {
      return Opacity(
        opacity: opacity,
        child: child,
      );
    }

    return Opacity(
      opacity: 0.1,
      child: child,
    );
  }
}
