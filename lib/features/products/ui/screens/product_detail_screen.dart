import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/current_slide_indicator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/product_name_and_quantity_section.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  static final String name = 'ProductDetails';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CurrentSlideIndicatorController currentSlideIndicatorController =
      Get.find<CurrentSlideIndicatorController>();
  final  CarouselController carouselController = CarouselController();

  List productImages = [1, 2, 3, 4, 5,];
  List<Color> productColor = [Colors.black, AppColors.themColor, Color(0xff221122), Colors.black12, Colors.grey, ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildProductImageSection(context),
              const SizedBox(height: 10),
              ProductNameAndQuantitySection(),
              const SizedBox(height: 5),
              buildReviewSection(),
              const SizedBox(height: 5),
              buildColorSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColorSection(){
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Color'),
          GestureDetector(
            onTap: (){},
            child: Row(
              children: productColor.asMap().entries.map((entry){
                int index = entry.key;
                Color i = entry.value;
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: i,
                  ),
                );
              }).toList()
            ),
          )
        ],
      ),
    );
  }

  Widget buildReviewSection() {
    return Row(
              children: [
                const SizedBox(width: 5,),
                Icon(Icons.star, color: Colors.amber,size: 20,),
                const SizedBox(width: 5,),
                Text('4.8',style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w300),),
                const SizedBox(width: 8,),
                Text('Reviews',style: TextStyle(color:  AppColors.themColor,fontSize: 18,fontWeight: FontWeight.w500)),
                const SizedBox(width: 8,),
                Card(
                  color: AppColors.themColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.favorite_outline, color: Colors.white),
                ),
              ],
            );
  }

  Widget buildProductImageSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Stack(
        children: [
          productDetailCarousalSlider(productImages),
          Row(
            children: [
              IconButton(
                onPressed: backToHomeScree,
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
              Column(
                children: [
                  Text(
                    'Product details',
                    style: TextTheme.of(context).titleMedium,
                  ),
                ],
              ),
            ],
          ),
          buildSlideIndicator(productImages),
        ],
      ),
    );
  }

  Widget productDetailCarousalSlider(List productImages) {
    return CarouselSlider(
      items:
          productImages.asMap().entries.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(
                  AssetsPath.productImagePng,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.fill,
                );
              },
            );
          }).toList(),
      options: CarouselOptions(
        height: 250,
        viewportFraction: 1,
        onPageChanged: (int index, _) {
          Get.find<CurrentSlideIndicatorController>().changeIndicator(index);
        },
      ),
    );
  }

  Widget buildSlideIndicator(List productImages) {
    return Padding(
      padding: const EdgeInsets.only(top: 230),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            productImages.map((i) {
              return GetBuilder<CurrentSlideIndicatorController>(
                builder: (controller) {
                  int currentIndex =
                      Get.find<CurrentSlideIndicatorController>().currentIndex;
                  return Container(
                    margin: EdgeInsets.only(right: 5),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color:
                          currentIndex + 1 == i
                              ? AppColors.themColor
                              : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.themColor),
                    ),
                  );
                },
              );
            }).toList(),
      ),
    );
  }

  backToHomeScree() {
    Navigator.pop(context);
  }
}
