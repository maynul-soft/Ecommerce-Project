import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  addToCart({required String id,String? color, String? size }) async {
    Map<String, dynamic> body = {
      "product": id,
      "color": color ,
      "size": size // is not support current system
    };
    NetworkResponse response = await Get.find<NetworkClient>().postRequest(
      url: Urls.addToCartUrl,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(
            'Product added to cart',
            style: TextStyle(color: AppColors.themColor),
          ),
          duration: Duration(seconds: 2),

        ),
      );
    }else{
      Get.snackbar('Sorry', response.errorMessage!);
    }
  }
}
