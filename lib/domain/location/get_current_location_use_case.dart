import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:osk_flutter/data/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository _locationRepository;

  GetCurrentLocationUseCase(this._locationRepository);

  Future<Address> execute() async {
    final LocationData currentLocation = await _locationRepository.getCurrentLocationOrNull();

    if (currentLocation != null) {
      final List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(
        currentLocation.latitude,
        currentLocation.longitude,
      ));
      return addresses[0];
    }

    return null;
  }
}
