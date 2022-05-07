import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFCFC),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login.png"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                top: Dimensions.height25,
                left: Dimensions.width5,
                child: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.grey,
                      size: Dimensions.size44,
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get you groceries",
                  style: TextStyle(
                      color: darkBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.size26),
                ),
                SizedBox(
                  height: Dimensions.height6,
                ),
                Text(
                  "with nectar",
                  style: TextStyle(
                      color: darkBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.size26),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Get.toNamed("/number_login"),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height15),
                    margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xffE2E2E2),
                                width: Dimensions.width1,
                                style: BorderStyle.solid))),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.width33e97,
                          height: Dimensions.height23e7,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/india.png"),
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
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Or connect with socia media",
                    style: TextStyle(
                        color: Color(0xff828282),
                        fontSize: Dimensions.size14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  margin: EdgeInsets.only(top: Dimensions.height25),
                  height: Dimensions.height67,
                  decoration: BoxDecoration(
                      color: Color(0xff5383EC),
                      borderRadius: BorderRadius.circular(Dimensions.size19)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                        size: Dimensions.size24,
                      ),
                      Text(
                        "Continue with Google",
                        style: TextStyle(
                            color: Color(0xffFCFCFC),
                            fontSize: Dimensions.size18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  margin: EdgeInsets.only(top: Dimensions.height25),
                  height: Dimensions.height67,
                  decoration: BoxDecoration(
                      color: Color(0xff4A66AC),
                      borderRadius: BorderRadius.circular(Dimensions.size19)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                        size: Dimensions.size24,
                      ),
                      Text(
                        "Continue with Facebook",
                        style: TextStyle(
                            color: Color(0xffFCFCFC),
                            fontSize: Dimensions.size18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
