import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery/globalController/AuthController.dart';
import 'package:grocery/globalController/CartController.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:grocery/models/OrderModel.dart';
import 'package:grocery/repository/OrderRepository.dart';

class PlaceOrderController extends GetxController {
  final _deliveryLocation = Rx<LocationModel?>(null);

  final _placingOrder = false.obs;

  final AuthController _authController = Get.find();
  final CartController _cartController = Get.find();

  @override
  void onReady() {
    super.onReady();
  }

  bool get placingOrder => _placingOrder.value;

  LocationModel? get deliveryLocation => _deliveryLocation.value;

  setDeliveryAddress(LocationModel location) {
    _deliveryLocation.value = location;
  }

  clearDeliveryAddress() {
    _deliveryLocation.value = null;
  }

  _placeOrder() async {
    OrderModel orderModel = OrderModel(
        userId: _authController.user!.uid,
        orderProducts: _cartController.cartItems.values.toList(),
        orderStatus: "placed",
        deliveryAddress: deliveryLocation!,
        paymentStatus: "paid",
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        orderAmount: _cartController.getTotalAmountWithTip);
    try {
      _placingOrder.value = true;
      await OrderRepository.placeOrder(orderModel);
      _cartController.removeAllItems();
      Get.toNamed("/order_confirmation");
    } catch (e) {
      print("failed to place order $e");
    } finally {
      _placingOrder.value = false;
    }
  }

  proceedToCheckout() async {
    if (_authController.user == null)
      Get.toNamed("/login");
    else if (_deliveryLocation.value == null)
      Get.toNamed("/select_delivery_address");
    else
      _placeOrder();
  }
}
