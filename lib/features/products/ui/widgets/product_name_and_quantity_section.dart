
import 'package:crafty_bay_ecommerce/features/products/controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../controller/prodct_quantity_controller.dart';

class ProductNameAndQuantitySection extends StatelessWidget {

  const ProductNameAndQuantitySection({ super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsProvider>(
      builder: (_,controller,_) {
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
            Consumer<ProductQuantityProvider>(
                builder: (context, provider, child) {
                  return increaseDecreaseSection(context);
                }
            ),
          ],
        );
      }
    );
  }

  Widget increaseDecreaseSection(BuildContext context) {
    return Row(
              children: [
                IconButton(
                  onPressed: (){if(context.read<ProductQuantityProvider>().quantity>1){
                    context.read<ProductQuantityProvider>().dicreaseQuantity();
                  }},
                  icon: Icon(
                      Icons.indeterminate_check_box,
                      color:AppColors.themColor
                  ),
                ),
                Text(
                  '${context.watch<ProductQuantityProvider>().quantity}'
                  // '${ProductQuantityController.Controller.quantity}',
                ),
                IconButton(
                  onPressed: (){if(context.read<ProductQuantityProvider>().quantity<20){
                    context.read<ProductQuantityProvider>().increaseQuantity();
                  }},
                  icon: Icon(Icons.add_box,color: buttonColor(),),
                ),
              ],
            );
  }

  buttonColor() {
    return AppColors.themColor;
  }

}