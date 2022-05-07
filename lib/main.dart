import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/GlobalBinding.dart';
import 'package:grocery/screens/AccountPage.dart';
import 'package:grocery/screens/AddEditAddress/AddEditAddressPage.dart';
import 'package:grocery/screens/AddEditAddress/AddEditAddressPageBinding.dart';
import 'package:grocery/screens/AddProduct.dart';
import 'package:grocery/screens/Category/CategoryBinding.dart';
import 'package:grocery/screens/Category/CategoryPage.dart';
import 'package:grocery/screens/Main/MainBinding.dart';
import 'package:grocery/screens/LoginOptions.dart';
import 'package:grocery/screens/Main/MainPage.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesBinding.dart';
import 'package:grocery/screens/MyAddresses/MyAddressesPage.dart';
import 'package:grocery/screens/NumberLoginPage.dart';
import 'package:grocery/screens/OrderConfirmationPage.dart';
import 'package:grocery/screens/OtpPage.dart';
import 'package:grocery/screens/ProductPage/ProductPage.dart';
import 'package:grocery/screens/ProductPage/ProductPageBinding.dart';
import 'package:grocery/screens/SaveImages.dart';
import 'package:grocery/screens/SearchLocation/SearchLocationBinding.dart';
import 'package:grocery/screens/SearchLocation/SearchLocationPage.dart';
import 'package:grocery/screens/SelectDeliveryAddress/SelectDeliveryAddressBinding.dart';
import 'package:grocery/screens/SelectDeliveryAddress/SelectDeliveryAddressPage.dart';
import 'package:grocery/screens/SelectLocation/SelectLocationBinding.dart';
import 'package:grocery/screens/SelectLocation/SelectLocationPage.dart';
import 'package:grocery/screens/Splash/SplashPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery',
      theme: ThemeData(
          //  / accentColor: greenColor,
          inputDecorationTheme: InputDecorationTheme(focusColor: greenColor),
          fontFamily: "Roboto",
          backgroundColor: Colors.white,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white),
      initialRoute: "/",
      initialBinding: GlobalBinding(),
      getPages: [
        GetPage(name: "/home", page: () => MainPage(), binding: MainBinding()),
        GetPage(
            name: "/category",
            page: () => CategoryPage(),
            binding: CategoryBinding()),
        GetPage(name: "/login", page: () => LoginOptions()),
        GetPage(name: "/number_login", page: () => NumberLoginPage()),
        GetPage(name: "/otp", page: () => OtpPage()),
        GetPage(
            name: "/add_edit_address",
            page: () => AddEditAddressPage(),
            binding: AddEditAdressPageBinding()),
        GetPage(
            name: "/my_addresses",
            page: () => MyAddrressesPage(),
            binding: MyAddressesBinding()),
        GetPage(
            name: "/select_location",
            page: () => SelectLocationPage(),
            binding: SelectLocationBinding()),
        GetPage(
            name: "/product/:id",
            page: () => ProductPage(),
            binding: ProductPageBinding()),
        GetPage(name: "/account", page: () => AccountPage()),
        GetPage(name: "/", page: () => SplashPage()),
        GetPage(name: "/upload", page: () => SaveImages()),
        GetPage(name: "/add_product", page: () => AddProduct()),
        GetPage(
            name: "/search_location",
            page: () => SearchLocationPage(),
            binding: SearchLocationBinding()),
        GetPage(
            name: "/select_delivery_address",
            page: () => SelectDeliveryAddressPage(),
            binding: SelectDeliveryAddressBinding()),
        GetPage(
            name: "/order_confirmation", page: () => OrderConfirmationPage())
      ],
    );
  }
}
