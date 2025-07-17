import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/login_model.dart';

class AuthController extends GetxController {
  static   UserModel? userinfo;
  static   String? token;

  static final Logger _logger = Logger();

  static final String _userifoKey = 'use-info';
  static final String _tokenKey = 'use-token';

  static Future<void> saveUserInformation({required String userToken, required Map<String,dynamic> user })async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_tokenKey, userToken);
    sharedPreferences.setString(_userifoKey, jsonEncode(user));

    userinfo = UserModel.fromJson(user);
    token = userToken;

    _logger.i('Data saved successfully');

  }

  static Future<void> getUserInformation()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? userToken = sharedPreferences.getString(_tokenKey);
    String? stringUserInfo = sharedPreferences.getString(_userifoKey);

    if(userToken != null && stringUserInfo != null ){
      Map<String,dynamic> getUserInfo = jsonDecode(stringUserInfo);

      token = userToken;
      userinfo = UserModel.fromJson(getUserInfo);

    _logger.i('===>get user data from sharedpref');
    }else{
      _logger.i('===>May be user is not logged in');
    }

  }
  isLoggedIn(){
   if(token != null && userinfo != null){
     _logger.i('===>logged in');
     return true;
   }else{
     _logger.i('===>not logged in');
     return false;
   }
  }


}