import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget{
  static forButton(){
    return LoadingAnimationWidget.dotsTriangle(
      color: Colors.white,
      size: 20,
    );
  }

  static froScreen(){
    return LoadingAnimationWidget.dotsTriangle(
      color: AppColors.themColor,
      size: 50,
    );
  }

}

