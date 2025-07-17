import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/home/data/model/home_slider_model.dart';
import 'package:get/get.dart';

import '../../../app/urls.dart';

class HomeSliderController extends GetxController {
  bool isLoading = false;
  List<HomeSliderModel> homeSliderList= [];

  Future<void> getSlider ()async{
    isLoading = true;
    update();

    NetworkResponse response = await Get.find<NetworkClient>().getRequest(url: Urls.homeSliderUrl);

    if(response.statusCode == 200 || response.statusCode == 201){
      List sliderList = response.responseBody!['data']['results'];
      homeSliderList.clear();
      for(var data in sliderList){
        homeSliderList.add(HomeSliderModel.fromJson(data));
      }
    }
    isLoading = false;
    update();


  }
}