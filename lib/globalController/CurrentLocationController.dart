import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/models/LocationModel.dart';

class CurrentLocationController extends GetxController {
  final _localStorage = GetStorage();
  final _currentLocation = Rx<LocationModel?>(null);

  LocationModel? get currentLocation => _currentLocation.value;

  @override
  void onReady() {
    _localStorage.remove("current_location");
    _getLocationFromStorage();
    // ever(_currentLocation, _setLocationToStorage);
    super.onReady();
  }

  _getLocationFromStorage() {
    Map<String, Object>? location = _localStorage.read("current_location");
    
    if (location != null)
      _currentLocation.value = LocationModel.fromJson(location);
  }

  isCurrentLocationSet() {
    if (_currentLocation.value == null)
      Get.offNamed("/select_location");
    else
      Get.offNamed("/home");
  }

  _setLocationToStorage(LocationModel? location) {
    if (location != null)
      _localStorage.write("current_location", location.toJson());
  }

  setLocation(LocationModel location) {
    _currentLocation.value = location;
    _setLocationToStorage(location);
  }
}
