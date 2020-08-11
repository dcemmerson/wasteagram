/// filename: user_location.dart
/// last modified: 08/10/2020
/// description: Class used to contain details of using location package to
///   obtain user location on demand.
///   To use, call factory constructor LocationManager.getInstance(), followed
///   by call go getUserLocation.

import 'package:location/location.dart';

class LocationManager {
  static LocationManager _instance;

  final Location _location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData locationData;

  LocationManager._();

  factory LocationManager.getInstance() {
    if (_instance == null) {
      _instance = LocationManager._();
    }
    return _instance;
  }

  bool get servicesEnabled => _serviceEnabled;
  PermissionStatus get permissionGranted => _permissionGranted;

  Future<LocationData> getUserLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return _location.getLocation();
  }
}
