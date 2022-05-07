import 'package:get/get.dart';
import 'package:grocery/globalController/CurrentLocationController.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:grocery/utils/UtilityMethods.dart';

class SelectLocationController extends GetxController {
  final _isLoading = false.obs;

  final CurrentLocationController _currentLocationController = Get.find();

  get isLoading => _isLoading.value;

  onLocationSelected(LocationModel location) {
    _currentLocationController.setLocation(location);
    Get.offAndToNamed("/home");
  }

  setCurrentLocationAutomatically() async {
    try {
      _isLoading.value = true;
      LocationModel currentLocation = await UtilityMethods.getCurrentLocation();

      if (currentLocation.postalCode == null) {
        Get.toNamed("/search_location", arguments: {
          'address': currentLocation.location,
          'serviceAvailable': false,
          'callback': onLocationSelected
        });
      } else {
        Get.find<CurrentLocationController>().setLocation(currentLocation);
        Get.offAllNamed("/home");
      }
    } catch (e) {
      throw Error();
    } finally {
      _isLoading.value = false;
    }
  }
}
