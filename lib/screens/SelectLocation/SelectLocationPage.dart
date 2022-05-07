import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/screens/SelectLocation/SelectLocationController.dart';

class SelectLocationPage extends StatelessWidget {
  SelectLocationPage({Key? key}) : super(key: key);

  final SelectLocationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width15, vertical: Dimensions.height30),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: darkBlackColor.withOpacity(0.4),
                  offset: Offset(0, Dimensions.height2),
                  blurRadius: Dimensions.size4,
                  spreadRadius: Dimensions.height2)
            ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "where do you want your delivery ?",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      color: darkBlackColor,
                      fontSize: Dimensions.size16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                InkWell(
                  onTap: () => Get.find<SelectLocationController>().isLoading
                      ? null
                      : controller.setCurrentLocationAutomatically(),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(Dimensions.height12),
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.size5))),
                    child: Text(
                      "use my current location",
                      style: TextStyle(
                          color: Color(0xffFCFCFC),
                          fontSize: Dimensions.size18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                InkWell(
                  onTap: () => Get.toNamed("/search_location",
                      arguments: {'callback': controller.onLocationSelected}),
                  child: Text(
                    "set location manually",
                    style: TextStyle(
                        color: greenColor,
                        fontSize: Dimensions.size16,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.75,
              margin: EdgeInsets.symmetric(vertical: Dimensions.height30),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/select_location.png"),
                      fit: BoxFit.contain)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width22),
              child: Text(
                "Trusted by millions of families across 37+ cities",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: darkBlackColor,
                    fontSize: Dimensions.size22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
