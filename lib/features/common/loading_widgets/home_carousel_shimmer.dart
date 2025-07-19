import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/app_colors.dart';

class HomeCarouselShimmer extends StatelessWidget {
  const HomeCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.themColor.shade300,
          highlightColor: AppColors.themColor.shade50,
          child: Container(
            height: 140,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.all(4),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        )
      ],
    );
  }
}
