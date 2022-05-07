import 'package:get/get.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesPageController.dart';
import 'package:grocery/screens/SearchLocation/SearchLocationController.dart';

class SearchLocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchLocationController());
    Get.lazyPut(() => MyAddressesPageController());
  }
}
