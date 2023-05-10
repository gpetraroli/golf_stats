import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationService {
  static Future<LocationData?> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  static getDistanceBetween(LocationData start, LocationData end) {
    var lat1 = start.latitude;
    var lon1 = start.longitude;
    var lat2 = end.latitude;
    var lon2 = end.longitude;

    return Geolocator.distanceBetween(lat1!, lon1!, lat2!, lon2!);
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 -
    //     c((lat2! - lat1!) * p) / 2 +
    //     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2! - lon1!) * p)) / 2;
    //
    // return 1000 * 12742 * asin(sqrt(a));
  }
}
