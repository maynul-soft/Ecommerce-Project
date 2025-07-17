import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_colors.dart';
import '../../controller/prodct_quantity_controller.dart';

class ProductNameAndQuantitySection extends StatelessWidget {
  final String title;
  final Color? color;


  const ProductNameAndQuantitySection({ super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(overflow: TextOverflow.visible, color: color?? Colors.black),
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