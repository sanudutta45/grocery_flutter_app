import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesPageController.dart';
import 'package:grocery/screens/PlaceOrder/PlaceOrderController.dart';

class SelectDeliveryAddressPage extends StatelessWidget {
  final MyAddressesPageController _myAddressesPageController = Get.find();
  final PlaceOrderController _placeOrderController = Get.find();

  _onSelectSavedAddress(LocationModel location) {
    _placeOrderController.setDeliveryAddress(location);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height70,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            iconSize: Dimensions.size20,
            color: darkBlackColor,
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        bottom: PreferredSize(
          child: Divider(
            height: 1,
            thickness: Dimensions.height2,
            color: Color(0xffE2E2E2),
          ),
          preferredSize: Size.fromHeight(1),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Select Address",
          style: TextStyle(
              color: darkBlackColor,
              fontSize: Dimensions.size20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => Get.toNamed("/add_edit_address"),
            child: Container(
              padding: EdgeInsets.all(Dimensions.height15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5))),
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline_rounded,
                    size: Dimensions.size24,
                    color: greenColor,
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Text(
                    "Add new address",
                    style: TextStyle(
                        color: darkBlackColor,
                        fontSize: Dimensions.size16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Obx(() => _myAddressesPageController.myAddresses.length >=
                      0
                  ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => _onSelectSavedAddress(
                              _myAddressesPageController.myAddresses[index]),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width15,
                                vertical: Dimensions.height10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _myAddressesPageController
                                      .myAddresses[index].addressTypeName!,
                                  style: TextStyle(
                                      color: darkBlackColor,
                                      fontSize: Dimensions.size16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  _myAddressesPageController
                                      .myAddresses[index].receipentName!,
                                  style: TextStyle(
                                      color: darkBlackColor.withOpacity(0.6),
                                      fontSize: Dimensions.size15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  _myAddressesPageController
                                      .myAddresses[index].houseNo!,
                                  style: TextStyle(
                                      color: darkBlackColor.withOpacity(0.6),
                                      fontSize: Dimensions.size15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  _myAddressesPageController
                                      .myAddresses[index].street!,
                                  style: TextStyle(
                                      color: darkBlackColor.withOpacity(0.6),
                                      fontSize: Dimensions.size15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  _myAddressesPageController
                                      .myAddresses[index].location,
                                  style: TextStyle(
                                      color: darkBlackColor.withOpacity(0.6),
                                      fontSize: Dimensions.size15,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _myAddressesPageController.myAddresses.length)
                  : SizedBox(
                      height: 0,
                    )))
        ],
      ),
    );
  }
}
