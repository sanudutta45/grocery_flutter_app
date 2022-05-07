import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/CartController.dart';
import 'package:grocery/globalController/CurrentLocationController.dart';
import 'package:grocery/screens/Home/HomeController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.find();

  final CurrentLocationController _locationController = Get.find();

  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _homeController.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              SizedBox(
                height: Dimensions.height30,
              ),
              Container(
                width: Dimensions.width26,
                height: Dimensions.height30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/carrot.png"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: Dimensions.height5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: Dimensions.size18,
                    ),
                    SizedBox(
                      width: Dimensions.width5,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed("/search_location", arguments: {
                        'callback': _homeController.onLocationSelected
                      }),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Deliver To",
                            style: TextStyle(
                                color: Color(0xff4C4F4D),
                                fontSize: Dimensions.size18,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: Dimensions.width3,
                          ),
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: Dimensions.width250),
                            child: Obx(() => Text(
                                _locationController.currentLocation!.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    color: Color(0xff4C4F4D),
                                    fontSize: Dimensions.size18,
                                    fontWeight: FontWeight.bold))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height12),
                width: MediaQuery.of(context).size.width,
                height: Dimensions.height150,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Obx(() => CarouselSlider.builder(
                            itemCount: _homeController.banners.length,
                            options: CarouselOptions(
                                height: Dimensions.height150,
                                autoPlay: true,
                                viewportFraction: 1,
                                onPageChanged: (index, _) {
                                  _homeController.setBannerIndex(index);
                                }),
                            itemBuilder: (_, index, __) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(_homeController
                                            .banners[index].bannerUrl),
                                        fit: BoxFit.cover)),
                              );
                            },
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: Dimensions.height5),
                        child: Obx(() => AnimatedSmoothIndicator(
                              effect: ExpandingDotsEffect(
                                radius: Dimensions.size3,
                                dotWidth: Dimensions.width6,
                                dotHeight: Dimensions.height6,
                                dotColor: Color(0xff030303).withOpacity(0.3),
                                activeDotColor: greenColor,
                              ),
                              activeIndex: _homeController.currentBanner,
                              count: _homeController.banners.length,
                            )),
                      ),
                    ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width15,
                            right: Dimensions.width15,
                            bottom: Dimensions.height15,
                            top: Dimensions.height10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Best Selling",
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size24,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () => Get.toNamed("/category", arguments: {
                                "name": "Best Selling",
                                "totalSold": 45
                              }),
                              child: Text(
                                "See all",
                                style: TextStyle(
                                    color: greenColor,
                                    fontSize: Dimensions.size16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height230,
                        child: Obx(() => ListView.builder(
                            padding: EdgeInsets.only(left: Dimensions.width15),
                            itemCount: _homeController.bestSellingItems.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              final String _metaData = _homeController
                                      .bestSellingItems[index].varientName
                                      .toString() +
                                  ", " +
                                  _homeController.bestSellingItems[index].brand
                                      .toString();

                              final String cost = '\u{20B9}' +
                                  _homeController.bestSellingItems[index].cost
                                      .toInt()
                                      .toString();

                              return GestureDetector(
                                onTap: () => Get.toNamed(
                                    "/product/${_homeController.bestSellingItems[index].productId}"),
                                child: Container(
                                    width: Dimensions.width190,
                                    height: Dimensions.height230,
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height20,
                                        left: Dimensions.width10,
                                        right: Dimensions.width15,
                                        bottom: Dimensions.height15),
                                    margin: EdgeInsets.only(
                                        right: Dimensions.width15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xffE2E2E2),
                                          width: Dimensions.width1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size18)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              _homeController
                                                  .bestSellingItems[index]
                                                  .imgUrl,
                                              height: Dimensions.height95,
                                              width: Dimensions.height95,
                                            )),
                                        SizedBox(
                                          height: Dimensions.height18,
                                        ),
                                        Text(
                                          _homeController
                                              .bestSellingItems[index]
                                              .productName,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              cost,
                                              style: TextStyle(
                                                  color: darkBlackColor,
                                                  fontSize: Dimensions.size18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Obx(() => _cartController.cartItems
                                                    .containsKey(_homeController
                                                        .bestSellingItems[index]
                                                        .varientId)
                                                ? Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () => _cartController
                                                            .updateCartItem(
                                                                _homeController
                                                                        .bestSellingItems[
                                                                    index],
                                                                false),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: Dimensions
                                                              .height30,
                                                          height: Dimensions
                                                              .height30,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xffF0F0F0),
                                                                  width: 1,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid),
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      Dimensions
                                                                          .size8))),
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Color(
                                                                0xffB3B3B3),
                                                            size: Dimensions
                                                                .size20,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            Dimensions.width20,
                                                        height:
                                                            Dimensions.height22,
                                                        decoration: BoxDecoration(
                                                            color: greenColor
                                                                .withOpacity(
                                                                    0.8),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    Dimensions
                                                                        .size2))),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          _cartController
                                                              .cartItems[
                                                                  _homeController
                                                                      .bestSellingItems[
                                                                          index]
                                                                      .varientId]!
                                                              .quantity
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  Dimensions
                                                                      .size12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () => _cartController
                                                            .updateCartItem(
                                                                _homeController
                                                                        .bestSellingItems[
                                                                    index],
                                                                true),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: Dimensions
                                                              .height30,
                                                          height: Dimensions
                                                              .height30,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xffF0F0F0),
                                                                  width: 1,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid),
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      Dimensions
                                                                          .size8))),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: greenColor,
                                                            size: Dimensions
                                                                .size20,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : InkWell(
                                                    onTap: () => _cartController
                                                        .updateCartItem(
                                                            _homeController
                                                                    .bestSellingItems[
                                                                index],
                                                            true),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          Dimensions.height30,
                                                      height:
                                                          Dimensions.height30,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff53B175),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      Dimensions
                                                                          .size10))),
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
                            })),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width15,
                            right: Dimensions.width15,
                            bottom: Dimensions.height15,
                            top: Dimensions.height20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Exclusive Offers",
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size24,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () => Get.toNamed("/category", arguments: {
                                "name": "Exclusive Offers",
                                "discountedPerc": 30.0
                              }),
                              child: Text(
                                "See all",
                                style: TextStyle(
                                    color: greenColor,
                                    fontSize: Dimensions.size16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height230,
                        margin: EdgeInsets.only(bottom: Dimensions.height15),
                        child: (ListView.builder(
                            padding: EdgeInsets.only(left: Dimensions.width15),
                            itemCount: _homeController.exclusiveItems.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Obx(() {
                                final String _metaData = _homeController
                                        .exclusiveItems[index].varientName
                                        .toString() +
                                    ", " +
                                    _homeController.exclusiveItems[index].brand
                                        .toString();

                                final String cost = '\u{20B9}' +
                                    _homeController.exclusiveItems[index].cost
                                        .toInt()
                                        .toString();

                                return GestureDetector(
                                  onTap: () => Get.toNamed(
                                      "/product/${_homeController.exclusiveItems[index].productId}"),
                                  child: Container(
                                      width: Dimensions.width190,
                                      height: Dimensions.height230,
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height20,
                                          left: Dimensions.width15,
                                          right: Dimensions.width15,
                                          bottom: Dimensions.height15),
                                      margin: EdgeInsets.only(
                                          right: Dimensions.width15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xffE2E2E2),
                                            width: Dimensions.width1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.size18)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                _homeController
                                                    .exclusiveItems[index]
                                                    .imgUrl,
                                                width: Dimensions.height95,
                                                height: Dimensions.height95,
                                                fit: BoxFit.contain,
                                              )),
                                          SizedBox(
                                            height: Dimensions.height18,
                                          ),
                                          Text(
                                            _homeController
                                                .exclusiveItems[index]
                                                .productName,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cost,
                                                style: TextStyle(
                                                    color: darkBlackColor,
                                                    fontSize: Dimensions.size18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              _cartController.cartItems
                                                      .containsKey(
                                                          _homeController
                                                              .exclusiveItems[
                                                                  index]
                                                              .varientId)
                                                  ? Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () => _cartController
                                                              .updateCartItem(
                                                                  _homeController
                                                                          .exclusiveItems[
                                                                      index],
                                                                  false),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: Dimensions
                                                                .height30,
                                                            height: Dimensions
                                                                .height30,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xffF0F0F0),
                                                                    width: 1,
                                                                    style: BorderStyle
                                                                        .solid),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        Dimensions
                                                                            .size8))),
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: Color(
                                                                  0xffB3B3B3),
                                                              size: Dimensions
                                                                  .size20,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: Dimensions
                                                              .width20,
                                                          height: Dimensions
                                                              .height22,
                                                          decoration: BoxDecoration(
                                                              color: greenColor
                                                                  .withOpacity(
                                                                      0.8),
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      Dimensions
                                                                          .size2))),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            _cartController
                                                                .cartItems[_homeController
                                                                    .exclusiveItems[
                                                                        index]
                                                                    .varientId]!
                                                                .quantity
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    Dimensions
                                                                        .size12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () => _cartController
                                                              .updateCartItem(
                                                                  _homeController
                                                                          .exclusiveItems[
                                                                      index],
                                                                  true),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: Dimensions
                                                                .height30,
                                                            height: Dimensions
                                                                .height30,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xffF0F0F0),
                                                                    width: 1,
                                                                    style: BorderStyle
                                                                        .solid),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        Dimensions
                                                                            .size8))),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: greenColor,
                                                              size: Dimensions
                                                                  .size20,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : InkWell(
                                                      onTap: () => _cartController
                                                          .updateCartItem(
                                                              _homeController
                                                                      .exclusiveItems[
                                                                  index],
                                                              true),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width:
                                                            Dimensions.height30,
                                                        height:
                                                            Dimensions.height30,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xff53B175),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    Dimensions
                                                                        .size10))),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size:
                                                              Dimensions.size18,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      )),
                                );
                              });
                            })),
                      ),
                    ],
                  ),
                ),
              )
            ]);
    });
  }
}
