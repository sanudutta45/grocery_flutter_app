import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/AuthController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthController _authController = Get.find();

  late List menu;

  @override
  void initState() {
    super.initState();
    menu = [
      {
        "id": 1,
        "icon": Icons.shopping_bag_rounded,
        "title": "Orders",
        "callback": () => {}
      },
      {
        "id": 2,
        "icon": Icons.badge_outlined,
        "title": "My Details",
        "callback": () => {}
      },
      {
        "id": 3,
        "icon": Icons.location_on_outlined,
        "title": "My Address",
        "callback": () => Get.toNamed("/my_addresses")
      },
      {
        "id": 4,
        "icon": Icons.payment_outlined,
        "title": "Payment Methods",
        "callback": () => {}
      },
      {
        "id": 5,
        "icon": Icons.card_giftcard_outlined,
        "title": "Promo Codes",
        "callback": () => {}
      },
      {
        "id": 6,
        "icon": Icons.notifications_none_outlined,
        "title": "Notifications",
        "callback": () => {}
      },
      {
        "id": 7,
        "icon": Icons.help_outline,
        "title": "Help",
        "callback": () => {}
      },
      {
        "id": 8,
        "icon": Icons.info_outline_rounded,
        "title": "About",
        "callback": () => {}
      },
      {
        "id": 9,
        "icon": Icons.logout_outlined,
        "title": "Log Out",
        "callback": () => _authController.signout()
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => _authController.user != null
            ? Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height30),
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.height63e32,
                            height: Dimensions.height64e32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromARGB(255, 173, 26, 181)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.size27))),
                            child: FaIcon(
                              FontAwesomeIcons.solidUser,
                              color: Color.fromARGB(255, 173, 26, 181),
                              size: Dimensions.size35,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Guest",
                                    style: TextStyle(
                                        color: darkBlackColor,
                                        fontSize: Dimensions.size20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width6,
                                  ),
                                  Icon(
                                    Icons.create_outlined,
                                    color: greenColor,
                                    size: Dimensions.size20,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height3,
                              ),
                              Text(
                                _authController.user!.phoneNumber.toString(),
                                style: TextStyle(
                                    color: Color(0xff7C7C7C),
                                    fontSize: Dimensions.size16,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xffE2E2E2),
                    thickness: 1.5,
                  ),
                  Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.all(0),
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: menu[index]["callback"],
                            child: Padding(
                              padding: EdgeInsets.all(Dimensions.height15),
                              child: Row(
                                children: [
                                  Icon(
                                    menu[index]["icon"],
                                    color: darkBlackColor,
                                    size: Dimensions.size18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.width8,
                                  ),
                                  Text(
                                    menu[index]["title"],
                                    style: TextStyle(
                                        color: darkBlackColor,
                                        fontSize: Dimensions.size18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(child: Container()),
                                  if (index != menu.length - 1)
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: Dimensions.size20,
                                      color: darkBlackColor,
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => Divider(
                              height: 0,
                              thickness: 1,
                            ),
                        itemCount: menu.length),
                  ),
                ],
              )
            : Center(
                child: TextButton(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height15),
                      child: Text("Login / Signin",
                          style: TextStyle(
                              color: Color(0xffFCFCFC),
                              fontSize: Dimensions.size18,
                              fontWeight: FontWeight.w600)),
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.size12)))),
                  onPressed: () => Get.toNamed("/login"),
                ),
              )));
  }
}
