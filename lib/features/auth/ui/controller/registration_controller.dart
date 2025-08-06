import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/auth/data/models/registration_request_model.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class RegistrationProvider extends ChangeNotifier {
  bool _isLoading = false;
  get isLoading => _isLoading;


  Future<bool>registration(context, RegistrationRequestModel body)async{
    _isLoading = true;
   notifyListeners();

    String url = Urls.registrationUrl;

    bool isSuccess = false;
    Logger().e('''
    => ${body.toJson()}
    ''');

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).postRequest(url: url, body: body.toJson());

    if(response.statusCode == 200 || response.statusCode == 201){
      isSuccess = true;
      navigatorKey.currentState?.pushNamed(OtpVerificationScreen.name, arguments: body.email);
    }else{
     if(response.errorMessage != null){
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content:  Text('Sorry...! ${response.errorMessage}'),
           )
       );
     }
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}