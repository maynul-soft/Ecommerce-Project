import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:crafty_bay_ecommerce/features/cert/data/model/cart_checkout_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class GetCartProductProvider extends ChangeNotifier {
  bool isLoading = false;
  int totalPrice = 0;
  int deliveryCharge = 20;
  int tax = 0;
  int? checkoutPrice;

  List<CartCheckoutModel> cartProductList = [];

  Future<void> getCartProduct(context) async {
    isLoading = true;
    notifyListeners();

    NetworkResponse response = await  Provider.of<NetworkClient>(context, listen: false).getRequest(
      url: Urls.getCartItemUrl,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List respList = response.responseBody!['data']['results'];

      List<CartCheckoutModel> tempList = [];

      for (var item in respList) {
        tempList.add(CartCheckoutModel.fromJson(item));
      }
      cartProductList = tempList;
      countTotalPrice();
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  increaseQuantityFromQty(context, int index) {
    if (cartProductList[index].quantity >= 20) return;
    cartProductList[index].quantity++;
    countTotalPrice();
    notifyListeners();
    updateCart(context, index);
  }

  dicreaseQuantityFromQty(context, int index) {
    if (cartProductList[index].quantity <= 1) return;
    cartProductList[index].quantity--;
    countTotalPrice();
    notifyListeners();
    updateCart(context, index);
  }

  countTotalPrice() {
    totalPrice = cartProductList.fold(
      0,
      (sum, item) => sum + (item.productModel.productPrice * item.quantity),
    );

    tax = (totalPrice*5)~/100;
    finalCheckoutPrice();
    notifyListeners();
  }

  Future<void> updateCart(context, index) async {
    String id = cartProductList[index].cartItemId;
    Map<String, dynamic> body = {"quantity": cartProductList[index].quantity};
    NetworkResponse response = await Provider.of<NetworkClient>(context, listen: false).patchRequest(
      url: Urls.updateCartItemUrl(id: id ),
      body: body,
    );
    Logger().i(response.responseBody);
  }
  Future<void> deleteCartItem(context, index) async {
    String id = cartProductList[index].cartItemId;
    NetworkResponse response = await Provider.of<NetworkClient>(context,listen:  false).deleteRequest(
      url: Urls.deleteItemUrl(id: id),
    );
    cartProductList.removeAt(index);
    if(response.statusCode == 200 || response.statusCode == 201){
      countTotalPrice();
      updateCart(context ,index);

    }
    Logger().i('code==> ${ response.statusCode} body==> ${response.responseBody} error=>> ${response.errorMessage}');
  }

  finalCheckoutPrice(){
    checkoutPrice = (totalPrice+deliveryCharge+tax);
  }
}
