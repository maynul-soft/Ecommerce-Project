import 'package:crafty_bay_ecommerce/features/products/controller/current_slide_indicator_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/prodct_quantity_controller.dart';
import 'package:get/get.dart';

import '../features/auth/ui/controller/main_bottom_nav_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(CurrentSlideIndicatorController());
    Get.put(ProductQuantityController());
  }
}