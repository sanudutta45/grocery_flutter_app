import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/AuthController.dart';
import 'package:grocery/mixins/validationMixins.dart';

class NumberLoginPage extends StatefulWidget {
  NumberLoginPage({Key? key}) : super(key: key);

  @override
  _NumberLoginState createState() => _NumberLoginState();
}

class _NumberLoginState extends State<NumberLoginPage>
    with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();

  bool showSubmitButton = false;
  late TextEditingController phoneNumberController;

  void _toggleSubmitButton(bool flag) {
    setState(() {
      showSubmitButton = flag;
    });
  }

  final AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();

    phoneNumberController = TextEditingController();

    phoneNumberController.addListener(() {
      final bool isButtonActive =
          isPhoneNumberValid(phoneNumberController.text) ? true : false;
      _toggleSubmitButton(isButtonActive);
    });
  }

  @override
  void dispose() {
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/ranbow_bg.png"),
                fit: BoxFit.cover)),
      ),
      Scaffold(
        backgroundColor: Color(0xffFCFCFC).withOpacity(0),
        resizeToAvoidBottomInset: true,
        floatingActionButton: Visibility(
          visible: showSubmitButton,
          child: Container(
            width: Dimensions.height67,
            height: Dimensions.height67,
            child: Obx(() => RawMaterialButton(
                  fillColor:
                      _authController.isSending ? Colors.grey : greenColor,
                  onPressed: () => _authController.isSending
                      ? null
                      : _authController
                          .phoneNumberAuth(phoneNumberController.text),
                  shape: CircleBorder(),
                  elevation: 0.0,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffFCFCFC).withOpacity(0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: darkBlackColor,
            iconSize: Dimensions.size20,
            onPressed: () => Get.back(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Dimensions.height20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your mobile number",
                  style: TextStyle(
                      color: darkBlackColor,
                      fontSize: Dimensions.size26,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: Dimensions.height40,
                ),
                Text(
                  "Mobile Number",
                  style: TextStyle(
                      height: 0.4,
                      color: Color(0xff7C7C7C),
                      fontSize: Dimensions.size14,
                      fontWeight: FontWeight.w600),
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneNumberController,
                    maxLength: 10,
                    //  textInputAction: TextInputAction.unspecified,
                    cursorColor: Color(0xffE2E2E2),
                    autofocus: true,
                    style: TextStyle(
                        color: darkBlackColor,
                        fontSize: Dimensions.size18,
                        fontWeight: FontWeight.normal),
                    enabled: true,
                    decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenColor)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffE2E2E2),
                              width: Dimensions.width1,
                              style: BorderStyle.solid)),
                      prefixIconConstraints: BoxConstraints(),
                      prefixIcon: Container(
                        width: Dimensions.width80,
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.width33e97,
                              height: Dimensions.height23e7,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/india.png"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Text(
                              "+91",
                              style: TextStyle(
                                  color: darkBlackColor,
                                  fontSize: Dimensions.size18,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
