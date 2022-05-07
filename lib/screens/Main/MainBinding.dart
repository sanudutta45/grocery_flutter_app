import 'package:get/get.dart';
import 'package:grocery/screens/ExplorePage/ExplorePageController.dart';
import 'package:grocery/screens/Home/HomeController.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesPageController.dart';
import 'package:grocery/screens/PlaceOrder/PlaceOrderController.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ExplorePageController());
    Get.lazyPut(() => PlaceOrderController());
    Get.lazyPut(() => MyAddressesPageController());
  }
}
