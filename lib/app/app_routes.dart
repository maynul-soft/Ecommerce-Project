import 'package:crafty_bay_ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/register_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_detail_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_catagory_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_list.dart';
import 'package:flutter/cupertino.dart';
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
      screenWidgets = OtpVerificationScreen();
    }else if (setting.name == HomeScreen.name){
      screenWidgets = HomeScreen();
    }else if (setting.name == ProductCategoryScreen.name){
      screenWidgets = ProductCategoryScreen();
    }else if(setting.name == MainBottomNavScreen.name){
      screenWidgets = MainBottomNavScreen();
    }else if (setting.name == ProductList.name){
      final String category = setting.arguments as String;
      screenWidgets = ProductList(category: category);
    }else if(setting.name == ProductDetailScreen.name){
      screenWidgets = ProductDetailScreen();
    }
    return MaterialPageRoute(builder: (context) => screenWidgets);
  }
}