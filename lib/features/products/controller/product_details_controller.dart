import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/products/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool isLoading = false;

  ProductModel? productData;

  Future<void> getProduct(context, id) async {
    isLoading = true;
    notifyListeners();

    productData = null;

    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).getRequest(
      url: Urls.productDetailsUrl(id: id),
    );

    if(response.statusCode == 200 || response.statusCode == 201){
      productData = ProductModel.fromJson(response.responseBody!['data']);
      notifyListeners();

      Logger().t(productData!.sizes);
    }

    isLoading = false;
    notifyListeners();
  }
}
