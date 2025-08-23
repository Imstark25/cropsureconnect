import 'package:get/get.dart';


import 'home_model.dart';
import 'home_service.dart';

class HomeController extends GetxController {
  final HomeService _homeService = HomeService();

  var isLoading = true.obs;
  var topFarmers = <TopFarmer>[].obs;
  var allCategories = <Category>[].obs;
  var allProducts = <Product>[].obs;
  var selectedLocation = 'All'.obs;

  // For filtering
  var selectedCategories = <String>{}.obs;

  // A computed list that filters products based on selected categories
  List<Product> get filteredProducts {
    if (selectedCategories.isEmpty) {
      return allProducts;
    } else {
      // This is a placeholder for real filtering logic
      // In a real app, you'd filter based on a categoryId on the product
      return allProducts.where((p) => selectedCategories.contains(p.seller)).toList();
    }
  }

  void toggleCategoryFilter(String categoryName) {
    if (selectedCategories.contains(categoryName)) {
      selectedCategories.remove(categoryName);
    } else {
      selectedCategories.add(categoryName);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchHomePageData();
  }

  Future<void> fetchHomePageData() async {
    try {
      isLoading(true);
      final data = await _homeService.fetchMockData();
      topFarmers.value = data['topFarmers'] as List<TopFarmer>;
      allCategories.value = data['categories'] as List<Category>;
      allProducts.value = data['products'] as List<Product>;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}