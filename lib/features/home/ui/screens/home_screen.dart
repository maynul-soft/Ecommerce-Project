import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/home_carousal_slider.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/new_prduct_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/popular_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_%20catagory_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/special_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_list_by_category_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_list_screen.dart';
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
                HomeCarousalSlider(),
                const SizedBox(height: 20),
                HomeScreenSectionHeader(
                  header: 'All Categories',
                  onTap: _onTapToSeeAllCategories,
                ),
                const SizedBox(height: 10),
                buildCategorySection(),
                HomeScreenSectionHeader(header: 'Popular', onTap: _onTapToSeeAllPopularProduct,),
                const SizedBox(height: 5),
                getPopularProduct(),
                HomeScreenSectionHeader(header: 'Special', onTap: _onTapToSeeAlSpecialProduct, ),
                const SizedBox(height: 10),
                getSpecialProduct(),
                const SizedBox(height: 5),
                HomeScreenSectionHeader(header: 'New',onTap: _onTapToSeeAlNewProduct,),
                const SizedBox(height: 10),
                getNewProduct(),
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
        return Visibility(
          visible:
              categoryController.isLoading == false &&
              categoryController.isInitialLoading == false,
          replacement: LoadingWidget.forCategoryCardShimmer(),
          child: SizedBox(
            height: 115,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((BuildContext context, int index) {
                var controller = categoryController.categoryList[index];
                return GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      ProductListByCategoryScreen.name,
                      arguments: categoryController.categoryList[index],
                    );
                  },
                  child: CategoryCard(
                    imageUrl: controller.icon,
                    categoryName: controller.title,
                  ),
                );
              }),
              separatorBuilder: ((_, _) => SizedBox(width: 20)),
              itemCount:
                  categoryController.categoryList.length > 10
                      ? 10
                      : categoryController.categoryList.length,
            ),
          ),
        );
      },
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
    return GetBuilder<PopularProductController>(
      builder: (controller) {
        return Visibility(
          visible: controller.isLoading == false,
          replacement: LoadingWidget.forProductCardShimmerHorizontalAxis(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children:
                  controller.popularProductList.asMap().entries.map((e) {
                    int index = e.key;
                    var value = e.value;
                    return ProductCard(
                      id: index.toString(),
                      title: value.name,
                      price: value.price,
                      imageUrl: value.imageUrl.isNotEmpty ? value.imageUrl.first : null,
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget getSpecialProduct() {
    return GetBuilder<SpecialProductController>(
      builder: (controller) {
        return Visibility(
          visible: controller.isLoading == false,
          replacement: LoadingWidget.forProductCardShimmerHorizontalAxis(),
          child: SizedBox(
            height: ProductCard.height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.specialProductList.length,
              itemBuilder: ((BuildContext context, int index) {
                var item = controller.specialProductList[index];
                return ProductCard(
                  id:  item.id,
                  title: item.name,
                  price: item.price,
                  imageUrl: item.imageUrl.first,
                );
              }),
              separatorBuilder: (_, __) => Container(width: 10),
            ),
          ),
        );
      },
    );
  }

  Widget getNewProduct() {
    return GetBuilder<NewProductController>(
      builder: (controller) {
        return Visibility(
          visible:  controller.isLoading == false,
          replacement:  LoadingWidget.forProductCardShimmerHorizontalAxis(),
          child: SizedBox(
            height: ProductCard.height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.newProductList.length,
              itemBuilder: ((BuildContext context, int index) {
                var item = controller.newProductList[index];
                return ProductCard(
                  id:  item.id,
                  title: item.name,
                  price: item.price,
                  imageUrl: item.imageUrl.first,
                );
              }),
              separatorBuilder: (_, __) => Container(width: 10),
            ),
          ),
        );
      },
    );
  }
  _onTapToSeeAllCategories() {
    mainBottomNavController.gotoCategoryScreen();
  }
  _onTapToSeeAllPopularProduct(){
    Navigator.pushNamed(context, ProductListScreen.name, arguments: 'Popular');
  }
  _onTapToSeeAlNewProduct(){
    Navigator.pushNamed(context, ProductListScreen.name, arguments: 'New');
  }
  _onTapToSeeAlSpecialProduct(){
    Navigator.pushNamed(context, ProductListScreen.name, arguments: 'Special');
  }
}
