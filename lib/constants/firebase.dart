import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseConstants {
  static final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
}
