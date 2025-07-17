import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/auth/data/models/registration_request_model.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RegistrationController extends GetxController {
  bool _isLoading = false;
  get isLoading => _isLoading;


  Future<bool>registration(RegistrationRequestModel body)async{
    _isLoading = true;
    update();

    String url = Urls.registrationUrl;

    bool isSuccess = false;
    Logger().e('''
    => ${body.toJson()}
    ''');

    NetworkResponse response = await Get.find<NetworkClient>().postRequest(url: url, body: body.toJson());

    if(response.statusCode == 200 || response.statusCode == 201){
      isSuccess = true;
      navigatorKey.currentState?.pushNamed(OtpVerificationScreen.name, arguments: body.email);
    }else{
     if(response.errorMessage != null){
       Get.snackbar('Sorry..!', response.errorMessage!);
     }
    }
    _isLoading = false;
    update();
    return isSuccess;
  }


}