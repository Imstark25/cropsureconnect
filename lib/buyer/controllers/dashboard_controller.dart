import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index < 5) { // 5 is the number of tabs
      tabIndex.value = index;
    }
  }
}