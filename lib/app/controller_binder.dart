import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/auth_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/login_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/otp_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/registration_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/color_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/current_slide_indicator_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/prodct_quantity_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_%20catagory_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_size_controller.dart';
import 'package:get/get.dart';

import '../features/auth/ui/controller/main_bottom_nav_controller.dart';
import '../features/home/controller/home_slider_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkClient(onUnAuthorize: (){},commonHeader:  commonHeader ));
    Get.put(MainBottomNavController());
    Get.put(CurrentSlideIndicatorController());
    Get.put(ProductQuantityController());
    Get.put(ColorController());
    Get.put(ProductSizeController());
    Get.put(AuthController());
    Get.put(RegistrationController());
    Get.put(OtpController());
    Get.put(LoginController());
    Get.put (HomeSliderController());
    Get.put (ProductCategoryController());
  }
}

Map<String, String> commonHeader = {
  "Content-Type": "application/json",
  "token":   ''
} ;
