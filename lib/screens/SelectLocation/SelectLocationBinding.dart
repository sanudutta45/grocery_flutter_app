import 'package:get/get.dart';
import 'package:grocery/screens/SelectLocation/SelectLocationController.dart';

class SelectLocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectLocationController());
  }
}
