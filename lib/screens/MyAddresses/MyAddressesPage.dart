import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesPageController.dart';

class MyAddrressesPage extends StatelessWidget {
  final MyAddressesPageController _myAddressesPageController = Get.find();

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
          "My Addresses",
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
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width15,
                              vertical: Dimensions.height10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _myAddressesPageController
                                        .myAddresses[index].addressTypeName!,
                                    style: TextStyle(
                                        color: darkBlackColor,
                                        fontSize: Dimensions.size16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    splashColor: Colors.red.withOpacity(0.2),
                                    onPressed: () => _myAddressesPageController
                                        .removeAddress(index),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                      size: Dimensions.size20,
                                    ),
                                    padding: EdgeInsets.all(0),
                                    constraints: BoxConstraints(),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width12,
                                  ),
                                  IconButton(
                                    splashColor: greenColor.withOpacity(0.2),
                                    onPressed: () => Get.toNamed(
                                        "/add_edit_address",
                                        arguments: {
                                          "user_location":
                                              _myAddressesPageController
                                                  .myAddresses[index]
                                        }),
                                    icon: Icon(
                                      Icons.edit,
                                      color: greenColor,
                                      size: Dimensions.size20,
                                    ),
                                    padding: EdgeInsets.all(0),
                                    constraints: BoxConstraints(),
                                  )
                                ],
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
