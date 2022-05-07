import 'package:get/get.dart';
import 'package:grocery/screens/AddEditAddress/AddEditAddressPageController.dart';

class AddEditAdressPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEditAddressPageController());
  }
}
