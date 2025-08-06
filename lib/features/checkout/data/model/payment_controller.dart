import 'dart:math';
import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/env.dart';
import 'package:crafty_bay_ecommerce/features/cert/controller/get_cart_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/checkout/data/model/place_order_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class PaymentProvider extends ChangeNotifier {


  Future<void> makePayment(Map<String,dynamic>body, context) async {
    double totalAmount =
        Provider.of<GetCartProductProvider>(context, listen:  false).checkoutPrice?.toDouble()?? 0.00;

    final storeId = Env.sslStoreId;
    final storePass = Env.sslStorePassword;
    final transectionId = generateTxId();

    Logger().i('''
    ==>> total amt: $totalAmount
    ==>> store id: $storeId
    ==>> store pass: $storePass
    ==>> trsId: $transectionId
    ''');

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //   ipn_url: "www.ipnurl.com",
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Digital product",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: storeId,
        store_passwd: storePass,
        total_amount: totalAmount,
        tran_id: transectionId,
      ),
    );

    final response = await sslcommerz.payNow();

    switch (response.status) {
      case 'FAILED':
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content:  Text('Failed Payment failed'),
        //     )
        // );
        Navigator.pop(navigatorKey.currentContext!);
        break;

      case 'CANCELLED':
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content:  Text('Payment canceled by user'),
        //     )
        // );
        Navigator.pop(navigatorKey.currentContext!);
        break;

      case 'UNATTEMPTED':
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content:  Text('Payment unattempted'),
        //     )
        // );
        Navigator.pop(navigatorKey.currentContext!);
        break;

      case 'EXPIRED':
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content:  Text('Payment expired'),
        //     )
        // );
        Navigator.pop(navigatorKey.currentContext!);
        break;

      case 'ERROR':
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content:  Text('Something went wrong'),
        //     )
        // );
        Navigator.pop(navigatorKey.currentContext!);
        break;

      case 'VALID':
        context.read<PlaceOrderProvider>().placeOrder(body);
        break;
    }
  }

  String generateTxId() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();

    return List.generate(
      10,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
