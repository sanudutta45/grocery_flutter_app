import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/models/ProductVarientModel.dart';
import 'package:grocery/repository/ProductRepository.dart';

class CategoryController extends GetxController {
  final _gettingProducts = false.obs;
  final _gettingMoreProducts = false.obs;
  final _products = <ProductVarientModel>[].obs;
  bool _hasMoreProducts = true;
  final _scrollController = ScrollController();
  ProductVarientModel? _lastDoc;

  bool get gettingProducts => _gettingProducts.value;
  bool get gettingMoreProducts => _gettingMoreProducts.value;
  List<ProductVarientModel> get products => _products;
  ScrollController get scrollController => _scrollController;

  @override
  void onReady() {
    _getProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreProducts();
      }
    });
    super.onReady();
  }

  Future<void> _getProducts() async {
    try {
      _gettingProducts.value = true;
      _products.value = await ProductRepository.getProducts(
          limit: 10,
          discountedPerc: Get.arguments["discountedPerc"],
          categoryId: Get.arguments["categoryId"],
          totalSold: Get.arguments["totalSold"]);
      _lastDoc = products[products.length - 1];
      if (products.length < 10) _hasMoreProducts = false;
    } catch (e) {
      printError(info: e.toString());
    } finally {
      _gettingProducts.value = false;
    }
  }

  Future<void> _getMoreProducts() async {
    if (gettingMoreProducts) return;
    if (!_hasMoreProducts) return;
    try {
      _gettingMoreProducts.value = true;
      final List<ProductVarientModel> moreProductList =
          await ProductRepository.getProducts(
              limit: 10,
              startAfterDoc: _lastDoc,
              discountedPerc: Get.arguments["discountedPerc"],
              totalSold: Get.arguments["totalSold"]);
      _lastDoc = products[products.length - 1];
      if (moreProductList.length < 10) _hasMoreProducts = false;
      products.addAll(moreProductList);
    } catch (e) {
      printError(info: e.toString());
    } finally {
      _gettingMoreProducts.value = false;
    }
  }
}
