import 'dart:async';
import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  bool isLoading = false;
  int otpValidity = 10;

  String? userEmail;

  Future<void> verifyOtp({required String email, required String otp}) async {
    isLoading = true;
    update();

    userEmail = email;

    Map<String, dynamic> responseBody = {
      "email": email,
      "otp": otp, // static
    };

    String url = Urls.verifyOtpUrl;

    NetworkResponse response = await Get.find<NetworkClient>().postRequest(
      url: url,
      body: responseBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Welcome..!', "Successfully verified email address");
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.name,
        (predicate) => false,
      );
    } else {
      Get.snackbar('Sorry..!', response.errorMessage!);
    }
    isLoading = false;
    update();
  }

  countOtp() async {
    Timer.periodic(Duration(seconds: 1), (time) {
      if (otpValidity > 0) {
        otpValidity--;
        update();
      } else {
        time.cancel();
        update();
      }
    });
  }

  resendOtp() {
    otpValidity = 120;
    update();
    countOtp();
    tryResendOtp();
  }

  Future<void> tryResendOtp() async {
    try {
      if (userEmail != null) {
        NetworkResponse response = await Get.find<NetworkClient>().postRequest(
          url: Urls.resendOtpUrl,
          body: {"email": userEmail},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar('Awesome', 'A 4 digit otp send on your email');
        } else {
          Get.snackbar('Sorry', response.errorMessage!);
        }
      }
    } catch (e) {
      Get.snackbar('Warning', e.toString());
    }
  }
}
