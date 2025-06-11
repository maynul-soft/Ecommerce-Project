import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_catagory_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
class HomeScreenSectionHeader extends StatelessWidget {
   const HomeScreenSectionHeader({
    super.key, required this.header,
    this.onTap
  });

  final String header;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'See All',
            style: TextStyle(fontSize: 15, color: AppColors.themColor),
          ),
        ),
      ],
    );
  }
}