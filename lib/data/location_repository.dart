import 'package:location/location.dart';

class LocationRepository {
  final Location _location = Location();

  LocationData _currentLocationData;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Future<LocationData> getCurrentLocationOrNull() async {
    if (_currentLocationData != null) {
      return _currentLocationData;
    }
    final hasPermissons = await checkLocationPermissons();
    if (hasPermissons) {
      _currentLocationData = await _location.getLocation();
      return _currentLocationData;
    }
    return null;
  }

  Future<bool> checkLocationPermissons() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return false;
      }
    }

    return true;
  }
}
