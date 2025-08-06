import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CreateReviewProvider extends ChangeNotifier{
  bool isLoading = false;
  int rating = 0;
  int selectedIndex = 0;

  Future<bool> createReview(context, Map<String,dynamic> body)async{
    isLoading = true;
    notifyListeners();
    
    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).postRequest(url: Urls.createReviewUrl, body: body);

    if(response.statusCode == 200 || response.statusCode == 201){
      isLoading = false;
      selectedIndex = 0;
      notifyListeners();
      return true;
    }else{
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  ratingHandler(index){
    rating = index+1;
    selectedIndex = index;
    notifyListeners();
  }
}