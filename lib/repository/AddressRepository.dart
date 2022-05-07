import 'package:grocery/constants/firebase.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressRepository {
  static CollectionReference _addressRef =
      FirebaseConstants.firebaseFirestore.collection("deliveryAddresses");

  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<List<LocationModel>> getDeliveryAddress() {
    return _addressRef
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<LocationModel> addresses = [];
      for (var address in query.docs) {
        final locationModel = LocationModel.fromJson(address);
        addresses.add(locationModel);
      }
      return addresses;
    });
  }

  static Future<void> addDeliveryAddress(LocationModel location) async {
    try {
      await _addressRef
          .add({...location.toJson(), "userId": _auth.currentUser!.uid}).then(
              (_) => print("address saved successfully"));
    } catch (err) {
      print("err $err");
    }
  }

  static Future<void> updateDeliveryAddress(LocationModel location) async {
    try {
      await _addressRef
          .doc(location.locationId)
          .update({...location.toJson()}).then(
              (_) => print("address updated successfully"));
    } catch (err) {
      print("err $err");
    }
  }

  static Future<void> removeDeliveryAddress(LocationModel location) async {
    try {
      await _addressRef.doc(location.locationId).delete();
    } catch (err) {
      print("err $err");
    }
  }
}
