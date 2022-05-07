import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/CartController.dart';
import 'package:grocery/screens/ProductPage/ProductPageController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool favorite = false;

  void _setFavorite() {
    setState(() => favorite = !favorite);
  }

  final ProductPageController _productPageController = Get.find();
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height70,
        backgroundColor: lightGreyColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: Dimensions.size20,
          color: darkBlackColor,
        ),
        actions: [
          IconButton(
            onPressed: () => _setFavorite(),
            icon: Icon(
                favorite ? Icons.favorite : Icons.favorite_border_outlined),
            color: favorite ? greenColor : darkGreyColor,
            iconSize: Dimensions.size28,
          )
        ],
      ),
      body: Obx(() => _productPageController.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimensions.height250,
                    color: lightGreyColor,
                    child: PageView.builder(
                      itemCount: _productPageController
                          .productVarients[
                              _productPageController.selectedVarient]
                          .largeImageUrl!
                          .length,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) =>
                          _productPageController.setActiveBanner(index),
                      itemBuilder: (_, index) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15),
                            child: Image.network(
                              _productPageController
                                      .productVarients[_productPageController
                                          .selectedVarient]
                                      .largeImageUrl![
                                  _productPageController.activeBanner],
                              fit: BoxFit.contain,
                            ));
                      },
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height20),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: lightGreyColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimensions.size20),
                            bottomRight: Radius.circular(Dimensions.size20))),
                    child: AnimatedSmoothIndicator(
                      effect: ExpandingDotsEffect(
                        radius: Dimensions.size3,
                        dotWidth: Dimensions.width6,
                        dotHeight: Dimensions.height6,
                        dotColor: Color(0xff030303).withOpacity(0.3),
                        activeDotColor: greenColor,
                      ),
                      activeIndex: _productPageController.activeBanner,
                      count: _productPageController
                          .productVarients[
                              _productPageController.selectedVarient]
                          .largeImageUrl!
                          .length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15,
                        vertical: Dimensions.height25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _productPageController
                                  .productVarients[
                                      _productPageController.selectedVarient]
                                  .productName,
                              maxLines: 1,
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size22,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _productPageController
                                  .productVarients[
                                      _productPageController.selectedVarient]
                                  .varientName,
                              maxLines: 1,
                              style: TextStyle(
                                  color: darkGreyColor,
                                  fontSize: Dimensions.size16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: Dimensions.height8,
                            ),
                            Text(
                                "\u{20B9} ${_productPageController.productVarients[_productPageController.selectedVarient].cost}",
                                maxLines: 1,
                                style: TextStyle(
                                    color: darkBlackColor,
                                    fontSize: Dimensions.size18,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        _cartController.cartItems.containsKey(
                                _productPageController
                                    .productVarients[
                                        _productPageController.selectedVarient]
                                    .varientId)
                            ? Row(
                                children: [
                                  InkWell(
                                    onTap: () => _cartController.updateCartItem(
                                        _productPageController.productVarients[
                                            _productPageController
                                                .selectedVarient],
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
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
                                        color: greenColor.withOpacity(0.8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.size2))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _cartController
                                          .cartItems[_productPageController
                                              .productVarients[
                                                  _productPageController
                                                      .selectedVarient]
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
                                    onTap: () => _cartController.updateCartItem(
                                        _productPageController.productVarients[
                                            _productPageController
                                                .selectedVarient],
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
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
                            : GestureDetector(
                                onTap: () => _cartController.updateCartItem(
                                    _productPageController.productVarients[
                                        _productPageController.selectedVarient],
                                    true),
                                child: Container(
                                  width: Dimensions.width100,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: darkGreyColor,
                                            blurRadius: Dimensions.height2,
                                            spreadRadius: -Dimensions.height2,
                                            offset:
                                                Offset(0, Dimensions.height4))
                                      ],
                                      border: Border.all(
                                          width: Dimensions.height1,
                                          color: darkGreyColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.height5))),
                                  child: Text(
                                    "add",
                                    style: TextStyle(
                                        color: greenColor,
                                        fontSize: Dimensions.size16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width15,
                        right: Dimensions.height15,
                        bottom: Dimensions.height25),
                    child: Row(
                      children: List.generate(
                          _productPageController.productVarients.length,
                          (i) => Padding(
                                padding:
                                    EdgeInsets.only(right: Dimensions.width10),
                                child: GestureDetector(
                                  onTap: () =>
                                      _productPageController.toggleVarient(i),
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(Dimensions.height12),
                                    width: MediaQuery.of(context).size.width *
                                            0.25 -
                                        Dimensions.width10,
                                    decoration: BoxDecoration(
                                        color: _productPageController
                                                    .selectedVarient ==
                                                i
                                            ? greenColor.withOpacity(0.2)
                                            : lightGreyColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.size10))),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: Dimensions.height22,
                                          height: Dimensions.height22,
                                          padding: EdgeInsets.all(
                                              Dimensions.height3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: greenColor,
                                                  width: Dimensions.height2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.size11))),
                                          child: _productPageController
                                                      .selectedVarient ==
                                                  i
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: greenColor),
                                                )
                                              : null,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Text(
                                            _productPageController
                                                .productVarients[i].varientName,
                                            style: TextStyle(
                                                color: darkBlackColor,
                                                fontSize: Dimensions.size16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: Dimensions.height5,
                                        ),
                                        Text(
                                            _productPageController
                                                .productVarients[i].cost
                                                .toString(),
                                            style: TextStyle(
                                                color: darkBlackColor,
                                                fontSize: Dimensions.size16,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  if (_productPageController.showDetails)
                    productDetailsBuilder(),
                  Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width15,
                          right: Dimensions.width15,
                          bottom: Dimensions.height12),
                      child: GestureDetector(
                        onTap: () => _productPageController.toggleShowDetails(),
                        child: Row(
                          children: [
                            Text(
                                !_productPageController.showDetails
                                    ? "product details"
                                    : "read less",
                                style: TextStyle(
                                    color: greenColor,
                                    fontSize: Dimensions.size14,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(width: Dimensions.width2),
                            Icon(
                              !_productPageController.showDetails
                                  ? Icons.keyboard_arrow_down_outlined
                                  : Icons.keyboard_arrow_up_outlined,
                              color: greenColor,
                              size: Dimensions.size20,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            )),
    );
  }

  Widget productDetailsBuilder() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("product details",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size22,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height15,
          ),
          Text("Key Features",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          ...List.generate(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .features!
                  .length,
              (index) => Text(
                  _productPageController
                      .productVarients[_productPageController.selectedVarient]
                      .features![index],
                  maxLines: 1,
                  style: TextStyle(
                      color: darkBlackColor,
                      fontSize: Dimensions.size16,
                      fontWeight: FontWeight.normal))),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Unit",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .varientName,
              maxLines: 1,
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Packaging Type",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .packageType
                  .toString(),
              maxLines: 1,
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Shelf Life",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .shelfLife
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Disclaimer",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .disclaimer
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Country of Origin",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient].coo
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Customer Care Details",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .ccd!["number"]
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .ccd!["emailId"]
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Product Class",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .productClass
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Seller",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .seller
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
          SizedBox(
            height: Dimensions.height8,
          ),
          Text("Expiry Date",
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: Dimensions.height4,
          ),
          Text(
              _productPageController
                  .productVarients[_productPageController.selectedVarient]
                  .expiryDate
                  .toString(),
              style: TextStyle(
                  color: darkBlackColor,
                  fontSize: Dimensions.size16,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
