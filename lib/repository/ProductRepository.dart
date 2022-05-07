import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/constants/firebase.dart';
import 'package:grocery/models/ProductVarientModel.dart';

class ProductRepository {
  static final _productsCollectionRef =
      FirebaseConstants.firebaseFirestore.collection('productVarients');

  static Future<List<ProductVarientModel>> getProducts(
      {required int limit,
      String? categoryId,
      ProductVarientModel? startAfterDoc,
      double? discountedPerc,
      int? totalSold}) async {
    Query query = _productsCollectionRef;

    if (categoryId != null)
      query = query.where("categoryId", isEqualTo: categoryId);

    if (discountedPerc != null)
      query = query
          .where("discountPercentage", isGreaterThanOrEqualTo: discountedPerc)
          .orderBy("discountPercentage");

    if (totalSold != null)
      query = query
          .where("totalSold", isGreaterThanOrEqualTo: totalSold)
          .orderBy("totalSold");

    query = query.orderBy("createdAt", descending: true);

    if (startAfterDoc != null) {
      var startOverList = [];

      if (discountedPerc != null)
        startOverList.add(startAfterDoc.discountPercentage);
      if (totalSold != null) startOverList.add(startAfterDoc.totalSold);
      startOverList.add(startAfterDoc.createdAt);
      query = query.startAfter(startOverList);
    }

    List<ProductVarientModel> products = [];
    try {
      await query.limit(limit).get().then((QuerySnapshot query) {
        for (var product in query.docs) {
          final productModel =
              ProductVarientModel.fromJson(product);
          products.add(productModel);
        }
      });
    } catch (error) {
      print(error);
    }

    return products;
  }

  static Future<List<ProductVarientModel>> getProductByProductId(
      String productId) async {
    List<ProductVarientModel> products = [];
    try {
      await _productsCollectionRef
          .where("productId", isEqualTo: productId)
          .get()
          .then((QuerySnapshot query) {
        for (var product in query.docs) {
          final productModel =
              ProductVarientModel.fromJson(product);
          products.add(productModel);
        }
      });
    } catch (error) {
      print("error in repo $error");
    }

    return products;
  }
}
