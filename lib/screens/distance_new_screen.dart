import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:golf_distances_stats/services/location_service.dart';
import 'package:location/location.dart';

class DistanceNewScreen extends StatefulWidget {
  static const routeName = '/distances/new';

  const DistanceNewScreen({Key? key}) : super(key: key);

  @override
  State<DistanceNewScreen> createState() => _DistanceNewScreenState();
}

class _DistanceNewScreenState extends State<DistanceNewScreen> {
  LocationData? _startLocation;
  var _isFetchingStartLocation = false;

  LocationData? _endLocation;
  var _isFetchingEndLocation = false;

  double? _distance;

  void _getStartLocation() async {
    setState(() {
      _isFetchingStartLocation = true;
    });
    var locationData = await LocationService.getLocation();
    setState(() {
      _startLocation = locationData;
      _isFetchingStartLocation = false;
    });
  }

  void _getEndLocation() async {
    setState(() {
      _isFetchingEndLocation = true;
    });
    var locationData = await LocationService.getLocation();
    setState(() {
      _endLocation = locationData;
      _isFetchingEndLocation = false;
      _distance =
          LocationService.getDistanceBetween(_startLocation!, _endLocation!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Distance')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _getStartLocation,
                child: const Text('get start location'),
              ),
              _isFetchingStartLocation
                  ? const CircularProgressIndicator()
                  : Text(_startLocation != null
                      ? 'lat: ${_startLocation!.latitude}, lng: ${_startLocation!.longitude}'
                      : 'no location'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _startLocation != null ? _getEndLocation : null,
                child: const Text('get end location'),
              ),
              _isFetchingEndLocation
                  ? const CircularProgressIndicator()
                  : Text(_endLocation != null
                      ? 'lat: ${_endLocation!.latitude}, lng: ${_endLocation!.longitude}'
                      : 'no location'),
            ],
          ),
          Text(_distance != null
              ? 'distance: ${_distance!.toStringAsFixed(2)} m'
              : 'no distance'),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _startLocation = null;
                  _endLocation = null;
                  _distance = null;
                });
              },
              child: const Text('reset')),
        ],
      ),
    );
  }
}
