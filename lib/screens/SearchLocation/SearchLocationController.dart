import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:grocery/utils/UtilityMethods.dart';

class SearchLocationController extends GetxController {
  final _locationInputValue = ''.obs;
  final _showCloseIcon = false.obs;
  final _locations = <LocationModel>[].obs;
  final _isLoading = false.obs;
  final _isServiceAvailable = true.obs;
  final FocusNode focus = FocusNode();
  final _locationSearchController = TextEditingController();

  bool get isServiceAvailable => _isServiceAvailable.value;

  String get locationInputValue => _locationInputValue.value;

  bool get showCloseIcon => _showCloseIcon.value;

  List<LocationModel> get locations => _locations;

  bool get isLoading => _isLoading.value;

  TextEditingController get locationSearchController =>
      _locationSearchController;

  @override
  void onReady() {
    _checkIsDeliverable();
    debounce(_locationInputValue, _handleDebounce,
        time: Duration(milliseconds: 500));
    super.onReady();
  }

  _setIsLoading(bool loading) {
    if (_isLoading.value != loading) _isLoading.value = loading;
  }

  _checkIsDeliverable() {
    final serviceAvailable = Get.arguments?['serviceAvailable'] ?? true;
    if (!serviceAvailable) {
      focus.unfocus();
      _isServiceAvailable.value = false;
      _showCloseIcon.value = true;
      _locationSearchController.text = Get.arguments['address'];
      _locationInputValue.value = Get.arguments['address'];
    } else {
      focus.requestFocus();
    }
  }

  _handleDebounce(String text) {
    if (text.length > 2) {
      _getLocations(text);
    }
  }

  _getLocations(String inputText) async {
    try {
      _locations.value =
          await UtilityMethods.getLocationsFromAddress(inputText);
    } catch (e) {
      _locations.value = [];
    } finally {
      _setIsLoading(false);
    }
  }

  setLocationSearch(String text) {
    _locationInputValue.value = text;
    if (text.length > 2) {
      _showCloseIcon.value = true;
      _locations.value = [];
      _setIsLoading(true);
    } else {
      _locations.value = [];
      _showCloseIcon.value = false;
      _setIsLoading(false);
    }
  }

  setSavedLocation(LocationModel savedLocation) {
    Get.arguments?["callback"](savedLocation);
  }

  setLocation(int index) {
    LocationModel location = _locations[index];
    _checkLocationAndSet(location.postalCode, location);
  }

  _checkLocationAndSet(String? pincode, LocationModel currentLocation) {
    if (pincode == null) {
      _locations.value = [];
      _isServiceAvailable.value = false;
      _locationSearchController.text = currentLocation.location;
      _locationInputValue.value = currentLocation.location;
      focus.unfocus();
    } else {
      Get.arguments?["callback"](currentLocation);
    }
  }

  setCurrentLocation() async {
    try {
      _isLoading.value = true;
      LocationModel currentLocation = await UtilityMethods.getCurrentLocation();
      _checkLocationAndSet(currentLocation.postalCode, currentLocation);
    } catch (e) {
    } finally {
      _isLoading.value = false;
    }
  }

  clearQuery() {
    _locationInputValue.value = '';
    _locationSearchController.clear();
    _showCloseIcon.value = false;
    _locations.value = [];
    _isServiceAvailable.value = true;
    focus.requestFocus();
  }
}
