import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/assets_path.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.id,
    this.title,
    this.price,
    this.rating,
    this.imageUrl,
    super.key,
  });

  static const height = 170.0;

  final String? title;
  final String? rating;
  final int? price;
  final String? imageUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailScreen.name,arguments: id),
      child: Container(
        width: 120,
        height: height,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // softer shadow
              blurRadius: 2,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.themColor.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child:
                  imageUrl != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        child: Image.network(
                          imageUrl!,
                          height: 100,
                          width: 120,
                          fit: BoxFit.fill,
                        ),
                      )
                      : Image.asset(AssetsPath.productImagePng, height: 100),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4, left: 4, right: 4),
              child: Column(
                children: [
                  Text(
                    title ?? 'Nike special for new year',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${price.toString()}৳",
                        style: TextTheme.of(context).labelSmall,
                      ),
                      Wrap(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 15),
                          Text(
                            rating ?? '4.7',
                            style: TextTheme.of(context).labelSmall,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.themColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.favorite_border,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 3),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
