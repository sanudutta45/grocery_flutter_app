import 'package:get/get.dart';
import 'package:grocery/models/CategoryModel.dart';
import 'package:grocery/repository/CategoryRepository.dart';

class ExplorePageController extends GetxController {
  final _categories = <CategoryModel>[].obs;
  final _isLoading = true.obs;

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading.value;

  @override
  void onReady() {
    _getCategories();
    super.onReady();
  }

  goToCategory(int index) {
    Get.toNamed("/category", arguments: {
      "name": _categories[index].categoryName,
      "categoryId": _categories[index].categoryId
    });
  }

  _getCategories() async {
    _isLoading.value = true;
    try {
      _categories.value = await CategoryRepository.getCategories();
    } catch (e) {
      print(e);
    } finally {
      _isLoading.value = false;
    }
  }
}
