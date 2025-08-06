import 'package:flutter/cupertino.dart';

class CurrentSlideIndicatorProvider extends ChangeNotifier {
  int currentIndex = 0  ;

  changeIndicator(index){
    currentIndex = index;
    notifyListeners();
  }
}