import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceOrderProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> placeOrder(context, Map<String, dynamic> body) async {
    isLoading = true;
    notifyListeners();

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).postRequest(url: Urls.createOrderUrl, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        MainBottomNavScreen.name,
        (predicate) => false,
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Congratulation...! Order successful'),
      //     )
      // );

    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Filed ${response.errorMessage}'),
      //     )
      // );
    }
  }
}
