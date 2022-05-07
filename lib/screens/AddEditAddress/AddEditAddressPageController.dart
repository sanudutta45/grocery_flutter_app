import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/globalController/CurrentLocationController.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:grocery/repository/AddressRepository.dart';

class AddEditAddressPageController extends GetxController {
  final _isSaving = false.obs;
  final _activeAddressType = 0.obs;
  final _showOption = false.obs;
  bool _editMode = false;
  final _formKey = GlobalKey<FormState>();
  final _formData = Rx<LocationModel?>(null);
  final CurrentLocationController _currentLocationController = Get.find();

  bool get isSaving => _isSaving.value;
  int get activeAddressType => _activeAddressType.value;
  bool get showOption => _showOption.value;
  LocationModel? get formData => _formData.value;
  GlobalKey<FormState> get formKey => _formKey;
  bool get editMode => _editMode;

  final List addressTypes = [
    {"name": "home", "hasOption": false},
    {"name": "office", "hasOption": false},
    {"name": "others", "hasOption": true}
  ];

  @override
  void onInit() {
    if (Get.arguments?["user_location"] != null) {
      _formData.value = Get.arguments["user_location"];
      _activeAddressType.value = _formData.value!.addressType;
      if (activeAddressType == 2) _showOption.value = true;
      _editMode = true;
    } else
      _formData.value = _currentLocationController.currentLocation!;

    super.onInit();
  }

  setActiveAddressType(int index) {
    _activeAddressType.value = index;
    _formData.value!.addressType = index;
    if (addressTypes[index]["hasOption"])
      _showOption.value = true;
    else {
      _showOption.value = false;
      _formData.value!.addressTypeName = addressTypes[index]["name"];
    }
  }

  addAddress() async {
    _formData.value!.savedAddress = true;
    try {
      await AddressRepository.addDeliveryAddress(_formData.value!);
    } catch (error) {
      Get.snackbar("Add Address", "Failed to save address");
      print("err $error");
    }
  }

  updateAddress() async {
    try {
      await AddressRepository.updateDeliveryAddress(_formData.value!);
    } catch (error) {
      Get.snackbar("Update Address", "Failed to update address");
      print("err $error");
    }
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    try {
      _isSaving.value = true;
      if (editMode)
        await updateAddress();
      else
        await addAddress();
      Get.back();
    } catch (error) {
      print("err $error");
    } finally {
      _isSaving.value = false;
    }
  }

  onLocationSelected(LocationModel location) {
    _formData.value = location;
    Get.back();
  }
}
