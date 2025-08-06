import 'package:flutter/cupertino.dart';


class ColorProvider extends ChangeNotifier {

  int currentIndex = 0;

  changeIndex(index){
    currentIndex = index;
   notifyListeners();
  }
}
