import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/constants/firebase.dart';
import 'package:grocery/models/CartItemModel.dart';

class CartRepository {
  static CollectionReference _cartRef =
      FirebaseConstants.firebaseFirestore.collection("cart");

  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<Map<String, CartItemModel>> getCart() {
    return _cartRef
        .doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot query) {
      Map<String, CartItemModel> cart = {};

      if (!query.exists) return cart;

      final cartItems = query["items"];
      cartItems.forEach((varientId, item) {
        final cartModel = CartItemModel.fromJson(json: item);
        cart.putIfAbsent(varientId, () => cartModel);
      });

      return cart;
    });
  }

  static Future<void> addToCart(Map<String, CartItemModel> cart) async {
    Map<String, Map> cartItems = {};
    cart.forEach((key, value) {
      cartItems.putIfAbsent(key, () => value.toJson());
    });
    try {
      await _cartRef
          .doc(_auth.currentUser!.uid)
          .set({'items': cartItems}, SetOptions(merge: true));
    } catch (e) {
      print("error ${e.toString()}");
    }
  }
}
