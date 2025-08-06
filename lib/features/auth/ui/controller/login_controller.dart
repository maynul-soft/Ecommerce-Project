import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/auth/data/models/login_model.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/authProvider.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoading = false ;

  Future<void>login (context,{required String email, required String password} )async{
    isLoading = true;
    notifyListeners();

    final String url = Urls.loginUrls;
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };
    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).postRequest(url: url, body: requestBody);

    if(response.statusCode == 200 || response.statusCode == 201){
      LoginModel information = LoginModel.fromJson(response.responseBody!);

     await AuthProvider.saveUserInformation(userToken: information.userData.token, user: information.userData.user.toJson());
     await AuthProvider.getUserInformation();


      Logger().i('''
      =>>   ${information.message}
      =>>   ${information.userData.token}
      =>>   ${information.userData.user.firstName}
      ''');

      navigatorKey.currentState?.pushNamedAndRemoveUntil(MainBottomNavScreen.name, (predicate)=>false);
    }else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Sorry..! ${response.errorMessage!}'),
      //     )
      // );

    }

    isLoading = false;
    notifyListeners();
  }

}