import 'package:get/get.dart';

class ProductSizeController extends GetxController {

  static final ProductSizeController controller = Get.find<ProductSizeController>();

  String selectedSize = '';
  int? selectedIndex = 0;
  changeIndex(index){
    selectedIndex = index;
    update();
  }
  setSize(size){
    selectedSize = size;
    update();
  }

  unselectSize(){
    selectedIndex = null;
    update();
  }


  bool isSelected({required int key,}){
    if(key==selectedIndex){
      return true;
    }else{
      return false;
    }

  }
}