import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/CurrentLocationController.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final CurrentLocationController controller = Get.find();
  
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => controller.isCurrentLocationSet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/splashScreenLogo.png",
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.7,
          )),
    );
  }
}
