import 'package:get/get.dart';
class MainBottomNavController extends GetxController{
  int selectedIndex = 0;

  changeScreen(index){
    selectedIndex = index;
    update();
  }
  gotoCategoryScreen(){
    selectedIndex = 1;
    update();
  }
  backToHomeScreen(){
    selectedIndex = 0;
    update();
  }


}