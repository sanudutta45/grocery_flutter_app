import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:get/get.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:location/location.dart';

class UtilityMethods {
  static Future<LocationModel> getCurrentLocation() async {
    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;
    late LocationData _locationData;
    final Location _location = Location();

    try {
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled)
          Get.snackbar("Location", "Location service not available");
      }

      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted)
          Get.snackbar("Location", "Permission denied");
      }

      _locationData = await _location.getLocation();
      List<GeoCoding.Placemark> placemarks =
          await GeoCoding.placemarkFromCoordinates(
              _locationData.latitude!, _locationData.longitude!);

      return LocationModel(
          title: placemarks[0].name,
          latitude: _locationData.latitude!,
          postalCode: placemarks[0].postalCode,
          location:
              '${placemarks[0].name}, ${placemarks[0].street}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].postalCode}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}',
          longitude: _locationData.longitude!);
    } catch (e) {
      throw Error();
    }
  }

  static Future<List<LocationModel>> getLocationsFromAddress(
      String address) async {
    List<LocationModel> locations = [];
    try {
      List<GeoCoding.Location> cordinates = await GeoCoding.locationFromAddress(
          address,
          localeIdentifier: "en_IN");

      List<List<GeoCoding.Placemark>> placemarks = await Future.wait(
          cordinates.map((e) => GeoCoding.placemarkFromCoordinates(
              e.latitude, e.longitude,
              localeIdentifier: "en_IN")));
      for (int i = 0; i < placemarks[0].length; i++) {
        if (placemarks[0][i].postalCode == null) continue;
        locations.add(LocationModel(
            title: placemarks[0][i].name,
            latitude: cordinates[0].latitude,
            postalCode: placemarks[0][i].postalCode,
            location:
                '${placemarks[0][i].name}, ${placemarks[0][i].street}, ${placemarks[0][i].subAdministrativeArea}, ${placemarks[0][i].postalCode}, ${placemarks[0][i].administrativeArea}, ${placemarks[0][i].country}',
            longitude: cordinates[0].longitude));
      }
      return locations;
    } catch (e) {
      throw Error();
    }
  }
}
