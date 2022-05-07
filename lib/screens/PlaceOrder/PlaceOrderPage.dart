import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/CartController.dart';
import 'package:grocery/screens/PlaceOrder/PlaceOrderController.dart';

class PlaceOrderPage extends StatelessWidget {
  final CartController _cartController = Get.find();
  final PlaceOrderController _placeOrderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: Dimensions.height70,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            child: Divider(
              height: 1,
              color: Color(0xffE2E2E2),
            ),
            preferredSize: Size.fromHeight(1),
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(
                color: darkBlackColor,
                fontSize: Dimensions.size20,
                fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Obx(() => _cartController.cartItems.length > 0
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.height10),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _placeOrderController.deliveryLocation != null
                        ? Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimensions.size8))),
                                padding: EdgeInsets.all(Dimensions.height8),
                                child: Icon(
                                  _placeOrderController
                                              .deliveryLocation!.addressType ==
                                          1
                                      ? Icons.work_outline
                                      : _placeOrderController.deliveryLocation!
                                                  .addressType ==
                                              2
                                          ? Icons.other_houses_outlined
                                          : Icons.home_outlined,
                                  size: Dimensions.size40,
                                  color: darkBlackColor,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width20,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "delivering to ${_placeOrderController.deliveryLocation!.receipentName}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: darkBlackColor,
                                        fontSize: Dimensions.size18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height5,
                                  ),
                                  Text(
                                    "${_placeOrderController.deliveryLocation!.houseNo}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Dimensions.size14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )),
                              SizedBox(
                                width: Dimensions.width12,
                              ),
                              TextButton(
                                  onPressed: () =>
                                      Get.toNamed("/select_delivery_address"),
                                  child: Text(
                                    "change",
                                    style: TextStyle(
                                        color: greenColor,
                                        fontSize: Dimensions.size16,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Stack(children: [
                      GestureDetector(
                        onTap: _placeOrderController.placingOrder
                            ? null
                            : _placeOrderController.proceedToCheckout,
                        child: Container(
                          height: Dimensions.height54,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _placeOrderController.placingOrder
                                  ? Colors.grey
                                  : greenColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.size14))),
                          child: Text(
                            _placeOrderController.deliveryLocation != null
                                ? "place order"
                                : "proceed",
                            style: TextStyle(
                                color: Color(0xffFCFCFC),
                                fontSize: Dimensions.size18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Positioned(
                        right: Dimensions.width60,
                        top: Dimensions.height20,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width5,
                              vertical: Dimensions.height2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.size4)),
                              color: Color(0xff489E67)),
                          child: Obx(() => Text(
                                (_cartController.getTotalAmountWithTip)
                                    .toString(),
                                style: TextStyle(
                                    color: Color(0xffFCFCFC),
                                    fontSize: Dimensions.size12,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                    ])
                  ],
                ),
              )
            : SizedBox(
                height: 0,
              )),
        body: Obx(() => _cartController.cartItems.length > 0
            ? SingleChildScrollView(
                child: Column(children: [
                  ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width22),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final _metaData = _cartController.cartItems.values
                                .toList()[index]
                                .productDetail
                                .varientName
                                .toString() +
                            ", " +
                            _cartController.cartItems.values
                                .toList()[index]
                                .productDetail
                                .brand
                                .toString();

                        final String cost = '\u{20B9}' +
                            _cartController.cartItems.values
                                .toList()[index]
                                .productDetail
                                .cost
                                .toString();

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height12),
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.width70,
                                height: Dimensions.height64,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(_cartController
                                            .cartItems.values
                                            .toList()[index]
                                            .productDetail
                                            .imgUrl),
                                        fit: BoxFit.contain)),
                              ),
                              SizedBox(
                                width: Dimensions.width12,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _cartController.cartItems.values
                                              .toList()[index]
                                              .productDetail
                                              .productName,
                                          style: TextStyle(
                                              color: darkBlackColor,
                                              fontSize: Dimensions.size16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              _cartController.removeCartItem(
                                                  _cartController.cartItems.keys
                                                      .toList()[index]),
                                          icon: Icon(Icons.close_rounded),
                                          iconSize: Dimensions.size20,
                                          color: Color(0xffB3B3B3),
                                          constraints: BoxConstraints(),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height2,
                                    ),
                                    Text(
                                      _metaData,
                                      style: TextStyle(
                                          color: Color(0xff7C7C7C),
                                          fontSize: Dimensions.size14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              _cartController.updateCartItem(
                                                  _cartController
                                                      .cartItems.values
                                                      .toList()[index]
                                                      .productDetail,
                                                  false),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: Dimensions.height32,
                                            height: Dimensions.height32,
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
                                          width: Dimensions.width26,
                                          height: Dimensions.height22,
                                          decoration: BoxDecoration(
                                              color:
                                                  greenColor.withOpacity(0.8),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.size2))),
                                          alignment: Alignment.center,
                                          child: Obx(() => Text(
                                                _cartController.cartItems.values
                                                    .toList()[index]
                                                    .quantity
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions.size14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              _cartController.updateCartItem(
                                                  _cartController
                                                      .cartItems.values
                                                      .toList()[index]
                                                      .productDetail,
                                                  true),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: Dimensions.height32,
                                            height: Dimensions.height32,
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
                                        Expanded(child: Container()),
                                        Text(
                                          cost,
                                          style: TextStyle(
                                              color: darkBlackColor,
                                              fontSize: Dimensions.size18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => Divider(
                            thickness: 1,
                            color: Color(0xffE2E2E2),
                          ),
                      itemCount: _cartController.cartItems.length),
                  Divider(
                    color: Color(0xffF0F0F0),
                    thickness: Dimensions.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "bill details",
                          style: TextStyle(
                              color: darkBlackColor,
                              fontSize: Dimensions.size20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Dimensions.height12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "MRP",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.size16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '\u{20B9}' +
                                  _cartController.getTotalAmount.toString(),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.size16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "delivery charges",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.size16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '\u{20B9}' + "25",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.size16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "bill total",
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '\u{20B9}' +
                                  _cartController.getTotalAmountWithDelivery
                                      .toString(),
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height12),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Color(0xffF0F0F0)),
                            bottom: BorderSide(
                                color: Color(0xffF0F0F0),
                                width: Dimensions.width12))),
                    child: Text(
                      "promo code can be applied on payments screen",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.size15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffF0F0F0)))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "add a tip?",
                          style: TextStyle(
                              color: darkBlackColor,
                              fontSize: Dimensions.size20,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Dimensions.width250,
                              child: Text(
                                "all tips are directly transferred to delivery partners.",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimensions.size16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              width: Dimensions.height60,
                              height: Dimensions.height60,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.size8))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height12),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Color(0xffF0F0F0)),
                            bottom: BorderSide(
                                color: Color(0xffF0F0F0),
                                width: Dimensions.width12))),
                    child: Row(
                      children: List.generate(
                          _cartController.tipAmounts.length,
                          (index) => GestureDetector(
                                onTap: () => _cartController.tipHandler(index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width12,
                                      vertical: Dimensions.height10),
                                  margin:
                                      EdgeInsets.only(left: Dimensions.width20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: index ==
                                                  _cartController
                                                      .selectedTipIndex
                                              ? greenColor
                                              : darkBlackColor),
                                      color: index ==
                                              _cartController.selectedTipIndex
                                          ? greenColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size4))),
                                  child: Text(
                                    "+" +
                                        '\u{20B9}' +
                                        _cartController.tipAmounts[index]
                                            .toString(),
                                    style: TextStyle(
                                        color: index ==
                                                _cartController.selectedTipIndex
                                            ? Colors.white
                                            : darkBlackColor,
                                        fontSize: Dimensions.size15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )),
                    ),
                  )
                ]),
              )
            : Center(
                child: Text(
                  "Your cart is empty.Add some product to your cart",
                  textAlign: TextAlign.center,
                ),
              )));
  }
}
