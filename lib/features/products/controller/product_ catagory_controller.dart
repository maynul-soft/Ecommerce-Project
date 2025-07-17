import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/products/data/model/category_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProductCategoryController extends GetxController {
  bool _isLoading = false;
  bool _isInitialLoading = false;
  final int _count = 30;
  int _currentPage = 0;
  int? _lastPage;
  List<CategoryModel> _categoryList= [];

  Logger _logger = Logger();

  int get count => _count;

  int get currentPage => _currentPage;

  bool get isLoading => _isLoading;

  bool get isInitialLoading => _isInitialLoading;

  int? get lastPage => _lastPage;

  List<CategoryModel> get categoryList => _categoryList;

  Future<void> getCategoryList() async {
    if (currentPage > 1) {
      _isLoading = true;
      update();
    } else {
      _isInitialLoading = true;
      update();
    }

    if (lastPage != null && lastPage! < currentPage) {
      _isLoading = false;
      _isInitialLoading = false;
      update();
      return;
    }
    _currentPage++;

    NetworkResponse response = await Get.find<NetworkClient>().getRequest(
      url: Urls.productCatagoryUrl(count: count, page: currentPage),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      List getCategoryList = response.responseBody!['data']['results'];

      for(var item in getCategoryList){
        _categoryList.add(CategoryModel.fromJosn(item));
      }

      _logger.i('''
      ===>> this is from category list when calling api
      ====>> ${categoryList[0].id}
      ====>> ${categoryList[0].title}
      ====>> ${categoryList[0].description};
      ''');

      _lastPage = response.responseBody!['data']['last_page'];
    }



    if (currentPage > 1) {
     await Future.delayed(Duration(seconds: 2));
      _isLoading = false;
      update();
    } else {
      _isInitialLoading = false;
      update();
    }
  }
}
