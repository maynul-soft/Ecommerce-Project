import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/cert/controller/get_cart_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/checkout/ui/screens/place_order_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/ui/controller/main_bottom_nav_controller.dart';
import '../../products/controller/prodct_quantity_controller.dart';

class CartCheckOutScreen extends StatefulWidget {
  const CartCheckOutScreen({super.key});

  @override
  State<CartCheckOutScreen> createState() => _CartCheckOutScreenState();
}

class _CartCheckOutScreenState extends State<CartCheckOutScreen> {
  static final String name = 'cart-screen';

  MainBottomNavController mainBottomNavController =
      Get.find<MainBottomNavController>();
  ProductQuantityController productQuantityController =
      Get.find<ProductQuantityController>();
  GetCartProductController getCartProductController =
      Get.find<GetCartProductController>();

  @override
  void initState() {
    super.initState();
    fetchCartProduct();
  }

  fetchCartProduct() async {
    await Get.find<GetCartProductController>().getCartProduct();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
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
        body: GetBuilder<GetCartProductController>(
          builder: (controller) {
            return Visibility(
              visible: controller.isLoading == false,
              replacement: Center(child: LoadingWidget.forScreen()),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cartProductList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller
                                        .cartProductList[index]
                                        .productModel
                                        .productImage
                                        .isNotEmpty
                                    ? Image.network(
                                      controller
                                          .cartProductList[index]
                                          .productModel
                                          .productImage
                                          .first,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    )
                                    : Image.asset(
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
                                                //title
                                                '${controller.cartProductList[index].productModel.productTitle.substring(0, controller.cartProductList[index].productModel.productTitle.length < 16 ? controller.cartProductList[index].productModel.productTitle.length : 16)}..',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Row(
                                                children: [
                                                  controller
                                                              .cartProductList[index]
                                                              .color !=
                                                          null
                                                      ? Text(
                                                        'Color: ${controller.cartProductList[index].color}  ',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                      : SizedBox.shrink(),
                                                  controller
                                                              .cartProductList[index]
                                                              .size !=
                                                          null
                                                      ? Text(
                                                        'Color: ${controller.cartProductList[index].size}',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                      : SizedBox.shrink(),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(onPressed:()=> onPressedDeleteCartItem(index), icon: Icon(Icons.delete)),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              //price
                                              "${controller.cartProductList[index].quantity * controller.cartProductList[index].productModel.productPrice}",
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: AppColors.themColor,
                                              ),
                                            ),
                                          ),
                                          GetBuilder<ProductQuantityController>(
                                            builder: (controller) {
                                              return increaseDecreaseSection(
                                                index,
                                              );
                                            },
                                          ),
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
            );
          },
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
              GetBuilder<GetCartProductController>(
                builder: (controller) {
                  return Text(
                    '৳${controller.totalPrice}',
                    style: TextStyle(fontSize: 25, color: AppColors.themColor),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, PlaceOrderScreen.name);
            }, child: Text('Checkout')),
          ),
        ],
      ),
    );
  }

  Widget increaseDecreaseSection(int index) {
    return GetBuilder<GetCartProductController>(
      builder: (controller) {
        return Row(
          children: [
            IconButton(
              onPressed: () {
                controller.dicreaseQuantityFromQty(index);
              },
              icon: Icon(
                Icons.indeterminate_check_box,
                color: AppColors.themColor,
              ),
            ),
            Text(
              '${Get.find<GetCartProductController>().cartProductList[index].quantity}',
            ),
            IconButton(
              onPressed: () {
                controller.increaseQuantityFromQty(index);
              },
              icon: Icon(Icons.add_box, color: AppColors.themColor),
            ),
          ],
        );
      },
    );
  }

  onPressedDeleteCartItem(index){
    Get.find<GetCartProductController>().deleteCartItem(index);
  }
}
