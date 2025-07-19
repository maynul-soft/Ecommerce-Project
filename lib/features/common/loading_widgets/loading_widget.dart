import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/home_carousel_shimmer.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/product_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'category_card_shimmer.dart';

class LoadingWidget {
  static forButton() {
    return LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 20);
  }

  static forScreen() {
    return LoadingAnimationWidget.dotsTriangle(
      color: AppColors.themColor,
      size: 50,
    );
  }

  static forProductCardShimmerHorizontalAxis() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 5,
        children: List.generate(5, (index) => ProductCardShimmer()),
      ),
    );
  }

  static forCategoryCardShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 5,
        children: List.generate(5, (index) => CategoryCardShimmer()),
      ),
    );
  }

  static forHomeCarouselShimmer() {
    return HomeCarouselShimmer();
  }
}
