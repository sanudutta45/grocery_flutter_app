import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: Dimensions.width220,
                height: Dimensions.height220,
                margin: EdgeInsets.only(top: Dimensions.height150),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/confirmation.png"))),
              ),
              Container(
                width: Dimensions.width300,
                margin: EdgeInsets.only(
                    top: Dimensions.height30, bottom: Dimensions.height30),
                child: Text(
                  "Your Order has been accepted",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Dimensions.size30,
                      fontWeight: FontWeight.w600,
                      color: darkBlackColor),
                ),
              ),
              Container(
                width: Dimensions.width270,
                child: Text(
                  "Your items has been placcd and is on it’s way to being processed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Dimensions.size17,
                      fontWeight: FontWeight.normal,
                      color: darkGreyColor),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: Dimensions.height54,
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height80,
                      bottom: Dimensions.height15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.size14))),
                  child: Text(
                    "Track Order",
                    style: TextStyle(
                        color: Color(0xffFCFCFC),
                        fontSize: Dimensions.size18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => Get.toNamed("/home"),
                  child: Text(
                    "Back to home",
                    style: TextStyle(
                        color: darkBlackColor,
                        fontSize: Dimensions.size18,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
