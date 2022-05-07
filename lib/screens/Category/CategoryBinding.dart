import 'package:get/get.dart';
import 'package:grocery/screens/Category/CategoryController.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
