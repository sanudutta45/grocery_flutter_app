import 'package:cloud_firestore/cloud_firestore.dart';

class ProductVarientModel {
  ProductVarientModel(
      {required this.varientId,
      required this.brand,
      required this.productName,
      required this.productId,
      required this.cost,
      required this.discountPercentage,
      required this.imgUrl,
      required this.maxBuy,
      required this.totalAvailable,
      required this.totalSold,
      required this.varientName,
      required this.createdAt,
      this.ccd,
      this.coo,
      this.disclaimer,
      this.expiryDate,
      this.features,
      this.largeImageUrl,
      this.packageType,
      this.productClass,
      this.seller,
      this.shelfLife});

  final double cost;
  final double discountPercentage;
  final String imgUrl;
  final int maxBuy;
  final int totalAvailable;
  final int totalSold;
  final String varientName;
  final Timestamp createdAt;
  final String varientId;
  final String productId;
  final String productName;
  final String brand;
  final Map<String, String>? ccd;
  final String? coo;
  final String? disclaimer;
  final String? expiryDate;
  final List<String>? features;
  final List<String>? largeImageUrl;
  final String? packageType;
  final String? productClass;
  final String? seller;
  final String? shelfLife;

  ProductVarientModel.fromJson(json)
      : this(
            cost: (json['cost']! as num).toDouble(),
            discountPercentage: (json['discountPercentage']! as num).toDouble(),
            imgUrl: json['imgUrl']! as String,
            maxBuy: json['maxBuy']! as int,
            totalAvailable: json['totalAvailable']! as int,
            totalSold: json['totalSold']! as int,
            varientName: json["varientName"]! as String,
            createdAt: json["createdAt"]! as Timestamp,
            varientId: json.id,
            productId: json["productId"]! as String,
            productName: json["productName"]! as String,
            brand: json["brand"]! as String,
            ccd: Map<String, String>.from(json["ccd"]!),
            coo: json["coo"]! as String,
            disclaimer: json["disclaimer"]! as String,
            expiryDate: json["expiryDate"]! as String,
            features: List<String>.from(json["features"]),
            largeImageUrl: List<String>.from(json["largeImgUrl"]),
            packageType: json["packageType"]! as String,
            productClass: json["productClass"]! as String,
            seller: json["seller"]! as String,
            shelfLife: json["shelfLife"]! as String
            );

  Map<String, Object?> toJson() {
    return {
      'cost': cost,
      'discountPercentage': discountPercentage,
      'imgUrl': imgUrl,
      'maxBuy': maxBuy,
      'totalAvailable': totalAvailable,
      'totalSold': totalSold,
      'varientName': varientName,
      'createdAt': createdAt,
      'varientId': varientId,
      'productId': productId,
      'productName': productName,
      'brand': brand
    };
  }
}
