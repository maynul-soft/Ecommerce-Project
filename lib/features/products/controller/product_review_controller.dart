import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/products/data/model/product_review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProductReviewProvider extends ChangeNotifier{
  bool isLoading = false;

  List<ProductReviewModel> reviewList= [];

  Future<void> getReview(context, {required String id})async{
    isLoading = true;
    notifyListeners();

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).getRequest(url: Urls.productReviewUrl(id: id,));

    if (response.statusCode == 200 || response.statusCode == 201){
      List<ProductReviewModel> tempList = [];
      List respList = response.responseBody!['data']['results'];

      for(var item in respList){
        if(item['product']['_id'] == id){
          tempList.add(ProductReviewModel.fromJson(item));
        }
        reviewList = tempList;
        notifyListeners();
      }

    }
    isLoading = false;
    notifyListeners();
  }






}