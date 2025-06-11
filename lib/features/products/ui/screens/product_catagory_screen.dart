import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui/widgets/catagory_card.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({super.key});

  static final String name = 'product_category';

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {

  MainBottomNavController mainBottomNavController = Get.find<MainBottomNavController>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,__){
        mainBottomNavController.backToHomeScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories',style: TextTheme.of(context).headlineSmall,),
          leading: IconButton(onPressed: _onTapBackButton, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: GridView.builder(
          itemCount: 100,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: ((BuildContext context, int index){
              return FittedBox(child: CategoryCard(categoryName: 'Computer', icon: Icons.laptop));
            })
        ),
      
        
      
      ),
    );
  }
  _onTapBackButton(){
    mainBottomNavController.backToHomeScreen();
  }
}
