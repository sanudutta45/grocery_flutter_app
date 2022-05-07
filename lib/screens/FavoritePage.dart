import 'package:flutter/material.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);

  final List items = [
    {
      "id": 1,
      "img": "assets/images/capcicum.png",
      "total": 1,
      "amount": 4.99,
      "name": "Bell Pepper Red",
      "quantity": 12,
      "unit": "kg",
      "brand": "Pceg"
    },
    {
      "id": 2,
      "img": "assets/images/capcicum.png",
      "total": 1,
      "amount": 4.99,
      "name": "Bell Pepper Red",
      "quantity": 12,
      "unit": "kg",
      "brand": "Pceg"
    },
    {
      "id": 3,
      "img": "assets/images/capcicum.png",
      "amount": 4.99,
      "name": "Bell Pepper Red",
      "quantity": 12,
      "unit": "kg",
      "brand": "Pceg"
    },
    {
      "id": 4,
      "img": "assets/images/capcicum.png",
      "amount": 4.99,
      "name": "Bell Pepper Red",
      "quantity": 12,
      "unit": "kg",
      "brand": "Pceg"
    },
    {
      "id": 5,
      "img": "assets/images/capcicum.png",
      "amount": 4.99,
      "name": "Bell Pepper Red",
      "quantity": 12,
      "unit": "kg",
      "brand": "Pceg"
    },
    {
      "id": 6,
      "img": "assets/images/capcicum.png",
      "amount": 4.99,
      "name": "Bell Pepper Red",
      "quantity": 12,
      "unit": "kg",
      "brand": "Pceg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height70,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Divider(
            height: 1,
            color: Color(0xffE2E2E2),
          ),
          preferredSize: Size.fromHeight(1),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Favourite",
          style: TextStyle(
              color: darkBlackColor,
              fontSize: Dimensions.size20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Column(children: [
            Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    final _metaData = items[index]["quantity"].toString() +
                        items[index]["unit"].toString() +
                        ", " +
                        items[index]["brand"].toString();

                    final String total =
                        '\u{20B9}' + items[index]["amount"].toString();

                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: index == (items.length - 1)
                                  ? BorderSide(
                                      width: Dimensions.width2,
                                      color: Color(0xffE2E2E2))
                                  : BorderSide(width: 0, color: Colors.white))),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: index != (items.length - 1)
                                    ? BorderSide(
                                        width: 1, color: Color(0xffE2E2E2))
                                    : BorderSide(
                                        width: 0, color: Colors.white))),
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.width70,
                              height: Dimensions.height64,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(items[index]["img"]),
                                      fit: BoxFit.contain)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width20,
                                  top: Dimensions.height25,
                                  bottom: Dimensions.height35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index]["name"],
                                    style: TextStyle(
                                        color: darkBlackColor,
                                        fontSize: Dimensions.size16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height2,
                                  ),
                                  Text(
                                    _metaData,
                                    style: TextStyle(
                                        color: Color(0xff7C7C7C),
                                        fontSize: Dimensions.size14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Row(
                              children: [
                                Text(
                                  total,
                                  style: TextStyle(
                                      color: darkBlackColor,
                                      fontSize: Dimensions.size16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: Dimensions.width5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: Dimensions.size16,
                                  color: darkBlackColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: items.length),
            ),
            SizedBox(
              height: Dimensions.height62,
            )
          ]),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: Dimensions.height16,
            child: Container(
              height: Dimensions.height67,
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.size19))),
              child: Text(
                "Add All To Cart",
                style: TextStyle(
                    color: Color(0xffFCFCFC),
                    fontSize: Dimensions.size18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
