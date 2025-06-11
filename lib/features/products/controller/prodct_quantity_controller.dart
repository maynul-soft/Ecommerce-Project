import 'package:get/get.dart';

class ProductQuantityController extends GetxController {

  static final ProductQuantityController Controller = Get.find<ProductQuantityController>();

  int quantity = 1;

  increaseQuantity(){
    quantity++;
    update();
  }
  dicreaseQuantity(){
    quantity--;
    update();
  }


}