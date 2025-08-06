import 'package:flutter/cupertino.dart';

class ProductQuantityProvider extends ChangeNotifier {

  int quantity = 1;

  increaseQuantity(){
    quantity++;
    notifyListeners();
  }
  dicreaseQuantity(){
    quantity--;
    notifyListeners();
  }
}