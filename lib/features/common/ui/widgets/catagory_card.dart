import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key, required this.categoryName, required this.icon,
  });

  final String categoryName;
  final IconData icon;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.themColor.shade100,
          ),
          child: Icon(
            icon,
            size: 50,
            color: AppColors.themColor,
          ),
        ),
        Text(categoryName,style: TextStyle(color: AppColors.themColor),),
      ],
    );
  }
}