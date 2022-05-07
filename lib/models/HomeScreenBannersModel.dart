import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenBannersModel {
  String? imgId;
  late String bannerUrl;

  HomeScreenBannersModel({required this.bannerUrl});

  HomeScreenBannersModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    imgId = documentSnapshot.id;
    bannerUrl = documentSnapshot["bannerUrl"];
  }
}
