import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/current_slide_indicator_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/prodct_quantity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  static final String name = 'ProductDetails';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CurrentSlideIndicatorController currentSlideIndicatorController =
      Get.find<CurrentSlideIndicatorController>();

  List productImages = [1, 2, 3, 4, 5, 6];

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
              Row(children: [

              ],)
            ],
          ),
        ),
      ),
    );
  }

  Container buildProductImageSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Stack(
        children: [
          ProductDetailCarousalSlider(productImages: productImages),
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
          BuildSlideIndicator(productImages: productImages),
        ],
      ),
    );
  }

  backToHomeScree() {
    Navigator.pop(context);
  }
}

class ProductNameAndQuantitySection extends StatefulWidget {
  const ProductNameAndQuantitySection({super.key});

  @override
  State<ProductNameAndQuantitySection> createState() =>
      _ProductNameAndQuantitySectionState();
}

class _ProductNameAndQuantitySectionState
    extends State<ProductNameAndQuantitySection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Happy new year special deal save 30%',
              style: TextStyle(overflow: TextOverflow.visible),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GetBuilder<ProductQuantityController>(
            builder: (context) {
              return Row(
                children: [
                  IconButton(
                    onPressed: isDecreasable()?dicreaseQuantity:(){},
                    icon: Icon(
                      Icons.indeterminate_check_box,
                      color: isDecreasable()? AppColors.themColor:AppColors.themColor.shade200
                    ),
                  ),
                  Text(
                    '${ProductQuantityController.Controller.quantity}',
                  ),
                  IconButton(
                    onPressed: increaseQuantity,
                    icon: Icon(Icons.add_box,color: buttonColor(),),

                  ),
                ],
              );
            }
          ),
        ),
      ],
    );
  }

  buttonColor() {
    return AppColors.themColor;
  }

  increaseQuantity() {
    ProductQuantityController.Controller.increaseQuantity();
  }

  dicreaseQuantity() {
    ProductQuantityController.Controller.dicreaseQuantity();
  }

  bool isDecreasable(){
    if(ProductQuantityController.Controller.quantity>1){
      return true;
    }else{
      return false;
    }
  }
}

class ProductDetailCarousalSlider extends StatelessWidget {
  const ProductDetailCarousalSlider({super.key, required this.productImages});

  final List productImages;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          productImages.map((i) {
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
}

class BuildSlideIndicator extends StatelessWidget {
  const BuildSlideIndicator({super.key, required this.productImages});

  final List productImages;

  @override
  Widget build(BuildContext context) {
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
}
