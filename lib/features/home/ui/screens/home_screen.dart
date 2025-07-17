import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/home/controller/home_slider_controller.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/home_carousal_slider.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_%20catagory_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../common/ui/widgets/catagory_card.dart';
import '../../../common/ui/widgets/product_card.dart';
import '../widgets/app_bar_action_button.dart';
import '../widgets/build_search_section.dart';
import '../widgets/home_screen_section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final String name = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MainBottomNavController mainBottomNavController =
      Get.find<MainBottomNavController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                BuildSearchSection(),
                const SizedBox(height: 20),
                GetBuilder<HomeSliderController>(
                  builder: (controller) {
                    return Visibility(
                        visible: controller.isLoading == false,
                        replacement: LoadingWidget.froScreen(),
                        child: HomeCarousalSlider());
                  }
                ),
                const SizedBox(height: 20),
                HomeScreenSectionHeader(
                  header: 'All Categories',
                  onTap: () {
                    mainBottomNavController.gotoCategoryScreen();
                  },
                ),
                const SizedBox(height: 10),
                GetBuilder<ProductCategoryController>(
                  builder: (controller) {
                    return Visibility(
                          visible: controller.isLoading == false && controller.isInitialLoading == false,
                        replacement: LoadingWidget.froScreen(),
                        child: buildCategorySection());
                  }
                ),
                HomeScreenSectionHeader(header: 'Popular'),
                const SizedBox(height: 5),
                getPopularProduct(),
                HomeScreenSectionHeader(header: 'Special'),
                const SizedBox(height: 10),
                getSpecialProduct(),
                const SizedBox(height: 5),
                HomeScreenSectionHeader(header: 'New'),
                const SizedBox(height: 10),
                getSpecialProduct(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategorySection() {
    return GetBuilder<ProductCategoryController>(
      builder: (categoryController) {
        return SizedBox(
          height: 115,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((BuildContext context, int index) {
              var controller = categoryController.categoryList[index];
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ProductList.name, arguments: controller.title);
                  },
                child: CategoryCard(imageUrl: controller.icon, categoryName: controller.title),
              );
            }),
            separatorBuilder: ((_, _) => SizedBox(width: 20)),
            itemCount: categoryController.categoryList.length> 10? 10:categoryController.categoryList.length ,
          ),
        );
      }
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.navLogoSvg),
      actions: [
        appBarActionButton(onPressed: () {}, icon: Icons.person_2_outlined),
        appBarActionButton(onPressed: () {}, icon: Icons.call_outlined),
        appBarActionButton(
          onPressed: () {},
          icon: Icons.notifications_active_outlined,
        ),
      ],
    );
  }

  Widget getPopularProduct() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children:
            [1, 2, 3, 4, 5].map((e) {
              return ProductCard();
            }).toList(),
      ),
    );
  }

  Widget getSpecialProduct() {
    return SizedBox(
      height: ProductCard.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: ((BuildContext context, int index) {
          return ProductCard();
        }),
        separatorBuilder: (_, __) => Container(width: 10),
      ),
    );
  }

  Widget getNewProduct() {
    return SizedBox(
      height: ProductCard.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: ((BuildContext context, int index) {
          return ProductCard();
        }),
        separatorBuilder: (_, __) => Container(width: 10),
      ),
    );
  }
}



