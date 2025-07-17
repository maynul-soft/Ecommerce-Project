import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/ui/controller/main_bottom_nav_controller.dart';
import '../../products/controller/prodct_quantity_controller.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  static final String name = 'cart-screen';
  MainBottomNavController mainBottomNavController = Get.find<MainBottomNavController>();
  ProductQuantityController productQuantityController = Get.find<ProductQuantityController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __){
        mainBottomNavController.backToHomeScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            onPressed: () {
              mainBottomNavController.backToHomeScreen();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AssetsPath.productImagePng,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              spacing: 20,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'New year special',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          'Color: red, Size: xl',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.delete),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '৳100',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: AppColors.themColor,
                                        ),
                                      ),
                                    ),
                                    GetBuilder<ProductQuantityController>(
                                      builder: (controller) {
                                        return increaseDecreaseSection();
                                      }
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            buildCheckOutSection(),
          ],
        ),
      ),
    );
  }

  Widget buildCheckOutSection() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: AppColors.themColor.shade50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total price', style: TextStyle(fontSize: 13)),
              Text(
                '৳10000',
                style: TextStyle(fontSize: 25, color: AppColors.themColor),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(onPressed: () {}, child: Text('Checkout')),
          ),
        ],
      ),
    );
  }
  Widget increaseDecreaseSection() {
    return Row(
      children: [
        IconButton(
          onPressed: dicreaseQuantity,
          icon: Icon(
              Icons.indeterminate_check_box,
              color: AppColors.themColor
          ),
        ),
        Text(
          '${productQuantityController.quantity}',
        ),
        IconButton(
          onPressed: increaseQuantity,
          icon: Icon(Icons.add_box,color: AppColors.themColor,),
        ),
      ],
    );
  }

  increaseQuantity() {
    if(productQuantityController.quantity>19) return;
    productQuantityController.increaseQuantity();
  }

  dicreaseQuantity() {
    if(productQuantityController.quantity<2) return;
    productQuantityController.dicreaseQuantity();
  }
}
