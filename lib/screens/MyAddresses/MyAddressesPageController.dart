import 'package:get/get.dart';
import 'package:grocery/globalController/AuthController.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:grocery/repository/AddressRepository.dart';

class MyAddressesPageController extends GetxController {
  final _myAddresses = Rx<List<LocationModel>>([]);
  final AuthController _authController = Get.find();

  @override
  void onReady() {
    if (_authController.user != null)
      _myAddresses.bindStream(AddressRepository.getDeliveryAddress());
  }

  List<LocationModel> get myAddresses => _myAddresses.value;

  removeAddress(int locationIndex) async {
    try {
      await AddressRepository.removeDeliveryAddress(myAddresses[locationIndex]);
    } catch (err) {
      printError(info: "err $err");
    }
  }
}
