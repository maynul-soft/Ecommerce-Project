import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/register_screen.dart';
import 'package:crafty_bay_ecommerce/features/checkout/ui/screens/place_order_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/data/model/category_model.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/create_review_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_detail_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_catagory_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_list_by_category_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_list_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/review_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/ui/screens/splash_screen.dart';
import '../features/home/ui/screens/home_screen.dart';

class AppRoutes{
  static Route<dynamic> routes (RouteSettings setting) {
    late final Widget screenWidgets;
    if (setting.name == SplashScreen.name) {
      screenWidgets = SplashScreen();
    }else if(setting.name == LoginScreen.name){
      screenWidgets = LoginScreen();
    }else if (setting.name == RegisterScreen.name){
      screenWidgets = RegisterScreen();
    }else if (setting.name == OtpVerificationScreen.name){
      String? email = setting.arguments as String?;
      screenWidgets = OtpVerificationScreen(email: email??'null',);
    }else if (setting.name == HomeScreen.name){
      screenWidgets = HomeScreen();
    }else if (setting.name == ProductCategoryScreen.name){
      screenWidgets = ProductCategoryScreen();
    }else if(setting.name == MainBottomNavScreen.name){
      screenWidgets = MainBottomNavScreen();
    }else if (setting.name == ProductListByCategoryScreen.name){
      final CategoryModel category = setting.arguments as CategoryModel;
      screenWidgets = ProductListByCategoryScreen(category: category);
    }else if(setting.name == ProductDetailScreen.name){
      final _id = setting.arguments as String;
      screenWidgets = ProductDetailScreen(id:  _id,);
    }else if (setting.name == ReviewScreen.name){
      String id = setting.arguments as String;
      screenWidgets = ReviewScreen(id: id);
    }else if (setting.name == CreateReviewScreen.name){
      String id = setting.arguments as String;
      screenWidgets = CreateReviewScreen(id: id,);
    }else if (setting.name == ProductListScreen.name){
      final _tag = setting.arguments as String;
      screenWidgets = ProductListScreen(tag: _tag);
    }else if(setting.name == PlaceOrderScreen.name){
      screenWidgets = PlaceOrderScreen();
    }
    return MaterialPageRoute(builder: (context) => screenWidgets);
  }
}