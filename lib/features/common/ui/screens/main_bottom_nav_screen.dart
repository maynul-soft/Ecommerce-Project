import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/screens/home_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_catagory_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../wish_list/ui/screens/wish_list.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static String name = 'main_bottom_nav';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  List<Widget> screens = [
    HomeScreen(),
    ProductCategoryScreen(),
    HomeScreen(),
    WishList(),
  ];

  MainBottomNavController mainBottomNavController =
      Get.find<MainBottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BuildBottomNav(),
      body: GetBuilder<MainBottomNavController>(
        builder: (controller) {
          return screens[controller.selectedIndex];
        }
      ),
    );
  }
}



class BuildBottomNav extends StatelessWidget {
  const BuildBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (controller) {
        return NavigationBar(
          selectedIndex: controller.selectedIndex,
          onDestinationSelected: (int index) {
            controller.changeScreen(index);
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'home'),
            NavigationDestination(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outlined),
              label: 'category',
            ),
          ],
        );
      },
    );
  }
}
