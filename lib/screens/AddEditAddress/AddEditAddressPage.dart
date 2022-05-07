import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/screens/AddEditAddress/AddEditAddressPageController.dart';

class AddEditAddressPage extends StatelessWidget {
  final AddEditAddressPageController _addAddressPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height70,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          iconSize: Dimensions.size20,
          color: darkBlackColor,
        ),
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
          _addAddressPageController.editMode ? "Edit Address" : "Add Address",
          style: TextStyle(
              color: darkBlackColor,
              fontSize: Dimensions.size20,
              fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: Dimensions.height85,
        padding: EdgeInsets.all(Dimensions.height15),
        child: Obx(() => GestureDetector(
              onTap: _addAddressPageController.isSaving
                  ? null
                  : _addAddressPageController.handleSubmit,
              child: Container(
                padding: EdgeInsets.all(Dimensions.height12),
                width: double.maxFinite,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _addAddressPageController.isSaving
                        ? Colors.grey
                        : greenColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.size19))),
                child: Text(
                  _addAddressPageController.editMode ? "update address" : "save address",
                  style: TextStyle(
                      color: Color(0xffFCFCFC),
                      fontSize: Dimensions.size18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: Dimensions.size44,
                    color: darkBlackColor,
                  ),
                  SizedBox(
                    width: Dimensions.width5,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              _addAddressPageController.formData!.title
                                  .toString(),
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size18,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          height: Dimensions.height4,
                        ),
                        Obx(() => Text(
                              _addAddressPageController.formData!.location,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.size14,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width5,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed("/search_location", arguments: {
                      'callback': _addAddressPageController.onLocationSelected
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(Dimensions.height5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.size5))),
                      child: Text(
                        "Change",
                        style: TextStyle(
                            color: greenColor,
                            fontSize: Dimensions.size14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Divider(thickness: 1),
              Form(
                  key: _addAddressPageController.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _addAddressPageController.editMode
                            ? _addAddressPageController.formData!.houseNo
                            : "",
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xffE2E2E2),
                        style: TextStyle(
                            color: darkBlackColor,
                            fontSize: Dimensions.size18,
                            fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: "house no / flat no / floor / tower",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: greenColor)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffE2E2E2),
                                  width: Dimensions.width1,
                                  style: BorderStyle.solid)),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? "" : null,
                        onSaved: (value) =>
                            _addAddressPageController.formData!.houseNo = value,
                      ),
                      SizedBox(
                        height: Dimensions.height18,
                      ),
                      TextFormField(
                        initialValue: _addAddressPageController.editMode
                            ? _addAddressPageController.formData!.street
                            : "",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xffE2E2E2),
                        style: TextStyle(
                            color: darkBlackColor,
                            fontSize: Dimensions.size18,
                            fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: "street / society / landmark",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: greenColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffE2E2E2),
                                  width: Dimensions.width1,
                                  style: BorderStyle.solid)),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? "" : null,
                        onSaved: (value) =>
                            _addAddressPageController.formData!.street = value,
                      ),
                      SizedBox(
                        height: Dimensions.height18,
                      ),
                      TextFormField(
                        initialValue: _addAddressPageController.editMode
                            ? _addAddressPageController.formData!.receipentName
                            : "",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xffE2E2E2),
                        style: TextStyle(
                            color: darkBlackColor,
                            fontSize: Dimensions.size18,
                            fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: "recipient's name",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: greenColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffE2E2E2),
                                  width: Dimensions.width1,
                                  style: BorderStyle.solid)),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? "" : null,
                        onSaved: (value) => _addAddressPageController
                            .formData!.receipentName = value,
                      ),
                      SizedBox(
                        height: Dimensions.height18,
                      ),
                      TextFormField(
                        initialValue: _addAddressPageController.editMode
                            ? _addAddressPageController
                                    .formData!.receipentNumber ??
                                ""
                            : "",
                        keyboardType: TextInputType.text,
                        cursorColor: Color(0xffE2E2E2),
                        style: TextStyle(
                            color: darkBlackColor,
                            fontSize: Dimensions.size18,
                            fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: "recipient's phone number (optional)",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: greenColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffE2E2E2),
                                  width: Dimensions.width1,
                                  style: BorderStyle.solid)),
                        ),
                        onSaved: (value) => _addAddressPageController
                            .formData!.receipentNumber = value,
                      ),
                      SizedBox(
                        height: Dimensions.height23e7,
                      ),
                      Row(
                        children: List.generate(
                            _addAddressPageController.addressTypes.length,
                            (index) {
                          return GestureDetector(
                            onTap: () => _addAddressPageController
                                .setActiveAddressType(index),
                            child: Obx(() => Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10),
                                  padding: EdgeInsets.all(Dimensions.height8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: index ==
                                                  _addAddressPageController
                                                      .activeAddressType
                                              ? greenColor
                                              : Colors.grey),
                                      color: index ==
                                              _addAddressPageController
                                                  .activeAddressType
                                          ? greenColor
                                          : null,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size5))),
                                  child: Text(
                                    _addAddressPageController
                                        .addressTypes[index]["name"],
                                    style: TextStyle(
                                        color: index ==
                                                _addAddressPageController
                                                    .activeAddressType
                                            ? Colors.white
                                            : Colors.grey,
                                        fontSize: Dimensions.size14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          );
                        }),
                      ),
                      SizedBox(
                        height: Dimensions.height18,
                      ),
                      Obx(() => _addAddressPageController.showOption
                          ? TextFormField(
                              initialValue: _addAddressPageController.editMode
                                  ? _addAddressPageController
                                      .formData!.addressTypeName
                                  : "",
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffE2E2E2),
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size18,
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                hintText: "e.g. home name",
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: greenColor)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffE2E2E2),
                                        width: Dimensions.width1,
                                        style: BorderStyle.solid)),
                              ),
                              validator: (value) =>
                                  _addAddressPageController.showOption &&
                                          (value == null || value.isEmpty)
                                      ? ""
                                      : null,
                              onSaved: (value) => _addAddressPageController
                                  .formData!.addressTypeName = value,
                            )
                          : SizedBox(
                              height: 0,
                            ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
