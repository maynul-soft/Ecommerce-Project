import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/login_model.dart';

class AuthController extends GetxController {
  static   UserModel? _userInfo;
  static   String? _token;

  String? get  token => _token;
  UserModel? get  userInfo => _userInfo;

  static final Logger _logger = Logger();

  static final String _userInfoKey = 'use-info';
  static final String _tokenKey = 'use-token';

  static Future<void> saveUserInformation({required String userToken, required Map<String,dynamic> user })async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_tokenKey, userToken);
    sharedPreferences.setString(_userInfoKey, jsonEncode(user));

   _userInfo = UserModel.fromJson(user);
    _token = userToken;

    _logger.i('Data saved successfully');

  }

  static Future<void> getUserInformation()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? userToken = sharedPreferences.getString(_tokenKey);
    String? stringUserInfo = sharedPreferences.getString(_userInfoKey);

    if(userToken != null && stringUserInfo != null ){
      Map<String,dynamic> getUserInfo = jsonDecode(stringUserInfo);

      _token = userToken;
      _userInfo = UserModel.fromJson(getUserInfo);

    _logger.i('===>get user data from sharedpref');
    }else{
      _logger.i('===>May be user is not logged in');
    }

  }
  isLoggedIn(){
   if(_token != null && _userInfo != null){
     _logger.i('===>logged in');
     return true;
   }else{
     _logger.i('===>not logged in');
     return false;
   }
  }

  Future<void>logOut()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    _token = null;
    _userInfo = null;


  }


}