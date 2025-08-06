import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartProvider extends ChangeNotifier {
  addToCart(context, {required int quantity, required String id,String? color, String? size }) async {
    Map<String, dynamic> body = {
      "quantity": quantity,
      "product": id,
      "color": color ,
      "size": size // is not support current system
    };
    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).postRequest(
      url: Urls.addToCartUrl,
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Welcome..! Product added to cart'),
      //     )
      // );
    }else{
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Sorry..! ${response.errorMessage}'),
      //     )
      // );
    }
  }
}
