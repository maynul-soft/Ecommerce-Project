import 'dart:async';
import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpProvider extends ChangeNotifier {
  bool isLoading = false;
  int otpValidity = 10;

  String? userEmail;

  Future<void> verifyOtp(context,{required String email, required String otp}) async {
    isLoading = true;
    notifyListeners();

    userEmail = email;

    Map<String, dynamic> responseBody = {
      "email": email,
      "otp": otp, // static
    };

    String url = Urls.verifyOtpUrl;

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).postRequest(
      url: url,
      body: responseBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:  Text("Welcome..! Successfully verified email address"),
          )
      );
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.name,
        (predicate) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:  Text("Welcome..! ${response.errorMessage!}"),
          )
      );

    }
    isLoading = false;
    notifyListeners();
  }

  countOtp() async {
    Timer.periodic(Duration(seconds: 1), (time) {
      if (otpValidity > 0) {
        otpValidity--;
        notifyListeners();
      } else {
        time.cancel();
        notifyListeners();
      }
    });
  }

  resendOtp(context) {
    otpValidity = 120;
    notifyListeners();
    countOtp();
    tryResendOtp(context);
  }

  Future<void> tryResendOtp(context) async {
    try {
      if (userEmail != null) {
        NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).postRequest(
          url: Urls.resendOtpUrl,
          body: {"email": userEmail},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content:  Text('Awesome A 4 digit otp send on your email'),
          //     )
          // );
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content:  Text('Sorry...! ${response.errorMessage}'),
          //     )
          // );
        }
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Warning! ${e.toString()}'),
      //     )
      // );

    }
  }
}
