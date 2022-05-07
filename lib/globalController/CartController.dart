import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/models/CartItemModel.dart';
import 'package:grocery/models/ProductVarientModel.dart';
import 'package:grocery/repository/CartRepository.dart';

class CartController extends GetxController {
  final _cartItems = Rx<Map<String, CartItemModel>>({});
  final List<int> tipAmounts = [10, 25, 50];
  final _selectedTipIndex = (-1).obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _localStorage = GetStorage();

  @override
  void onReady() {
    _loadCartInit();
    super.onReady();
  }

  Map<String, CartItemModel> get cartItems => _cartItems.value;

  int get totalItems => cartItems.length;
  int get selectedTipIndex => _selectedTipIndex.value;

  _loadCartInit() async {
    if (_auth.currentUser != null) {
      _cartItems.value = await CartRepository.getCart();
    } else if (_localStorage.read<Map<String, Object>>("cart_items") != null) {
      Map<String, dynamic> localCart =
          _localStorage.read<Map<String, dynamic>>("cart_items")!;
      localCart.forEach((varientId, items) {
        _cartItems.value
            .putIfAbsent(varientId, () => CartItemModel.fromJson(json: items));
      });
    }
    debounce(_cartItems, _addToCart, time: Duration(milliseconds: 300));
  }

  _addToCart(Map<String, CartItemModel> items) {
    if (_auth.currentUser != null)
      CartRepository.addToCart(items);
    else {
      Map<String, Object> newCart = {};
      items.forEach((key, value) {
        newCart.putIfAbsent(key, () => value.toJson());
      });
      _localStorage.write("cart_items", newCart);
    }
  }

  addToCartFromDB() async {
    Map<String, CartItemModel> cart = {...cartItems};
    Map<String, CartItemModel> getRemoteCart = await CartRepository.getCart();
    getRemoteCart.forEach((remoteKey, remoteItem) {
      if (cart.containsKey(remoteKey)) {
        cart.update(
            remoteKey,
            (value) => CartItemModel(
                productDetail: value.productDetail,
                quantity: value.quantity + remoteItem.quantity));
      } else
        cart.putIfAbsent(remoteKey, () => remoteItem);
    });

    _cartItems.value = cart;
    _localStorage.remove("cart_items");
  }

  updateCartItem(ProductVarientModel product, bool add) {
    Map<String, CartItemModel> cart = {...cartItems};
    if (cart.containsKey(product.varientId)) {
      cart.update(
          product.varientId,
          (existingItem) => CartItemModel(
              productDetail: product,
              quantity:
                  add ? existingItem.quantity + 1 : existingItem.quantity - 1));
      if (cart[product.varientId]?.quantity == 0) {
        cart.remove(product.varientId);
      }
    } else {
      cart.putIfAbsent(product.varientId,
          () => CartItemModel(productDetail: product, quantity: 1));
    }
    _cartItems.value = cart;
  }

  removeCartItem(String varientId) {
    Map<String, CartItemModel> cart = {...cartItems};
    cart.remove(varientId);
    _cartItems.value = cart;
  }

  removeAllItems() {
    _cartItems.value = {};
  }

  double get getTotalAmountWithDelivery {
    double deliverRate = 25.0;

    return getTotalAmount + deliverRate;
  }

  double get getTotalAmount {
    double total = 0.0;

    cartItems.forEach(
        (key, item) => total += (item.productDetail.cost * item.quantity));
    return total;
  }

  double get getTotalAmountWithTip {
    if (_selectedTipIndex.value != -1)
      return getTotalAmountWithDelivery + tipAmounts[_selectedTipIndex.value];
    return getTotalAmountWithDelivery;
  }

  tipHandler(int index) => {
        if (index == selectedTipIndex)
          _selectedTipIndex.value = -1
        else
          _selectedTipIndex.value = index
      };
}
