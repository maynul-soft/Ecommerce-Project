import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_colors.dart';
import '../../controller/prodct_quantity_controller.dart';

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