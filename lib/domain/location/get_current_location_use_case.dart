import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class GetCurrentLocationUseCase {
  final Location _location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Future<Address> execute() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return null;
      }
    }

    return await _getAddress();
  }

  Future<Address> _getAddress() async {
    final LocationData latestLocation = await _location.getLocation();

    final List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(
      latestLocation.latitude,
      latestLocation.longitude,
    ));

    return addresses[0];
  }
}
