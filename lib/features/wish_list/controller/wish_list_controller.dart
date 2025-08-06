import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../core/urls.dart';
import '../../../core/service/network_client.dart';
import '../ui/data/model/wish_list_model.dart';

class WishListProvider extends ChangeNotifier {

  final NetworkClient networkClient;

  WishListProvider({required this.networkClient});

  bool _isLoading = false;
  bool _isInitialLoading = false;
  final int _count = 30;
  int _currentPage = 0;
  int? totalItem;
  int? _lastPage;
  List<WishListProductCardModel> _wishList= [];

  final Logger _logger = Logger();

  int get count => _count;

  int get currentPage => _currentPage;

  bool get isLoading => _isLoading;

  bool get isInitialLoading => _isInitialLoading;

  int? get lastPage => _lastPage;

  List<WishListProductCardModel> get wishList => _wishList;

  Future<void> getWishListProduct(context) async {
    if (currentPage > 1) {
      _isLoading = true;
      notifyListeners();
    } else {
      wishList.clear();
      _isInitialLoading = true;
      notifyListeners();
    }

    if (lastPage != null && lastPage! < currentPage) {
      _isLoading = false;
      _isInitialLoading = false;
      notifyListeners();
      return;
    }
    _currentPage++;

    NetworkResponse response = await  networkClient.getRequest(
      url: Urls.wishListUrl,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      List getCategoryList = response.responseBody!['data']['results'];

      for(var item in getCategoryList){
        _wishList.add(WishListProductCardModel.fromJson(item));
      }

      _logger.i('''
      ===>> this is from category list when calling api
      ====>>id: ${wishList[0].itemId}
      ====>>name: ${wishList[0].name}
      ====>>price: ${wishList[0].price};
      ''');
      _lastPage = response.responseBody!['data']['last_page']??1;
      totalItem = response.responseBody!['data']['total']??1;
    }
      _isLoading = false;
      _isInitialLoading = false;
      notifyListeners();
  }
}