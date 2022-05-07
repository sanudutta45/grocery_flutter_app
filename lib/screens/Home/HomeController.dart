import 'package:get/get.dart';
import 'package:grocery/globalController/CurrentLocationController.dart';
import 'package:grocery/models/HomeScreenBannersModel.dart';
import 'package:grocery/models/LocationModel.dart';
import 'package:grocery/models/ProductVarientModel.dart';
import 'package:grocery/repository/BannersRepository.dart';
import 'package:grocery/repository/ProductRepository.dart';
import 'package:grocery/screens/PlaceOrder/PlaceOrderController.dart';

class HomeController extends GetxController {
  final _totalDataToLoad = 2.obs;

  final CurrentLocationController _currentLocationController = Get.find();
  final PlaceOrderController _placeOrderController = Get.find();

  Rx<List<HomeScreenBannersModel>> _banners =
      Rx<List<HomeScreenBannersModel>>([]);

  Rx<List<ProductVarientModel>> _exclusiveItems =
      Rx<List<ProductVarientModel>>([]);

  Rx<List<ProductVarientModel>> _bestSellingProducts =
      Rx<List<ProductVarientModel>>([]);

  List<HomeScreenBannersModel> get banners => _banners.value;

  final _currentBanner = 0.obs;
  final _isLoading = true.obs;

  @override
  void onReady() {
    _banners.bindStream(BannersRepository.bannersStream());
    _loadProducts();
    _banners.listen((_) {
      _totalDataToLoad.value -= 1;
    });

    ever(_totalDataToLoad, (value) {
      if (value == 0) _isLoading.value = false;
    });
  }

  Future<void> _loadProducts() async {
    var futures = await Future.wait([
      ProductRepository.getProducts(discountedPerc: 30, limit: 4),
      ProductRepository.getProducts(totalSold: 45, limit: 4)
    ]);

    _exclusiveItems.value = futures[0];
    _bestSellingProducts.value = futures[1];

    _totalDataToLoad.value -= 1;
  }

  int get currentBanner => _currentBanner.value;

  bool get isLoading => _isLoading.value;

  List<ProductVarientModel> get exclusiveItems => _exclusiveItems.value;
  List<ProductVarientModel> get bestSellingItems => _bestSellingProducts.value;

  setBannerIndex(int index) {
    _currentBanner.value = index;
  }

  onLocationSelected(LocationModel location) {
    _currentLocationController.setLocation(location);
    if (location.savedAddress)
      _placeOrderController.setDeliveryAddress(location);
    else
      _placeOrderController.clearDeliveryAddress();
    Get.back();
  }
}
