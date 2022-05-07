import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/CartController.dart';
import 'package:grocery/screens/AccountPage.dart';
import 'package:grocery/screens/PlaceOrder/PlaceOrderPage.dart';
import 'package:grocery/screens/ExplorePage/ExplorePage.dart';
import 'package:grocery/screens/FavoritePage.dart';
import 'package:grocery/screens/Home/HomePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final CartController _cartController = Get.find();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          ExplorePage(),
          PlaceOrderPage(),
          FavoritePage(),
          AccountPage()
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.height92,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.size15),
              topRight: Radius.circular(Dimensions.size15)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(85, 94, 88, 0.09),
                blurRadius: Dimensions.size15,
                spreadRadius: 0,
                offset: Offset(Dimensions.width2, -Dimensions.height5))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.size15),
            topRight: Radius.circular(Dimensions.size15),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.storefront_outlined,
                  ),
                  label: "Shop"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.manage_search_outlined), label: "Explore"),
              BottomNavigationBarItem(
                  icon: Obx(() => Badge(
                      badgeColor: greenColor,
                      showBadge: _cartController.totalItems > 0 ? true : false,
                      badgeContent: Text(_cartController.totalItems.toString()),
                      child: Icon(Icons.shopping_cart_outlined))),
                  label: "Cart"),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.clipboardList),
                  label: "My List"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined), label: "Account")
            ],
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            selectedItemColor: greenColor,
            unselectedItemColor: darkBlackColor,
            selectedFontSize: Dimensions.size12,
            unselectedFontSize: Dimensions.size12,
            iconSize: Dimensions.size35,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
