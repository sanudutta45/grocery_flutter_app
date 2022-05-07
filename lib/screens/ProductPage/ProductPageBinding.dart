import 'package:get/get.dart';
import 'package:grocery/screens/ProductPage/ProductPageController.dart';

class ProductPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductPageController());
  }
}
