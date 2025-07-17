import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/auth_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/color_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/current_slide_indicator_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_size_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/review_screen.dart';
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
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  List productImages = [
    AssetsPath.productImagePng,
    AssetsPath.productImage1Png,
    AssetsPath.productImagePng,
    AssetsPath.productImagePng,
    AssetsPath.productImagePng,
  ];
  List<Color> productColor = [
    Colors.black,
    AppColors.themColor,
    Color(0xff915d50),
    Colors.black12,
    Colors.grey,
  ];
  List<String> productSize = ['L', 'M', 'XL', '2XL'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildProductImageSection(context),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductNameAndQuantitySection(title: 'Happy new year special deal save 30%',),
                    const SizedBox(height: 10),
                    buildReviewSection(),
                    const SizedBox(height: 10),
                    buildColorSection(),
                    const SizedBox(height: 10),
                    buildSizeSection(),
                    const SizedBox(height: 10),
                    buildDescriptionSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: buildAddToCartSection(),
      ),
    );
  }

  Container buildAddToCartSection() {
    return Container(
        height: 90,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.themColor.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Price', style: TextStyle(color: Colors.black54)),
                  Text('৳1000', style: TextStyle(color: AppColors.themColor)),
                ],
              ),
              GestureDetector(
                onTap: (){
                  bool isLoggedIn = AuthController().isLoggedIn();
                    if(!isLoggedIn){
                      Navigator.pushNamed(context, LoginScreen.name);
                    }
                },
                child: Container(
                  padding: EdgeInsets.symmetric (horizontal: 25,vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.themColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Add to card',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Column buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        Text(
          'Reference site about Lorem ipsum, giving information on its origins, as well '
          'as a random Lipsum generator Reference site about Lorem ipsum,'
          ' giving information on its origns, as well as a random Lipsum generator'
          'as a random Lipsum generator Reference site about Lorem ipsum,'
          ' giving information on its origns, as well as a random Lipsum generator',

          style: TextStyle(
            overflow: TextOverflow.visible,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Padding buildSizeSection() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size',
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Row(
            children:
                productSize.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      ProductSizeController.controller.changeIndex(entry.key);
                      ProductSizeController.controller.setSize(entry.value);
                    },
                    child: GetBuilder<ProductSizeController>(
                      builder: (context) {
                        return Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color:
                                ProductSizeController.controller.isSelected(
                                          key: entry.key,
                                        ) ==
                                        true
                                    ? AppColors.themColor
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color:
                                  ProductSizeController.controller.isSelected(
                                            key: entry.key,
                                          ) ==
                                          true
                                      ? AppColors.themColor
                                      : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: FittedBox(
                            child: Center(
                              child: Text(
                                entry.value,
                                style: TextStyle(
                                  color:
                                      ProductSizeController.controller
                                                  .isSelected(key: entry.key) ==
                                              true
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildColorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          children:
              productColor.asMap().entries.map((entry) {
                int index = entry.key;
                Color i = entry.value;
                return GestureDetector(
                  onTap: () {
                    ColorController.controller.changeIndex(index);
                    carouselSliderController.jumpToPage(
                      ColorController.controller.currentIndex,
                    );
                  },
                  child: GetBuilder<ColorController>(
                    builder: (controller) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: i,
                        ),
                        child:
                            ColorController.controller.currentIndex == index
                                ? Icon(Icons.done, color: Colors.white)
                                : Text(''),
                      );
                    },
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget buildReviewSection() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 5),
        Text(
          '4.8',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, ReviewScreen.name);
          },
          child: Text(
            'Reviews',
            style: TextStyle(
              color: AppColors.themColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Card(
          color: AppColors.themColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
      carouselController: carouselSliderController,
      items:
          productImages.asMap().entries.map((entry) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(
                  entry.value,
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
            productImages.asMap().entries.map((entry) {
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
                          currentIndex == entry.key
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
