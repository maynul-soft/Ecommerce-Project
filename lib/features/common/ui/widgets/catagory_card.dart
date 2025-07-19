import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryName,
    this.icon,
    this.imageUrl,
  });

  final String categoryName;
  final IconData? icon;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            height: 80,
            width: 80,
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.themColor.shade100,
            ),
            child:
                imageUrl != null
                    ? Image.network(imageUrl!, fit: BoxFit.fill)
                    : Icon(icon, size: 50, color: AppColors.themColor),
          ),
        ),
        Text(
          customTitle(categoryName),
          style: TextStyle(fontSize: 10, color: AppColors.themColor),
        ),
      ],
    );
  }

  customTitle(String title) {
    if (title.length > 12) {
      return '${title.substring(0, 12)}..';
    } else {
      return title;
    }
  }
}
