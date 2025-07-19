import 'package:crafty_bay_ecommerce/features/products/controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_colors.dart';
import '../../controller/prodct_quantity_controller.dart';

class ProductNameAndQuantitySection extends StatelessWidget {

  const ProductNameAndQuantitySection({ super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                controller.productData?.title?? '',
                style: TextStyle(overflow: TextOverflow.visible, ),
              ),
            ),
            GetBuilder<ProductQuantityController>(
                builder: (context) {
                  return increaseDecreaseSection();
                }
            ),
          ],
        );
      }
    );
  }

  Widget increaseDecreaseSection() {
    return Row(
              children: [
                IconButton(
                  onPressed: dicreaseQuantity,
                  icon: Icon(
                      Icons.indeterminate_check_box,
                      color:AppColors.themColor
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

  buttonColor() {
    return AppColors.themColor;
  }

  increaseQuantity() {
    if(ProductQuantityController.Controller.quantity>19) return;
    ProductQuantityController.Controller.increaseQuantity();
  }

  dicreaseQuantity() {
    if(ProductQuantityController.Controller.quantity<2) return;
    ProductQuantityController.Controller.dicreaseQuantity();
  }
}