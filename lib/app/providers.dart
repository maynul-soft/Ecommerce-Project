
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/login_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/otp_controller.dart';
import 'package:crafty_bay_ecommerce/features/cert/controller/get_cart_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/checkout/data/model/payment_controller.dart';
import 'package:crafty_bay_ecommerce/features/checkout/data/model/place_order_controller.dart';
import 'package:crafty_bay_ecommerce/features/home/controller/home_slider_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/add_cart_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/color_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/create_review_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/current_slide_indicator_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/new_prduct_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/popular_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/prodct_quantity_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_%20catagory_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_details_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_list_by_category_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_review_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_size_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/special_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/wish_list/controller/add_to_wish_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/wish_list/controller/wish_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/service/network_client.dart';
import '../features/auth/ui/controller/authProvider.dart';
import '../features/auth/ui/controller/registration_controller.dart';
import '../features/auth/ui/screens/login_screen.dart';
import 'app.dart';

class Providers {
  static final List<SingleChildWidget> providers= [
    ChangeNotifierProvider(create: (context)=> AuthProvider()),
    Provider<NetworkClient>(
      create: (context) => NetworkClient(
          onUnAuthorize: () => _onUnAuth(context),
          commonHeader: () => commonHeader(context),
          onSocketException: () => onSocketException(context)
      )),
    ChangeNotifierProvider(create: (context)=> MainBottomNavProvider()),
    ChangeNotifierProvider(create: (context)=> CurrentSlideIndicatorProvider()),
    ChangeNotifierProvider(create: (context)=> ProductQuantityProvider()),
    ChangeNotifierProvider(create: (context)=> ColorProvider()),
    ChangeNotifierProvider(create: (context)=> NewProductProvider()),
    ChangeNotifierProvider(create: (context)=> ProductSizeProvider()),
    ChangeNotifierProvider(create: (context)=> RegistrationProvider()),
    ChangeNotifierProvider(create: (context)=> RegistrationProvider()),
    ChangeNotifierProvider(create: (context)=> OtpProvider()),
    ChangeNotifierProvider(create: (context)=> LoginProvider()),
    ChangeNotifierProvider(create: (context)=> HomeSliderProvider()),
    ChangeNotifierProvider(create: (context)=> ProductCategoryProvider()),
    ChangeNotifierProvider(create: (context)=> ProductListByCategoryProvider()),
    ChangeNotifierProvider(create: (context)=> PopularProductProvider()),
    ChangeNotifierProvider(create: (context)=> SpecialProductProvider()),
    ChangeNotifierProvider(create: (context)=> ProductDetailsProvider()),
    ChangeNotifierProvider(create: (context)=> AddToCartProvider()),
    ChangeNotifierProvider(create: (context)=> ProductReviewProvider()),
    ChangeNotifierProvider(create: (context)=> ProductReviewProvider()),
    ChangeNotifierProvider(create: (context)=> GetCartProductProvider()),
    ChangeNotifierProvider(create: (context)=> CreateReviewProvider()),
    ChangeNotifierProvider(create: (context)=> WishListProvider(networkClient: Provider.of(context, listen: false))),
    ChangeNotifierProvider(create: (context)=> AddToWishListProvider()),
    ChangeNotifierProvider(create: (context)=> PaymentProvider()),
    ChangeNotifierProvider(create: (context)=> PlaceOrderProvider()),


  ];

  static Map<String, String> commonHeader(BuildContext context) {
    String? token = context.read<AuthProvider>().token;

    final Map<String, String> commonHeader ={
      "Content-Type": "application/json",
      "token": token?? '',
    };
    return commonHeader;
  }


  }

    Future<void> _onUnAuth(BuildContext context) async {
    await context.read<AuthProvider>().logOut();
    Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentContext!,
      LoginScreen.name,
          (predicate) => false,
    );


  }

  onSocketException(context) {
    return (){
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content:  Text('Please check your internet connection and try again later'),
       )
    );
    };
  }




