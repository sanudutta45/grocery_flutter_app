import 'package:get/get.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesPageController.dart';

class SelectDeliveryAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAddressesPageController());
  }
}
