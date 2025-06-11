import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishList extends StatefulWidget {
  const WishList({super.key, });

  static final String name = 'wish-list';

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,__)=>_backToHome(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _backToHome,
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            'Wish List',
            style: TextTheme.of(context).headlineSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            itemCount: 100,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16
            ),
            itemBuilder: ((BuildContext context, int index) {
              return FittedBox(
                child: ProductCard(),
              );
            }),
          ),
        ),
      ),
    );
  }
  _backToHome(){
    Get.find<MainBottomNavController>().backToHomeScreen();
  }
}
