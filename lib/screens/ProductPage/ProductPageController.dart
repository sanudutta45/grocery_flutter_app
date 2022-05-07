import 'package:get/get.dart';
import 'package:grocery/models/ProductVarientModel.dart';
import 'package:grocery/repository/ProductRepository.dart';

class ProductPageController extends GetxController {
  final _productVarients = <ProductVarientModel>[].obs;
  final _selectedVarient = 0.obs;
  final _isLoading = true.obs;
  final _activeBanner = 0.obs;
  final _showDetails = false.obs;

  bool get isLoading => _isLoading.value;
  bool get showDetails => _showDetails.value;
  int get selectedVarient => _selectedVarient.value;
  int get activeBanner => _activeBanner.value;
  List<ProductVarientModel> get productVarients => _productVarients;

  @override
  void onReady() {
    _getProduct();
    super.onReady();
  }

  toggleVarient(int index) {
    _selectedVarient.value = index;
  }

  toggleShowDetails() {
    _showDetails.value = !_showDetails.value;
  }

  setActiveBanner(int index) {
    _activeBanner.value = index;
  }

  _getProduct() async {
    _isLoading.value = true;
    String productId = Get.parameters["id"]!;
    try {
      _productVarients.value =
          await ProductRepository.getProductByProductId(productId);
    } catch (e) {
      printError(info: "error loading product");
    } finally {
      _isLoading.value = false;
    }

    // print(_productVarients[0].largeImageUrl![0]);
  }
}
