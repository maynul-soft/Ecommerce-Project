import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../core/urls.dart';
import '../../../core/service/network_client.dart';
import '../data/model/product_card_model.dart';

class SpecialProductProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ProductCardModel> specialProductList = [];
  List<ProductCardModel> productList = [];

  final Logger _logger = Logger();

  Future<void> getSpecialProduct(context) async {
    isLoading = true;
    notifyListeners();

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).getRequest(
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
      notifyListeners();

      _logger.w("this is product list $tempList");
    }
    isLoading = false;
    notifyListeners();
  }
}
