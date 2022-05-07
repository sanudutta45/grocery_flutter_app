import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String categoryName;
  final String colorCode;
  final Timestamp createdAt;
  final String imgUrl;
  final String categoryId;

  CategoryModel(
      {required this.categoryName,
      required this.colorCode,
      required this.createdAt,
      required this.imgUrl,
      required this.categoryId});

  CategoryModel.documentFromSnapshot(
      {required DocumentSnapshot documentSnapshot})
      : this(
            categoryId: documentSnapshot.id,
            categoryName: documentSnapshot["categoryName"] as String,
            colorCode: documentSnapshot["colorCode"] as String,
            createdAt: documentSnapshot["createdAt"] as Timestamp,
            imgUrl: documentSnapshot["imgUrl"] as String);
}
