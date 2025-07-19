import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/auth_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/add_cart_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/color_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/current_slide_indicator_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/prodct_quantity_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_details_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_size_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/review_screen.dart';
import 'package:crafty_bay_ecommerce/features/wish_list/controller/add_to_wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/product_name_and_quantity_section.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.id, super.key});

  static final String name = 'ProductDetails';
  final String id;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CurrentSlideIndicatorController currentSlideIndicatorController =
      Get.find<CurrentSlideIndicatorController>();
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    await Get.find<ProductDetailsController>().getProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProductDetailsController>(
          builder: (controller) {
            return Visibility(
              visible: controller.isLoading == false,
              replacement: Center(child: LoadingWidget.forScreen()),
              child:
                  controller.productData == null
                      ? Center(child: Text('Maybe its a dummy product'))
                      : SingleChildScrollView(
                        child: Column(
                          children: [
                            buildProductImageSection(
                              context,
                              controller.productData!.photos,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductNameAndQuantitySection(),
                                  const SizedBox(height: 10),
                                  buildReviewSection(widget.id),
                                  const SizedBox(height: 10),
                                  buildColorSection(
                                    controller.productData?.colors,
                                  ),
                                  const SizedBox(height: 10),
                                  buildSizeSection(
                                    controller.productData?.sizes,
                                  ),
                                  const SizedBox(height: 10),
                                  buildDescriptionSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
            );
          },
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
                GetBuilder<ProductDetailsController>(
                  builder: (controller) {
                    return Text(
                      controller.productData?.price.toString() ?? '',
                      style: TextStyle(color: AppColors.themColor),
                    );
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                bool isLoggedIn = AuthController().isLoggedIn();
                if (!isLoggedIn) {
                  Get.snackbar('Sorry', 'Something went wrong');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.name,
                    (route) => false,
                  );
                } else {
                  Get.find<AddToCartController>().addToCart(
                    quantity: Get.find<ProductQuantityController>().quantity,

                    id: Get.find<ProductDetailsController>().productData!.id,
                    color: Get.find<ProductDetailsController>().productData!.colors.isNotEmpty?
                        Get.find<ProductDetailsController>()
                            .productData!
                            .colors[Get.find<ColorController>().currentIndex] : null,
                    size:
                        Get.find<ProductSizeController>().selectedIndex != null && Get.find<ProductDetailsController>().productData!.sizes.isNotEmpty
                            ? Get.find<ProductDetailsController>()
                                .productData!
                                .colors[Get.find<ProductSizeController>()
                                .selectedIndex!]
                            : null,
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                decoration: BoxDecoration(
                  color: AppColors.themColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Add to card',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
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
          Get.find<ProductDetailsController>().productData?.description ?? '',

          style: TextStyle(
            overflow: TextOverflow.visible,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Padding buildSizeSection(List<String>? sizes) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child:
          sizes != null && sizes.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Size',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    children:
                        sizes.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () {
                              ProductSizeController.controller.changeIndex(
                                entry.key,
                              );
                              ProductSizeController.controller.setSize(
                                entry.value,
                              );
                            },
                            onDoubleTap: () {
                              ProductSizeController.controller.unselectSize();
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
                                        ProductSizeController.controller
                                                    .isSelected(
                                                      key: entry.key,
                                                    ) ==
                                                true
                                            ? AppColors.themColor
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color:
                                          ProductSizeController.controller
                                                      .isSelected(
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
                                                          .isSelected(
                                                            key: entry.key,
                                                          ) ==
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
                  Text('double tap to unselect size',style: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.normal),)
                ],
              )
              : SizedBox.shrink(),
    );
  }

  Widget buildColorSection(List<String>? colors) {
    return colors != null && colors.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    colors.asMap().entries.map((entry) {
                      int index = entry.key;
                      String colorName = entry.value;
                      return GestureDetector(
                        onTap: () {
                          ColorController.controller.changeIndex(index);
                          // carouselSliderController.jumpToPage(
                          //   ColorController.controller.currentIndex,
                          // ); /// it will change the image with link
                        },
                        child: GetBuilder<ColorController>(
                          builder: (controller) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.themColor),
                                borderRadius: BorderRadius.circular(30),
                                color:
                                    index ==
                                            ColorController
                                                .controller
                                                .currentIndex
                                        ? AppColors.themColor.shade200
                                        : null,
                              ),
                              child: Text(
                                colorName,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        )
        : SizedBox.shrink();
  }

  Widget buildReviewSection(String id) {
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
          onTap: () {
            Navigator.pushNamed(context, ReviewScreen.name, arguments: id);
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
          child: IconButton(onPressed: (){
            Get.find<AddToWishListController>().addToWishList(id: id);
          }, icon: Icon(Icons.favorite_outline, color: Colors.white)),
        ),
      ],
    );
  }

  Widget buildProductImageSection(BuildContext context, List<String>? photos) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Stack(
        children: [
          productDetailCarousalSlider(photos!),
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
          buildSlideIndicator(photos),
        ],
      ),
    );
  }

  Widget productDetailCarousalSlider(List<String> productImages) {
    return CarouselSlider(
      carouselController: carouselSliderController,
      items:
          productImages.asMap().entries.map((entry) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
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
