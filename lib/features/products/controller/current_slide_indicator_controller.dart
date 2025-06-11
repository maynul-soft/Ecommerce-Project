import 'package:get/get.dart';

class CurrentSlideIndicatorController extends GetxController {
  int currentIndex = 0  ;

  changeIndicator(index){
    currentIndex = index;
    update();
  }
}