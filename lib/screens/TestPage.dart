import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/globalController/CurrentLocationController.dart';

class TestPage extends StatelessWidget {
  final CurrentLocationController controller = Get.find();
    final _localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(controller.currentLocation.toString()),
            SizedBox(height: Dimensions.height150),
            Text(_localStorage.read("location").toString()),
            SizedBox(height: Dimensions.height15),
            TextButton(onPressed: ()=>Get.toNamed("/home"), child: Text("Home"))
          ],
        ),
      ),
    );
  }
}
