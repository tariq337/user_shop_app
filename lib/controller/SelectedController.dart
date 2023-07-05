import 'package:get/get.dart';

class SelectedController extends GetxController {
  RxInt selected = 0.obs;
  void onselected(int index) {
    selected(index);
    update();
  }
}
