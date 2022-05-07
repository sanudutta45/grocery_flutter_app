import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesPageController.dart';
import 'package:grocery/screens/SearchLocation/SearchLocationController.dart';

class SearchLocationPage extends StatelessWidget {
  final SearchLocationController controller = Get.find();
  final MyAddressesPageController _myAddressesPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: Dimensions.width15,
                  left: Dimensions.width15,
                  top: Dimensions.height15),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.size10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 1),
                      blurRadius: Dimensions.size12,
                    )
                  ]),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.keyboard_backspace_rounded,
                      size: Dimensions.size30,
                    ),
                    color: darkBlackColor.withOpacity(0.9),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.locationSearchController,
                      focusNode: controller.focus,
                      onChanged: (text) => controller.setLocationSearch(text),
                      keyboardType: TextInputType.text,
                      cursorColor: Color(0xffE2E2E2),
                      style: TextStyle(fontSize: Dimensions.size20),
                      decoration: InputDecoration(
                        hintText: "search for delivery location",
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Obx(() => controller.showCloseIcon
                      ? IconButton(
                          onPressed: () => controller.clearQuery(),
                          icon: Icon(Icons.close_rounded),
                          iconSize: Dimensions.size30,
                          color: Colors.grey.withOpacity(0.9),
                        )
                      : SizedBox(
                          width: 0,
                        ))
                ],
              ),
            ),
            Obx(() => !controller.showCloseIcon
                ? Expanded(
                    child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.my_location_outlined,
                              color: greenColor,
                              size: Dimensions.size22,
                            ),
                            SizedBox(
                              width: Dimensions.width8,
                            ),
                            TextButton(
                              onPressed: () => controller.setCurrentLocation(),
                              child: Text(
                                "use my current location",
                                style: TextStyle(
                                    color: greenColor,
                                    fontSize: Dimensions.size18,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (_myAddressesPageController.myAddresses.length > 0)
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.maxFinite,
                                color: Colors.grey.withOpacity(0.2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Text(
                                  "SAVED ADDRESSES",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.size16,
                                      color: darkGreyColor),
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (_, index) {
                                        return GestureDetector(
                                          onTap: () =>
                                              controller.setSavedLocation(
                                                  _myAddressesPageController
                                                      .myAddresses[index]),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width15,
                                                vertical: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.grey))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _myAddressesPageController
                                                      .myAddresses[index]
                                                      .addressTypeName!,
                                                  style: TextStyle(
                                                      color: darkBlackColor,
                                                      fontSize:
                                                          Dimensions.size16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  _myAddressesPageController
                                                      .myAddresses[index]
                                                      .receipentName!,
                                                  style: TextStyle(
                                                      color: darkBlackColor
                                                          .withOpacity(0.6),
                                                      fontSize:
                                                          Dimensions.size15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  _myAddressesPageController
                                                      .myAddresses[index]
                                                      .houseNo!,
                                                  style: TextStyle(
                                                      color: darkBlackColor
                                                          .withOpacity(0.6),
                                                      fontSize:
                                                          Dimensions.size15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  _myAddressesPageController
                                                      .myAddresses[index]
                                                      .street!,
                                                  style: TextStyle(
                                                      color: darkBlackColor
                                                          .withOpacity(0.6),
                                                      fontSize:
                                                          Dimensions.size15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  _myAddressesPageController
                                                      .myAddresses[index]
                                                      .location,
                                                  style: TextStyle(
                                                      color: darkBlackColor
                                                          .withOpacity(0.6),
                                                      fontSize:
                                                          Dimensions.size15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: _myAddressesPageController
                                          .myAddresses.length))
                            ],
                          ),
                        )
                    ],
                  ))
                : SizedBox(
                    width: 0,
                  )),
            Obx(() => !controller.isServiceAvailable
                ? buildDeliveryNotAvailable()
                : !controller.isLoading && controller.locations.length > 0
                    ? Expanded(
                        child: ListView.builder(
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () => controller.setLocation(index),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.height15,
                                  left: Dimensions.width15,
                                  right: Dimensions.width15),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(Dimensions.height12),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.size10))),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      size: Dimensions.size28,
                                      color: darkBlackColor.withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width15,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.locations[index].title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: darkBlackColor,
                                              fontSize: Dimensions.size18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height2,
                                        ),
                                        Text(
                                          controller.locations[index].location,
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              fontSize: Dimensions.size16,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: controller.locations.length,
                      ))
                    : controller.isLoading
                        ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: CircularProgressIndicator(),
                        )
                        : SizedBox(width: 0)),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryNotAvailable() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/notDeliverable.jpg",
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Text(
              "Delivery to",
              style:
                  TextStyle(color: darkBlackColor, fontSize: Dimensions.size24),
            ),
            SizedBox(
              height: Dimensions.height12,
            ),
            Obx(() => Text(
                  controller.locationInputValue.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: darkBlackColor,
                      fontSize: Dimensions.size24,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: Dimensions.height12,
            ),
            Text(
              "not available",
              style:
                  TextStyle(color: darkBlackColor, fontSize: Dimensions.size24),
            )
          ],
        ),
      ),
    );
  }
}
