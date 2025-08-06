import 'package:flutter/material.dart';
class MainBottomNavProvider extends ChangeNotifier{
  int selectedIndex = 0;


  changeScreen(index){
    selectedIndex = index;
    notifyListeners();
  }
  gotoCategoryScreen(){
    selectedIndex = 1;
    notifyListeners();
  }
  backToHomeScreen(){
    selectedIndex = 0;
    notifyListeners();
  }


}