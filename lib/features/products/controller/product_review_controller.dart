import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/products/data/model/product_review_model.dart';
import 'package:get/get.dart';

class ProductReviewController extends GetxController{
  bool isLoading = false;

  List<ProductReviewModel> reviewList= [];

  Future<void> getReview({required String id})async{
    isLoading = true;
    update();

    NetworkResponse response = await Get.find<NetworkClient>().getRequest(url: Urls.productReviewUrl(id: id,));

    if (response.statusCode == 200 || response.statusCode == 201){
      List<ProductReviewModel> tempList = [];
      List respList = response.responseBody!['data']['results'];

      for(var item in respList){
        if(item['product']['_id'] == id){
          tempList.add(ProductReviewModel.fromJson(item));
        }
        reviewList = tempList;
        update();
      }

    }
    isLoading = false;
    update();
  }






}