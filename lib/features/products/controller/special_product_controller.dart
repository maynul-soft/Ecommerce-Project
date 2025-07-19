import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../app/urls.dart';
import '../../../core/service/network/network_client.dart';
import '../data/model/product_card_model.dart';

class SpecialProductController extends GetxController {
  bool isLoading = false;
  List<ProductCardModel> specialProductList = [];
  List<ProductCardModel> productList = [];

  final Logger _logger = Logger();

  Future<void> getSpecialProduct() async {
    isLoading = true;
    update();

    NetworkResponse response = await Get.find<NetworkClient>().getRequest(
      url: Urls.productByTagUrl(tag: 'Special'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List splProductList = response.responseBody!['data']['results'];
      specialProductList.clear();
      List<ProductCardModel> tempList = [];
      _logger.w(response);
      for (var data in splProductList) {
        tempList.add(ProductCardModel.fromJson(data));
      }

      if (tempList.isEmpty) {
        List<Map<String, dynamic>> x = List.generate(10, (index) {
          return {
            'id': index.toString(),
            'title': 'empty resp',
            'photos': [
              'https://api.luxyh.com/fileuploads/dummy4-1746548582119.jpg',
            ],
            'current_price': 100,
          };
        });
        for (var y in x) {
          tempList.add(ProductCardModel.fromJson(y));
        }
      }

      _logger.w("this is temp list $tempList");
      specialProductList = tempList.sublist(
        0,
        tempList.length > 8 ? 8 : tempList.length,
      );
      productList = tempList;
      update();

      _logger.w("this is product list $tempList");
    }
    isLoading = false;
    update();
  }
}
