import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/models/HomeScreenBannersModel.dart';
import 'package:grocery/constants/firebase.dart';

class BannersRepository {
  static Stream<List<HomeScreenBannersModel>> bannersStream() {
    return FirebaseConstants.firebaseFirestore
        .collection('banners')
        .snapshots()
        .map((QuerySnapshot query) {
      List<HomeScreenBannersModel> banners = [];
      for (var banner in query.docs) {
        final bannerModel = HomeScreenBannersModel.fromDocumentSnapshot(
            documentSnapshot: banner);
        banners.add(bannerModel);
      }
      return banners;
    });
  }
}
