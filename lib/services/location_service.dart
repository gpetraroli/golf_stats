import 'dart:math';

import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static double getDistanceBetween(Position start, Position end) {
    var lat1 = start.latitude;
    var lon1 = start.longitude;
    var lat2 = end.latitude;
    var lon2 = end.longitude;

    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 -
    //     c((lat2! - lat1!) * p) / 2 +
    //     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2! - lon1!) * p)) / 2;
    //
    // return 1000 * 12742 * asin(sqrt(a));
  }
}
