import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/home/data/model/home_slider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../core/urls.dart';

class HomeSliderProvider extends ChangeNotifier {
  bool isLoading = false;
  List<HomeSliderModel> homeSliderList= [];

  Future<void> getSlider (context)async{
    isLoading = true;
    notifyListeners();

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).getRequest(url: Urls.homeSliderUrl);

    if(response.statusCode == 200 || response.statusCode == 201){
      List sliderList = response.responseBody!['data']['results'];
      homeSliderList.clear();
      for(var data in sliderList){
        homeSliderList.add(HomeSliderModel.fromJson(data));
      }
    }
    isLoading = false;
    notifyListeners();


  }
}