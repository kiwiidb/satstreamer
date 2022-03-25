import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentTabIndex = 0.obs;

  void setTab(int i) {
    currentTabIndex.value = i;
  }
}
