import 'package:grocery/constants/firebase.dart';
import 'package:grocery/models/OrderModel.dart';

class OrderRepository {
  static final _ordersRef =
      FirebaseConstants.firebaseFirestore.collection("orders");

  static Future<void> placeOrder(OrderModel order) async {
    try {
      await _ordersRef
          .add({...order.toJson()}).then((_) => print("ordered successfully"));
    } catch (e) {
      print("order unsuccessful $e");
    }
  }
}
