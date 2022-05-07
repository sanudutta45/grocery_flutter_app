import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/screens/ExplorePage/ExplorePageController.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key);

  final ExplorePageController _explorePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height70,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Explore",
          style: TextStyle(
              color: darkBlackColor,
              fontSize: Dimensions.size20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() => _explorePageController.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width15,
                  vertical: Dimensions.height10),
              crossAxisSpacing: Dimensions.width10,
              mainAxisSpacing: Dimensions.height10,
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              children: List.generate(_explorePageController.categories.length,
                  (index) {
                return InkWell(
                  onTap: () => _explorePageController.goToCategory(index),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height20),
                      decoration: BoxDecoration(
                        color: Color(_explorePageController
                                .categories[index].colorCode.hashCode)
                            .withOpacity(0.1),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Color(_explorePageController
                                    .categories[index].colorCode.hashCode)
                                .withOpacity(0.7)),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.size18)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: Dimensions.width111,
                            height: Dimensions.height74,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      _explorePageController
                                          .categories[index].imgUrl,
                                    ),
                                    fit: BoxFit.contain)),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Text(
                            _explorePageController
                                .categories[index].categoryName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: darkBlackColor,
                                fontSize: Dimensions.size16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                );
              }),
            )),
    );
  }
}
