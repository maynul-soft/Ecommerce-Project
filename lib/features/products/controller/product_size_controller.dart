import 'package:flutter/cupertino.dart';

class ProductSizeProvider extends ChangeNotifier {


  String selectedSize = '';
  int? selectedIndex = 0;
  changeIndex(index){
    selectedIndex = index;
    notifyListeners();
  }
  setSize(size){
    selectedSize = size;
    notifyListeners();
  }

  unselectSize(){
    selectedIndex = null;
    notifyListeners();
  }


  bool isSelected({required int key,}){
    if(key==selectedIndex){
      return true;
    }else{
      return false;
    }

  }
}