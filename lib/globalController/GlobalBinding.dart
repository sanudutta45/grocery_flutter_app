import 'package:get/get.dart';
import 'package:grocery/globalController/CartController.dart';
import 'package:grocery/globalController/CurrentLocationController.dart';
import 'package:grocery/globalController/AuthController.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CurrentLocationController>(CurrentLocationController());
    Get.put<AuthController>(AuthController());
    Get.put<CartController>(CartController());
  }
}
