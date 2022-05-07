import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/models/ProductVarientModel.dart';

class CartItemModel {
  late ProductVarientModel productDetail;
  late int quantity;

  CartItemModel({required this.productDetail, required this.quantity});

  CartItemModel.fromJson({required json}) {
    ProductVarientModel _productDetail = ProductVarientModel(
        productName: json["productDetail"]["productName"] as String,
        productId: json["productDetail"]["productId"] as String,
        brand: json["productDetail"]["brand"] as String,
        varientId: json["productDetail"]["varientId"] as String,
        varientName: json["productDetail"]["varientName"] as String,
        cost: json["productDetail"]["cost"] as double,
        imgUrl: json["productDetail"]["imgUrl"] as String,
        maxBuy: json["productDetail"]["maxBuy"] as int,
        discountPercentage:
            json["productDetail"]["discountPercentage"] as double,
        totalSold: json["productDetail"]["totalSold"] as int,
        createdAt: json["productDetail"]["createdAt"] as Timestamp,
        totalAvailable: json["productDetail"]["totalAvailable"] as int);
    productDetail = _productDetail;
    quantity = json["quantity"] as int;
  }

  Map<String, dynamic> toJson() {
    Map productDetail = this.productDetail.toJson();
    return {'productDetail': productDetail, 'quantity': quantity};
  }
}
