import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  addToCart({required int quantity, required String id,String? color, String? size }) async {
    Map<String, dynamic> body = {
      "quantity": quantity,
      "product": id,
      "color": color ,
      "size": size // is not support current system
    };
    NetworkResponse response = await Get.find<NetworkClient>().postRequest(
      url: Urls.addToCartUrl,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Welcome..!', 'Product added to cart');
    }else{
      Get.snackbar('Sorry', response.errorMessage!);
    }
  }
}
