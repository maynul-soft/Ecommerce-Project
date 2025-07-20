import 'package:crafty_bay_ecommerce/app/app.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:get/get.dart';

class PlaceOrderController extends GetxController  {
  bool  isLoading= false ;


  Future<void>placeOrder(Map<String,dynamic> body)async{
    isLoading =true;
    update();

    NetworkResponse response = await Get.find<NetworkClient>().postRequest(url: Urls.createOrderUrl, body: body);
    if(response.statusCode == 200 || response.statusCode ==201 ){
      navigatorKey.currentState?.pushNamedAndRemoveUntil(MainBottomNavScreen.name, (predicate)=> false);
      Get.snackbar('Congratulation.!', 'Order successful');
    }else{
      Get.snackbar('Failed', response.errorMessage!);
    }


  }



}