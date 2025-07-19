import 'package:crafty_bay_ecommerce/features/cert/controller/get_cart_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/cert/data/model/cart_checkout_model.dart';
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