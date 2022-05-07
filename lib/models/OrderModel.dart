import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/models/CartItemModel.dart';
import 'package:grocery/models/LocationModel.dart';

class OrderModel {
  late String? orderId;
  late String userId;
  late List<CartItemModel> orderProducts;
  late String orderStatus;
  late String paymentStatus;
  late LocationModel deliveryAddress;
  late Timestamp createdAt;
  late Timestamp updatedAt;
  late double orderAmount;
  Timestamp? deliveredAt;

  OrderModel(
      {required this.userId,
      required this.orderProducts,
      required this.orderStatus,
      required this.deliveryAddress,
      required this.paymentStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.orderAmount});

  OrderModel.fromJson(json) {
    List<CartItemModel> items = [];
    for (var orderItem in json["orderProducts"]) {
      CartItemModel item = CartItemModel.fromJson(json: orderItem);
      items.add(item);
    }

    LocationModel locationModel =
        LocationModel.fromJson(json["deliveryAddress"]);

    orderId = json["orderId"] as String;
    userId = json["userId"] as String;
    orderProducts = items;
    orderStatus = json["orderStatus"] as String;
    paymentStatus = json["paymentStatus"] as String;
    deliveryAddress = locationModel;
    createdAt = Timestamp.fromMillisecondsSinceEpoch(json["createdAt"] as int);
    updatedAt = Timestamp.fromMillisecondsSinceEpoch(json["updatedAt"] as int);
    orderAmount = json["orderAmount"] as double;
    deliveredAt =
        Timestamp.fromMillisecondsSinceEpoch(json["deliveredAt"] as int);
  }

  Map<String, dynamic> toJson() {
    final items = orderProducts.map((e) => e.toJson()).toList();
    return {
      'userId': userId,
      'orderProducts': items,
      'orderStatus': orderStatus,
      'paymentStatus': paymentStatus,
      'deliveryAddress': deliveryAddress.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'orderAmount': orderAmount,
      'deliveredAt': deliveredAt
    };
  }
}
