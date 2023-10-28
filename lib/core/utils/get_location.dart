import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '/domain/exceptions/app_exception.dart';

Future<LocationPermission> _getPermission() async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    final permission = await Geolocator.requestPermission();
    return permission;
  } else {
    return permission;
  }
}

Future<Position> determinePosition() async {
  Position? position;
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(msg: "Please enable location service");
    Geolocator.openLocationSettings();
    position = await Geolocator.getLastKnownPosition();
  }

  permission = await _getPermission();

  if (permission != LocationPermission.denied &&
      permission != LocationPermission.deniedForever) {
    position = await Geolocator.getCurrentPosition();
  } else {
    throw LocationNotFound(
        title: 'Location permission is denied',
        message:
            'Your location service is disabled, try again after enabling location permission.');
  }

  return position;
}
