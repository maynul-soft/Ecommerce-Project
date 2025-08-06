import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../core/urls.dart';
import '../../../core/service/network_client.dart';
import '../data/model/product_card_model.dart';

class NewProductProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ProductCardModel> newProductList = [];
  List<ProductCardModel> productList = [];

  final Logger _logger = Logger();

  Future<void> getNewProduct(context) async {
    isLoading = true;
    notifyListeners();

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).getRequest(
      url: Urls.productByTagUrl(tag: 'new'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List nProductList = response.responseBody!['data']['results'];
      newProductList.clear();
      List<ProductCardModel> tempList = [];
      _logger.w(response);
      for (var data in nProductList) {
        tempList.add(ProductCardModel.fromJson(data));
      }

      if (tempList.isEmpty) {
        List<Map<String, dynamic>> x = List.generate(10, (index) {
          return {
            'id': index.toString(),
            'title': 'empty resp',
            'photos': ['https://api.luxyh.com/fileuploads/dummy4-1746548582119.jpg'],
            'current_price': 100,
          };
        });
        for (var y in x) {
          tempList.add(ProductCardModel.fromJson(y));
        }
      }

      _logger.w("this is temp list $tempList");
      newProductList = tempList.sublist(0,tempList.length>8? 8:tempList.length );
      productList = tempList;
      notifyListeners();

      _logger.w("this is product list $tempList");
    }
    isLoading = false;
    notifyListeners();
  }
}
