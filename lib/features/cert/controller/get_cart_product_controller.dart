import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network/network_client.dart';
import 'package:crafty_bay_ecommerce/features/cert/data/model/cart_checkout_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GetCartProductController extends GetxController {
  bool isLoading = false;
  int totalPrice = 0;
  int deliveryCharge = 20;
  int tax = 0;
  int? checkoutPrice;

  List<CartCheckoutModel> cartProductList = [];

  Future<void> getCartProduct() async {
    isLoading = true;
    update();

    NetworkResponse response = await Get.find<NetworkClient>().getRequest(
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
      update();
    }

    isLoading = false;
    update();
  }

  increaseQuantityFromQty(int index) {
    if (cartProductList[index].quantity >= 20) return;
    cartProductList[index].quantity++;
    countTotalPrice();
    update();
    updateCart(index);
  }

  dicreaseQuantityFromQty(int index) {
    if (cartProductList[index].quantity <= 1) return;
    cartProductList[index].quantity--;
    countTotalPrice();
    update();
    updateCart(index);
  }

  countTotalPrice() {
    totalPrice = cartProductList.fold(
      0,
      (sum, item) => sum + (item.productModel.productPrice * item.quantity),
    );

    tax = (totalPrice*5)~/100;
    finalCheckoutPrice();
    update();
  }

  Future<void> updateCart(index) async {
    String id = cartProductList[index].cartItemId;
    Map<String, dynamic> body = {"quantity": cartProductList[index].quantity};
    NetworkResponse response = await Get.find<NetworkClient>().patchRequest(
      url: Urls.updateCartItemUrl(id: id ),
      body: body,
    );
    Logger().i(response.responseBody);
  }
  Future<void> deleteCartItem(index) async {
    String id = cartProductList[index].cartItemId;
    NetworkResponse response = await Get.find<NetworkClient>().deleteRequest(
      url: Urls.deleteItemUrl(id: id),
    );
    cartProductList.removeAt(index);
    if(response.statusCode == 200 || response.statusCode == 201){
      countTotalPrice();
      updateCart(index);

    }
    Logger().i('code==> ${ response.statusCode} body==> ${response.responseBody} error=>> ${response.errorMessage}');
  }

  finalCheckoutPrice(){
    checkoutPrice = (totalPrice+deliveryCharge+tax);
  }
}
