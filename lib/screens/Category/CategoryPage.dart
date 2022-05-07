import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/CartController.dart';
import 'package:grocery/screens/Category/CategoryController.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController _categoryController = Get.find();

  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: Dimensions.height70,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            iconSize: Dimensions.size20,
            color: darkBlackColor,
          ),
          title: Text(
            Get.arguments['name'] ?? 'Category',
            style: TextStyle(
                fontSize: Dimensions.size20,
                fontWeight: FontWeight.bold,
                color: darkBlackColor),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.tune_rounded),
              color: darkBlackColor,
              iconSize: Dimensions.size20,
            )
          ],
        ),
        body: Obx(() => _categoryController.gettingProducts
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                controller: _categoryController.scrollController,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height10),
                crossAxisSpacing: Dimensions.width10,
                mainAxisSpacing: Dimensions.height10,
                childAspectRatio: 0.79,
                crossAxisCount: 2,
                children:
                    List.generate(_categoryController.products.length, (index) {
                  final String _metaData = _categoryController
                          .products[index].varientName
                          .toString() +
                      ", " +
                      _categoryController.products[index].brand.toString();

                  final String cost = '\u{20B9}' +
                      _categoryController.products[index].cost.toString();
                  return GestureDetector(
                    onTap: () => Get.toNamed(
                        "/product/${_categoryController.products[index].productId}"),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height15,
                            horizontal: Dimensions.width15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffE2E2E2)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.size18)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Image.network(
                                  _categoryController.products[index].imgUrl
                                      .toString(),
                                  width: Dimensions.height95,
                                  height: Dimensions.height95,
                                  fit: BoxFit.contain,
                                )),
                            SizedBox(
                              height: Dimensions.height14,
                            ),
                            Text(
                              _categoryController.products[index].productName
                                  .toString(),
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Dimensions.height3,
                            ),
                            Text(
                              _metaData,
                              style: TextStyle(
                                  color: Color(0xff7C7C7C),
                                  fontSize: Dimensions.size14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cost,
                                  style: TextStyle(
                                      color: darkBlackColor,
                                      fontSize: Dimensions.size18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Obx(() => _cartController.cartItems.containsKey(
                                        _categoryController
                                            .products[index].varientId)
                                    ? Row(
                                        children: [
                                          InkWell(
                                            onTap: () =>
                                                _cartController.updateCartItem(
                                                    _categoryController
                                                        .products[index],
                                                    false),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: Dimensions.height30,
                                              height: Dimensions.height30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xffF0F0F0),
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Dimensions.size8))),
                                              child: Icon(
                                                Icons.remove,
                                                color: Color(0xffB3B3B3),
                                                size: Dimensions.size20,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Dimensions.width20,
                                            height: Dimensions.height22,
                                            decoration: BoxDecoration(
                                                color:
                                                    greenColor.withOpacity(0.8),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Dimensions.size2))),
                                            alignment: Alignment.center,
                                            child: Text(
                                              _cartController
                                                  .cartItems[_categoryController
                                                      .products[index]
                                                      .varientId]!
                                                  .quantity
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Dimensions.size12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () =>
                                                _cartController.updateCartItem(
                                                    _categoryController
                                                        .products[index],
                                                    true),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: Dimensions.height30,
                                              height: Dimensions.height30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xffF0F0F0),
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Dimensions.size8))),
                                              child: Icon(
                                                Icons.add,
                                                color: greenColor,
                                                size: Dimensions.size20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () =>
                                            _cartController.updateCartItem(
                                                _categoryController
                                                    .products[index],
                                                true),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: Dimensions.height30,
                                          height: Dimensions.height30,
                                          decoration: BoxDecoration(
                                              color: Color(0xff53B175),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.size10))),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: Dimensions.size18,
                                          ),
                                        ),
                                      ))
                              ],
                            )
                          ],
                        )),
                  );
                }),
              )));
  }
}
