import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:golf_distances_stats/services/location_service.dart';

class DistanceNewScreen extends StatefulWidget {
  static const routeName = '/distances/new';

  const DistanceNewScreen({Key? key}) : super(key: key);

  @override
  State<DistanceNewScreen> createState() => _DistanceNewScreenState();
}

class _DistanceNewScreenState extends State<DistanceNewScreen> {
  Position? _startLocation;
  var _isFetchingStartLocation = false;
  String? _error;

  Position? _endLocation;
  var _isFetchingEndLocation = false;

  double? _distance;

  void _getStartLocation() async {
    setState(() {
      _isFetchingStartLocation = true;
    });
    try {
      var locationData = await LocationService.getLocation();
      setState(() {
        _startLocation = locationData;
        _isFetchingStartLocation = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isFetchingStartLocation = false;
      });
    }
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _getStartLocation,
                    child: const Text('get start location'),
                  ),
                  _isFetchingStartLocation
                      ? const CircularProgressIndicator()
                      : Text(_startLocation != null
                          ? 'lat: ${_startLocation!.latitude}, lng: ${_startLocation!.longitude}, a: ${_startLocation!.accuracy.toStringAsFixed(2)}'
                          : 'no location'),
                ],
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _startLocation != null ? _getEndLocation : null,
                    child: const Text('get end location'),
                  ),
                  _isFetchingEndLocation
                      ? const CircularProgressIndicator()
                      : Text(_endLocation != null
                          ? 'lat: ${_endLocation!.latitude}, lng: ${_endLocation!.longitude}, a: ${_startLocation!.accuracy.toStringAsFixed(2)}'
                          : 'no location'),
                ],
              ),
              const SizedBox(height: 50),
              Text(_distance != null
                  ? 'distance: ${_distance!.toStringAsFixed(2)} m'
                  : 'no distance'),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _startLocation = null;
                      _endLocation = null;
                      _distance = null;
                    });
                  },
                  child: const Text('reset')),
              Text(_error != null ? _error as String : ''),
            ],
          ),
        ),
      ),
    );
  }
}
