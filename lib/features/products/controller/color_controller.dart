
import 'package:get/get.dart';

class ColorController extends GetxController {

  static final controller =  Get.find<ColorController>();

  int currentIndex = 0;

  changeIndex(index){
    currentIndex = index;
    update();
  }
}
