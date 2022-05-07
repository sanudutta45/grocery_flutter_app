import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/constants/firebase.dart';
import 'package:grocery/models/CategoryModel.dart';

class CategoryRepository {
  static final _categoriesRef =
      FirebaseConstants.firebaseFirestore.collection('categories');

  static Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    return await _categoriesRef.get().then((QuerySnapshot query) {
      for (var category in query.docs) {
        final categoryModel =
            CategoryModel.documentFromSnapshot(documentSnapshot: category);
        categories.add(categoryModel);
      }
      return categories;
    });
  }
}
