import 'package:crafty_bay_ecommerce/features/products/data/model/product_card_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../app/urls.dart';
import '../../../core/service/network/network_client.dart';

class ProductListByCategoryController extends GetxController {
  bool _isLoading = false;
  bool _isInitialLoading = false;
  final int _count = 30;
  int _currentPage = 0;
  int? _lastPage;
  String? _id;
  List<ProductCardModel> _productList = [];

  final Logger _logger = Logger();

  int get count => _count;

  int get currentPage => _currentPage;

  bool get isLoading => _isLoading;

  bool get isInitialLoading => _isInitialLoading;

  int? get lastPage => _lastPage;

  List<ProductCardModel> get productList => _productList;

  Future<void> getProductList({required String categoryId}) async {

    _logger.w('currentPage Before sum=> $currentPage');

    if (_id != null && _id != categoryId) {
      _currentPage = 0;
      _lastPage = null;
      _productList.clear();

      _logger.w('Category not mathced! &&  make zero current page=> $currentPage');
    }

    if (currentPage > 1) {
      _isLoading = true;
      _isInitialLoading = false;
      update();
    } else {
      _isInitialLoading = true;
      _isLoading = false;
      update();
    }

    if (lastPage != null && lastPage! <= currentPage) {
      _isLoading = false;
      _isInitialLoading = false;
      update();
      return;
    }
    _currentPage++;

    _logger.w('After sum=> $currentPage');

    NetworkResponse response = await Get.find<NetworkClient>().getRequest(
      url: Urls.productListByCategory(
        count: count,
        page: currentPage,
        categoryId: categoryId,
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<ProductCardModel> tempProductList = [];

      for (var item in response.responseBody!['data']['results']) {
        tempProductList.add(ProductCardModel.fromJson(item));
      }
      _productList.addAll(tempProductList);

      if (productList.isNotEmpty) {
        _logger.i('''
      ===>> this is from category list when calling api
      ===>> ${productList.length}
      ====>> ${productList[0].id}
      ====>> ${productList[0].name}
      ====>> ${productList[0].price};
      ''');
      } else {
        _logger.i('''
      ===>> this is from category list when calling api
      ===>> empty list
      ''');
      }
      _lastPage = response.responseBody!['data']['last_page'];

    }

    _id = categoryId;


      _isLoading = false;
      _isInitialLoading = false;
      update();


  }
}
